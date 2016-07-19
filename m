From: jun.li@nxp.com (Jun Li)
Date: Tue, 19 Jul 2016 02:31:41 +0000
Subject: [PATCH 4/4] usb: chipidea: imx: set over current polarity per dts
 setting
In-Reply-To: <20160719015729.GA26038@shlinux2>
References: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
 <1468840547-17899-4-git-send-email-jun.li@nxp.com>
 <20160719015729.GA26038@shlinux2>
Message-ID: <AM4PR04MB21300689DA05A4D36F13607B89370@AM4PR04MB2130.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

> -----Original Message-----
> From: Peter Chen [mailto:hzpeterchen at gmail.com]
> Sent: Tuesday, July 19, 2016 9:57 AM
> To: Jun Li <jun.li@nxp.com>
> Cc: Peter Chen <peter.chen@nxp.com>; robh+dt at kernel.org;
> shawnguo at kernel.org; devicetree at vger.kernel.org; linux-usb at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 4/4] usb: chipidea: imx: set over current polarity per
> dts setting
> 
> On Mon, Jul 18, 2016 at 07:15:47PM +0800, Li Jun wrote:
> > With over-current-polarity property added, imx usb over current
> > polarity can be configed to be low or high active, since the default
> > setting value(0) is for active high, so keep this setting for those
> > legacy platforms without this property specified.
> >
> > Signed-off-by: Li Jun <jun.li@nxp.com>
> > ---
> >  drivers/usb/chipidea/ci_hdrc_imx.c |  9 +++++++++
> > drivers/usb/chipidea/ci_hdrc_imx.h |  1 +
> > drivers/usb/chipidea/usbmisc_imx.c | 30 +++++++++++++++++++++++++-----
> >  3 files changed, 35 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c
> > b/drivers/usb/chipidea/ci_hdrc_imx.c
> > index dedc33e..61e712b 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> > @@ -140,6 +140,15 @@ static struct imx_usbmisc_data
> *usbmisc_get_init_data(struct device *dev)
> >  	if (of_find_property(np, "disable-over-current", NULL))
> >  		data->disable_oc = 1;
> >
> > +	if (!of_property_read_u32(np, "over-current-polarity", &ret))
> > +		data->oc_polarity = ret ? 1 : 0;
> > +	else
> > +		/*
> > +		 * Keep the oc polarity setting of legacy
> > +		 * platforms unchanged.
> > +		 */
> > +		data->oc_polarity = 1;
> 
> We may can't ensure that, since there are lots of i.mx platforms, eg from
> imx27 to imx7.
> 
> If the user does not assign oc polarity at DT, we need to read it from
> register.

I suppose old platforms (other than i.mx6&7) should set either
"over-current-polarity" or "disable-over-current" if want to use
"data->oc_polarity".
 
Do you mean read the register value before set "data->oc_polarity" here?
Even with that, as I still can't ensure all i.mx platforms have the same
mapping:
0 <--> active high.
1 <--> active low.
How should I set "data->oc_polarity" accordingly?

Li Jun
> 
> Peter
> > +
> >  	if (of_find_property(np, "external-vbus-divider", NULL))
> >  		data->evdo = 1;
> >
> > diff --git a/drivers/usb/chipidea/ci_hdrc_imx.h
> > b/drivers/usb/chipidea/ci_hdrc_imx.h
> > index 635717e..409aa5ca8 100644
> > --- a/drivers/usb/chipidea/ci_hdrc_imx.h
> > +++ b/drivers/usb/chipidea/ci_hdrc_imx.h
> > @@ -17,6 +17,7 @@ struct imx_usbmisc_data {
> >  	int index;
> >
> >  	unsigned int disable_oc:1; /* over current detect disabled */
> > +	unsigned int oc_polarity:1; /* over current polarity if oc enabled
> > +*/
> >  	unsigned int evdo:1; /* set external vbus divider option */  };
> >
> > diff --git a/drivers/usb/chipidea/usbmisc_imx.c
> > b/drivers/usb/chipidea/usbmisc_imx.c
> > index ab8b027..193dbe4 100644
> > --- a/drivers/usb/chipidea/usbmisc_imx.c
> > +++ b/drivers/usb/chipidea/usbmisc_imx.c
> > @@ -56,6 +56,7 @@
> >
> >  #define MX6_BM_NON_BURST_SETTING	BIT(1)
> >  #define MX6_BM_OVER_CUR_DIS		BIT(7)
> > +#define MX6_BM_OVER_CUR_POLARITY	BIT(8)
> >  #define MX6_BM_WAKEUP_ENABLE		BIT(10)
> >  #define MX6_BM_ID_WAKEUP		BIT(16)
> >  #define MX6_BM_VBUS_WAKEUP		BIT(17)
> > @@ -266,11 +267,18 @@ static int usbmisc_imx6q_init(struct
> > imx_usbmisc_data *data)
> >
> >  	spin_lock_irqsave(&usbmisc->lock, flags);
> >
> > +	reg = readl(usbmisc->base + data->index * 4);
> >  	if (data->disable_oc) {
> > -		reg = readl(usbmisc->base + data->index * 4);
> > -		writel(reg | MX6_BM_OVER_CUR_DIS,
> > -			usbmisc->base + data->index * 4);
> > +		reg |= MX6_BM_OVER_CUR_DIS;
> > +	} else if (data->oc_polarity == 1) {
> > +		/* High active */
> > +		reg &= ~(MX6_BM_OVER_CUR_DIS | MX6_BM_OVER_CUR_POLARITY);
> > +	} else {
> > +		/* Low active */
> > +		reg &= ~MX6_BM_OVER_CUR_DIS;
> > +		reg |= MX6_BM_OVER_CUR_POLARITY;
> >  	}
> > +	writel(reg, usbmisc->base + data->index * 4);
> >
> >  	/* SoC non-burst setting */
> >  	reg = readl(usbmisc->base + data->index * 4); @@ -365,10 +373,18 @@
> > static int usbmisc_imx7d_init(struct imx_usbmisc_data *data)
> >  		return -EINVAL;
> >
> >  	spin_lock_irqsave(&usbmisc->lock, flags);
> > +	reg = readl(usbmisc->base);
> >  	if (data->disable_oc) {
> > -		reg = readl(usbmisc->base);
> > -		writel(reg | MX6_BM_OVER_CUR_DIS, usbmisc->base);
> > +		reg |= MX6_BM_OVER_CUR_DIS;
> > +	} else if (data->oc_polarity == 1) {
> > +		/* High active */
> > +		reg &= ~(MX6_BM_OVER_CUR_DIS | MX6_BM_OVER_CUR_POLARITY);
> > +	} else {
> > +		/* Low active */
> > +		reg &= ~MX6_BM_OVER_CUR_DIS;
> > +		reg |= MX6_BM_OVER_CUR_POLARITY;
> >  	}
> > +	writel(reg, usbmisc->base);
> >
> >  	reg = readl(usbmisc->base + MX7D_USBNC_USB_CTRL2);
> >  	reg &= ~MX7D_USB_VBUS_WAKEUP_SOURCE_MASK;
> > @@ -492,6 +508,10 @@ static const struct of_device_id
> usbmisc_imx_dt_ids[] = {
> >  		.compatible = "fsl,imx6ul-usbmisc",
> >  		.data = &imx6sx_usbmisc_ops,
> >  	},
> > +	{
> > +		.compatible = "fsl,imx7d-usbmisc",
> > +		.data = &imx7d_usbmisc_ops,
> > +	},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, usbmisc_imx_dt_ids);
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> 
> Best Regards,
> Peter Chen
