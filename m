From: digetx@gmail.com (Dmitry Osipenko)
Date: Mon, 21 May 2018 10:36:52 +0300
Subject: [PATCH v1 4/5] ARM: tegra: Don't apply CPU erratas in insecure
 mode
In-Reply-To: <20180520101542.12206-5-digetx@gmail.com>
References: <20180520101542.12206-1-digetx@gmail.com>
 <20180520101542.12206-5-digetx@gmail.com>
Message-ID: <57fceed2-6ca4-8dcf-dd0c-5e4432c086b9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.05.2018 13:15, Dmitry Osipenko wrote:
> CPU isn't allowed to touch secure registers while running under secure
> monitor. Hence skip applying CPU erratas in the reset handler if Trusted
> Foundations firmware presents.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/reset-handler.S | 27 +++++++++++++++++++--------
>  arch/arm/mach-tegra/reset.c         |  3 +++
>  arch/arm/mach-tegra/reset.h         |  4 +++-
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
> index 805f306fa6f7..d84c74a95806 100644
> --- a/arch/arm/mach-tegra/reset-handler.S
> +++ b/arch/arm/mach-tegra/reset-handler.S
> @@ -121,6 +121,12 @@ ENTRY(__tegra_cpu_reset_handler)
>  	cpsid	aif, 0x13			@ SVC mode, interrupts disabled
>  
>  	tegra_get_soc_id TEGRA_APB_MISC_BASE, r6
> +
> +	adr	r12, __tegra_cpu_reset_handler_data
> +	ldr	r0, [r12, #RESET_DATA(TF_PRESENT)]
> +	cmp	r0, #0
> +	bne	after_errata
> +
>  #ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  t20_check:
>  	cmp	r6, #TEGRA20
> @@ -155,7 +161,6 @@ after_errata:
>  	and	r10, r10, #0x3			@ R10 = CPU number
>  	mov	r11, #1
>  	mov	r11, r11, lsl r10  		@ R11 = CPU mask
> -	adr	r12, __tegra_cpu_reset_handler_data
>  
>  #ifdef CONFIG_SMP
>  	/* Does the OS know about this CPU? */
> @@ -169,10 +174,9 @@ after_errata:
>  	cmp	r6, #TEGRA20
>  	bne	1f
>  	/* If not CPU0, don't let CPU0 reset CPU1 now that CPU1 is coming up. */
> -	mov32	r5, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
>  	mov	r0, #CPU_NOT_RESETTABLE
>  	cmp	r10, #0
> -	strneb	r0, [r5, #__tegra20_cpu1_resettable_status_offset]
> +	strneb	r0, [r12, #RESET_DATA(RESETTABLE_STATUS)]
>  1:
>  #endif
>  
> @@ -278,13 +282,20 @@ ENDPROC(__tegra_cpu_reset_handler)
>  	.type	__tegra_cpu_reset_handler_data, %object
>  	.globl	__tegra_cpu_reset_handler_data
>  __tegra_cpu_reset_handler_data:
> -	.rept	TEGRA_RESET_DATA_SIZE
> -	.long	0
> -	.endr
> +	.long	0	/* TEGRA_RESET_MASK_PRESENT */
> +	.long	0	/* TEGRA_RESET_MASK_LP1 */
> +	.long	0	/* TEGRA_RESET_MASK_LP2 */
> +	.long	0	/* TEGRA_RESET_STARTUP_SECONDARY */
> +	.long	0	/* TEGRA_RESET_STARTUP_LP2 */
> +	.long	0	/* TEGRA_RESET_STARTUP_LP1 */
> +
>  	.globl	__tegra20_cpu1_resettable_status_offset
>  	.equ	__tegra20_cpu1_resettable_status_offset, \
>  					. - __tegra_cpu_reset_handler_start
> -	.byte	0
> -	.align L1_CACHE_SHIFT
> +	.long	0	/* TEGRA_RESET_RESETTABLE_STATUS */
>  
> +	.globl	__tegra_tf_present
> +	.equ	__tegra_tf_present, . - __tegra_cpu_reset_handler_start

I've noticed that __tegra_tf_present shouldn't belong to this patch, I've missed
to remove it while was rebasing.

Also, it occurred to me that it will be much better to remove the whole array
__tegra_cpu_reset_handler_data definition in the asm and get back to the
original ".rept   TEGRA_RESET_DATA_SIZE" instead. That will make this part of
code much nicer, I'll change that in v2.

Russell / Thierry, please give you acks-reviews where appropriate and let me
know if I should change anything else in v2, thanks.

> +	.long	0	/* TEGRA_RESET_TF_PRESENT */
> +	.align L1_CACHE_SHIFT
>  ENTRY(__tegra_cpu_reset_handler_end)
> diff --git a/arch/arm/mach-tegra/reset.c b/arch/arm/mach-tegra/reset.c
> index dc558892753c..b02ae7699842 100644
> --- a/arch/arm/mach-tegra/reset.c
> +++ b/arch/arm/mach-tegra/reset.c
> @@ -24,6 +24,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/firmware.h>
>  #include <asm/hardware/cache-l2x0.h>
> +#include <asm/trusted_foundations.h>
>  
>  #include "iomap.h"
>  #include "irammap.h"
> @@ -89,6 +90,8 @@ static void __init tegra_cpu_reset_handler_enable(void)
>  
>  void __init tegra_cpu_reset_handler_init(void)
>  {
> +	__tegra_cpu_reset_handler_data[TEGRA_RESET_TF_PRESENT] =
> +		trusted_foundations_registered();
>  
>  #ifdef CONFIG_SMP
>  	__tegra_cpu_reset_handler_data[TEGRA_RESET_MASK_PRESENT] =
> diff --git a/arch/arm/mach-tegra/reset.h b/arch/arm/mach-tegra/reset.h
> index 9c479c7925b8..0d9ddc022ece 100644
> --- a/arch/arm/mach-tegra/reset.h
> +++ b/arch/arm/mach-tegra/reset.h
> @@ -25,7 +25,9 @@
>  #define TEGRA_RESET_STARTUP_SECONDARY	3
>  #define TEGRA_RESET_STARTUP_LP2		4
>  #define TEGRA_RESET_STARTUP_LP1		5
> -#define TEGRA_RESET_DATA_SIZE		6
> +#define TEGRA_RESET_RESETTABLE_STATUS	6
> +#define TEGRA_RESET_TF_PRESENT		7
> +#define TEGRA_RESET_DATA_SIZE		8
>  
>  #ifndef __ASSEMBLY__
>  
> 
