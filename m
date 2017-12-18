From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 18 Dec 2017 21:19:07 +0100
Subject: [PATCH v6] atmel_flexcom: Support resuming after a chip reset
In-Reply-To: <20171212162119.32138-1-romain.izard.pro@gmail.com>
References: <20171212162119.32138-1-romain.izard.pro@gmail.com>
Message-ID: <20171218201907.GU7022@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2017 at 17:21:19 +0100, Romain Izard wrote:
> The controller used by a flexcom module is configured at boot, and left
> alone after this. In the suspend mode called "backup with self-refresh"
> available on SAMA5D2, the chip will resume with most of its registers
> reset. In this case, we need to restore the state of the flexcom driver
> on resume.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>

Seems good to me

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> Changes in v5:
> * extract from the patch series, and send as a standalone patch
> 
> Changes in v6:
> * Reword the patch title and description
> * Rename the internal structure to ddata
> 
>  drivers/mfd/atmel-flexcom.c | 63 ++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 48 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/atmel-flexcom.c b/drivers/mfd/atmel-flexcom.c
> index 064bde9cff5a..f684a93a3340 100644
> --- a/drivers/mfd/atmel-flexcom.c
> +++ b/drivers/mfd/atmel-flexcom.c
> @@ -39,34 +39,43 @@
>  #define FLEX_MR_OPMODE(opmode)	(((opmode) << FLEX_MR_OPMODE_OFFSET) &	\
>  				 FLEX_MR_OPMODE_MASK)
>  
> +struct atmel_flexcom {
> +	void __iomem *base;
> +	u32 opmode;
> +	struct clk *clk;
> +};
>  
>  static int atmel_flexcom_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	struct clk *clk;
>  	struct resource *res;
> -	void __iomem *base;
> -	u32 opmode;
> +	struct atmel_flexcom *ddata;
>  	int err;
>  
> -	err = of_property_read_u32(np, "atmel,flexcom-mode", &opmode);
> +	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ddata);
> +
> +	err = of_property_read_u32(np, "atmel,flexcom-mode", &ddata->opmode);
>  	if (err)
>  		return err;
>  
> -	if (opmode < ATMEL_FLEXCOM_MODE_USART ||
> -	    opmode > ATMEL_FLEXCOM_MODE_TWI)
> +	if (ddata->opmode < ATMEL_FLEXCOM_MODE_USART ||
> +	    ddata->opmode > ATMEL_FLEXCOM_MODE_TWI)
>  		return -EINVAL;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	ddata->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ddata->base))
> +		return PTR_ERR(ddata->base);
>  
> -	clk = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	ddata->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ddata->clk))
> +		return PTR_ERR(ddata->clk);
>  
> -	err = clk_prepare_enable(clk);
> +	err = clk_prepare_enable(ddata->clk);
>  	if (err)
>  		return err;
>  
> @@ -76,9 +85,9 @@ static int atmel_flexcom_probe(struct platform_device *pdev)
>  	 * inaccessible and are read as zero. Also the external I/O lines of the
>  	 * Flexcom are muxed to reach the selected device.
>  	 */
> -	writel(FLEX_MR_OPMODE(opmode), base + FLEX_MR);
> +	writel(FLEX_MR_OPMODE(ddata->opmode), ddata->base + FLEX_MR);
>  
> -	clk_disable_unprepare(clk);
> +	clk_disable_unprepare(ddata->clk);
>  
>  	return devm_of_platform_populate(&pdev->dev);
>  }
> @@ -89,10 +98,34 @@ static const struct of_device_id atmel_flexcom_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, atmel_flexcom_of_match);
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int atmel_flexcom_resume(struct device *dev)
> +{
> +	struct atmel_flexcom *ddata = dev_get_drvdata(dev);
> +	int err;
> +	u32 val;
> +
> +	err = clk_prepare_enable(ddata->clk);
> +	if (err)
> +		return err;
> +
> +	val = FLEX_MR_OPMODE(ddata->opmode),
> +	writel(val, ddata->base + FLEX_MR);
> +
> +	clk_disable_unprepare(ddata->clk);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(atmel_flexcom_pm_ops, NULL,
> +			 atmel_flexcom_resume);
> +
>  static struct platform_driver atmel_flexcom_driver = {
>  	.probe	= atmel_flexcom_probe,
>  	.driver	= {
>  		.name		= "atmel_flexcom",
> +		.pm		= &atmel_flexcom_pm_ops,
>  		.of_match_table	= atmel_flexcom_of_match,
>  	},
>  };
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
