From: jhovold@gmail.com (Johan Hovold)
Date: Thu, 4 Apr 2013 10:16:34 +0200
Subject: [PATCH] rtc: rtc-at91sam9.c add DT support
In-Reply-To: <515CF985.6050009@interlog.com>
References: <515CF985.6050009@interlog.com>
Message-ID: <20130404081634.GD27151@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 03, 2013 at 11:54:45PM -0400, Douglas Gilbert wrote:
> diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
> index 39cfd2e..69e9389 100644
> --- a/drivers/rtc/rtc-at91sam9.c
> +++ b/drivers/rtc/rtc-at91sam9.c
> @@ -20,6 +20,8 @@
>  #include <linux/ioctl.h>
>  #include <linux/slab.h>
>  #include <linux/platform_data/atmel.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <mach/at91_rtt.h>
>  #include <mach/cpu.h>
> @@ -71,6 +73,17 @@ struct sam9_rtc {
>  #define gpbr_writel(rtc, val) \
>  	__raw_writel((val), (rtc)->gpbr)
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id at91sam9_rtc_dt_ids[] = {
> +        { .compatible = "atmel,at91sam9-rtc" },

This should probably be "atmel,at91sam9260-rtt".

> +        { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, at91sam9_rtc_dt_ids);
> +#else
> +#define at91sam9_rtc_dt_ids NULL
> +#endif  /* CONFIG_OF */

You don't need the else-clause when you use of_match_ptr below.

> +
> +
>  /*
>   * Read current time and date in RTC
>   */
> @@ -470,6 +483,7 @@ static struct platform_driver at91_rtc_driver = {
>  	.driver		= {
>  		.name	= "rtc-at91sam9",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(at91sam9_rtc_dt_ids),
>  	},
>  };

Thanks,
Johan
