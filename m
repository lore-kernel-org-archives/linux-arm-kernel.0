From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 10:05:17 +0100
Subject: [PATCH v5 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
Message-ID: <52A587CD.7010203@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 07:31 AM, Peter Chen wrote:
> After clear portsc.phcd, PHY needs 200us stable time for switch
> 32K clock to AHB clock.

If this is a general bugbix, please move it to the start of this series
and add stable on Cc. I think I hit the bug on the second USB port of a
custom MX28 board, the stmp_reset_block() in the USB phy will fail.

Is the problem documented somewhere?

Is it possible to add the delay in the clock framework? I think only the
regulator framework has a configurable delay for the regulator to stabilize.

> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index e18fdf3..7ae5225 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -151,6 +151,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
>  	return mxs_phy->data == &imx6sl_phy_data;
>  }
>  
> +/*
> + * PHY needs some 32K cycles to switch from 32K clock to
> + * bus (such as AHB/AXI, etc) clock.
> + */
> +static void mxs_phy_clock_switch(void)
> +{
> +	usleep_range(300, 400);
> +}
> +
>  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
>  {
>  	int ret;
> @@ -276,6 +285,7 @@ static int mxs_phy_init(struct usb_phy *phy)
>  {
>  	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
>  
> +	mxs_phy_clock_switch();
>  	clk_prepare_enable(mxs_phy->clk);
>  	return mxs_phy_hw_init(mxs_phy);
>  }
> @@ -300,6 +310,7 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
>  		       x->io_priv + HW_USBPHY_CTRL_SET);
>  		clk_disable_unprepare(mxs_phy->clk);
>  	} else {
> +		mxs_phy_clock_switch();
>  		clk_prepare_enable(mxs_phy->clk);
>  		writel(BM_USBPHY_CTRL_CLKGATE,
>  		       x->io_priv + HW_USBPHY_CTRL_CLR);
> 

Marc
-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/2a1a086e/attachment.sig>
