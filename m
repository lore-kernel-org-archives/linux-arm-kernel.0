From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 17 Jul 2012 09:30:32 +0800
Subject: [PATCH 10/12] USB: chipidea: add set_vbus_power support
In-Reply-To: <500404AF.3070100@pengutronix.de>
References: <1342076512-19207-1-git-send-email-richard.zhao@freescale.com>
 <1342076512-19207-11-git-send-email-richard.zhao@freescale.com>
 <500404AF.3070100@pengutronix.de>
Message-ID: <20120717013031.GJ21635@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 02:10:23PM +0200, Marc Kleine-Budde wrote:
> On 07/12/2012 09:01 AM, Richard Zhao wrote:
> > set_vbus_power is used to enable or disable vbus power for usb host.
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  drivers/usb/chipidea/ci13xxx_imx.c |   39 +++++++++++++++++++++++++-----------
> >  drivers/usb/chipidea/host.c        |    8 ++++++++
> >  include/linux/usb/chipidea.h       |    2 ++
> >  3 files changed, 37 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
> > index c94e30f..b3173d8 100644
> > --- a/drivers/usb/chipidea/ci13xxx_imx.c
> > +++ b/drivers/usb/chipidea/ci13xxx_imx.c
> > @@ -26,6 +26,8 @@
> >  
> >  #define pdev_to_phy(pdev) \
> >  	((struct usb_phy *)platform_get_drvdata(pdev))
> > +#define ci_to_imx_data(ci) \
> > +	((struct ci13xxx_imx_data *)dev_get_drvdata(ci->dev->parent))
> >  
> >  struct ci13xxx_imx_data {
> >  	struct device_node *phy_np;
> > @@ -35,12 +37,32 @@ struct ci13xxx_imx_data {
> >  	struct regulator *reg_vbus;
> >  };
> >  
> > +static int ci13xxx_imx_vbus(struct ci13xxx *ci, int enable)
> > +{
> > +	struct ci13xxx_imx_data *data = ci_to_imx_data(ci);
> > +	int ret;
> > +
> > +	if (!data->reg_vbus)
> > +		return 0;
> > +
> > +	if (enable)
> > +		ret = regulator_enable(data->reg_vbus);
> > +	else
> > +		ret = regulator_disable(data->reg_vbus);
> > +	if (ret)
> > +		dev_err(ci->dev, "ci13xxx_imx_vbus failed, enable:%d err:%d\n",
> > +			enable, ret);
> > +
> > +	return ret;
> > +}
> > +
> >  static struct ci13xxx_platform_data ci13xxx_imx_platdata __devinitdata  = {
> >  	.name			= "ci13xxx_imx",
> >  	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
> >  				  CI13XXX_PULLUP_ON_VBUS |
> >  				  CI13XXX_DISABLE_STREAMING,
> >  	.capoffset		= DEF_CAPOFFSET,
> > +	.set_vbus_power		= ci13xxx_imx_vbus,
> >  };
> >  
> >  static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> > @@ -101,18 +123,10 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
> >  
> >  	/* we only support host now, so enable vbus here */
> 
> With this patch, the comment becomes wrong.
Good catch.

Thanks
Richard
> 
> >  	reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
> > -	if (!IS_ERR(reg_vbus)) {
> > -		ret = regulator_enable(reg_vbus);
> > -		if (ret) {
> > -			dev_err(&pdev->dev,
> > -				"Failed to enable vbus regulator, err=%d\n",
> > -				ret);
> > -			goto put_np;
> > -		}
> > +	if (!IS_ERR(reg_vbus))
> >  		data->reg_vbus = reg_vbus;
> > -	} else {
> > +	else
> >  		reg_vbus = NULL;
> > -	}
> >  
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
