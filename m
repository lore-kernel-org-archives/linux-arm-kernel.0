From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 24 Nov 2011 17:02:08 -0500 (EST)
Subject: [PATCH 22/41] ARM: restart: mv78xx0: use new restart hook
In-Reply-To: <E1RN6oX-0001Y2-QF@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6oX-0001Y2-QF@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111241701100.17904@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Nov 2011, Russell King - ARM Linux wrote:

> Hook these platforms restart code into the new restart hook rather than
> using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: ?Nicolas pitre <nico@linaro.org>

(missed the non Kirkwood ones before)


> ---
>  arch/arm/mach-mv78xx0/buffalo-wxl-setup.c   |    1 +
>  arch/arm/mach-mv78xx0/common.c              |   16 ++++++++++++++++
>  arch/arm/mach-mv78xx0/common.h              |    1 +
>  arch/arm/mach-mv78xx0/db78x00-bp-setup.c    |    1 +
>  arch/arm/mach-mv78xx0/include/mach/system.h |   14 --------------
>  arch/arm/mach-mv78xx0/rd78x00-masa-setup.c  |    1 +
>  6 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> index 0e94268..ee74ec9 100644
> --- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> +++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
> @@ -151,4 +151,5 @@ MACHINE_START(TERASTATION_WXL, "Buffalo Nas WXL")
>  	.init_early	= mv78xx0_init_early,
>  	.init_irq	= mv78xx0_init_irq,
>  	.timer		= &mv78xx0_timer,
> +	.restart	= mv78xx0_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
> index 23d3980..5b9632b 100644
> --- a/arch/arm/mach-mv78xx0/common.c
> +++ b/arch/arm/mach-mv78xx0/common.c
> @@ -401,3 +401,19 @@ void __init mv78xx0_init(void)
>  	feroceon_l2_init(is_l2_writethrough());
>  #endif
>  }
> +
> +void mv78xx0_restart(char mode, const char *cmd)
> +{
> +	/*
> +	 * Enable soft reset to assert RSTOUTn.
> +	 */
> +	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> +
> +	/*
> +	 * Assert soft reset.
> +	 */
> +	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> +
> +	while (1)
> +		;
> +}
> diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
> index 632e63d..07d5f8f 100644
> --- a/arch/arm/mach-mv78xx0/common.h
> +++ b/arch/arm/mach-mv78xx0/common.h
> @@ -46,6 +46,7 @@ void mv78xx0_uart1_init(void);
>  void mv78xx0_uart2_init(void);
>  void mv78xx0_uart3_init(void);
>  void mv78xx0_i2c_init(void);
> +void mv78xx0_restart(char, const char *);
>  
>  extern struct sys_timer mv78xx0_timer;
>  
> diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
> index 50b85ae..4d6d48b 100644
> --- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
> +++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
> @@ -99,4 +99,5 @@ MACHINE_START(DB78X00_BP, "Marvell DB-78x00-BP Development Board")
>  	.init_early	= mv78xx0_init_early,
>  	.init_irq	= mv78xx0_init_irq,
>  	.timer		= &mv78xx0_timer,
> +	.restart	= mv78xx0_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mv78xx0/include/mach/system.h b/arch/arm/mach-mv78xx0/include/mach/system.h
> index 66e7ce4..1ae3585 100644
> --- a/arch/arm/mach-mv78xx0/include/mach/system.h
> +++ b/arch/arm/mach-mv78xx0/include/mach/system.h
> @@ -9,8 +9,6 @@
>  #ifndef __ASM_ARCH_SYSTEM_H
>  #define __ASM_ARCH_SYSTEM_H
>  
> -#include <mach/bridge-regs.h>
> -
>  static inline void arch_idle(void)
>  {
>  	cpu_do_idle();
> @@ -18,18 +16,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/*
> -	 * Enable soft reset to assert RSTOUTn.
> -	 */
> -	writel(SOFT_RESET_OUT_EN, RSTOUTn_MASK);
> -
> -	/*
> -	 * Assert soft reset.
> -	 */
> -	writel(SOFT_RESET, SYSTEM_SOFT_RESET);
> -
> -	while (1)
> -		;
>  }
>  
>  
> diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
> index e85222e..9a88270 100644
> --- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
> +++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
> @@ -84,4 +84,5 @@ MACHINE_START(RD78X00_MASA, "Marvell RD-78x00-MASA Development Board")
>  	.init_early	= mv78xx0_init_early,
>  	.init_irq	= mv78xx0_init_irq,
>  	.timer		= &mv78xx0_timer,
> +	.restart	= mv78xx0_restart,
>  MACHINE_END
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
