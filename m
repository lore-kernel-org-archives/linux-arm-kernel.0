From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 8 Mar 2013 10:14:23 +0100
Subject: [PATCH] rtc: at91rm9200: add DT support
In-Reply-To: <1360879147-17273-1-git-send-email-manabian@gmail.com>
References: <1360879147-17273-1-git-send-email-manabian@gmail.com>
Message-ID: <5139ABEF.2000408@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/14/2013 10:59 PM, Joachim Eastwood :
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Alessandro, do you want to queue this one on your side?

Best regards,

> ---
>  .../devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt      | 15 +++++++++++++++
>  drivers/rtc/rtc-at91rm9200.c                              |  9 +++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
>
> diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
> new file mode 100644
> index 0000000..2a3feab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
> @@ -0,0 +1,15 @@
> +Atmel AT91RM9200 Real Time Clock
> +
> +Required properties:
> +- compatible: should be: "atmel,at91rm9200-rtc"
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +- interrupts: rtc alarm/event interrupt
> +
> +Example:
> +
> +rtc at fffffe00 {
> +	compatible = "atmel,at91rm9200-rtc";
> +	reg = <0xfffffe00 0x100>;
> +	interrupts = <1 4 7>;
> +};
> diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
> index b6469e2..2ea0ee3 100644
> --- a/drivers/rtc/rtc-at91rm9200.c
> +++ b/drivers/rtc/rtc-at91rm9200.c
> @@ -28,6 +28,8 @@
>  #include <linux/ioctl.h>
>  #include <linux/completion.h>
>  #include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <asm/uaccess.h>
>  
> @@ -382,12 +384,19 @@ static const struct dev_pm_ops at91_rtc_pm = {
>  #define at91_rtc_pm_ptr	NULL
>  #endif
>  
> +static const struct of_device_id at91_rtc_dt_ids[] = {
> +	{ .compatible = "atmel,at91rm9200-rtc" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91_rtc_dt_ids);
> +
>  static struct platform_driver at91_rtc_driver = {
>  	.remove		= __exit_p(at91_rtc_remove),
>  	.driver		= {
>  		.name	= "at91_rtc",
>  		.owner	= THIS_MODULE,
>  		.pm	= at91_rtc_pm_ptr,
> +		.of_match_table = of_match_ptr(at91_rtc_dt_ids),
>  	},
>  };
-- 
Nicolas Ferre
