From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 16 Nov 2010 10:30:30 +0900
Subject: [PATCH 1/3] rtc: rtc-s3c: Fix return type and argument of
	s3c_rtc_setaie
In-Reply-To: <1289865774-31073-2-git-send-email-kgene.kim@samsung.com>
References: <1289865774-31073-1-git-send-email-kgene.kim@samsung.com>
	<1289865774-31073-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikhEahF7o6XbW7TFESrGPaEVwFX3B8f5LHmaU7r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

It's same patch early.
I used the email address by ./script/get_maintainer.sh

http://groups.google.com/group/linux.kernel/browse_thread/thread/953c417a31756ab9?pli=1

Thank you,
Kyungmin Park

On Tue, Nov 16, 2010 at 9:02 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> According to struct rtc_class_ops, this patch fixes return type
> and argument of s3c_rtc_setaie().
>
> ?int (*alarm_irq_enable)(struct device *, unsigned int enabled);
>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Wan ZongShun <mcuos.com@gmail.com>
> Cc: Alessandro Zummo <a.zummo@towertech.it>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?drivers/rtc/rtc-s3c.c | ? 13 +++++++------
> ?1 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index cf953ec..e2636ff 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -76,19 +76,20 @@ static irqreturn_t s3c_rtc_tickirq(int irq, void *id)
> ? ? ? ?return IRQ_HANDLED;
> ?}
>
> -/* Update control registers */
> -static void s3c_rtc_setaie(int to)
> +static int s3c_rtc_setaie(struct device *dev, unsigned int enabled)
> ?{
> ? ? ? ?unsigned int tmp;
>
> - ? ? ? pr_debug("%s: aie=%d\n", __func__, to);
> + ? ? ? pr_debug("%s: aie=%d\n", __func__, enabled);
>
> ? ? ? ?tmp = readb(s3c_rtc_base + S3C2410_RTCALM) & ~S3C2410_RTCALM_ALMEN;
>
> - ? ? ? if (to)
> + ? ? ? if (enabled)
> ? ? ? ? ? ? ? ?tmp |= S3C2410_RTCALM_ALMEN;
>
> ? ? ? ?writeb(tmp, s3c_rtc_base + S3C2410_RTCALM);
> +
> + ? ? ? return 0;
> ?}
>
> ?static int s3c_rtc_setpie(struct device *dev, int enabled)
> @@ -308,7 +309,7 @@ static int s3c_rtc_setalarm(struct device *dev, struct rtc_wkalrm *alrm)
>
> ? ? ? ?writeb(alrm_en, base + S3C2410_RTCALM);
>
> - ? ? ? s3c_rtc_setaie(alrm->enabled);
> + ? ? ? s3c_rtc_setaie(dev, alrm->enabled);
>
> ? ? ? ?return 0;
> ?}
> @@ -440,7 +441,7 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
> ? ? ? ?rtc_device_unregister(rtc);
>
> ? ? ? ?s3c_rtc_setpie(&dev->dev, 0);
> - ? ? ? s3c_rtc_setaie(0);
> + ? ? ? s3c_rtc_setaie(&dev->dev, 0);
>
> ? ? ? ?clk_disable(rtc_clk);
> ? ? ? ?clk_put(rtc_clk);
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
