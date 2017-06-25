From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sun, 25 Jun 2017 13:41:01 -0700
Subject: [RFC PATCH 2/3] remoteproc: imx_rproc: add a NXP/Freescale imx
 rproc driver
In-Reply-To: <20170614204855.18347-3-o.rempel@pengutronix.de>
References: <20170614204855.18347-1-o.rempel@pengutronix.de>
 <20170614204855.18347-3-o.rempel@pengutronix.de>
Message-ID: <20170625204101.GB26155@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 14 Jun 13:48 PDT 2017, Oleksij Rempel wrote:

> From: Oleksij Rempel <linux@rempel-privat.de>
> 
> this driver was tested on NXP imx7d but should work on
> imx6sx as well.
> It will upload firmware to OCRAM, which shared memory between
> Cortex A7 and Cortex M4, then turn M4 on.
> 

This looks very generic, are there any IMX specific parts or is this the
"default" way of integrating a M4? Could we perhaps come up with a
common M4-rproc driver?


Even though it will be rather short, you need a DT binding document
defining the compatible and the few properties that you use.

> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  drivers/remoteproc/Kconfig     |   8 ++
>  drivers/remoteproc/Makefile    |   1 +
>  drivers/remoteproc/imx_rproc.c | 264 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+)
>  create mode 100644 drivers/remoteproc/imx_rproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index faad69a1a597..8d33bff4f530 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -130,6 +130,14 @@ config ST_SLIM_REMOTEPROC
>  	tristate
>  	depends on REMOTEPROC
>  
> +config IMX_REMOTEPROC

Please make an attempt to keep entries in the Kconfig and Makefile
alphabetically sorted.

> +	tristate "IMX6/7 remoteproc support"
> +	depends on SOC_IMX6SX || SOC_IMX7D
> +	depends on REMOTEPROC
> +	help
> +	  TODO, write some thing here
> +	  This can be either built-in or a loadable module.
> +
>  endif # REMOTEPROC
>  
>  endmenu
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index ffc5e430df27..d351c25cdb4e 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -19,3 +19,4 @@ qcom_wcnss_pil-y			+= qcom_wcnss.o
>  qcom_wcnss_pil-y			+= qcom_wcnss_iris.o
>  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
>  obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
> +obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> new file mode 100644
> index 000000000000..6bef85237a27
> --- /dev/null
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -0,0 +1,264 @@
> +/*
> + * Oleksij Rempel <o.rempel@pengutronix.de>
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +#define IMX7D_ENABLE_M4			BIT(3)
> +#define IMX7D_SW_M4P_RST		BIT(2)
> +#define IMX7D_SW_M4C_RST		BIT(1)
> +#define IMX7D_SW_M4C_NON_SCLR_RST	BIT(0)
> +
> +#define IMX7D_M4_RST_MASK		0xf
> +
> +
> +#define IMX7D_RPROC_MEM_MAX		2
> +enum {
> +	IMX7D_RPROC_IMEM,
> +	IMX7D_RPROC_DMEM,
> +};
> +
> +static const char *mem_names[IMX7D_RPROC_MEM_MAX] = {
> +	[IMX7D_RPROC_IMEM]	= "imem",
> +	[IMX7D_RPROC_DMEM]	= "dmem",
> +};
> +
> +/**
> + * struct imx_rproc_mem - slim internal memory structure
> + * @cpu_addr: MPU virtual address of the memory region
> + * @bus_addr: Bus address used to access the memory region
> + * @size: Size of the memory region
> + */
> +struct imx_rproc_mem {
> +	void __iomem *cpu_addr;
> +	phys_addr_t bus_addr;
> +	size_t size;
> +};
> +
> +struct imx_rproc_dcfg {
> +	int offset;
> +};

Unless you foresee this being expanded in the very near future I would
prefer that you just inline the offset in imx_rproc and put (void*)0xc
as .data in your of_match (typecast the of_device_get_match_data result
to unsigned long).

> +
> +struct imx_rproc {
> +	struct device			*dev;
> +	struct regmap			*regmap;
> +	struct rproc			*rproc;
> +	const struct imx_rproc_dcfg	*dcfg;
> +	struct imx_rproc_mem mem[IMX7D_RPROC_MEM_MAX];
> +	struct clk		*clk;
> +};
> +
> +static const struct imx_rproc_dcfg imx_rproc_cfg_imx7d = {
> +	.offset = 0xc,
> +};
> +
> +static int imx_rproc_start(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +	struct device *dev = priv->dev;
> +	int ret;
> +
> +	ret = clk_enable(priv->clk);
> +	if (ret) {
> +		dev_err(&rproc->dev, "Failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(priv->regmap, dcfg->offset,
> +				 IMX7D_M4_RST_MASK,
> +				 IMX7D_SW_M4C_RST | IMX7D_SW_M4P_RST | IMX7D_ENABLE_M4);
> +	if (ret) {
> +		dev_err(dev, "Filed to enable M4!\n");
> +		clk_disable(priv->clk);
> +	}
> +
> +	return ret;
> +}
> +
> +static int imx_rproc_stop(struct rproc *rproc)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	const struct imx_rproc_dcfg *dcfg = priv->dcfg;
> +	struct device *dev = priv->dev;
> +	int ret;
> +
> +	ret = regmap_update_bits(priv->regmap, dcfg->offset,
> +				 IMX7D_M4_RST_MASK,
> +				 IMX7D_SW_M4C_NON_SCLR_RST);
> +	if (ret)
> +		dev_err(dev, "Filed to stop M4!\n");
> +
> +	clk_disable(priv->clk);
> +
> +	return ret;
> +}
> +
> +static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> +{
> +	struct imx_rproc *priv = rproc->priv;
> +	void *va = NULL;
> +	int i;
> +
> +	for (i = 0; i < IMX7D_RPROC_MEM_MAX; i++) {
> +		if (da != priv->mem[i].bus_addr)
> +			continue;
> +
> +		if (len <= priv->mem[i].size) {
> +			/* __force to make sparse happy with type conversion */
> +			va = (__force void *)priv->mem[i].cpu_addr;
> +			break;
> +		}
> +	}
> +
> +	dev_dbg(&rproc->dev, "da = 0x%llx len = 0x%x va = 0x%p\n", da, len, va);
> +
> +	return va;
> +}
> +
> +static const struct rproc_ops imx_rproc_ops = {
> +	.start		= imx_rproc_start,
> +	.stop		= imx_rproc_stop,
> +	.da_to_va       = imx_rproc_da_to_va,
> +};
> +
> +static const struct of_device_id imx_rproc_of_match[] = {
> +	{ .compatible = "fsl,imx7d-rproc", .data = &imx_rproc_cfg_imx7d },

.data = (void*)0xc

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, imx_rproc_of_match);

By using of_device_get_match_data() you don't need to reference your
of_device_id table, so please move it down to your definition of
imx_rproc_driver.

[..]
> +static int imx_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct imx_rproc *priv;
> +	struct rproc *rproc;
> +	struct regmap_config config = { .name = "imx_rproc" };
> +	const struct imx_rproc_dcfg *dcfg;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
> +	if (IS_ERR(regmap)) {
> +		dev_err(dev, "failed to find syscon\n");
> +		return PTR_ERR(regmap);
> +	}
> +        regmap_attach_dev(dev, regmap, &config);

Indentation...

> +
> +	/* set some other name then imx */
> +	rproc = rproc_alloc(dev, "imx_rproc", &imx_rproc_ops, NULL, sizeof(*priv));
> +	if (!rproc) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	dcfg = of_device_get_match_data(dev);

priv->cfg_offset = (unsigned long)of_device_get_match_data(dev);

> +	if (!dcfg)
> +		return -EINVAL;
> +
> +	priv = rproc->priv;
> +	priv->rproc = rproc;
> +	priv->regmap = regmap;
> +	priv->dcfg = dcfg;
> +
> +	dev_set_drvdata(dev, rproc);
> +
> +	ret = imx_rproc_addr_init(priv, pdev);
> +	if (ret) {
> +		dev_err(dev, "filed on imx_rproc_addr_init\n");
> +		goto err_put_rproc;
> +	}
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "Failed to get clock\n");

rproc_free()

> +		return PTR_ERR(priv->clk);
> +	}
> +
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "rproc_add failed\n");
> +		goto err_put_rproc;
> +	}
> +
> +	ret = clk_prepare(priv->clk);

1) You're not unpreparing this clock in remove.

2) Why do you prepare the clock here instead of prepare_enable &
disable_unprepare it during start/stop?

3) This is racy as you could have start() being called between
rproc_add() and clk_prepare() (although highly unlikely...).

> +	if (ret)
> +		dev_err(dev, "failed to get clock\n");

s/get/prepare/

Regards,
Bjorn
