From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 08:05:37 +0100
Subject: [PATCH 4/8] rtc: rtc-s3c: Add alarm_irq_enable RTC class operation
In-Reply-To: <1274162363-1911-1-git-send-email-kgene.kim@samsung.com>
References: <1274162363-1911-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518070537.GB26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 02:59:23PM +0900, Kukjin Kim wrote:
> From: Taekgyun Ko <taeggyun.ko@samsung.com>
> 
> This patch updates rtc-s3c driver to support
> 'alarm_irq_enable' RTC class operation.

this could have gone on one line.
 
> Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 4969b60..9364dc2 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -59,18 +59,20 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
>  }
>  
>  /* Update control registers */
> -static void s3c_rtc_setaie(int to)
> +static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
>  {
>  	unsigned int tmp;
>  
> -	pr_debug("%s: aie=%d\n", __func__, to);
> +	pr_debug("%s: aie=%d\n", __func__, enabled);
>  
>  	tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
>  
> -	if (to)
> +	if (enabled)
>  		tmp |= S3C2410_RTCALM_ALMEN;
>  
>  	writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
> +
> +	return 0;

Please stop changing names jsut because you feel like it.

>  }
>  
>  static int s3c_rtc_setpie(struct device *dev, int enabled)
> @@ -271,7 +273,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	writeb(alrm_en, base + S3C2410_RTCALM);
>  
> -	s3c_rtc_setaie(alrm->enabled);
> +	s3c_rtc_setaie(0, alrm->enabled);

if you've got a pointer to device, then please pass it.
  
>  	if (alrm->enabled)
>  		enable_irq_wake(s3c_rtc_alarmno);
> @@ -340,6 +342,7 @@ static const struct rtc_class_ops s3c_rtcops = {
>  	.set_alarm	= s3c_rtc_setalarm,
>  	.irq_set_freq	= s3c_rtc_setfreq,
>  	.irq_set_state	= s3c_rtc_setpie,
> +	.alarm_irq_enable = s3c_rtc_setaie,
>  	.proc	        = s3c_rtc_proc,
>  };
>  
> @@ -391,7 +394,7 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
>  	rtc_device_unregister(rtc);
>  
>  	s3c_rtc_setpie(&dev->dev, 0);
> -	s3c_rtc_setaie(0);
> +	s3c_rtc_setaie(0, 0);

see previous comment about pointers to device.
  
>  	iounmap(s3c_rtc_base);
>  	release_resource(s3c_rtc_mem);
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
