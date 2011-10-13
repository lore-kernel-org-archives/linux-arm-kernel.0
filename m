From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 13 Oct 2011 14:44:09 +0100
Subject: [PATCH] ARM imx51: Add Armadeus systems APF51 support
In-Reply-To: <1318512796-8126-1-git-send-email-julien.boibessot@free.fr>
References: <1318512796-8126-1-git-send-email-julien.boibessot@free.fr>
Message-ID: <20111013134409.GK1098@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 03:33:16PM +0200, julien.boibessot at free.fr wrote:

> +static struct gpio apf51_wm8311_gpios[] = {
> +	{ APF51_WM8311_IRQ_GPIO, GPIOF_IN, "wm8311_irq" },
> +	{ APF51_WM8311_TOUCH_DETECT_GPIO, GPIOF_IN, "wm8311_touch_detect" },
> +	{ APF51_WM8311_TOUCH_EOC_GPIO, GPIOF_IN, "wm8311_touch_eoc" },
> +};

> +static int apf51_wm8311_pre_init(struct wm831x *wm831x)
> +{
> +	int ret;
> +
> +	ret = gpio_request_array(apf51_wm8311_gpios,
> +					ARRAY_SIZE(apf51_wm8311_gpios));
> +	if (ret) {
> +		pr_err("failed to get WM8311 GPIOs: %d\n", ret);
> +		return ret;
> +	}

These are all interrupts, if you need to request them as GPIOs then the
IRQ implementation is buggy.

> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_IRQ_GPIO),
> +					IRQF_TRIGGER_FALLING);
> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_TOUCH_DETECT_GPIO),
> +					IRQF_TRIGGER_FALLING);
> +	irq_set_irq_type(gpio_to_irq(APF51_WM8311_TOUCH_EOC_GPIO),
> +					IRQF_TRIGGER_FALLING);

Similarly here, request_threaded_irq() should be doing anything that's
needed.

> +static int apf51_wm8311_post_init(struct wm831x *wm831x)
> +{
> +	/* Configure GPIO6: input, pwdmn 0, inverted, CMOS, enable, pullup */
> +	wm831x_reg_write(wm831x, WM831X_GPIO6_CONTROL, 0xc080);

Use gpio_defaults in the platform data.

> +static struct wm831x_pdata apf51_wm8311_pdata = {
> +	.pre_init = apf51_wm8311_pre_init,
> +	.post_init = apf51_wm8311_post_init,
> +	.irq_cmos = 1,
> +	.irq_base = MXC_BOARD_IRQ_START,
> +	.status = {
> +		&apf51_wm8311_led1_pdata,
> +		&apf51_wm8311_led2_pdata,
> +	},
> +	.touch = &apf51_wm8311_touch_pdata,
> +};

I'm surprised you've not got the ARM supply wired up to cpufreq, though
I don't know if the cpufreq driver for the CPU got merged.
