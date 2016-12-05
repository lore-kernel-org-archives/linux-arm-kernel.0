From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 05 Dec 2016 11:54:00 +0100
Subject: [PATCH] i2c: rk3x: keep i2c irq ON in suspend
In-Reply-To: <1480924979-13450-1-git-send-email-david.wu@rock-chips.com>
References: <1480924979-13450-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <1737869.ycGphUXI8X@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Am Montag, 5. Dezember 2016, 16:02:59 CET schrieb David Wu:
> During suspend there may still be some i2c access happening.
> And if we don't keep i2c irq ON, there may be i2c access timeout if
> i2c is in irq mode of operation.

can you describe the issue you're trying to fix a bit more please?

I.e. I'd think the i2c-core does suspend i2c-client devices first, so that
these should be able to finish up their ongoing transfers and not start any
new ones instead?

Your irq can still happen slightly after the system started going to actually
sleep, so to me it looks like you just widened the window where irqs can be
handled. Especially as your irq could also just simply stem from the start
state, so you cannot even be sure if your transaction actually is finished.

So to me it looks like the i2c-connected device driver should be fixed instead?

In the past I solved this for example in the zforce_ts driver [0] to
prevent i2c transfers from happening during suspend.


Heiko

[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/zforce_ts.c


> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
> index df22066..67af32a 100644
> --- a/drivers/i2c/busses/i2c-rk3x.c
> +++ b/drivers/i2c/busses/i2c-rk3x.c
> @@ -1261,7 +1261,7 @@ static int rk3x_i2c_probe(struct platform_device
> *pdev) }
> 
>  	ret = devm_request_irq(&pdev->dev, irq, rk3x_i2c_irq,
> -			       0, dev_name(&pdev->dev), i2c);
> +			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), i2c);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "cannot request IRQ\n");
>  		return ret;
