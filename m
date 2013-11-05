From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 13:17:47 +0800
Subject: [PATCH v3 05/11] usb: phy-mxs: Add anatop regmap
In-Reply-To: <20131105024753.GH19770@S2101-09.ap.freescale.net>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-6-git-send-email-peter.chen@freescale.com>
 <20131105024753.GH19770@S2101-09.ap.freescale.net>
Message-ID: <20131105051746.GF13472@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:47:55AM +0800, Shawn Guo wrote:
> On Tue, Nov 05, 2013 at 09:49:37AM +0800, Peter Chen wrote:
> > It is needed by imx6 SoC serial, but not for imx23 and imx28.
> 
> s/serial/series
> 
> Should we have another MXS_PHY_XXX flag for this, so that we can
> explicitly check when anatop must be there?
> 

OK, I will add it, it can let the imx23/28 do not check dts.

> Shawn
> 
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   15 +++++++++++++++
> >  1 files changed, 15 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index 472fe36..8cdfbf1 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -21,6 +21,8 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/of_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/mfd/syscon.h>
> >  
> >  #define DRIVER_NAME "mxs_phy"
> >  
> > @@ -87,6 +89,7 @@ struct mxs_phy {
> >  	struct usb_phy phy;
> >  	struct clk *clk;
> >  	unsigned int flags;
> > +	struct regmap *regmap_anatop;
> >  };
> >  
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> > @@ -191,6 +194,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  	const struct of_device_id *of_id =
> >  			of_match_device(mxs_phy_dt_ids, &pdev->dev);
> >  	const struct mxs_phy_platform_flag *platform_flag = of_id->data;
> > +	struct device_node *np = pdev->dev.of_node;
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	base = devm_ioremap_resource(&pdev->dev, res);
> > @@ -210,6 +214,17 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >  
> > +	/* Some SoCs don't have anatop registers */
> > +	if (of_get_property(np, "fsl,anatop", NULL)) {
> > +		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
> > +			(np, "fsl,anatop");
> > +		if (IS_ERR(mxs_phy->regmap_anatop)) {
> > +			dev_dbg(&pdev->dev,
> > +				"failed to find regmap for anatop\n");
> > +			return PTR_ERR(mxs_phy->regmap_anatop);
> > +		}
> > +	}
> > +
> >  	mxs_phy->phy.io_priv		= base;
> >  	mxs_phy->phy.dev		= &pdev->dev;
> >  	mxs_phy->phy.label		= DRIVER_NAME;
> > -- 
> > 1.7.1
> > 
> > 

-- 

Best Regards,
Peter Chen
