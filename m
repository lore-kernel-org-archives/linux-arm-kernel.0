From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 22 Aug 2012 17:02:41 +0100
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <1345619928-15446-2-git-send-email-b29396@freescale.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
Message-ID: <20120822160241.GR7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 03:18:42PM +0800, Dong Aisheng wrote:

> From: Dong Aisheng <dong.aisheng@linaro.org>

> Add regmap based imx syscon driver.

Nice to see more regmap-mmio usage!

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

from a regmap point of view.

> +int imx_syscon_write(struct device_node *np, u32 reg, u32 val)
> +{
> +	struct device *dev;
> +	struct imx_syscon *syscon;
> +	int ret = 0;
> +
> +	dev = driver_find_device(&imx_syscon_driver.driver, NULL, np,
> +				 imx_syscon_match);
> +	if (!dev)
> +		return -EPROBE_DEFER;
> +
> +	syscon = dev_get_drvdata(dev);
> +	ret = regmap_write(syscon->regmap, reg, val);

It'd be good to provide a way of retrieving the regmap so that drivers
for subsystems with generic regmap code could use the framework features
(regulator is one example that I just mentioned in my other mail).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120822/bde6a801/attachment.sig>
