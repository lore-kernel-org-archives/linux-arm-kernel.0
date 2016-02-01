From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 1 Feb 2016 14:59:14 +0100
Subject: [PATCH v2 01/21] arm/arm64: Add new is_kernel_in_hyp_mode
 predicate
In-Reply-To: <1453737235-16522-2-git-send-email-marc.zyngier@arm.com>
References: <1453737235-16522-1-git-send-email-marc.zyngier@arm.com>
 <1453737235-16522-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160201135914.GN1478@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 03:53:35PM +0000, Marc Zyngier wrote:
> With ARMv8.1 VHE extension, it will be possible to run the kernel
> at EL2 (aka HYP mode). In order for the kernel to easily find out
> where it is running, add a new predicate that returns whether or
> not the kernel is in HYP mode.
> 
> For completeness, the 32bit code also get such a predicate (always
> returning false) so that code common to both architecture (timers,
> KVM) can use it transparently.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  arch/arm/include/asm/virt.h   |  5 +++++
>  arch/arm64/include/asm/virt.h | 10 ++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
> index 4371f45..b6a3cef 100644
> --- a/arch/arm/include/asm/virt.h
> +++ b/arch/arm/include/asm/virt.h
> @@ -74,6 +74,11 @@ static inline bool is_hyp_mode_mismatched(void)
>  {
>  	return !!(__boot_cpu_mode & BOOT_CPU_MODE_MISMATCH);
>  }
> +
> +static inline bool is_kernel_in_hyp_mode(void)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
> index 7a5df52..9f22dd6 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -23,6 +23,8 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +#include <asm/ptrace.h>
> +
>  /*
>   * __boot_cpu_mode records what mode CPUs were booted in.
>   * A correctly-implemented bootloader must start all CPUs in the same mode:
> @@ -50,6 +52,14 @@ static inline bool is_hyp_mode_mismatched(void)
>  	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
>  }
>  
> +static inline bool is_kernel_in_hyp_mode(void)
> +{
> +	u64 el;
> +
> +	asm("mrs %0, CurrentEL" : "=r" (el));
> +	return el == CurrentEL_EL2;
> +}
> +
>  /* The section containing the hypervisor text */
>  extern char __hyp_text_start[];
>  extern char __hyp_text_end[];
> -- 
> 2.1.4
> 
