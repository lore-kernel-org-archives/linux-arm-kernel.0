From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 29 May 2018 21:15:26 +0200
Subject: [PATCH] mtd: atmel-quadspi: add suspend/resume hooks
In-Reply-To: <1527091728-19895-1-git-send-email-claudiu.beznea@microchip.com>
References: <1527091728-19895-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20180529211526.7653c6eb@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 May 2018 19:08:48 +0300
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Implement suspend/resume hooks.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/mtd/spi-nor/atmel-quadspi.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/atmel-quadspi.c b/drivers/mtd/spi-nor/atmel-quadspi.c
> index 6c5708bacad8..85d7610fb920 100644
> --- a/drivers/mtd/spi-nor/atmel-quadspi.c
> +++ b/drivers/mtd/spi-nor/atmel-quadspi.c
> @@ -737,6 +737,28 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int atmel_qspi_suspend(struct device *dev)
> +{
> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> +
> +	clk_disable_unprepare(aq->clk);
> +
> +	return 0;
> +}
> +
> +static int atmel_qspi_resume(struct device *dev)
> +{
> +	struct atmel_qspi *aq = dev_get_drvdata(dev);
> +
> +	clk_prepare_enable(aq->clk);
> +
> +	return atmel_qspi_init(aq);
> +}
> +#endif

You can avoid this #ifdef section if you use the __maybe_unused
specifier:

static __maybe_unused int atmel_qspi_suspend(struct device *dev)
...

> +
> +static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
> +			 atmel_qspi_resume);
>  
>  static const struct of_device_id atmel_qspi_dt_ids[] = {
>  	{ .compatible = "atmel,sama5d2-qspi" },
> @@ -749,6 +771,7 @@ static struct platform_driver atmel_qspi_driver = {
>  	.driver = {
>  		.name	= "atmel_qspi",
>  		.of_match_table	= atmel_qspi_dt_ids,
> +		.pm	= &atmel_qspi_pm_ops,
>  	},
>  	.probe		= atmel_qspi_probe,
>  	.remove		= atmel_qspi_remove,
