From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 24 Sep 2011 22:08:36 -0600
Subject: [PATCH v2 6/7] clk: Add initial WM831x clock driver
In-Reply-To: <1316730422-20027-7-git-send-email-mturquette@ti.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-7-git-send-email-mturquette@ti.com>
Message-ID: <20110925040836.GP24631@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 03:27:01PM -0700, Mike Turquette wrote:
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
> The WM831x and WM832x series of PMICs contain a flexible clocking
> subsystem intended to provide always on and system core clocks.  It
> features:
> 
> - A 32.768kHz crystal oscillator which can optionally be used to pass
>   through an externally generated clock.
> - A FLL which can be clocked from either the 32.768kHz oscillator or
>   the CLKIN pin.
> - A CLKOUT pin which can bring out either the oscillator or the FLL
>   output.
> - The 32.768kHz clock can also optionally be brought out on the GPIO
>   pins of the device.
> 
> This driver fully supports the 32.768kHz oscillator and CLKOUT.  The FLL
> is supported only in AUTO mode, the full flexibility of the FLL cannot
> currently be used.  The use of clock references other than the internal
> oscillator is not currently supported, and since clk_set_parent() is not
> implemented in the generic clock API the clock tree configuration cannot
> be changed at runtime.
> 
> Due to a lack of access to systems where the core SoC has been converted
> to use the generic clock API this driver has been compile tested only.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Signed-off-by: Mike Turquette <mturquette@ti.com>

A few minor comments below.  Otherwise looks fine to me.

> +static __devinit int wm831x_clk_probe(struct platform_device *pdev)
> +{
> +	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
> +	struct wm831x_clk *clkdata;
> +	int ret;
> +
> +	clkdata = kzalloc(sizeof(*clkdata), GFP_KERNEL);

If devm_kzalloc() is used, then all the kfree unwinding can be
dropped.

> +static int __init wm831x_clk_init(void)
> +{
> +	int ret;
> +
> +	ret = platform_driver_register(&wm831x_clk_driver);
> +	if (ret != 0)
> +		pr_err("Failed to register WM831x clock driver: %d\n", ret);
> +
> +	return ret;

No need for this song-and-dance.  The driver core is pretty well
debugged.  Just use "return platform_driver_register(...);"

g.
