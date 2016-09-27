From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 Sep 2016 20:40:45 +0100
Subject: [PATCH 1/4] mfd: ti_am335x_tscadc: store physical address
In-Reply-To: <20160921161134.6951-2-mugunthanvnm@ti.com>
References: <20160921161134.6951-1-mugunthanvnm@ti.com>
 <20160921161134.6951-2-mugunthanvnm@ti.com>
Message-ID: <20160927194045.GK21388@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 21 Sep 2016, Mugunthan V N wrote:

> store the physical address of the device in its priv to use it
> for DMA addressing in the client drivers.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 1 +
>  include/linux/mfd/ti_am335x_tscadc.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index c8f027b..0f3fab4 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -183,6 +183,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		tscadc->irq = err;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	tscadc->tscadc_phys_base = res->start;

This is unusual.  Can't you use a virt_to_phys() variant instead?

>  	tscadc->tscadc_base = devm_ioremap_resource(&pdev->dev, res);
>  	if (IS_ERR(tscadc->tscadc_base))
>  		return PTR_ERR(tscadc->tscadc_base);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 7f55b8b..e45a208 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -155,6 +155,7 @@ struct ti_tscadc_dev {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	void __iomem *tscadc_base;
> +	phys_addr_t tscadc_phys_base;
>  	int irq;
>  	int used_cells;	/* 1-2 */
>  	int tsc_wires;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
