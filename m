From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Nov 2012 16:43:28 +0100
Subject: [PATCH 4/4] ARM: sunxi: Add sunxi restart function via onchip
 watchdog
In-Reply-To: <1353323383-11827-4-git-send-email-sr@denx.de>
References: <1353323383-11827-1-git-send-email-sr@denx.de>
 <1353323383-11827-4-git-send-email-sr@denx.de>
Message-ID: <50AA53A0.2040404@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

While I've taken the three other patches, I'm more concerned about this one.

On a general basis, I would rather see this code into the machine source
file, since it doesn't directly relate to the timer driver. If at some
point someone wants to write a proper watchdog driver alongside with the
timer driver, I'll be fine with moving the code there, but for now,
let's keep it simple.

Le 19/11/2012 12:09, Stefan Roese a ?crit :
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-sunxi/sunxi.c       |  1 +
>  arch/arm/mach-sunxi/sunxi.h       |  2 ++
>  drivers/clocksource/sunxi_timer.c | 14 ++++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
> index 13d4d96..6b1186c 100644
> --- a/arch/arm/mach-sunxi/sunxi.c
> +++ b/arch/arm/mach-sunxi/sunxi.c
> @@ -57,5 +57,6 @@ DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
>  	.init_irq	= sunxi_init_irq,
>  	.handle_irq	= sunxi_handle_irq,
>  	.timer		= &sunxi_timer,
> +	.restart	= sunxi_restart,
>  	.dt_compat	= sunxi_board_dt_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-sunxi/sunxi.h b/arch/arm/mach-sunxi/sunxi.h
> index 33b5871..806c5fd 100644
> --- a/arch/arm/mach-sunxi/sunxi.h
> +++ b/arch/arm/mach-sunxi/sunxi.h
> @@ -17,4 +17,6 @@
>  #define SUNXI_REGS_VIRT_BASE	IOMEM(0xf1c00000)
>  #define SUNXI_REGS_SIZE		(SZ_2M + SZ_1M)
>  
> +void sunxi_restart(char mode, const char *cmd);
> +
>  #endif /* __MACH_SUNXI_H */
> diff --git a/drivers/clocksource/sunxi_timer.c b/drivers/clocksource/sunxi_timer.c
> index 3c46434..dfbf879 100644
> --- a/drivers/clocksource/sunxi_timer.c
> +++ b/drivers/clocksource/sunxi_timer.c
> @@ -34,6 +34,8 @@
>  #define TIMER0_CTL_ONESHOT		(1 << 7)
>  #define TIMER0_INTVAL_REG	0x14
>  #define TIMER0_CNTVAL_REG	0x18
> +#define WATCH_DOG_CTRL_REG	0x90
> +#define WATCH_DOG_MODE_REG	0x94
>  
>  #define TIMER_SCAL		16
>  
> @@ -103,6 +105,18 @@ static struct of_device_id sunxi_timer_dt_ids[] = {
>  	{ .compatible = "allwinner,sunxi-timer" },
>  };
>  
> +void sunxi_restart(char mode, const char *cmd)
> +{
> +	/* Use watchdog to reset system */
> +
> +	/* Enable timer and set reset bit */
> +	writel(3, timer_base + WATCH_DOG_MODE_REG);
> +	writel(0xa57 << 1 | 1, timer_base + WATCH_DOG_CTRL_REG);
> +
> +	while(1)
> +		;
> +}

Here, your code looks way more obscure and "complicated" than the one
from linux-sunxi found here:
https://github.com/linux-sunxi/linux-sunxi/blob/sunxi-3.4/arch/arm/mach-sun4i/core.c#L289

Why is that?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
