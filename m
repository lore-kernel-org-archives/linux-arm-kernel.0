From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 24 Dec 2013 10:25:17 +0800
Subject: [PATCH v7 10/14] usb: phy-mxs: add controller id
In-Reply-To: <20131224013446.GB13518@shlinux1.ap.freescale.net>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-11-git-send-email-peter.chen@freescale.com>
 <20131224020826.GC1128@S2101-09.ap.freescale.net>
 <20131224013446.GB13518@shlinux1.ap.freescale.net>
Message-ID: <20131224022516.GD1128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 24, 2013 at 09:34:47AM +0800, Peter Chen wrote:
> On Tue, Dec 24, 2013 at 10:08:28AM +0800, Shawn Guo wrote:
> > On Fri, Dec 20, 2013 at 03:52:06PM +0800, Peter Chen wrote:
> > > It is used to access un-regulator registers according to
> > > different controllers.
> > > 
> > > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > > ---
> > >  drivers/usb/phy/phy-mxs-usb.c |    8 ++++++++
> > >  1 files changed, 8 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > > index f28bdd8..09ece2b 100644
> > > --- a/drivers/usb/phy/phy-mxs-usb.c
> > > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > > @@ -111,6 +111,7 @@ struct mxs_phy {
> > >  	struct clk *clk;
> > >  	const struct mxs_phy_data *data;
> > >  	struct regmap *regmap_anatop;
> > > +	int port_id;
> > >  };
> > >  
> > >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> > > @@ -237,6 +238,13 @@ static int mxs_phy_probe(struct platform_device *pdev)
> > >  		return -ENOMEM;
> > >  	}
> > >  
> > > +	ret = of_alias_get_id(np, "usbphy");
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > It has the same compatibility issue with an old DTB.  In case the alias
> > is not found, we should keep driver work in the existing way rather than
> > failing out.
> > 
> 
> Thanks, will change.
> 
> Do the two DTS patches are ok?

Yes.  And with the DTS change being optional to kernel driver, the DTS
and driver changes can be merged independently through two trees.  So
I just applied those two DTS patches.

Shawn
