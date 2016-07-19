From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 19 Jul 2016 14:40:51 +0200
Subject: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
In-Reply-To: <578DED17.7040309@free-electrons.com>
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160718125753.GF4199@lukather>
 <578DED17.7040309@free-electrons.com>
Message-ID: <20160719124051.GB4107@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 11:04:23AM +0200, Quentin Schulz wrote:
> >> +/* TP_CTRL1 bits */
> >> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE(x)	((x) << 12) /* 8 bits */
> >> +#define SUNXI_GPADC_STYLUS_UP_DEBOUNCE_EN	BIT(9)
> >> +#define SUNXI_GPADC_TOUCH_PAN_CALI_EN		BIT(6)
> >> +#define SUNXI_GPADC_TP_DUAL_EN			BIT(5)
> >> +#define SUNXI_GPADC_TP_MODE_EN			BIT(4)
> >> +#define SUNXI_GPADC_TP_ADC_SELECT		BIT(3)
> >> +#define SUNXI_GPADC_ADC_CHAN_SELECT(x)		((x) << 0)  /* 3 bits */
> > 
> > Usually the comments are on the line above. However, if you really
> > want to enforce something, you should rather mask the
> > value. Otherwise, that comment is pretty useless.
> > 
> 
> Do you mean something like that:
> #define SUNXI_GPADC_ADC_CHAN_SELECT(x)		(GENMASK(2,0) & x) ?

Yes.

> >> +/* TP_CTRL1 bits for sun6i SOCs */
> >> +#define SUNXI_GPADC_SUN6I_TOUCH_PAN_CALI_EN	BIT(7)
> >> +#define SUNXI_GPADC_SUN6I_TP_DUAL_EN		BIT(6)
> >> +#define SUNXI_GPADC_SUN6I_TP_MODE_EN		BIT(5)
> >> +#define SUNXI_GPADC_SUN6I_TP_ADC_SELECT		BIT(4)
> > 
> > Shouldn't that go in either a common define or the touchscreen driver?
> > 
> 
> Then shouldn't I put all defines in a common header? (sunxi-gpadc-mfd.h)

You should :)

> >> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> >> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> >> +					   sunxi_gpadc_fifo_data_irq_handler,
> >> +					   0, "fifo_data", info);
> >> +	if (ret < 0) {
> >> +		dev_err(&pdev->dev,
> >> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> >> +			ret);
> >> +		goto err;
> >> +	}
> >> +
> >> +	info->fifo_data_irq = irq;
> >> +	disable_irq(irq);
> > 
> > request_irq starts with irq enabled, which means that you can have an
> > interrupt showing up between your call to request_irq and the
> > disable_irq. 
> > 
> > How would that work?
> > 
> 
> Same as what I answered in Jonathan's mail:
> 
> "Once the interrupt is activated, the IP performs continuous conversions
> (temp_data_irq only periodically). I want these interrupts to be enabled
> only when I read the sysfs file or we get useless interrupts.
> In the current state of this driver's irq handlers, I only set values in
> structures and all the needed structures are already initialized before
> requesting irqs. So it does not look like a race. I can prevent races in
> future versions by adding an atomic flag if wanted."

Then please have a nice comment explaining that.

> >> +static struct platform_driver sunxi_gpadc_driver = {
> >> +	.driver = {
> >> +		.name = "sunxi-gpadc-iio",
> >> +	},
> >> +	.id_table = sunxi_gpadc_id,
> >> +	.probe = sunxi_gpadc_probe,
> >> +	.remove = sunxi_gpadc_remove,
> >> +};
> > 
> > Having some runtime_pm support for this would be great too.
> > 
> 
> Basically disabling the ADC and interrupts (as in the remove) in
> _suspend and _idle and reenabling everything in "before _suspend"-state
> in _resume I guess?

Well, yes and no. Your probe would not do any hardware
initialisation. You can pm_runtime_get_sync before using it, which
will call the suspend hook.

Once you're done, call pm_runtime_put, and that will disable the
hardware.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160719/9f70c297/attachment.sig>
