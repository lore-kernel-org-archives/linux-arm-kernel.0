From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 26 Apr 2011 18:03:32 +0530
Subject: [PATCH 10/15] OMAP: GPIO: conslidate enable/disable of GPIO IRQs,
	remove ifdefs
In-Reply-To: <1303513327-14532-11-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
	<1303513327-14532-11-git-send-email-khilman@ti.com>
Message-ID: <BANLkTi=ivNqfTTscWJYk2gCEznMus_Qd-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Sat, Apr 23, 2011 at 04:32, Kevin Hilman <khilman@ti.com> wrote:
> Cleanup GPIO IRQ enable/disable handling by removing SoC-specific
>
> Also split enable/disable IRQ into separate functions for better
> readability and also facilitate potentially moving to generic irq_chip
> in the future.
>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---

<<snip>>

> ?static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index 35e8b31..880f3cb 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -44,6 +44,8 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
> ? ? ? ?.datain ? ? ? ? = OMAP_MPUIO_INPUT_LATCH / 2,
> ? ? ? ?.dataout ? ? ? ?= OMAP_MPUIO_OUTPUT / 2,
> ? ? ? ?.irqstatus ? ? ?= OMAP_MPUIO_GPIO_INT / 2,
> + ? ? ? .irqenable ? ? ?= OMAP_MPUIO_GPIO_MASKIT / 2,
> + ? ? ? .irqenable_inv ?= true,
> ?};
>
> ?static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
> @@ -82,6 +84,8 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
> ? ? ? ?.datain ? ? ? ? = OMAP7XX_GPIO_DATA_INPUT,
> ? ? ? ?.dataout ? ? ? ?= OMAP7XX_GPIO_DATA_OUTPUT,
> ? ? ? ?.irqstatus ? ? ?= OMAP7XX_GPIO_INT_STATUS,
> + ? ? ? .irqenable ? ? ?= OMAP7XX_GPIO_INT_MASK,
> + ? ? ? .irqenable ? ? ?= true,

irqenable_inv should be true and not irqenable.

> ?};
>
> ?static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {

<<snip>>

> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 4f875cf..17833c8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c

<<snip>>

> -static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)
> +static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
> ?{
> ? ? ? ?void __iomem *reg = bank->base;
> ? ? ? ?u32 l;
>
> - ? ? ? switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP1
> - ? ? ? case METHOD_MPUIO:
> - ? ? ? ? ? ? ? reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
> - ? ? ? ? ? ? ? l = __raw_readl(reg);
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? l &= ~(gpio_mask);
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? l |= gpio_mask;
> - ? ? ? ? ? ? ? break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP15XX
> - ? ? ? case METHOD_GPIO_1510:
> - ? ? ? ? ? ? ? reg += OMAP1510_GPIO_INT_MASK;
> + ? ? ? if (bank->regs->set_irqenable) {
> + ? ? ? ? ? ? ? reg += bank->regs->set_irqenable;
> + ? ? ? ? ? ? ? l = gpio_mask;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? reg += bank->regs->irqenable;
> ? ? ? ? ? ? ? ?l = __raw_readl(reg);
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? l &= ~(gpio_mask);
> + ? ? ? ? ? ? ? if (bank->regs->irqenable_inv)
> + ? ? ? ? ? ? ? ? ? ? ? l &= ~gpio_mask;
> ? ? ? ? ? ? ? ?else
> ? ? ? ? ? ? ? ? ? ? ? ?l |= gpio_mask;

This else case code is required for _disable_gpio_irqbank() only.
There should be no else part here.

> - ? ? ? ? ? ? ? break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP16XX
> - ? ? ? case METHOD_GPIO_1610:
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP1610_GPIO_SET_IRQENABLE1;
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP1610_GPIO_CLEAR_IRQENABLE1;
> + ? ? ? }
> +
> + ? ? ? __raw_writel(l, reg);
> +}
> +
> +static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
> +{
> + ? ? ? void __iomem *reg = bank->base;
> + ? ? ? u32 l;
> +
> + ? ? ? if (bank->regs->clr_irqenable) {
> + ? ? ? ? ? ? ? reg += bank->regs->clr_irqenable;
> ? ? ? ? ? ? ? ?l = gpio_mask;
> - ? ? ? ? ? ? ? break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> - ? ? ? case METHOD_GPIO_7XX:
> - ? ? ? ? ? ? ? reg += OMAP7XX_GPIO_INT_MASK;
> + ? ? ? } else {
> + ? ? ? ? ? ? ? reg += bank->regs->irqenable;
> ? ? ? ? ? ? ? ?l = __raw_readl(reg);
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? l &= ~(gpio_mask);
> - ? ? ? ? ? ? ? else
> + ? ? ? ? ? ? ? if (bank->regs->irqenable_inv)
> ? ? ? ? ? ? ? ? ? ? ? ?l |= gpio_mask;
> - ? ? ? ? ? ? ? break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> - ? ? ? case METHOD_GPIO_24XX:
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP24XX_GPIO_SETIRQENABLE1;
> - ? ? ? ? ? ? ? else
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP24XX_GPIO_CLEARIRQENABLE1;
> - ? ? ? ? ? ? ? l = gpio_mask;
> - ? ? ? ? ? ? ? break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> - ? ? ? case METHOD_GPIO_44XX:
> - ? ? ? ? ? ? ? if (enable)
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP4_GPIO_IRQSTATUSSET0;
> ? ? ? ? ? ? ? ?else
> - ? ? ? ? ? ? ? ? ? ? ? reg += OMAP4_GPIO_IRQSTATUSCLR0;
> - ? ? ? ? ? ? ? l = gpio_mask;
> - ? ? ? ? ? ? ? break;
> -#endif
> - ? ? ? default:
> - ? ? ? ? ? ? ? WARN_ON(1);
> - ? ? ? ? ? ? ? return;
> + ? ? ? ? ? ? ? ? ? ? ? l &= ~gpio_mask;

This else case code is required for _enable_gpio_irqbank() only.
There should be no else part here.

> ? ? ? ?}
> +
> ? ? ? ?__raw_writel(l, reg);
> ?}
>

-V Charulatha
