From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 11 Nov 2011 12:02:38 +0800
Subject: [PATCH 24/41] ARM: restart: mxs: use new restart hook
In-Reply-To: <E1RN6pC-0001YC-Mx@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6pC-0001YC-Mx@rmk-PC.arm.linux.org.uk>
Message-ID: <20111111040237.GA8732@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 06, 2011 at 05:48:06PM +0000, Russell King - ARM Linux wrote:
> Hook these platforms restart code into the new restart hook rather
> than using arch_reset().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

> ---
>  arch/arm/mach-mxs/include/mach/common.h |    1 +
>  arch/arm/mach-mxs/include/mach/system.h |    4 +++-
>  arch/arm/mach-mxs/mach-m28evk.c         |    1 +
>  arch/arm/mach-mxs/mach-mx23evk.c        |    1 +
>  arch/arm/mach-mxs/mach-mx28evk.c        |    1 +
>  arch/arm/mach-mxs/mach-stmp378x_devb.c  |    1 +
>  arch/arm/mach-mxs/mach-tx28.c           |    1 +
>  arch/arm/mach-mxs/system.c              |    2 +-
>  8 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/common.h b/arch/arm/mach-mxs/include/mach/common.h
> index 635bb5d..1388485 100644
> --- a/arch/arm/mach-mxs/include/mach/common.h
> +++ b/arch/arm/mach-mxs/include/mach/common.h
> @@ -16,6 +16,7 @@ struct clk;
>  extern const u32 *mxs_get_ocotp(void);
>  extern int mxs_reset_block(void __iomem *);
>  extern void mxs_timer_init(struct clk *, int);
> +extern void mxs_restart(char, const char *);
>  
>  extern int mx23_register_gpios(void);
>  extern int mx23_clocks_init(void);
> diff --git a/arch/arm/mach-mxs/include/mach/system.h b/arch/arm/mach-mxs/include/mach/system.h
> index 0e42823..bcd8989 100644
> --- a/arch/arm/mach-mxs/include/mach/system.h
> +++ b/arch/arm/mach-mxs/include/mach/system.h
> @@ -22,6 +22,8 @@ static inline void arch_idle(void)
>  	cpu_do_idle();
>  }
>  
> -void arch_reset(char mode, const char *cmd);
> +static inline void arch_reset(char mode, const char *cmd)
> +{
> +}
>  
>  #endif /* __MACH_MXS_SYSTEM_H__ */
> diff --git a/arch/arm/mach-mxs/mach-m28evk.c b/arch/arm/mach-mxs/mach-m28evk.c
> index 3b1681e..7799cd9 100644
> --- a/arch/arm/mach-mxs/mach-m28evk.c
> +++ b/arch/arm/mach-mxs/mach-m28evk.c
> @@ -363,4 +363,5 @@ MACHINE_START(M28EVK, "DENX M28 EVK")
>  	.init_irq	= mx28_init_irq,
>  	.init_machine	= m28evk_init,
>  	.timer		= &m28evk_timer,
> +	.restart	= mxs_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
> index c325fbe..5ea1c57 100644
> --- a/arch/arm/mach-mxs/mach-mx23evk.c
> +++ b/arch/arm/mach-mxs/mach-mx23evk.c
> @@ -184,4 +184,5 @@ MACHINE_START(MX23EVK, "Freescale MX23 EVK")
>  	.init_irq	= mx23_init_irq,
>  	.timer		= &mx23evk_timer,
>  	.init_machine	= mx23evk_init,
> +	.restart	= mxs_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
> index ac2316d..1d2548f 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -501,4 +501,5 @@ MACHINE_START(MX28EVK, "Freescale MX28 EVK")
>  	.init_irq	= mx28_init_irq,
>  	.timer		= &mx28evk_timer,
>  	.init_machine	= mx28evk_init,
> +	.restart	= mxs_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-stmp378x_devb.c b/arch/arm/mach-mxs/mach-stmp378x_devb.c
> index 177e531..857e857 100644
> --- a/arch/arm/mach-mxs/mach-stmp378x_devb.c
> +++ b/arch/arm/mach-mxs/mach-stmp378x_devb.c
> @@ -117,4 +117,5 @@ MACHINE_START(STMP378X, "STMP378X")
>  	.init_irq	= mx23_init_irq,
>  	.init_machine	= stmp378x_dvb_init,
>  	.timer		= &stmp378x_dvb_timer,
> +	.restart	= mxs_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> index 9a1f0e7..2c0862e 100644
> --- a/arch/arm/mach-mxs/mach-tx28.c
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -178,4 +178,5 @@ MACHINE_START(TX28, "Ka-Ro electronics TX28 module")
>  	.init_irq = mx28_init_irq,
>  	.timer = &tx28_timer,
>  	.init_machine = tx28_stk5v3_init,
> +	.restart	= mxs_restart,
>  MACHINE_END
> diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> index cab8836..b936633 100644
> --- a/arch/arm/mach-mxs/system.c
> +++ b/arch/arm/mach-mxs/system.c
> @@ -42,7 +42,7 @@ static void __iomem *mxs_clkctrl_reset_addr;
>  /*
>   * Reset the system. It is called by machine_restart().
>   */
> -void arch_reset(char mode, const char *cmd)
> +void mxs_restart(char mode, const char *cmd)
>  {
>  	/* reset the chip */
>  	__mxs_setl(MXS_CLKCTRL_RESET_CHIP, mxs_clkctrl_reset_addr);
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
