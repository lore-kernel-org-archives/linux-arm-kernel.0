From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Jun 2016 13:39:31 +0200
Subject: [PATCH v2 02/14] thermal: sun8i_ths: Add support for the thermal
 sensor on Allwinner H3
In-Reply-To: <4a43f993-6b58-8303-466b-a9115ed26fd6@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-3-megous@megous.com>
 <20160625071044.GB4000@lukather>
 <4a43f993-6b58-8303-466b-a9115ed26fd6@megous.com>
Message-ID: <20160628113931.GD5550@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 25, 2016 at 05:12:41PM +0200, Ond?ej Jirman wrote:
> >> +	data->calreg = devm_ioremap_resource(&pdev->dev, res);
> >> +	if (IS_ERR(data->calreg)) {
> >> +		ret = PTR_ERR(data->calreg);
> >> +		dev_err(&pdev->dev, "failed to ioremap THS registers: %d\n", ret);
> >> +		return ret;
> >> +	}
> > 
> > Why did you remove the SID use through the nvmem framework ?!
> 
> Because it's overkill for reading a single word from memeory, the sunxi
> nvmem driver doesn't support H3, the sid is not documented in the
> datasheet, aside from some registger name/offset dump on the mailing
> list some time ago.
> 
> Aside from that, I've yet to see H3 soc that has anything else than 0 in
> the calibration data memory location. So this is basically nop.
> 
> Proposed solution seems simpler with no drawbacks that I can see,
> without resorting to dropping the thing entirely from this driver. Which
> I would be fine with too. Calibration is optional feature in the BSP
> kernel, so I assume dropping it may not do too much harm either.
> 
> If anyone wants to implement sid in the future, it will be easy enough
> to do with backwards compatibility. The second reg will become optional,
> and the driver can check for nvmem.

A lot of things in drivers boil down to "reading a single word from
memory". However, abstractions are here for a reason, and there's none
to not use it.

If that's not something we can use today, remove it entirely. And if
that becomes necessary, we will add an optional nvmem property.

> >> +
> >> +	irq = platform_get_irq(pdev, 0);
> >> +	if (irq < 0) {
> >> +		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
> >> +		return irq;
> >> +	}
> >> +
> >> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> >> +					sun8i_ths_irq_thread, IRQF_ONESHOT,
> >> +					dev_name(&pdev->dev), data);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	data->busclk = devm_clk_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(data->busclk)) {
> >> +		ret = PTR_ERR(data->busclk);
> >> +		dev_err(&pdev->dev, "failed to get ahb clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	data->clk = devm_clk_get(&pdev->dev, "ths");
> >> +	if (IS_ERR(data->clk)) {
> >> +		ret = PTR_ERR(data->clk);
> >> +		dev_err(&pdev->dev, "failed to get ths clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	data->reset = devm_reset_control_get(&pdev->dev, "ahb");
> >> +	if (IS_ERR(data->reset)) {
> >> +		ret = PTR_ERR(data->reset);
> >> +		dev_err(&pdev->dev, "failed to get reset: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = clk_prepare_enable(data->busclk);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to enable bus clk: %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = clk_prepare_enable(data->clk);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "failed to enable ths clk: %d\n", ret);
> >> +		goto err_disable_bus;
> >> +	}
> >> +
> >> +	ret = clk_set_rate(data->clk, THS_H3_CLK_IN);
> >> +	if (ret)
> >> +		goto err_disable_ths;
> >> +
> >> +	ret = reset_control_deassert(data->reset);
> >> +	if (ret) {
> >> +		dev_err(&pdev->dev, "reset deassert failed: %d\n", ret);
> >> +		goto err_disable_ths;
> >> +	}
> > 
> > Having runtime_pm support would be great.
> 
> Suspend/resume handling? I would have no way of testing it, other than
> blindly impelementing what BSP kernel does. Other than that, I can add
> it quite easily. It should be rather simple.

No, I mean runtime_pm, with runtime_suspend and runtime_resume, to
allow only powering up the device when it's used, and shut it down
when not used.

> >> +MODULE_AUTHOR("Ond?ej Jirman <megous@megous.com>");
> >> +MODULE_DESCRIPTION("Thermal sensor driver for Allwinner H3 SoC");
> >> +MODULE_LICENSE("GPL v2");
> > 
> > Looks quite good otherwise. It looks very similar to the older
> > touchscreen driver (without the touchscreen part).
> > 
> > Have you tried to merge the two?
> 
> What driver?

drivers/input/touchscreen/sun4i-ts.c

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160628/59304ceb/attachment-0001.sig>
