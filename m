From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 29 Jul 2010 13:19:27 +0800
Subject: [rtc-linux] [PATCH v3 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <1280379570-6147-1-git-send-email-kgene.kim@samsung.com>
References: <1280379570-6147-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTimoyYGXc-bwQCOWFSBP+nWTVVri6ZMsNuwwYtC7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/29 Kukjin Kim <kgene.kim@samsung.com>:
> From: Taekgyun Ko <taeggyun.ko@samsung.com>
>
> RTC needs to be initialized when BCD registers have invalid value.
>
> Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
> Hi, Alessandro Zummo
> Just moved the routine to support all Samsung SoCs' RTC.
> Is still your ack valid?

Alessandro is busy, not every patch he can reviewed and acked,
if nobody have any other suggestions about your patch, you can
merge it. if you donot have specific git tree to merge it, you can get
Andrew's help.

>
> Changes since v2:
> Moved chekcing BCD registers to support all Samsung SoCs as per Ben's comments.
>
> ?drivers/rtc/rtc-s3c.c | ? 10 ++++++++++
> ?1 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 2040017..a0d3ec8 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -458,6 +458,7 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
> ?{
> ? ? ? ?struct rtc_device *rtc;
> ? ? ? ?struct resource *res;
> + ? ? ? unsigned int tmp, i;
> ? ? ? ?int ret;
>
> ? ? ? ?pr_debug("%s: probe=%p\n", __func__, pdev);
> @@ -536,6 +537,15 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>
> ? ? ? ?s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
>
> + ? ? ? /* Check RTC Time */
> +
> + ? ? ? for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> + ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + i);
> +
> + ? ? ? ? ? ? ? if ((tmp & 0xf) > 0x9 || ((tmp >> 4) & 0xf) > 0x9)
> + ? ? ? ? ? ? ? ? ? ? ? writeb(0, s3c_rtc_base + i);
> + ? ? ? }
> +
> ? ? ? ?if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> ? ? ? ? ? ? ? ?rtc->max_user_freq = 32768;
> ? ? ? ?else
> --
> 1.6.2.5
>
> --
> You received this message because you are subscribed to "rtc-linux".
> Membership options at http://groups.google.com/group/rtc-linux .
> Please read http://groups.google.com/group/rtc-linux/web/checklist
> before submitting a driver.



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
