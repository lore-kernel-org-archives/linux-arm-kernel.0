From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 May 2012 13:24:10 -0600
Subject: [PATCH] pinctrl: mxs: add gpio range support
In-Reply-To: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
References: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4FB5505A.7010004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2012 11:56 PM, Shawn Guo wrote:
> The mxs pins are organized in banks and each bank contains 32 pins.
> i.MX23 has 4 banks in total, and every pin in the first 3 banks has
> gpio function available.  i.MX28 has 7 banks and the first 5 banks
> are capable of gpio mode.
> 
> As the gpio base is runtime determined for each port when booting
> from device tree, the .base of struct pinctrl_gpio_range can only be
> initialized with a offset local to the port, and have to plus gpio base
> of the port at runtime.

> diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c

> +static struct pinctrl_gpio_range imx23_gpio_ranges[] = {
> +	{ .name = "gpio", .id = 0, .base = 0, .pin_base = 0,  .npins = 32, },
> +	{ .name = "gpio", .id = 1, .base = 0, .pin_base = 32, .npins = 31, },

Is that last number meant to be 31 or 32?

> +	{ .name = "gpio", .id = 2, .base = 0, .pin_base = 64, .npins = 32, },

> diff --git a/drivers/pinctrl/pinctrl-mxs.c b/drivers/pinctrl/pinctrl-mxs.c

> @@ -500,6 +532,26 @@ int __devinit mxs_pinctrl_probe(struct platform_device *pdev,
>  	mxs_pinctrl_desc.npins = d->soc->npins;
>  	mxs_pinctrl_desc.name = dev_name(&pdev->dev);
>  
> +	for_each_child_of_node(np, child) {
> +		if (!of_device_is_compatible(child, "fsl,mxs-gpio"))
> +			continue;
> +
> +		id = of_alias_get_id(child, "gpio");

Hmmm. I'm not sure if using /aliases is the correct approach here.
Rather, shouldn't the pin controller node have an explicit list of GPIO
phandles in the order they're needed.

In other words, rather than:

	aliases {
		gpio0 = "/some/path/gpio at 0";
		gpio1 = "/some/path/gpio at 1";
		...
	};

Instead have the following property in the pin controller's own node:

gpio-controllers = <&imx_gpio0 &imx_gpio1 ...>;

That seems a little more direct/explicit; relying on /aliases seems
slightly fragile - what if someone wants to change those aliases and
doesn't realize the implications?
