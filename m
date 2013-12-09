From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Dec 2013 17:07:50 +0800
Subject: [PATCH v5 09/15] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <52A58179.2050702@pengutronix.de>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-10-git-send-email-peter.chen@freescale.com>
 <52A58179.2050702@pengutronix.de>
Message-ID: <20131209090749.GB5291@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 09, 2013 at 09:38:17AM +0100, Marc Kleine-Budde wrote:
> On 12/09/2013 07:30 AM, Peter Chen wrote:
> > Some PHY bugs are fixed by IC logic, but these bits are not
> > enabled by default, so we enable them at driver.
> 
> Which bugs are fixed by enabling this bit? Is it only suspend related?
> Can you document them or better add a pointer to the documentation.

I will add more, in fact, it fixes the bug which flag BIT(1) and BIT(2)
stands for.

> 
> Further I don't like the idea of adding code, or enabling a feature on
> certain hardware, that is broken in the first place and fixing it in a
> later patch. Think about squashing it into the correct patch.

No fixes are related with this patch, you can see there is no "-"
at this patch.

> >  
> > +static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
> > +{
> > +	return mxs_phy->data == &imx6q_phy_data;
> > +}
> > +
> > +static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
> > +{
> > +	return mxs_phy->data == &imx6sl_phy_data;
> > +}
> 
> Are the two is_imx6* functions still needed?

Will more it to [14/15], they are needed there.

Peter

> 
> > +
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> >  	int ret;
> > @@ -123,6 +144,9 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  		BM_USBPHY_CTRL_ENUTMILEVEL3,
> >  	       base + HW_USBPHY_CTRL_SET);
> >  
> > +	if (mxs_phy->data->flags & MXS_PHY_NEED_IP_FIX)
> > +		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
> > +
> >  	return 0;
> >  }
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 



-- 

Best Regards,
Peter Chen
