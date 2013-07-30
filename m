From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 30 Jul 2013 09:46:17 +0800
Subject: [PATCH v13 02/14] usb: chipidea: imx: remove vbus regulator
 operation
In-Reply-To: <20130729223025.GA7109@pengutronix.de>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
 <1374830310-21765-3-git-send-email-peter.chen@freescale.com>
 <20130729223025.GA7109@pengutronix.de>
Message-ID: <20130730014616.GD27709@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 12:30:25AM +0200, Michael Grzeschik wrote:
> Hi Peter,
> 
> On Fri, Jul 26, 2013 at 05:18:18PM +0800, Peter Chen wrote:
> > Since we have added vbus reguatlor operation at common
> > host file (chipidea/host.c), the glue layer vbus operation
> > isn't needed any more.
> > 
> > Tested-by: Marek Vasut <marex@denx.de>
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c |   30 +++++++-----------------------
> >  1 files changed, 7 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index 14362c0..d06355e 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -31,7 +31,6 @@ struct ci_hdrc_imx_data {
> >  	struct usb_phy *phy;
> >  	struct platform_device *ci_pdev;
> >  	struct clk *clk;
> > -	struct regulator *reg_vbus;
> >  };
> >  
> >  static const struct usbmisc_ops *usbmisc_ops;
> > @@ -141,22 +140,13 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
> >  		goto err_clk;
> >  	}
> >  
> > -	/* we only support host now, so enable vbus here */
> > -	data->reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > -	if (!IS_ERR(data->reg_vbus)) {
> > -		ret = regulator_enable(data->reg_vbus);
> > -		if (ret) {
> > -			dev_err(&pdev->dev,
> > -				"Failed to enable vbus regulator, err=%d\n",
> > -				ret);
> > -			goto err_clk;
> > -		}
> > -	} else {
> > -		data->reg_vbus = NULL;
> > -	}
> > -
> >  	pdata.phy = data->phy;
> >  
> > +	/* Get the vbus regulator */
> > +	pdata.reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > +	if (IS_ERR(pdata.reg_vbus))
> > +		pdata.reg_vbus = NULL;
> > +
> 
> This hunk needs the reg_vbus variable from the previous patch, therefor
> it should also be added in that patch. As the user of the variable is
> the previous patch, it's the reason to swap their order.
> 

The [1/14] implements the vbus operation at common code (host.c)
This one [2/14] implements how the glue layer get the vbus.

I am OK to swap above two, but I still can't see obvious reason.

> Anyway, can't this be done in core.c instead? I don't see why other
> users don't need this code.
> 

We still not implement DT support at core.c, it is a big job, this
is the main reason, besides, Alex prefers platform things at
glue layer.
-- 

Best Regards,
Peter Chen
