From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 12 Oct 2016 12:30:29 +0200
Subject: [PATCH v7 2/8] power: add power sequence library
In-Reply-To: <1474342607-27512-3-git-send-email-peter.chen@nxp.com>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
 <1474342607-27512-3-git-send-email-peter.chen@nxp.com>
Message-ID: <4691591.qnCGxrEkrZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 20. September 2016, 11:36:41 CEST schrieb Peter Chen:
> We have an well-known problem that the device needs to do some power
> sequence before it can be recognized by related host, the typical
> example like hard-wired mmc devices and usb devices.
> 
> This power sequence is hard to be described at device tree and handled by
> related host driver, so we have created a common power sequence
> library to cover this requirement. The core code has supplied
> some common helpers for host driver, and individual power sequence
> libraries handle kinds of power sequence for devices.
> 
> pwrseq_generic is intended for general purpose of power sequence, which
> handles gpios and clocks currently, and can cover regulator and pinctrl
> in future. The host driver just needs to call of_pwrseq_on/of_pwrseq_off
> if only one power sequence is needed, else call of_pwrseq_on_list
> /of_pwrseq_off_list instead (eg, USB hub driver).
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>

first of all, glad to see this move forward. I've only some qualms with the 
static number of allocated power sequences below.

[...]

> diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
> new file mode 100644
> index 0000000..dff5e35
> --- /dev/null
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -0,0 +1,45 @@
> +#
> +# Power Sequence library
> +#
> +
> +config POWER_SEQUENCE
> +	bool
> +
> +menu "Power Sequence Support"
> +
> +config PWRSEQ_GENERIC
> +	bool "Generic power sequence control"
> +	depends on OF
> +	select POWER_SEQUENCE
> +	help
> +	   It is used for drivers which needs to do power sequence
> +	   (eg, turn on clock, toggle reset gpio) before the related
> +	   devices can be found by hardware. This generic one can be
> +	   used for common power sequence control.
> +
> +config PWRSEQ_GENERIC_INSTANCE_NUMBER
> +	int "Number of Generic Power Sequence Instance"
> +	depends on PWRSEQ_GENERIC
> +	range 1 10
> +	default 2
> +	help
> +	   Usually, there are not so many devices needs power sequence, we set two
> +	   as default value.

limiting this to some arbitary compile-time number somehow seems crippling for 
the single-image approach. I.e. a distribution might select something and 
during its lifetime the board requiring n+1 power-sequences appears and thus 
needs a different kernel version just to support that additional sequence.

Also, board designers are creative, and there were already complex examples 
mentioned elsewhere, so nothing keeps people from inventing something even 
more complex.

[...]

> diff --git a/drivers/power/pwrseq/pwrseq_generic.c
> b/drivers/power/pwrseq/pwrseq_generic.c new file mode 100644
> index 0000000..bcd16c3
> --- /dev/null
> +++ b/drivers/power/pwrseq/pwrseq_generic.c

[...]

> +static int pwrseq_generic_get(struct device_node *np, struct pwrseq
> *pwrseq) +{
> +	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> +	enum of_gpio_flags flags;
> +	int reset_gpio, clk, ret = 0;
> +
> +	for (clk = 0; clk < PWRSEQ_MAX_CLKS; clk++) {
> +		pwrseq_gen->clks[clk] = of_clk_get(np, clk);
> +		if (IS_ERR(pwrseq_gen->clks[clk])) {
> +			ret = PTR_ERR(pwrseq_gen->clks[clk]);
> +			if (ret != -ENOENT)
> +				goto err_put_clks;
> +			pwrseq_gen->clks[clk] = NULL;
> +			break;
> +		}
> +	}
> +
> +	reset_gpio = of_get_named_gpio_flags(np, "reset-gpios", 0, &flags);
> +	if (gpio_is_valid(reset_gpio)) {
> +		unsigned long gpio_flags;
> +
> +		if (flags & OF_GPIO_ACTIVE_LOW)
> +			gpio_flags = GPIOF_ACTIVE_LOW | GPIOF_OUT_INIT_LOW;
> +		else
> +			gpio_flags = GPIOF_OUT_INIT_HIGH;
> +
> +		ret = gpio_request_one(reset_gpio, gpio_flags,
> +				"pwrseq-reset-gpios");
> +		if (ret)
> +			goto err_put_clks;
> +
> +		pwrseq_gen->gpiod_reset = gpio_to_desc(reset_gpio);
> +		of_property_read_u32(np, "reset-duration-us",
> +				&pwrseq_gen->duration_us);
> +	} else {
> +		if (reset_gpio == -ENOENT)
> +			return 0;
> +
> +		ret = reset_gpio;
> +		pr_err("Failed to get reset gpio on %s, err = %d\n",
> +				np->full_name, reset_gpio);
> +		goto err_put_clks;
> +	}
> +
> +	return ret;
> +
> +err_put_clks:
> +	while (--clk >= 0)
> +		clk_put(pwrseq_gen->clks[clk]);
> +	return ret;
> +}
> +
> +static const struct of_device_id generic_id_table[] = {
> +	{ .compatible = "generic",},
> +	{ /* sentinel */ }
> +};
> +
> +static int __init pwrseq_generic_register(void)
> +{
> +	struct pwrseq_generic *pwrseq_gen;
> +	int i;
> +
> +	for (i = 0; i < CONFIG_PWRSEQ_GENERIC_INSTANCE_NUMBER; i++) {
> +		pwrseq_gen = kzalloc(sizeof(*pwrseq_gen), GFP_KERNEL);
> +		if (!pwrseq_gen)
> +			return -ENOMEM;
> +
> +		pwrseq_gen->pwrseq.pwrseq_of_match_table = generic_id_table;
> +		pwrseq_gen->pwrseq.get = pwrseq_generic_get;
> +		pwrseq_gen->pwrseq.on = pwrseq_generic_on;
> +		pwrseq_gen->pwrseq.off = pwrseq_generic_off;
> +		pwrseq_gen->pwrseq.put = pwrseq_generic_put;
> +		pwrseq_gen->pwrseq.free = pwrseq_generic_free;
> +
> +		pwrseq_register(&pwrseq_gen->pwrseq);
> +	}
> +
> +	return 0;
> +}
> +postcore_initcall(pwrseq_generic_register)

I see that you need to have it preallocated for the compatible matching, but 
wouldn't it also work to either just register the type and allocate 
dynamically or otherwise just allocate a new spare everytime 
pwrseq_generic_get() picks up the previous spare?

That way the total number of power sequences can still be dynamic without 
haggling over how many power sequences should be the build-default in the 
generic configs.
