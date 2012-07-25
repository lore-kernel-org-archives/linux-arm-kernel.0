From: cjb@laptop.org (Chris Ball)
Date: Wed, 25 Jul 2012 12:47:26 -0400
Subject: [PATCH 2/7] MMC: pxa-mci: add DT bindings
In-Reply-To: <1343233066-15397-3-git-send-email-zonque@gmail.com> (Daniel
 Mack's message of "Wed, 25 Jul 2012 18:17:41 +0200")
References: <1343233066-15397-1-git-send-email-zonque@gmail.com>
 <1343233066-15397-3-git-send-email-zonque@gmail.com>
Message-ID: <87ehnzvlcx.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, Jul 25 2012, Daniel Mack wrote:
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Chris Ball <cjb@laptop.org>
> ---
>  Documentation/devicetree/bindings/mmc/pxa-mmc.txt |   24 ++++++++++
>  drivers/mmc/host/pxamci.c                         |   50 +++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/pxa-mmc.txt
>
> diff --git a/Documentation/devicetree/bindings/mmc/pxa-mmc.txt b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
> new file mode 100644
> index 0000000..8f0ea58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/pxa-mmc.txt
> @@ -0,0 +1,24 @@
> +* PXA MMC drivers
> +
> +Driver bindings for the PXA MCI (MMC/SDIO) interfaces
> +
> +Required properties:
> +- compatible: Should be "mrvl,pxa-mmc".
> +- reg: Should contain registers location and length
> +- interrupts: Should contain the interrupt
> +- vmmc-supply: A regulator for VMMC
> +
> +Optional properties:
> +- mrvl,detect-delay-ms: sets the detection delay timeout in ms.
> +- mrvl,gpio-card-detect: GPIO spec for the card detect pin
> +- mrvl,gpio-card-readonly: GPIO spec for the card write protection pin
> +- mrvl,gpio-power: GPIO spec for the card power enable pin

Please see Documentation/devicetree/bindings/mmc/mmc.txt.  It looks like
you should be using cd-gpios and wp-gpios, and you should refer to
mmc.txt instead of specifying reg/interrupts, with:

This file documents differences between the core properties in mmc.txt
and the properties used by the pxa-mmc driver.

I saw Arnd mention that we're moving from "mrvl," to "marvell,", but
maybe that's not finalized yet.  (And there are other drivers using
mrvl, so it'll presumably involve a large renaming patch.)

> +Examples:
> +
> +mmc0: mmc at 41100000 {
> +	compatible = "mrvl,pxa-mmc";
> +	reg = <0x41100000 0x1000>;
> +	interrupts = <23>;
> +};
> +
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index cb2dc0e..39ddc00 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -30,6 +30,9 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/gpio.h>
>  #include <linux/gfp.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_device.h>
>  
>  #include <asm/sizes.h>
>  
> @@ -573,6 +576,48 @@ static irqreturn_t pxamci_detect_irq(int irq, void *devid)
>  	return IRQ_HANDLED;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id pxa_mmc_dt_ids[] = {
> +        { .compatible = "mrvl,pxa-mmc" },
> +        { }
> +};
> +
> +MODULE_DEVICE_TABLE(of, pxa_mmc_dt_ids);
> +
> +static int __devinit pxamci_of_init(struct platform_device *pdev)
> +{
> +        struct device_node *np = pdev->dev.of_node;
> +        struct pxamci_platform_data *pdata;
> +        u32 tmp;
> +
> +        if (!np)
> +                return 0;
> +
> +        pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +        if (!pdata)
> +                return -ENOMEM;
> +
> +	pdata->gpio_card_detect =
> +		of_get_named_gpio(np, "pxa-mmc,gpio-card-detect", 0);
> +	pdata->gpio_card_ro =
> +		of_get_named_gpio(np, "pxa-mmc,gpio-card-readonly", 0);
> +	pdata->gpio_power =
> +		of_get_named_gpio(np, "pxa-mmc,gpio-power", 0);
> +
> +	if (of_property_read_u32(np, "pxa-mmc,detect-delay-ms", &tmp) == 0)
> +		pdata->detect_delay_ms = tmp;
> +
> +        pdev->dev.platform_data = pdata;
> +
> +        return 0;
> +}
> +#else
> +static int __devinit pxamci_of_init(struct platform_device *pdev)
> +{
> +        return 0;
> +}
> +#endif
> +
>  static int pxamci_probe(struct platform_device *pdev)
>  {
>  	struct mmc_host *mmc;
> @@ -580,6 +625,10 @@ static int pxamci_probe(struct platform_device *pdev)
>  	struct resource *r, *dmarx, *dmatx;
>  	int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
>  
> +	ret = pxamci_of_init(pdev);
> +	if (ret)
> +		return ret;
> +
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!r || irq < 0)
> @@ -866,6 +915,7 @@ static struct platform_driver pxamci_driver = {
>  	.driver		= {
>  		.name	= DRIVER_NAME,
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(pxa_mmc_dt_ids),

Have you tried compiling without CONFIG_OF?  This doesn't look to be
inside #ifdef CONFIG_OF, which I think would cause a compile error.

>  #ifdef CONFIG_PM
>  		.pm	= &pxamci_pm_ops,
>  #endif

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
