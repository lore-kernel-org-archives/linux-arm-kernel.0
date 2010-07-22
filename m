From: mcuos.com@gmail.com (Wan ZongShun)
Date: Thu, 22 Jul 2010 14:09:00 +0800
Subject: [rtc-linux] [PATCH 2/2] rtc: rtc-s3c: Updates RTC driver for
	clock enabling support
In-Reply-To: <1279702501-6803-3-git-send-email-kgene.kim@samsung.com>
References: <1279702501-6803-1-git-send-email-kgene.kim@samsung.com>
	<1279702501-6803-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTikGjzmHxCX6_s5Z-ZXkoyPbtF28uCyE1VqdGPvb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/21 Kukjin Kim <kgene.kim@samsung.com>:
> From: Atul Dahiya <atul.dahiya@samsung.com>
>
> This Patch updates existing Samsung RTC driver for clock enabling support.
>
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?drivers/rtc/rtc-s3c.c | ? 22 ++++++++++++++++++++++
> ?1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
> index 70b68d3..c032a15 100644
> --- a/drivers/rtc/rtc-s3c.c
> +++ b/drivers/rtc/rtc-s3c.c
> @@ -1,5 +1,8 @@
> ?/* drivers/rtc/rtc-s3c.c
> ?*
> + * Copyright (c) 2010 Samsung Electronics Co., Ltd.
> + * ? ? ? ? ? ? http://www.samsung.com/
> + *
> ?* Copyright (c) 2004,2006 Simtec Electronics
> ?* ? ? Ben Dooks, <ben@simtec.co.uk>
> ?* ? ? http://armlinux.simtec.co.uk/
> @@ -39,6 +42,7 @@ enum s3c_cpu_type {
>
> ?static struct resource *s3c_rtc_mem;
>
> +static struct clk *rtc_clk;
> ?static void __iomem *s3c_rtc_base;
> ?static int s3c_rtc_alarmno = NO_IRQ;
> ?static int s3c_rtc_tickno ?= NO_IRQ;
> @@ -431,6 +435,10 @@ static int __devexit s3c_rtc_remove(struct platform_device *dev)
> ? ? ? ?s3c_rtc_setpie(&dev->dev, 0);
> ? ? ? ?s3c_rtc_setaie(0);
>
> + ? ? ? clk_disable(rtc_clk);
> + ? ? ? clk_put(rtc_clk);
> + ? ? ? rtc_clk = NULL;
> +
> ? ? ? ?iounmap(s3c_rtc_base);
> ? ? ? ?release_resource(s3c_rtc_mem);
> ? ? ? ?kfree(s3c_rtc_mem);
> @@ -488,6 +496,16 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto err_nomap;
> ? ? ? ?}
>
> + ? ? ? rtc_clk = clk_get(&pdev->dev, "rtc");

Do you really need the second argument? I think the bus clock for
a device should be findable with NULL for s3c platform..

> + ? ? ? if (IS_ERR(rtc_clk)) {
> + ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to find rtc clock source\n");
> + ? ? ? ? ? ? ? ret = PTR_ERR(rtc_clk);
> + ? ? ? ? ? ? ? rtc_clk = NULL;
> + ? ? ? ? ? ? ? goto err_clk;
> + ? ? ? }
> +
> + ? ? ? clk_enable(rtc_clk);
> +
> ? ? ? ?/* check to see if everything is setup correctly */
>
> ? ? ? ?s3c_rtc_enable(pdev, 1);
> @@ -523,6 +541,10 @@ static int __devinit s3c_rtc_probe(struct platform_device *pdev)
>
> ?err_nortc:
> ? ? ? ?s3c_rtc_enable(pdev, 0);
> + ? ? ? clk_disable(rtc_clk);
> + ? ? ? clk_put(rtc_clk);
> +
> + err_clk:
> ? ? ? ?iounmap(s3c_rtc_base);
>
> ?err_nomap:
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
