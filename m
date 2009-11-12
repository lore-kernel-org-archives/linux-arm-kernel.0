From: niej0001@gmail.com (Jun Nie)
Date: Thu, 12 Nov 2009 10:16:49 +0800
Subject: [PATCH 2/8] pxa: support PXA168 LCD platform dependent power on
In-Reply-To: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
References: <7c34ac520911100012y4b52659eid46c241111c34032@mail.gmail.com>
Message-ID: <7c34ac520911111816h27f071bcu7e158494f24882f9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From 7a497795dfd6f314e52b015b85031a0498a70a03 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 09:21:19 +0800
> Subject: [PATCH] pxa: support PXA168 LCD platform dependent power on
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> ?drivers/video/pxa168fb.c | ? 14 ++++++++++++++
> ?1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
> index e1f1c5f..50f72e9 100644
> --- a/drivers/video/pxa168fb.c
> +++ b/drivers/video/pxa168fb.c
> @@ -845,6 +845,20 @@ static int __init pxa168fb_probe(struct
> platform_device *pdev)
> ? ? ? ?}
>
> ? ? ? ?platform_set_drvdata(pdev, fbi);
> + ? ? ? if (mi->pxa168fb_lcd_power){
> + ? ? ? ? ? ? ? if (gpio_is_valid(mi->spi_gpio_cs)) {
> + ? ? ? ? ? ? ? ? ? ? ? ret = gpio_request(mi->spi_gpio_cs, "LCD_SPI_CS");
> + ? ? ? ? ? ? ? ? ? ? ? if (ret) {
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "failed to request GPIO for LCD CS\n");
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? return -EIO;
> + ? ? ? ? ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? }
> + ? ? ? ? ? ? ? if(mi->pxa168fb_lcd_power(fbi, mi->spi_gpio_cs, mi->spi_gpio_reset, 1)){
> + ? ? ? ? ? ? ? ? ? ? ? dev_err(&pdev->dev, "Failed to power up pxa168-fb\n");
> + ? ? ? ? ? ? ? ? ? ? ? goto failed_free_irq;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> + ? ? ? dev_info(fbi->dev, "frame buffer detected\n");
> ? ? ? ?return 0;
>
> ?failed_free_irq:
> --
> 1.5.4.3
>
patch attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch
Type: text/x-diff
Size: 1139 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091112/96215d54/attachment.bin>
