From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 11 Nov 2015 13:41:46 -0800
Subject: [PATCH v6 2/3] mtd: mtk-nor: mtk serial flash controller driver
In-Reply-To: <1446824889-16144-3-git-send-email-bayi.cheng@mediatek.com>
References: <1446824889-16144-1-git-send-email-bayi.cheng@mediatek.com>
 <1446824889-16144-3-git-send-email-bayi.cheng@mediatek.com>
Message-ID: <20151111214146.GL12143@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One more small comment, since you're respinning this:

On Fri, Nov 06, 2015 at 11:48:08PM +0800, Bayi Cheng wrote:
> diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
> new file mode 100644
> index 0000000..6582811
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/mtk-quadspi.c
> @@ -0,0 +1,475 @@

...

> +static int mtk_nor_drv_probe(struct platform_device *pdev)
> +{
> +	struct device_node *flash_np;
> +	struct resource *res;
> +	int ret;
> +	struct mt8173_nor *mt8173_nor;
> +
> +	if (!pdev->dev.of_node) {
> +		dev_err(&pdev->dev, "No DT found\n");
> +		return -EINVAL;
> +	}
> +
> +	mt8173_nor = devm_kzalloc(&pdev->dev, sizeof(*mt8173_nor), GFP_KERNEL);
> +	if (!mt8173_nor)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, mt8173_nor);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mt8173_nor->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mt8173_nor->base))
> +		return PTR_ERR(mt8173_nor->base);
> +
> +	mt8173_nor->spi_clk = devm_clk_get(&pdev->dev, "spi");
> +	if (IS_ERR(mt8173_nor->spi_clk)) {
> +		ret = PTR_ERR(mt8173_nor->spi_clk);
> +		goto nor_free;
> +	}
> +
> +	mt8173_nor->nor_clk = devm_clk_get(&pdev->dev, "sf");
> +	if (IS_ERR(mt8173_nor->nor_clk)) {
> +		ret = PTR_ERR(mt8173_nor->nor_clk);
> +		goto nor_free;
> +	}
> +
> +	mt8173_nor->dev = &pdev->dev;
> +	clk_prepare_enable(mt8173_nor->spi_clk);
> +	clk_prepare_enable(mt8173_nor->nor_clk);

You enable the clocks here, but...

> +
> +	/* only support one attached flash */
> +	flash_np = of_get_next_available_child(pdev->dev.of_node, NULL);
> +	if (!flash_np) {

... you might bail out here if there is no available flash node, and you
never disable the clocks. (Same is true if we fail to detect the flash;
you leave the no-longer-needed clocks enabled.) Seems like maybe you
should disable clocks on failure.

> +		dev_err(&pdev->dev, "no SPI flash device to configure\n");
> +		ret = -ENODEV;
> +		goto nor_free;
> +	}
> +	ret = mtk_nor_init(mt8173_nor, flash_np);
> +
> +nor_free:
> +	return ret;
> +}

Brian
