From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 25 Jan 2016 09:55:39 +0100
Subject: [PATCH] drivers: power: reset: at91-reset: Provide reset reason
 via sysfs (amended with Signed-off-by tag)
In-Reply-To: <1453394936-16616-1-git-send-email-davidm@egauge.net>
References: <1453394936-16616-1-git-send-email-davidm@egauge.net>
Message-ID: <20160125085539.GB16261@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(Adding Sebastian in Cc)

On 21/01/2016 at 09:48:56 -0700, David Mosberger-Tang wrote :
> Rather than just printing the reset-reason at boot-time, make it available
> via sysfs as attribute "reset_reason" of the reset controller.  For example,
> on SAMA5D2 Xplained, this sysfs attribute is available at:
> 
>  /sys/devices/platform/ahb/ahb:apb/f8048000.rstc/reset_reason
> 
> Signed-off-by: David Mosberger <davidm@egauge.net>
> ---
>  drivers/power/reset/at91-reset.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
> index 264b9b8..184516b 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -45,6 +45,11 @@ enum reset_type {
>  	RESET_TYPE_USER		= 4,
>  };
>  
> +static ssize_t reset_reason_show(struct device *,
> +				 struct device_attribute *attr,
> +				 char *);
> +static DEVICE_ATTR(reset_reason, S_IRUSR, reset_reason_show, NULL);
> +

All sysfs files have to be documented. Can you add some documentation in
Documentation/ABI ?

Also, I think this should be added as a generic file for the whole subsystem.

>  static void __iomem *at91_ramc_base[2], *at91_rstc_base;
>  
>  /*
> @@ -132,7 +137,7 @@ static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
>  	return NOTIFY_DONE;
>  }
>  
> -static void __init at91_reset_status(struct platform_device *pdev)
> +static const char *at91_reset_reason(struct platform_device *pdev)
>  {
>  	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
>  	char *reason;
> @@ -157,8 +162,15 @@ static void __init at91_reset_status(struct platform_device *pdev)
>  		reason = "unknown reset";
>  		break;
>  	}
> +	return reason;
> +}
>  
> -	pr_info("AT91: Starting after %s\n", reason);

I'm pretty sure Nicolas will not want the reset reason to disappear from
the kernel log.

> +static ssize_t reset_reason_show(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	return strcpy(buf, at91_reset_reason(pdev));
>  }
>  
>  static const struct of_device_id at91_ramc_of_match[] = {
> @@ -250,7 +262,13 @@ static int at91_reset_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	at91_reset_status(pdev);
> +	ret = device_create_file(&pdev->dev, &dev_attr_reset_reason);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Could not create sysfs entry\n");
> +		return ret;
> +	}
> +
> +	pr_info("AT91: Starting after %s\n", at91_reset_reason(pdev));
>  
>  	return 0;
>  }

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
