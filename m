From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 7 Mar 2013 10:18:18 +0800
Subject: [PATCH v11 8/9] usb: chipidea: imx: add getting vbus regulator
 code
In-Reply-To: <20130306101146.GM28587@arwen.pp.htv.fi>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-9-git-send-email-peter.chen@freescale.com>
 <20130306101146.GM28587@arwen.pp.htv.fi>
Message-ID: <20130307021817.GB20470@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 12:11:46PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Mar 06, 2013 at 05:56:39PM +0800, Peter Chen wrote:
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci13xxx_imx.c |   28 +++++-----------------------
> >  1 files changed, 5 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> > index 3ed119e..b2d8350 100644
> > --- a/drivers/usb/chipidea/ci13xxx_imx.c
> > +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> > @@ -33,7 +33,6 @@ struct ci13xxx_imx_data {
> >  	struct usb_phy *phy;
> >  	struct platform_device *ci_pdev;
> >  	struct clk *clk;
> > -	struct regulator *reg_vbus;
> >  };
> >  
> >  static const struct usbmisc_ops *usbmisc_ops;
> > @@ -163,20 +162,9 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
> >  		data->phy = phy;
> >  	}
> >  
> > -	/* we only support host now, so enable vbus here */
> >  	reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > -	if (!IS_ERR(reg_vbus)) {
> > -		ret = regulator_enable(reg_vbus);
> > -		if (ret) {
> > -			dev_err(&pdev->dev,
> > -				"Failed to enable vbus regulator, err=%d\n",
> > -				ret);
> > -			goto err_clk;
> > -		}
> > -		data->reg_vbus = reg_vbus;
> > -	} else {
> > -		reg_vbus = NULL;
> > -	}
> > +	if (!IS_ERR(reg_vbus))
> > +		pdata->reg_vbus = reg_vbus;
> 
> what you're doing here is wrong. chipidea core should be the one calling
> devm_regulator_get().

chipidea core has not dts entry, is created by platform layer.
Regulator info is passed from dts.

> 
> -- 
> balbi



-- 

Best Regards,
Peter Chen
