From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Mar 2013 10:18:20 +0100
Subject: [PATCH 5/5] pcmcia: at91_cf: add support for DT
In-Reply-To: <1360863766-22511-6-git-send-email-manabian@gmail.com>
References: <1360863766-22511-1-git-send-email-manabian@gmail.com>
 <1360863766-22511-6-git-send-email-manabian@gmail.com>
Message-ID: <5139ACDC.3080505@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 06:42 PM, Joachim Eastwood :
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

Seems good.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  .../devicetree/bindings/ata/atmel-at91_cf.txt      | 19 +++++++++
>  drivers/pcmcia/Kconfig                             |  2 +-
>  drivers/pcmcia/at91_cf.c                           | 45 +++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt b/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> new file mode 100644
> index 0000000..c1d22b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/atmel-at91_cf.txt
> @@ -0,0 +1,19 @@
> +Atmel AT91RM9200 CompactFlash
> +
> +Required properties:
> +- compatible : "atmel,at91rm9200-cf".
> +- reg : should specify localbus address and size used.
> +- gpios : specifies the gpio pins to control the CF device. Detect
> +  and reset gpio's are mandatory while irq and vcc gpio's are
> +  optional and may be set to 0 if not present.
> +
> +Example:
> +compact-flash at 50000000 {
> +	compatible = "atmel,at91rm9200-cf";
> +	reg = <0x50000000 0x30000000>;
> +	gpios = <&pioC 13 0	/* irq */
> +		 &pioC 15 0 	/* detect */
> +		 0		/* vcc */
> +		 &pioC  5 0	/* reset */
> +		>;
> +};
> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 8fd255f..2adad5b 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -288,7 +288,7 @@ config BFIN_CFPCMCIA
>  
>  config AT91_CF
>  	tristate "AT91 CompactFlash Controller"
> -	depends on PCMCIA && ARCH_AT91RM9200
> +	depends on PCMCIA && ARCH_AT91
>  	help
>  	  Say Y here to support the CompactFlash controller on AT91 chips.
>  	  Or choose M to compile the driver as a module named "at91_cf".
> diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
> index bce8a64..149b95c 100644
> --- a/drivers/pcmcia/at91_cf.c
> +++ b/drivers/pcmcia/at91_cf.c
> @@ -20,6 +20,9 @@
>  #include <linux/platform_data/atmel.h>
>  #include <linux/io.h>
>  #include <linux/sizes.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
>  
>  #include <pcmcia/ss.h>
>  
> @@ -211,6 +214,37 @@ static struct pccard_operations at91_cf_ops = {
>  
>  /*--------------------------------------------------------------------------*/
>  
> +#if defined(CONFIG_OF)
> +static const struct of_device_id at91_cf_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-cf" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_cf_dt_ids);
> +
> +static int at91_cf_dt_init(struct platform_device *pdev)
> +{
> +	struct at91_cf_data *board;
> +
> +	board = devm_kzalloc(&pdev->dev, sizeof(*board), GFP_KERNEL);
> +	if (!board)
> +		return -ENOMEM;
> +
> +	board->irq_pin = of_get_gpio(pdev->dev.of_node, 0);
> +	board->det_pin = of_get_gpio(pdev->dev.of_node, 1);
> +	board->vcc_pin = of_get_gpio(pdev->dev.of_node, 2);
> +	board->rst_pin = of_get_gpio(pdev->dev.of_node, 3);
> +
> +	pdev->dev.platform_data = board;
> +
> +	return 0;
> +}
> +#else
> +static int at91_cf_dt_init(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int __init at91_cf_probe(struct platform_device *pdev)
>  {
>  	struct at91_cf_socket	*cf;
> @@ -218,7 +252,15 @@ static int __init at91_cf_probe(struct platform_device *pdev)
>  	struct resource		*io;
>  	int			status;
>  
> -	if (!board || !gpio_is_valid(board->det_pin) || !gpio_is_valid(board->rst_pin))
> +	if (!board) {
> +		status = at91_cf_dt_init(pdev);
> +		if (status)
> +			return status;
> +
> +		board = pdev->dev.platform_data;
> +	}
> +
> +	if (!gpio_is_valid(board->det_pin) || !gpio_is_valid(board->rst_pin))
>  		return -ENODEV;
>  
>  	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -360,6 +402,7 @@ static struct platform_driver at91_cf_driver = {
>  	.driver = {
>  		.name		= "at91_cf",
>  		.owner		= THIS_MODULE,
> +		.of_match_table = of_match_ptr(at91_cf_dt_ids),
>  	},
>  	.remove		= __exit_p(at91_cf_remove),
>  	.suspend	= at91_cf_suspend,
> 


-- 
Nicolas Ferre
