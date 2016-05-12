From: gnurou@gmail.com (Alexandre Courbot)
Date: Thu, 12 May 2016 19:26:32 +0900
Subject: [PATCH v9 1/2] gpio: mmio: add DT support for memory-mapped GPIOs
In-Reply-To: <2c0675cd6f67bd487105c46c38c72d49d84d4df8.1462911225.git.chunkeey@googlemail.com>
References: <cover.1462911225.git.chunkeey@googlemail.com>
 <cover.1462911225.git.chunkeey@googlemail.com>
 <2c0675cd6f67bd487105c46c38c72d49d84d4df8.1462911225.git.chunkeey@googlemail.com>
Message-ID: <0a1ab2b6-b4c5-44d7-abb4-ce1e9da7e477@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, May 11, 2016 6:34:34 PM JST, Christian Lamparter wrote:
> From: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
>
> This patch adds support for defining memory-mapped GPIOs which
> are compatible with the existing gpio-mmio interface. The generic
> library provides support for many memory-mapped GPIO controllers
> that are found in various on-board FPGA and ASIC solutions that
> are used to control board's switches, LEDs, chip-selects,
> Ethernet/USB PHY power, etc.
>
> For setting GPIO's there are three configurations:

s/GPIO's/GPIOs

> 	1. single input/output register resource (named "dat"),
> 	2. set/clear pair (named "set" and "clr"),
> 	3. single output register resource and single input resource
> 	   ("set" and dat").
>
> The configuration is detected by which resources are present.
> For the single output register, this drives a 1 by setting a bit
> and a zero by clearing a bit.  For the set clr pair, this drives
> a 1 by setting a bit in the set register and clears it by setting
> a bit in the clear register. The configuration is detected by
> which resources are present.

The last sentence of this paragraph repeats for first one.

>
> For setting the GPIO direction, there are three configurations:
> 	a. simple bidirectional GPIOs that requires no configuration.
> 	b. an output direction register (named "dirout")
> 	   where a 1 bit indicates the GPIO is an output.
> 	c. an input direction register (named "dirin")
> 	   where a 1 bit indicates the GPIO is an input.
>
> The first user for this binding is "wd,mbl-gpio".
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
> ---
>  drivers/gpio/gpio-mmio.c | 68 
> ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
> index 6c1cb3b..f72e40e 100644
> --- a/drivers/gpio/gpio-mmio.c
> +++ b/drivers/gpio/gpio-mmio.c
> @@ -61,6 +61,8 @@ o        `                     ~~~~\___/~~~~  
>   ` controller in FPGA is ,.`
>  #include <linux/bitops.h>
>  #include <linux/platform_device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  static void bgpio_write8(void __iomem *reg, unsigned long data)
>  {
> @@ -569,6 +571,58 @@ static void __iomem *bgpio_map(struct 
> platform_device *pdev,
>  	return devm_ioremap_resource(&pdev->dev, r);
>  }
>  
> +#ifdef CONFIG_OF
> +static int bgpio_basic_mmio_parse_dt(struct platform_device *pdev,
> +				     struct bgpio_pdata *pdata,
> +				     unsigned long *flags)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pdata->base = -1;
> +
> +	if (of_property_read_bool(dev->of_node, "no-output"))
> +		*flags |= BGPIOF_NO_OUTPUT;

I don't think it is a good idea to add "generic" properties. Whether a 
controller is capable of output or not should be determined by its 
compatible string only, and not a vague property.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bgpio_of_match[] = {
> +	{ .compatible = "wd,mbl-gpio", .data = bgpio_basic_mmio_parse_dt },

Mmm cannot you determine whether your controller is capable of output or 
not just from the compatible property here? If so, the 
bgpio_basic_mmio_parse_dt seems to be unneeded. If not, then this is 
dependent on the wd,mbl-gpio binding and should be renamed accordingly.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bgpio_of_match);
> +
> +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> +					  unsigned long *flags)
> +{
> +	const int (*parse_dt)(struct platform_device *,
> +			      struct bgpio_pdata *, unsigned long *);
> +	struct bgpio_pdata *pdata;
> +	int err;
> +
> +	parse_dt = of_device_get_match_data(&pdev->dev);
> +	if (!parse_dt)
> +		return NULL;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bgpio_pdata),
> +			     GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = parse_dt(pdev, pdata, flags);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	return pdata;
> +}
> +#else
> +static struct bgpio_pdata *bgpio_parse_dt(struct platform_device *pdev,
> +					  unsigned long *flags)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  static int bgpio_pdev_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -579,10 +633,19 @@ static int bgpio_pdev_probe(struct 
> platform_device *pdev)
>  	void __iomem *dirout;
>  	void __iomem *dirin;
>  	unsigned long sz;
> -	unsigned long flags = pdev->id_entry->driver_data;
> +	unsigned long flags = 0;
>  	int err;
>  	struct gpio_chip *gc;
> -	struct bgpio_pdata *pdata = dev_get_platdata(dev);
> +	struct bgpio_pdata *pdata;
> +
> +	pdata = bgpio_parse_dt(pdev, &flags);
> +	if (IS_ERR(pdata))
> +		return PTR_ERR(pdata);
> +
> +	if (!pdata) {
> +		pdata = dev_get_platdata(dev);
> +		flags = pdev->id_entry->driver_data;
> +	}
>  
>  	r = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dat");
>  	if (!r)
> @@ -646,6 +709,7 @@ MODULE_DEVICE_TABLE(platform, bgpio_id_table);
>  static struct platform_driver bgpio_driver = {
>  	.driver = {
>  		.name = "basic-mmio-gpio",
> +		.of_match_table = of_match_ptr(bgpio_of_match),
>  	},
>  	.id_table = bgpio_id_table,
>  	.probe = bgpio_pdev_probe,

It seems to me that this patch does two things:

1) Add code to support device tree lookup
2) Add support for "wd,mbl-gpio".

If true, these two things should be in their own patches. You should also 
have another patch that adds the DT bindings for "wd,mbl-gpio", so I would 
do things in that order:

1/3: DT support for basic-mmio-gpio
2/3: DT bindings for "wd,mbl-gpio" (and have them validated by the DT 
people - e.g. do you really need a "reg" property or is it here just to fit 
with what bgpio_pdev_probe expects? More about this on 2/2)
3/3: Support for "wd,mbl-gpio" in basic-mmio-gpio
