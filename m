From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 13 Dec 2016 09:38:21 +0000
Subject: [PATCH RFC 2/2] ARM: nommu: remap exception base address to RAM
In-Reply-To: <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
References: <20161211131028.3019-1-afzal.mohd.ma@gmail.com>
 <20161211131255.3221-1-afzal.mohd.ma@gmail.com>
Message-ID: <584FC18D.2050908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/16 13:12, Afzal Mohammed wrote:
> Remap exception base address to start of RAM in Kernel in !MMU mode.
> 
> Based on existing Kconfig help, Kernel was expecting it to be
> configured by external support. Also earlier it was not possible to
> copy the exception table to start of RAM due to Kconfig dependency,
> which has been fixed by a change prior to this.
> 
> Kernel text start at an offset of at least 32K to account for page
> tables in MMU case. On a !MMU build too this space is kept aside, and
> since 2 pages (8K) is the maximum for exception plus stubs, it can be
> placed at the start of RAM.
> 
> Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
> ---
> 
> i am a bit shaky about this change, though it works here on Cortex-A9,
> this probably would have to be made robust so as to not cause issue on
> other v7-A's upon trying to do !MMU (this won't affect normal MMU boot),
> or specifically where security extensions are not enabled. Also effect
> of hypervisor extension also need to be considered. Please let know if
> any better ways to handle this.

You might need to check ID_PFR1 for that.

> 
> 
>  arch/arm/Kconfig-nommu       | 6 +++---
>  arch/arm/kernel/head-nommu.S | 6 ++++++
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
> index b7576349528c..f57fbe3d5eb0 100644
> --- a/arch/arm/Kconfig-nommu
> +++ b/arch/arm/Kconfig-nommu
> @@ -46,9 +46,9 @@ config REMAP_VECTORS_TO_RAM
>  	  If your CPU provides a remap facility which allows the exception
>  	  vectors to be mapped to writable memory, say 'n' here.
>  
> -	  Otherwise, say 'y' here.  In this case, the kernel will require
> -	  external support to redirect the hardware exception vectors to
> -	  the writable versions located at DRAM_BASE.
> +	  Otherwise, say 'y' here.  In this case, the kernel will
> +	  redirect the hardware exception vectors to the writable
> +	  versions located at DRAM_BASE.
>  
>  config ARM_MPU
>         bool 'Use the ARM v7 PMSA Compliant MPU'
> diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
> index 6b4eb27b8758..ac31c9647830 100644
> --- a/arch/arm/kernel/head-nommu.S
> +++ b/arch/arm/kernel/head-nommu.S
> @@ -158,6 +158,12 @@ __after_proc_init:
>  	bic	r0, r0, #CR_V
>  #endif
>  	mcr	p15, 0, r0, c1, c0, 0		@ write control reg
> +
> +#ifdef CONFIG_REMAP_VECTORS_TO_RAM
> +	mov	r3, #CONFIG_VECTORS_BASE	@ read VECTORS_BASE

ldr r3,=CONFIG_VECTORS_BASE

would be more robust. I hit this in [1]

[1] https://www.spinics.net/lists/arm-kernel/msg546825.html

Cheers
Vladimir

> +	mcr	p15, 0, r3, c12, c0, 0		@ write to VBAR
> +#endif
> +
>  #elif defined (CONFIG_CPU_V7M)
>  	/* For V7M systems we want to modify the CCR similarly to the SCTLR */
>  #ifdef CONFIG_CPU_DCACHE_DISABLE
> 
