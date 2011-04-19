From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 19 Apr 2011 11:53:24 +0800
Subject: [PATCH] rtc: max8925 crash since driver data not set before
	interrupt
In-Reply-To: <49989E8F-D7CA-409B-ABB2-519E3EB9067C@marvell.com>
References: <49989E8F-D7CA-409B-ABB2-519E3EB9067C@marvell.com>
Message-ID: <BANLkTi=+bm6VVYycVBzLQf5_X9A14u6kfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 3:59 AM, Philip Rakity <prakity@marvell.com> wrote:
> From 449d78d5145f25d95c3bcf8fbcbbf5554299ec0f Mon Sep 17 00:00:00 2001
> From: Philip Rakity <prakity@marvell.com>
> Date: Mon, 18 Apr 2011 12:56:17 -0700
> Subject: [PATCH] rtc: max8925 crash since driver data not set before interrupt
>
> in probe set the platform data before setting up interrupts
> avoids crash at start-up time.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Acked-by: Eric Miao <eric.y.miao@gmail.com>

Hi Alessandro,

This looks like a right fix to me. Please help merge. Thanks.

> ---
> ?drivers/rtc/rtc-max8925.c | ? ?6 +++---
> ?1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc-max8925.c b/drivers/rtc/rtc-max8925.c
> index 174036d..24a326a 100644
> --- a/drivers/rtc/rtc-max8925.c
> +++ b/drivers/rtc/rtc-max8925.c
> @@ -249,6 +249,9 @@ static int __devinit max8925_rtc_probe(struct platform_device *pdev)
> ? ? ? ?info->dev = &pdev->dev;
> ? ? ? ?irq = chip->irq_base + MAX8925_IRQ_RTC_ALARM0;
>
> + ? ? ? dev_set_drvdata(&pdev->dev, info);
> + ? ? ? platform_set_drvdata(pdev, info);
> +
> ? ? ? ?ret = request_threaded_irq(irq, NULL, rtc_update_handler,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? IRQF_ONESHOT, "rtc-alarm0", info);
> ? ? ? ?if (ret < 0) {
> @@ -265,9 +268,6 @@ static int __devinit max8925_rtc_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?goto out_rtc;
> ? ? ? ?}
>
> - ? ? ? dev_set_drvdata(&pdev->dev, info);
> - ? ? ? platform_set_drvdata(pdev, info);
> -
> ? ? ? ?return 0;
> ?out_rtc:
> ? ? ? ?free_irq(chip->irq_base + MAX8925_IRQ_RTC_ALARM0, info);
> --
> 1.7.0.4
>
>
>
