From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 09:38:07 +0200
Subject: [RFC 4/5] RTC: rtc-at91sam9: add device-tree support
In-Reply-To: <1365347572-14972-4-git-send-email-jhovold@gmail.com>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <1365347572-14972-4-git-send-email-jhovold@gmail.com>
Message-ID: <20130408073807.GQ20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> Add device-tree support.
> 
> The AT91 RTT can be used as an RTC if the atmel,at91-rtt-as-rtc-gpbr
> property is present and set to the general-purpose backup register to
> use to store the RTC time base.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  .../devicetree/bindings/rtc/rtc-at91sam9.txt       | 19 ++++++++++++
>  drivers/rtc/rtc-at91sam9.c                         | 36 +++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> 
> diff --git a/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> new file mode 100644
> index 0000000..0f54988
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/rtc-at91sam9.txt
> @@ -0,0 +1,19 @@
> +Atmel AT91 RTT as RTC
> +=====================
> +
> +Required properties:
> +- compatible: Should be "atmel,at91sam9260-rtt"
> +- reg: Should contain register location and length
> +- interrupts: Should contain interrupt for the RTT which is the IRQ line
> +  shared across all System Controller members.
> +- atmel,rtt-as-rtc-gpbr: Should contain the backup-register to use to store
> +  the RTC time base
> +
> +Example:
> +
> +rtt at fffffd20 {
> +		compatible = "atmel,at91sam9g45-rtt", "atmel,at91sam9260-rtt";
> +		reg = <0xfffffd20 0x10>;
> +		interrupts = <1 4 7>;
> +		atmel,at91-rtt-as-rtc-gpbr = <0>;
no you miss the point of the DT

you need to describe the hardware no a particular use of it

the RTT is a general purpose timer backuped that we use in linux as a RTC with a gpbr
to store the time


you need 2 binding on for the RTT one the RTT-rtc
> +	};
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 983667b..7ccce19 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -13,6 +13,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/time.h>
>  #include <linux/rtc.h>
> @@ -282,6 +283,29 @@ static const struct rtc_class_ops at91_rtc_ops = {
>  	.alarm_irq_enable = at91_rtc_alarm_irq_enable,
>  };
>  
> +
> +#ifdef CONFIG_OF
> +static struct of_device_id at91_rtc_of_match[] = {
> +	{ .compatible = "atmel,at91sam9260-rtt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, at91_rtc_of_match);
> +#endif
> +
> +static int at91_rtc_parse_dt(struct device_node *node, unsigned *gpbr)
> +{
> +	u32 val;
> +	int res;
> +
> +	res = of_property_read_u32(node, "atmel,at91-rtt-as-rtc-gpbr", &val);
> +	if (!res)
> +		return -ENODEV;
> +
> +	*gpbr = val;
> +
> +	return 0;
> +}
> +
>  /*
>   * Initialize and install RTC driver
>   */
> @@ -291,6 +315,15 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  	struct sam9_rtc	*rtc;
>  	int		ret, irq;
>  	u32		mr;
> +	unsigned	gpbr;
> +
> +	if (pdev->dev.of_node) {
> +		ret = at91_rtc_parse_dt(pdev->dev.of_node, &gpbr);
> +		if (ret)
> +			return ret;
> +	} else {
> +		gpbr = CONFIG_RTC_DRV_AT91SAM9_GPBR;
> +	}
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!r)
> @@ -320,7 +353,7 @@ static int at91_rtc_probe(struct platform_device *pdev)
>  		goto fail;
>  	}
>  
> -	rtc->gpbr = CONFIG_RTC_DRV_AT91SAM9_GPBR;
> +	rtc->gpbr = gpbr;
>  
>  	mr = rtt_readl(rtc, MR);
>  
> @@ -455,6 +488,7 @@ static struct platform_driver at91_rtc_driver = {
>  	.driver		= {
>  		.name	= "rtc-at91sam9",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(at91_rtc_of_match),
>  	},
>  };
>  
> -- 
> 1.8.1.5
> 
