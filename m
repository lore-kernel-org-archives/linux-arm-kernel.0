From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Dec 2013 17:19:52 +0800
Subject: [PATCH v5 15/15] usb: phy-mxs: Add sync time after controller
 clear phcd
In-Reply-To: <52A587CD.7010203@pengutronix.de>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-16-git-send-email-peter.chen@freescale.com>
 <52A587CD.7010203@pengutronix.de>
Message-ID: <20131209091951.GD5291@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 10:05:17AM +0100, Marc Kleine-Budde wrote:
> On 12/09/2013 07:31 AM, Peter Chen wrote:
> > After clear portsc.phcd, PHY needs 200us stable time for switch
> > 32K clock to AHB clock.
> 
> If this is a general bugbix, please move it to the start of this series
> and add stable on Cc. I think I hit the bug on the second USB port of a
> custom MX28 board, the stmp_reset_block() in the USB phy will fail.

Not a bug-fix, just the requirement for the PHY leaves low power mode.
Does the bug exists with my this patchset, or just current mainline code?

> 
> Is the problem documented somewhere?
> 
> Is it possible to add the delay in the clock framework? I think only the
> regulator framework has a configurable delay for the regulator to stabilize.

It is just related to mxs PHY's hardware timing. It is better to add
it at specific driver.

Peter

> 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
> >  1 files changed, 11 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index e18fdf3..7ae5225 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -151,6 +151,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
> >  	return mxs_phy->data == &imx6sl_phy_data;
> >  }
> >  
> > +/*
> > + * PHY needs some 32K cycles to switch from 32K clock to
> > + * bus (such as AHB/AXI, etc) clock.
> > + */
> > +static void mxs_phy_clock_switch(void)
> > +{
> > +	usleep_range(300, 400);
> > +}
> > +
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> >  	int ret;
> > @@ -276,6 +285,7 @@ static int mxs_phy_init(struct usb_phy *phy)
> >  {
> >  	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
> >  
> > +	mxs_phy_clock_switch();
> >  	clk_prepare_enable(mxs_phy->clk);
> >  	return mxs_phy_hw_init(mxs_phy);
> >  }
> > @@ -300,6 +310,7 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
> >  		       x->io_priv + HW_USBPHY_CTRL_SET);
> >  		clk_disable_unprepare(mxs_phy->clk);
> >  	} else {
> > +		mxs_phy_clock_switch();
> >  		clk_prepare_enable(mxs_phy->clk);
> >  		writel(BM_USBPHY_CTRL_CLKGATE,
> >  		       x->io_priv + HW_USBPHY_CTRL_CLR);
> > 
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 

Best Regards,
Peter Chen
