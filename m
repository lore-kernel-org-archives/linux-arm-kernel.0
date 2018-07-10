From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 10 Jul 2018 10:42:23 +0200
Subject: [PATCH v5 18/22] media: platform: Add Sunxi-Cedrus VPU decoder
 driver
In-Reply-To: <20180710080114.31469-19-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com>
 <20180710080114.31469-19-paul.kocialkowski@bootlin.com>
Message-ID: <20180710084223.jguogmvlwloi2utf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:01:10AM +0200, Paul Kocialkowski wrote:
> +static int cedrus_remove(struct platform_device *pdev)
> +{
> +       struct cedrus_dev *dev = platform_get_drvdata(pdev);
> +
> +       v4l2_info(&dev->v4l2_dev, "Removing " CEDRUS_NAME);

That log is kind of pointless.

> +static void cedrus_hw_set_capabilities(struct cedrus_dev *dev)
> +{
> +	unsigned int engine_version;
> +
> +	engine_version = cedrus_read(dev, VE_VERSION) >> VE_VERSION_SHIFT;
> +
> +	if (engine_version >= 0x1667)
> +		dev->capabilities |= CEDRUS_CAPABILITY_UNTILED;

The version used here would need a define, but I'm wondering if this
is the right solution here. You are using at the same time the version
ID returned by the register and the compatible in various places, and
they are both redundant. If you want to base the capabilities on the
compatible, then you can do it for all of those properties and
capabilities, and if you want to use the version register, then you
don't need all those compatibles but just one.

I think that basing all our capabilities on the compatible makes more
sense, since you need to have access to the registers in order to read
the version register, and this changes from one SoC generation to the
other (for example, keeping the reset line asserted would prevent you
from reading it, and the fact that there is a reset line depends on
the SoC).

> +int cedrus_hw_probe(struct cedrus_dev *dev)
> +{
> +	struct resource *res;
> +	int irq_dec;
> +	int ret;
> +
> +	irq_dec = platform_get_irq(dev->pdev, 0);
> +	if (irq_dec <= 0) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to get IRQ\n");
> +		return -ENXIO;
> +	}

You already have an error code returned by platform_get_irq, there's
no point in masking it and returning -ENXIO. This can even lead to
some bugs, for example when the error code is EPROBE_DEFER.

(and please add a new line there).

> +	ret = devm_request_threaded_irq(dev->dev, irq_dec, cedrus_irq,
> +					cedrus_bh, 0, dev_name(dev->dev),
> +					dev);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to request IRQ\n");
> +		return -ENXIO;
> +	}

Same thing here, you're masking the actual error code.

> +	res = platform_get_resource(dev->pdev, IORESOURCE_MEM, 0);
> +	dev->base = devm_ioremap_resource(dev->dev, res);
> +	if (!dev->base) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to map registers\n");
> +
> +		ret = -EFAULT;

ENOMEM is usually returned in such a case.

> +		goto err_sram;
> +	}
> +
> +	ret = clk_set_rate(dev->mod_clk, CEDRUS_CLOCK_RATE_DEFAULT);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to set clock rate\n");
> +		goto err_sram;
> +	}
> +
> +	ret = clk_prepare_enable(dev->ahb_clk);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to enable AHB clock\n");
> +
> +		ret = -EFAULT;
> +		goto err_sram;

Same thing for the error code.

> +	}
> +
> +	ret = clk_prepare_enable(dev->mod_clk);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to enable MOD clock\n");
> +
> +		ret = -EFAULT;
> +		goto err_ahb_clk;

Ditto.

> +	}
> +
> +	ret = clk_prepare_enable(dev->ram_clk);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to enable RAM clock\n");
> +
> +		ret = -EFAULT;
> +		goto err_mod_clk;

Ditto.

> +	}
> +
> +	ret = reset_control_reset(dev->rstc);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev, "Failed to apply reset\n");
> +
> +		ret = -EFAULT;

Ditto.

There's also a bunch of warnings/checks reported by checkpatch that
should be fixed in the next iteration: the spaces after a cast, the
NULL comparison, macros arguments precedence, parenthesis alignments
issues, etc.)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180710/8e9d4db5/attachment.sig>
