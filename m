From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 24 Feb 2016 18:29:43 +0100 (CET)
Subject: [PATCH] i2c: bcm2835: Don't complain on -EPROBE_DEFER from
 getting our clock
In-Reply-To: <1455844375-15019-1-git-send-email-eric@anholt.net>
References: <1455844375-15019-1-git-send-email-eric@anholt.net>
Message-ID: <1956465948.222514.b52ca77e-fe5e-4536-8e14-525e9a846cdc.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 19. Februar 2016 um 02:12 geschrieben:
>
>
> Fixes dmesg spam when we just need to wait a moment for the clock
> driver to probe.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-bcm2835.c
> b/drivers/i2c/busses/i2c-bcm2835.c
> index 818b051..d4f3239 100644
> --- a/drivers/i2c/busses/i2c-bcm2835.c
> +++ b/drivers/i2c/busses/i2c-bcm2835.c
> @@ -253,7 +253,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>
> i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
> if (IS_ERR(i2c_dev->clk)) {
> - dev_err(&pdev->dev, "Could not get clock\n");
> + if (PTR_ERR(i2c_dev->clk) != -EPROBE_DEFER)
> + dev_err(&pdev->dev, "Could not get clock\n");

i know it's something different, but how about printing the error code here?

Regards
Stefan

> return PTR_ERR(i2c_dev->clk);
> }
>
> --
> 2.7.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
