From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 08:10:30 +0100
Subject: [PATCH 5/8] rtc: rtc-s3c: Add RTC support for Samsung S3C64XX
In-Reply-To: <1274162369-1946-1-git-send-email-kgene.kim@samsung.com>
References: <1274162369-1946-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518071030.GC26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 02:59:29PM +0900, Kukjin Kim wrote:
> From: Taekgyun Ko <taeggyun.ko@samsung.com>
> 
> This patch adds support for Samsung S3C64XX.
> 
> Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/rtc/rtc-s3c.c |  153 +++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 130 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 9364dc2..77f33df 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -1,5 +1,8 @@
>  /* drivers/rtc/rtc-s3c.c
>   *
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
>   * Copyright (c) 2004,2006 Simtec Electronics
>   *	Ben Dooks, <ben@simtec.co.uk>
>   *	http://armlinux.simtec.co.uk/
> @@ -8,7 +11,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   *
> - * S3C2410/S3C2440/S3C24XX Internal RTC Driver
> + * S3C2410/S3C2440/S3C24XX/S3C64XX Internal RTC Driver
>  */
>  
>  #include <linux/module.h>
> @@ -28,16 +31,24 @@
>  #include <asm/io.h>
>  #include <asm/irq.h>
>  #include <plat/regs-rtc.h>
> +#include <plat/clock.h>
>  
>  /* I have yet to find an S3C implementation with more than one
>   * of these rtc blocks in */
>  
> +enum s3c_cpu_type {
> +	TYPE_S3C2410,
> +	TYPE_S3C64XX,
> +};
> +
>  static struct resource *s3c_rtc_mem;
>  
>  static void __iomem *s3c_rtc_base;
>  static int s3c_rtc_alarmno = NO_IRQ;
>  static int s3c_rtc_tickno  = NO_IRQ;
>  
> +static enum s3c_cpu_type s3c_rtc_cpu_type;
> +
>  static DEFINE_SPINLOCK(s3c_rtc_pie_lock);
>  
>  /* IRQ Handlers */
> @@ -47,6 +58,10 @@ static irqreturn_t s3c_rtc_alarmirq(int irq, void *id)
>  	struct rtc_device *rdev = id;
>  
>  	rtc_update_irq(rdev, 1, RTC_AF | RTC_IRQF);
> +
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> +		writeb(S3C64XX_INTP_ALM, s3c_rtc_base + S3C64XX_INTP);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -55,6 +70,10 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
>  	struct rtc_device *rdev = id;
>  
>  	rtc_update_irq(rdev, 1, RTC_PF | RTC_IRQF);
> +
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> +		writeb(S3C64XX_INTP_TIC, s3c_rtc_base + S3C64XX_INTP);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -82,12 +101,25 @@ static int s3c_rtc_setpie(struct device *dev, int enabled)
>  	pr_debug("%s: pie=%d\n", __func__, enabled);
>  
>  	spin_lock_irq(&s3c_rtc_pie_lock);
> -	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & ~S3C2410_TICNT_ENABLE;
>  
> -	if (enabled)
> -		tmp |= S3C2410_TICNT_ENABLE;
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
> +		tmp &= ~S3C64XX_RTCCON_TICEN;
> +
> +		if (enabled)
> +			tmp |= S3C64XX_RTCCON_TICEN;
> +
> +		writew(tmp, s3c_rtc_base + S3C2410_RTCCON);
> +	} else {
> +		tmp = readb(s3c_rtc_base + S3C2410_TICNT);
> +		tmp &= ~S3C2410_TICNT_ENABLE;
> +
> +		if (enabled)
> +			tmp |= S3C2410_TICNT_ENABLE;
> +
> +		writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> +	}
>  
> -	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
>  	spin_unlock_irq(&s3c_rtc_pie_lock);
>  
>  	return 0;
> @@ -102,10 +134,16 @@ static int s3c_rtc_setfreq(struct device *dev, int freq)
>  
>  	spin_lock_irq(&s3c_rtc_pie_lock);
>  
> -	tmp = readb(s3c_rtc_base + S3C2410_TICNT) & S3C2410_TICNT_ENABLE;
> -	tmp |= (128 / freq)-1;
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		tmp = (32768 / freq) - 1;
> +		writel(tmp, s3c_rtc_base + S3C2410_TICNT);
> +	} else {
> +		tmp = readb(s3c_rtc_base + S3C2410_TICNT);
> +		tmp &= S3C2410_TICNT_ENABLE;
> +		tmp |= (128 / freq) - 1;
> +		writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
> +	}
>  
> -	writeb(tmp, s3c_rtc_base + S3C2410_TICNT);
>  	spin_unlock_irq(&s3c_rtc_pie_lock);
>  
>  	return 0;
> @@ -275,20 +313,29 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	s3c_rtc_setaie(0, alrm->enabled);
>  
> -	if (alrm->enabled)
> -		enable_irq_wake(s3c_rtc_alarmno);
> -	else
> -		disable_irq_wake(s3c_rtc_alarmno);
> +	if (s3c_rtc_cpu_type == TYPE_S3C2410) {
> +		if (alrm->enabled)
> +			enable_irq_wake(s3c_rtc_alarmno);
> +		else
> +			disable_irq_wake(s3c_rtc_alarmno);
> +	}


Hmm, why are you removing the enable/disable irq_wake for non s3c2410?
  
>  	return 0;
>  }
>  
>  static int s3c_rtc_proc(struct device *dev, struct seq_file *seq)
>  {
> -	unsigned int ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
> +	unsigned int ticnt;
>  
> -	seq_printf(seq, "periodic_IRQ\t: %s\n",
> -		     (ticnt & S3C2410_TICNT_ENABLE) ? "yes" : "no" );
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		ticnt = readw(s3c_rtc_base + S3C2410_RTCCON);
> +		ticnt &= S3C64XX_RTCCON_TICEN;
> +	} else {
> +		ticnt = readb(s3c_rtc_base + S3C2410_TICNT);
> +		ticnt &= S3C2410_TICNT_ENABLE;
> +	}
> +
> +	seq_printf(seq, "periodic_IRQ\t: %s\n", ticnt ? "yes" : "no");
>  	return 0;
>  }
>  
> @@ -355,11 +402,20 @@ static void s3c_rtc_enable(struct platform_device *pdev, int en)
>  		return;
>  
>  	if (!en) {
> -		tmp = readb(base + S3C2410_RTCCON);
> -		writeb(tmp & ~S3C2410_RTCCON_RTCEN, base + S3C2410_RTCCON);
> +		if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +			tmp = readw(base + S3C2410_RTCCON);
> +			tmp &= ~S3C64XX_RTCCON_TICEN;
> +			tmp &= ~S3C2410_RTCCON_RTCEN;
> +			writew(tmp, base + S3C2410_RTCCON);
> +		} else {
> +			tmp = readb(base + S3C2410_RTCCON);
> +			writeb(tmp & ~S3C2410_RTCCON_RTCEN,
> +				base + S3C2410_RTCCON);
>  
> -		tmp = readb(base + S3C2410_TICNT);
> -		writeb(tmp & ~S3C2410_TICNT_ENABLE, base + S3C2410_TICNT);
> +			tmp = readb(base + S3C2410_TICNT);
> +			writeb(tmp & ~S3C2410_TICNT_ENABLE,
> +				base + S3C2410_TICNT);
> +		}
>  	} else {
>  		/* re-enable the device, and check it is ok */
>  
> @@ -407,12 +463,16 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  {
>  	struct rtc_device *rtc;
>  	struct resource *res;
> +	struct clk *clk_rtc;
> +	unsigned char tmp, i;
>  	int ret;
>  
>  	pr_debug("%s: probe=%p\n", __func__, pdev);
>  
>  	/* find the IRQs */
>  
> +	s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
> +
>  	s3c_rtc_tickno = platform_get_irq(pdev, 1);
>  	if (s3c_rtc_tickno < 0) {
>  		dev_err(&pdev->dev, "no irq for rtc tick\n");
> @@ -453,6 +513,11 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  		goto err_nomap;
>  	}
>  
> +	clk_rtc = clk_get(NULL, "rtc");
> +	if (IS_ERR(clk_rtc))
> +		dev_err(&pdev->dev, "failed to get clock for RTC\n");
> +	clk_enable(clk_rtc);
> +

this really shgould have been a seperate patch.
also, why not return an error if no clock?

>  	/* check to see if everything is setup correctly */
>  
>  	s3c_rtc_enable(pdev, 1);
> @@ -475,7 +540,18 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  		goto err_nortc;
>  	}
>  
> -	rtc->max_user_freq = 128;
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		rtc->max_user_freq = 32768;
> +
> +		/* check rtc time */
> +		for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> +			tmp = readb(s3c_rtc_base + i);
> +			if (((tmp & 0xf) > 0x9) || (((tmp >> 4) & 0xf) > 0x9))
> +				writeb(0, s3c_rtc_base + i);
> +		}

hmm, a 'valid_bcd' function would have been useful here.
also, this is secondary to the puprose of the patch (you could easily
do this for all rtc ases)
also, a dev_warn() would have been useful here

> +	} else {
> +		rtc->max_user_freq = 128;
> +	}
>  
>  	platform_set_drvdata(pdev, rtc);
>  	return 0;
> @@ -495,20 +571,37 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>  
>  /* RTC Power management control */
>  
> -static int ticnt_save;
> +static unsigned int ticnt_save;
> +static int ticnt_en_save;
>  
>  static int s3c_rtc_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	/* save TICNT for anyone using periodic interrupts */
> -	ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		ticnt_save = readl(s3c_rtc_base + S3C2410_TICNT);
> +		ticnt_en_save = readw(s3c_rtc_base + S3C2410_RTCCON) &
> +			S3C64XX_RTCCON_TICEN;
> +	} else {
> +		ticnt_save = readb(s3c_rtc_base + S3C2410_TICNT);
> +	}
>  	s3c_rtc_enable(pdev, 0);
>  	return 0;
>  }
>  
>  static int s3c_rtc_resume(struct platform_device *pdev)
>  {
> +	unsigned int tmp;
> +
>  	s3c_rtc_enable(pdev, 1);
> -	writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
> +	if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> +		writel(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
> +		if (ticnt_en_save) {
> +			tmp = readw(s3c_rtc_base + S3C2410_RTCCON);
> +			writew(tmp | ticnt_en_save, s3c_rtc_base + S3C2410_RTCCON);
> +		}
> +	} else {
> +		writeb(ticnt_save, s3c_rtc_base + S3C2410_TICNT);
> +	}
>  	return 0;
>  }
>  #else
> @@ -516,11 +609,25 @@ static int s3c_rtc_resume(struct platform_device *pdev)
>  #define s3c_rtc_resume  NULL
>  #endif
>  
> +static struct platform_device_id s3c_rtc_driver_ids[] = {
> +	{
> +		.name		= "s3c2410-rtc",
> +		.driver_data	= TYPE_S3C2410,
> +	}, {
> +		.name		= "s3c64xx-rtc",
> +		.driver_data	= TYPE_S3C64XX,
> +	},
> +	{}
> +}
> +
> +MODULE_DEVICE_TABLE(platform, s3c_rtc_driver_ids);
> +
>  static struct platform_driver s3c2410_rtc_driver = {
>  	.probe		= s3c_rtc_probe,
>  	.remove		= __devexit_p(s3c_rtc_remove),
>  	.suspend	= s3c_rtc_suspend,
>  	.resume		= s3c_rtc_resume,
> +	.id_table	= s3c_rtc_driver_ids,
>  	.driver		= {
>  		.name	= "s3c2410-rtc",
>  		.owner	= THIS_MODULE,
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
