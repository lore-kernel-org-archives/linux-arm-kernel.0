From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 18:23:51 +0000
Subject: [PATCH 4/5] ASoC: dwc: Add devicetree support for Designware I2S
In-Reply-To: <547F3CAC.9050105@arm.com>
References: <547F3CAC.9050105@arm.com>
Message-ID: <20141203182351.GF7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 04:39:08PM +0000, Andrew Jackson wrote:

> Convert to driver to use either platform_data or device-tree for configuration
> of the device.  When using device-tree, the I2S block's configuration is read
> from the relevant registers: this reduces the amount of information required in
> the device tree.

This really needs to be split into two or more patches, there's a whole
bunch of refactoring to support this DT stuff which should be separate
from the DT addition itself.  Right now it's hard to tell what each
individual bit of the code is supposed to be doing, the patch is far too
large and doing far too many individual things.

> +	if (dev->using_pd) {
> +		ret = dev->i2s_clk_cfg(config);
> +		if (ret < 0) {
> +			dev_err(dev->dev, "runtime audio clk config fail\n");
> +			return ret;
> +		}
> +	} else {
> +		u32	bitclk;

Having this whole separate path for using platform data feels icky, we
don't want to have completely separate flows like this.  Checking for
the callbacks being there is probably fine but just having totally
separate code paths is a bit icky.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/b0fe93b2/attachment.sig>
