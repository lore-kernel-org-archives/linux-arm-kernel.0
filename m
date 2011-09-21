From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 21 Sep 2011 13:25:55 +0200
Subject: [PATCH v2 1/3] net/fec: change phy-reset-gpio request warning
	to debug message
In-Reply-To: <1316603432-20032-2-git-send-email-shawn.guo@linaro.org>
References: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
	<1316603432-20032-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110921112555.GE1966@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Wed, Sep 21, 2011 at 07:10:30PM +0800, Shawn Guo wrote:
> FEC can work without a phy reset on some platforms, which means not
> very platform necessarily have a phy-reset gpio encoded in device tree.
> So it makes more sense to have the phy-reset-gpio request failure as
> a debug message rather than a warning.

Or remove it entirely?

> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/net/ethernet/freescale/fec.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.c b/drivers/net/ethernet/freescale/fec.c
> index 158b82e..a057abf 100644
> --- a/drivers/net/ethernet/freescale/fec.c
> +++ b/drivers/net/ethernet/freescale/fec.c
> @@ -1422,7 +1422,7 @@ static int __devinit fec_reset_phy(struct platform_device *pdev)
>  	phy_reset = of_get_named_gpio(np, "phy-reset-gpios", 0);
>  	err = gpio_request_one(phy_reset, GPIOF_OUT_INIT_LOW, "phy-reset");
>  	if (err) {
> -		pr_warn("FEC: failed to get gpio phy-reset: %d\n", err);
> +		pr_debug("FEC: failed to get gpio phy-reset: %d\n", err);
>  		return err;

I also wanted to suggested to drop returning the error code, since it is
not an error anymore, strictly speaking. Then I noticed that the caller
does not check the error code. So, this could be added or turn the
function to void?

>  	}
>  	msleep(1);
> -- 
> 1.7.4.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110921/ac4f8693/attachment.sig>
