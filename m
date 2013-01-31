From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 31 Jan 2013 14:44:59 -0800
Subject: [rtc-linux] [PATCH] rtc: pl031: fix the missing operation on
 enable
In-Reply-To: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
References: <1359507865-29808-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130131144459.39f9a978.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013 09:04:25 +0800
Haojian Zhuang <haojian.zhuang@linaro.org> wrote:

> RTC control register should be enabled in the process of initliazing.
> 
> ...
>
> --- a/drivers/rtc/rtc-pl031.c
> +++ b/drivers/rtc/rtc-pl031.c
> @@ -44,6 +44,7 @@
>  #define RTC_YMR		0x34	/* Year match register */
>  #define RTC_YLR		0x38	/* Year data load register */
>  
> +#define RTC_CR_EN	(1 << 0)	/* counter enable bit */
>  #define RTC_CR_CWEN	(1 << 26)	/* Clockwatch enable bit */
>  
>  #define RTC_TCR_EN	(1 << 1) /* Periodic timer enable bit */
> @@ -320,7 +321,7 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct pl031_local *ldata;
>  	struct pl031_vendor_data *vendor = id->data;
>  	struct rtc_class_ops *ops = &vendor->ops;
> -	unsigned long time;
> +	unsigned long time, data;
>  
>  	ret = amba_request_regions(adev, NULL);
>  	if (ret)
> @@ -345,10 +346,11 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
>  	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
>  	dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
>  
> +	data = readl(ldata->base + RTC_CR);
>  	/* Enable the clockwatch on ST Variants */
>  	if (vendor->clockwatch)
> -		writel(readl(ldata->base + RTC_CR) | RTC_CR_CWEN,
> -		       ldata->base + RTC_CR);
> +		data |= RTC_CR_CWEN;
> +	writel(data | RTC_CR_EN, ldata->base + RTC_CR);

Does this patch fix some user-visible misbehaviour?  If so, please
fully describe that misbehaviour.
