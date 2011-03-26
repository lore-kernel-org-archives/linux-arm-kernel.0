From: vwadekar@nvidia.com (Varun Wadekar)
Date: Sun, 27 Mar 2011 01:42:07 +0530
Subject: [patch 02/23] arm: tegra: Remove unused function which fiddles
	with	irq_desc
In-Reply-To: <20110325132047.552074703@linutronix.de>
References: <20110325131617.258789658@linutronix.de>
	<20110325132047.552074703@linutronix.de>
Message-ID: <4D8E4897.5030705@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thomas, then how do you think we should handle restoring of gpio states
across suspend-resume cycles?

On Friday 25 March 2011 06:51 PM, Thomas Gleixner wrote:
> These functions are unused and in the way of cleanups in the core
> code. If you have special requirements vs. irqs and PM then please
> talk to me. Access to the generic core internals is going away.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Colin Cross <ccross@android.com>
> Cc: linux-tegra at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/mach-tegra/gpio.c                 |   63 -----------------------------
>  arch/arm/mach-tegra/include/mach/suspend.h |    2 
>  2 files changed, 65 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-tegra/gpio.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-tegra/gpio.c
> +++ linux-2.6/arch/arm/mach-tegra/gpio.c
> @@ -254,69 +254,6 @@ static void tegra_gpio_irq_handler(unsig
>  }
>  
>  #ifdef CONFIG_PM
> -void tegra_gpio_resume(void)
> -{
> -	unsigned long flags;
> -	int b, p, i;
> -
> -	local_irq_save(flags);
> -
> -	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
> -		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
> -
> -		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
> -			unsigned int gpio = (b<<5) | (p<<3);
> -			__raw_writel(bank->cnf[p], GPIO_CNF(gpio));
> -			__raw_writel(bank->out[p], GPIO_OUT(gpio));
> -			__raw_writel(bank->oe[p], GPIO_OE(gpio));
> -			__raw_writel(bank->int_lvl[p], GPIO_INT_LVL(gpio));
> -			__raw_writel(bank->int_enb[p], GPIO_INT_ENB(gpio));
> -		}
> -	}
> -
> -	local_irq_restore(flags);
> -
> -	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> -		struct irq_desc *desc = irq_to_desc(i);
> -		if (!desc || (desc->status & IRQ_WAKEUP))
> -			continue;
> -		enable_irq(i);
> -	}
> -}
> -
> -void tegra_gpio_suspend(void)
> -{
> -	unsigned long flags;
> -	int b, p, i;
> -
> -	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
> -		struct irq_desc *desc = irq_to_desc(i);
> -		if (!desc)
> -			continue;
> -		if (desc->status & IRQ_WAKEUP) {
> -			int gpio = i - INT_GPIO_BASE;
> -			pr_debug("gpio %d.%d is wakeup\n", gpio/8, gpio&7);
> -			continue;
> -		}
> -		disable_irq(i);
> -	}
> -
> -	local_irq_save(flags);
> -	for (b = 0; b < ARRAY_SIZE(tegra_gpio_banks); b++) {
> -		struct tegra_gpio_bank *bank = &tegra_gpio_banks[b];
> -
> -		for (p = 0; p < ARRAY_SIZE(bank->oe); p++) {
> -			unsigned int gpio = (b<<5) | (p<<3);
> -			bank->cnf[p] = __raw_readl(GPIO_CNF(gpio));
> -			bank->out[p] = __raw_readl(GPIO_OUT(gpio));
> -			bank->oe[p] = __raw_readl(GPIO_OE(gpio));
> -			bank->int_enb[p] = __raw_readl(GPIO_INT_ENB(gpio));
> -			bank->int_lvl[p] = __raw_readl(GPIO_INT_LVL(gpio));
> -		}
> -	}
> -	local_irq_restore(flags);
> -}
> -
>  static int tegra_gpio_wake_enable(struct irq_data *d, unsigned int enable)
>  {
>  	struct tegra_gpio_bank *bank = irq_data_get_irq_chip_data(d);
> Index: linux-2.6/arch/arm/mach-tegra/include/mach/suspend.h
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-tegra/include/mach/suspend.h
> +++ linux-2.6/arch/arm/mach-tegra/include/mach/suspend.h
> @@ -23,14 +23,12 @@
>  
>  void tegra_pinmux_suspend(void);
>  void tegra_irq_suspend(void);
> -void tegra_gpio_suspend(void);
>  void tegra_clk_suspend(void);
>  void tegra_dma_suspend(void);
>  void tegra_timer_suspend(void);
>  
>  void tegra_pinmux_resume(void);
>  void tegra_irq_resume(void);
> -void tegra_gpio_resume(void);
>  void tegra_clk_resume(void);
>  void tegra_dma_resume(void);
>  void tegra_timer_resume(void);
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
