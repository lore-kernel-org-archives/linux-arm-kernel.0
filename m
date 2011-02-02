From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 02 Feb 2011 12:54:30 -0500 (EST)
Subject: [PATCH] Kirkwood: enable PCIe for kexec
In-Reply-To: <1296666790-996-1-git-send-email-ecc@cmu.edu>
References: <1296666790-996-1-git-send-email-ecc@cmu.edu>
Message-ID: <alpine.LFD.2.00.1102021248340.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Feb 2011, Eric Cooper wrote:

> PCIe may have been disabled by kirkwood_clock_gate.
> Make sure PCIe is enabled before attempting to access
> the device ID register, otherwise the system will hang.
> 
> Add kexec_reinit hook so that kexec'ing older kernels will work.
> 
> Signed-off-by: Eric Cooper <ecc@cmu.edu>

I'd suggest splitting this into 3 patches, each with their own 
rationals:

1) The kexec machine hook facility, non Kirkwood specific.

2) The clock ungate for the ID reading upon boot.

3) Initializing the kexec hook with the Kirkwood specific part.

Also, kexec_reinit should probably be called early in machine_kexec() 
before the caches are flushed.

> ---
>  arch/arm/kernel/machine_kexec.c |    7 +++++++
>  arch/arm/mach-kirkwood/common.c |    4 ++++
>  arch/arm/mach-kirkwood/common.h |    1 +
>  arch/arm/mach-kirkwood/pcie.c   |    8 ++++++++
>  4 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
> index 30ead13..7e870ea 100644
> --- a/arch/arm/kernel/machine_kexec.c
> +++ b/arch/arm/kernel/machine_kexec.c
> @@ -75,6 +75,11 @@ void machine_crash_shutdown(struct pt_regs *regs)
>  	printk(KERN_INFO "Loading crashdump kernel...\n");
>  }
>  
> +/*
> + * Function pointer to optional machine-specific reinitialization
> + */
> +void (*kexec_reinit)(void);
> +
>  void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list;
> @@ -113,5 +118,7 @@ void machine_kexec(struct kimage *image)
>  	cpu_proc_fin();
>  	outer_inv_all();
>  	flush_cache_all();
> +	if (kexec_reinit)
> +		kexec_reinit();
>  	cpu_reset(reboot_code_buffer_phys);
>  }
> diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
> index 3688123..78eeb63 100644
> --- a/arch/arm/mach-kirkwood/common.c
> +++ b/arch/arm/mach-kirkwood/common.c
> @@ -974,6 +974,8 @@ static void __init kirkwood_l2_init(void)
>  
>  void __init kirkwood_init(void)
>  {
> +	extern void (*kexec_reinit)(void);
> +
>  	printk(KERN_INFO "Kirkwood: %s, TCLK=%d.\n",
>  		kirkwood_id(), kirkwood_tclk);
>  	kirkwood_ge00_shared_data.t_clk = kirkwood_tclk;
> @@ -1003,6 +1005,8 @@ void __init kirkwood_init(void)
>  	kirkwood_xor0_init();
>  	kirkwood_xor1_init();
>  	kirkwood_crypto_init();
> +
> +	kexec_reinit = kirkwood_enable_pcie;
>  }
>  
>  static int __init kirkwood_clock_gate(void)
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 95bb0a7..a35b862 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -32,6 +32,7 @@ void kirkwood_init_irq(void);
>  extern struct mbus_dram_target_info kirkwood_mbus_dram_info;
>  void kirkwood_setup_cpu_mbus(void);
>  
> +void kirkwood_enable_pcie(void);
>  void kirkwood_pcie_id(u32 *dev, u32 *rev);
>  
>  void kirkwood_ehci_init(void);
> diff --git a/arch/arm/mach-kirkwood/pcie.c b/arch/arm/mach-kirkwood/pcie.c
> index 513ad31..ca294ff 100644
> --- a/arch/arm/mach-kirkwood/pcie.c
> +++ b/arch/arm/mach-kirkwood/pcie.c
> @@ -18,8 +18,16 @@
>  #include <mach/bridge-regs.h>
>  #include "common.h"
>  
> +void kirkwood_enable_pcie(void)
> +{
> +	u32 curr = readl(CLOCK_GATING_CTRL);
> +	if (!(curr & CGC_PEX0))
> +		writel(curr | CGC_PEX0, CLOCK_GATING_CTRL);
> +}
> +
>  void __init kirkwood_pcie_id(u32 *dev, u32 *rev)
>  {
> +	kirkwood_enable_pcie();
>  	*dev = orion_pcie_dev_id((void __iomem *)PCIE_VIRT_BASE);
>  	*rev = orion_pcie_rev((void __iomem *)PCIE_VIRT_BASE);
>  }
> -- 
> 1.7.2.3
> 
