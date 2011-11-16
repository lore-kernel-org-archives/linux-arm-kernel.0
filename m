From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 16 Nov 2011 16:03:54 +0530
Subject: [PATCH] watchdog: fix initialisation printout in s3c2410_wdt
In-Reply-To: <1321433173-17757-1-git-send-email-mad_soft@inbox.ru>
References: <1321433173-17757-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <CAJuYYwTv3d9Wg8TDBEkc0r3BweUiLdqVwGdMU4iKpK0B+EM=GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 14:16, Dmitry Artamonow <mad_soft@inbox.ru> wrote:
> Looks like a typo creeped in, and driver prints
> s3c2410-wdt s3c2410-wdt: watchdog active, reset abled, irq abled
>
> instead of
> s3c2410-wdt s3c2410-wdt: watchdog active, reset enabled, irq enabled
>
> Also it may completely disinform about irq status, as it prints
> "irq enabled" when S3C2410_WTCON_INTEN is in fact 0.
>
> Fix it.
>
> Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> ---
>
> It seems to be here for a long time, but I don't think it's
> important enough for cc-ing stable.
>
> Also I haven't tested it, as I don't have a hardware, but it's
> rather trivial (and yes, I checked with datasheet that 1 in
> S3C2410_WTCON_*EN bits really means 'enabled')
>

Tested on Exynos4210 based Origen board. This patch fixed in incorrect
"irq enabled" message at bootup. Thanks for this fix.

Tested-by: Thomas Abraham <thomas.abraham@linaro.org>

> ?drivers/watchdog/s3c2410_wdt.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 5de7e4f..a79e384 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -401,8 +401,8 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
>
> ? ? ? ?dev_info(dev, "watchdog %sactive, reset %sabled, irq %sabled\n",
> ? ? ? ? ? ? ? ? (wtcon & S3C2410_WTCON_ENABLE) ? ?"" : "in",
> - ? ? ? ? ? ? ? ?(wtcon & S3C2410_WTCON_RSTEN) ? "" : "dis",
> - ? ? ? ? ? ? ? ?(wtcon & S3C2410_WTCON_INTEN) ? "" : "en");
> + ? ? ? ? ? ? ? ?(wtcon & S3C2410_WTCON_RSTEN) ? "en" : "dis",
> + ? ? ? ? ? ? ? ?(wtcon & S3C2410_WTCON_INTEN) ? "en" : "dis");
>
> ? ? ? ?return 0;
>
> --
> 1.7.5.1.300.gc565c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
