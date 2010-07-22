From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 22 Jul 2010 09:50:36 +0800
Subject: [rtc-linux] [PATCH 3/3] rtc: rtc-s3c: Add BCD register
	initialization codes
In-Reply-To: <1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
References: <1279702666-13021-1-git-send-email-kgene.kim@samsung.com>
	<1279702666-13021-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTinHlD1fC_Es6P7mcX4-_STNoYxV4wmsKe6KAw_N@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/21 Kukjin Kim <kgene.kim@samsung.com>:
> From: Taekgyun Ko <taeggyun.ko@samsung.com>
>
> RTC needs to be initialized when BCD registers have invalid value.

Do you mean that the hardware register does not have default value?
Any results if no initialized value here?

>
> Signed-off-by: Taekgyun Ko <taeggyun.ko@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?drivers/rtc/rtc-s3c.c | ? 14 ++++++++++++--
> ?1 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 2040017..e96e109 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -536,10 +536,20 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>
> ? ? ? ?s3c_rtc_cpu_type = platform_get_device_id(pdev)->driver_data;
>
> - ? ? ? if (s3c_rtc_cpu_type == TYPE_S3C64XX)
> + ? ? ? if (s3c_rtc_cpu_type == TYPE_S3C64XX) {
> ? ? ? ? ? ? ? ?rtc->max_user_freq = 32768;
> - ? ? ? else
> +
> + ? ? ? ? ? ? ? /* Check RTC Time */
> +
> + ? ? ? ? ? ? ? for (i = S3C2410_RTCSEC; i <= S3C2410_RTCYEAR; i += 0x4) {
> + ? ? ? ? ? ? ? ? ? ? ? tmp = readb(s3c_rtc_base + i);
> +
> + ? ? ? ? ? ? ? ? ? ? ? if (((tmp & 0xf) > 0x9) || (((tmp >> 4) & 0xf) > 0x9))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? writeb(0, s3c_rtc_base + i);
> + ? ? ? ? ? ? ? }
> + ? ? ? } else {
> ? ? ? ? ? ? ? ?rtc->max_user_freq = 128;
> + ? ? ? }
>
> ? ? ? ?platform_set_drvdata(pdev, rtc);
>
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
