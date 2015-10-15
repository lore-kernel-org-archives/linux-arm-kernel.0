From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Oct 2015 13:37:27 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <20151015112532.GA16125@e106634-lin.cambridge.arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
 <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
 <561EC58B.9080408@arm.com> <20151015104515.GE8825@leverpostej>
 <20151015112532.GA16125@e106634-lin.cambridge.arm.com>
Message-ID: <20151015123727.GH8825@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 12:25:33PM +0100, Suzuki K. Poulose wrote:
> On Thu, Oct 15, 2015 at 11:45:15AM +0100, Mark Rutland wrote:
> > On Wed, Oct 14, 2015 at 04:13:47PM -0500, Jeremy Linton wrote:
> > > On 10/14/2015 06:20 AM, Suzuki K. Poulose wrote:
> > > 
> > > >+ * Checks if the selected granule size is supported by the CPU.
> > > >+ * If it doesn't park the CPU
> > > 
> > > The problem is when you park the boot CPU.
> > > 
> > > I think for EFI there is a slightly better error mechanism. This
> > > tweak will print an error and return to the EFI boot manager rather
> > > than hanging the machine without any notification. Now it prints:
> > > 
> > > EFI stub: Booting Linux Kernel...
> > > EFI stub: ERROR: 16K granule not supported by this machine
> > > EFI stub: ERROR: Failed to relocate kernel
> > > FS4:\>
> > 
> > Neat. We should definitely have checks like this in the stub.
> > 
> > However, we still need checks in head.S, given !EFI systems, SMP, and
> > kexec, so this is a complementary mechanism.
> 
> Indeed. I meant to add the above check. The updated patch looks like :
> 
> ----8>----
> 
> Author: Suzuki K. Poulose <suzuki.poulose@arm.com>
> Date:   Wed Oct 14 11:25:16 2015 +0100
> 
>     arm64: Check for selected granule support
>     
>     Ensure that the selected page size is supported by the CPU(s). If it isn't
>     park the CPU. A check is added to the EFI stub to detect if the boot CPU
>     supports the page size, failing which, we fail the boot gracefully, with
>     an error message.
>     
>     Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>     [ Added a check to EFI stub ]
>     Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Your sign-off should be last, given you are taking resposibility for
Jeremy's patch.

However, I would prefer that the EFI stub addition were a separate/later
patch.

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index a7f3d4b..72d814c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -44,6 +44,26 @@
>  #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
>  				     (!!x)<<8 | 0x1f)
>  
> +
> +#define ID_AA64MMFR0_TGRAN4_SHIFT	28
> +#define ID_AA64MMFR0_TGRAN64_SHIFT	24
> +#define ID_AA64MMFR0_TGRAN16_SHIFT	20
> +
> +#define ID_AA64MMFR0_TGRAN4_NI		0xf
> +#define ID_AA64MMFR0_TGRAN4_ON		0x0
> +#define ID_AA64MMFR0_TGRAN64_NI		0xf
> +#define ID_AA64MMFR0_TGRAN64_ON		0x0
> +#define ID_AA64MMFR0_TGRAN16_NI		0x0
> +#define ID_AA64MMFR0_TGRAN16_ON		0x1

I still don't like "ON" here -- I thought these would also be changed
s/ON/SUPPORTED/.

> +
> +#if defined(CONFIG_ARM64_4K_PAGES)
> +#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN4_SHIFT
> +#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN4_ON
> +#else
> +#define ID_AA64MMFR0_TGRAN_SHIFT	ID_AA64MMFR0_TGRAN64_SHIFT
> +#define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN64_ON
> +#endif
> +
>  #ifdef __ASSEMBLY__
>  
>  	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
> diff --git a/arch/arm64/kernel/efi-stub.c b/arch/arm64/kernel/efi-stub.c
> index 816120e..77d7de1 100644
> --- a/arch/arm64/kernel/efi-stub.c
> +++ b/arch/arm64/kernel/efi-stub.c
> @@ -11,8 +11,15 @@
>   */
>  #include <linux/efi.h>
>  #include <asm/efi.h>
> +#include <asm/sysreg.h>
>  #include <asm/sections.h>

Nit: include order.

>  
> +#if defined(CONFIG_ARM64_4K_PAGES)
> +#define PAGE_SIZE_STR	"4K"
> +#elif defined(CONFIG_ARM64_64K_PAGES)
> +#define PAGE_SIZE_STR	"64K"
> +#endif
> +
>  efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>  					unsigned long *image_addr,
>  					unsigned long *image_size,
> @@ -25,6 +32,17 @@ efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
>  	unsigned long kernel_size, kernel_memsize = 0;
>  	unsigned long nr_pages;
>  	void *old_image_addr = (void *)*image_addr;
> +	u64 aa64mmfr0_el1;
> +
> +	/*
> +	 * Check to see if the CPU supports the requested pagesize
> +	 */
> +	asm volatile("mrs %0, ID_AA64MMFR0_EL1" : "=r" (aa64mmfr0_el1));

Can we not use read_cpuid() or similar here?

> +	aa64mmfr0_el1 >>= ID_AA64MMFR0_TGRAN_SHIFT;

... and can we not do the shift and mask in one go?

> +	if ((aa64mmfr0_el1 & 0xf) != ID_AA64MMFR0_TGRAN_SUPPORTED) {
> +		pr_efi_err(sys_table_arg, PAGE_SIZE_STR" granule not supported by the CPU\n");

Nit: space before the first quote, please.

Thanks,
Mark.
