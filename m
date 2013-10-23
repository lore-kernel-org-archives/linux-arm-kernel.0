From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 23 Oct 2013 14:46:04 +0800
Subject: [Patch v2 02/14] usb: phy-mxs: Add platform judgement code
In-Reply-To: <20131023061322.GF2839@S2101-09.ap.freescale.net>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
 <1382421528-17897-3-git-send-email-peter.chen@freescale.com>
 <20131023061322.GF2839@S2101-09.ap.freescale.net>
Message-ID: <20131023064604.GE8534@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 02:13:24PM +0800, Shawn Guo wrote:
> > +
> > +enum imx_phy_type {
> > +	IMX6Q_USB_PHY,
> > +	IMX6SL_USB_PHY,
> > +	IMX23_USB_PHY,
> > +};
> > +
> >  struct mxs_phy {
> >  	struct usb_phy phy;
> >  	struct clk *clk;
> > +	enum imx_phy_type devtype;
> >  };
> >  
> > -#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> > +static inline int is_mx6q_phy(struct mxs_phy *data)
> > +{
> > +	return data->devtype == IMX6Q_USB_PHY;
> > +}
> > +
> > +static inline int is_mx6sl_phy(struct mxs_phy *data)
> > +{
> > +	return data->devtype == IMX6SL_USB_PHY;
> > +}
> > +
> > +static inline int is_mx23_phy(struct mxs_phy *data)
> > +{
> > +	return data->devtype == IMX23_USB_PHY;
> > +}
> > +
> > +static struct platform_device_id imx_phy_devtype[] = {
> > +	{
> > +		.name = "usb-phy-imx6q",
> > +		.driver_data = IMX6Q_USB_PHY,
> > +	}, {
> > +		.name = "usb-phy-imx6sl",
> > +		.driver_data = IMX6SL_USB_PHY,
> > +	}, {
> > +		.name = "usb-phy-imx23",
> > +		.driver_data = IMX23_USB_PHY,
> > +	}, {
> > +		/* sentinel */
> > +	}
> > +};
> 
> I know many imx device drivers have this platform_device_id table, but
> that's because they need to support both non-DT and DT probe.  Since
> this driver supports DT probe only, we can save this table by passing
> imx_phy_type value through of_device_id.data directly.

How about compare compatible string directly at probe?

	if (of_device_is_compatible(np, "fsl,imx6q-usbphy"))
		mxs_phy->devtype = IMX6Q_USB_PHY;
	else if ((of_device_is_compatible(np, "fsl,imx6sl-usbphy"))
		mxs_phy->devtype = IMX6SL_USB_PHY;
	else if (...)
		...;

I don't know how to passing imx_phy_type value through below table
directly? imx_phy_type is a enum variable, not a arrary.

> 
> > +static const struct of_device_id mxs_phy_dt_ids[] = {
> > +	{ .compatible = "fsl,imx6q-usbphy", .data = &imx_phy_devtype[IMX6Q_USB_PHY], },
> > +	{ .compatible = "fsl,imx6sl-usbphy", .data = &imx_phy_devtype[IMX6SL_USB_PHY], },
> > +	{ .compatible = "fsl,imx23-usbphy", .data = &imx_phy_devtype[IMX23_USB_PHY], },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> >  
> >  static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
> >  {
> > @@ -131,6 +177,14 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >  	struct clk *clk;
> >  	struct mxs_phy *mxs_phy;
> >  	int ret;
> > +	const struct of_device_id *of_id =
> > +			of_match_device(mxs_phy_dt_ids, &pdev->dev);
> > +
> > +	/* This driver is DT-only version now */
> > +	if (!of_id)
> > +		return -ENXIO;
> 
> Since it's DT-only, I'm not sure you will run into the case that
> mxs_phy_probe() is called with a NULL of_id.  The check looks
> unnecessary to me.

Will change.

> 
> > +
> > +	pdev->id_entry = of_id->data;
> 
> Some imx device drivers did the same thing, but we should keep
> pdev->id_entry immutable.  The removal of that platform_device_id table
> will help save this.

Surely we can delete this line if no platform_device_id table.

-- 

Best Regards,
Peter Chen
