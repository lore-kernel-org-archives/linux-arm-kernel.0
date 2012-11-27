From: mgr@pengutronix.de (Michael Grzeschik)
Date: Tue, 27 Nov 2012 10:54:32 +0100
Subject: [PATCH 6/9] usb: chipidea: add PTW and PTS handling
In-Reply-To: <20121127011210.GA17856@nchen-desktop>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-7-git-send-email-m.grzeschik@pengutronix.de>
 <20121127011210.GA17856@nchen-desktop>
Message-ID: <20121127095432.GC31008@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 09:12:30AM +0800, Peter Chen wrote:
> On Wed, Nov 14, 2012 at 05:19:07PM +0100, Michael Grzeschik wrote:
> >  /**
> >   * hw_device_reset: resets chip (execute without interruption)
> >   * @ci: the controller
> > @@ -237,6 +256,8 @@ int hw_device_reset(struct ci13xxx *ci, u32 mode)
> >  	if (ci->platdata->flags & CI13XXX_DISABLE_STREAMING)
> >  		hw_write(ci, OP_USBMODE, USBMODE_CI_SDIS, USBMODE_CI_SDIS);
> >  
> > +	hw_portsc_configure(ci);
> > +

This can be dropped.

> >  	/* USBMODE should be configured step by step */
> >  	hw_write(ci, OP_USBMODE, USBMODE_CM, USBMODE_CM_IDLE);
> >  	hw_write(ci, OP_USBMODE, USBMODE_CM, mode);
> > @@ -522,6 +543,32 @@ void ci13xxx_remove_device(struct platform_device *pdev)
> >  }
> >  EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
> >  
> > +void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
> > +{
> > +	int interface = of_get_usbphy_mode(of_node);
> > +
> > +	switch (interface) {
> > +	case USBPHY_INTERFACE_MODE_UTMI:
> > +		pdata->flags |= CI13XXX_PORTSC_PTS_UTMI;
> > +		break;
> > +	case USBPHY_INTERFACE_MODE_UTMIW:
> > +		pdata->flags |= CI13XXX_PORTSC_PTS_UTMI |
> > +			CI13XXX_PORTSC_PTW_16BIT;
> > +		break;
> > +	case USBPHY_INTERFACE_MODE_ULPI:
> > +		pdata->flags |= CI13XXX_PORTSC_PTS_ULPI;
> > +		break;
> > +	case USBPHY_INTERFACE_MODE_SERIAL:
> > +		pdata->flags |= CI13XXX_PORTSC_PTS_FSLS;
> > +		break;
> > +	case USBPHY_INTERFACE_MODE_NA:
> > +	default:
> > +		pr_err("no phy interface defined\n");
> > +	}
> > +
> > +}
> > +EXPORT_SYMBOL_GPL(ci13xxx_get_dr_flags);
> > +
> >  void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
> >  {
> >  	const unsigned char *dr_mode;
> > diff --git a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c
> > index ebff9f4..b23ee1d 100644
> > --- a/drivers/usb/chipidea/host.c
> > +++ b/drivers/usb/chipidea/host.c
> > @@ -106,6 +106,10 @@ static int host_start(struct ci13xxx *ci)
> >  	if (usb_disabled())
> >  		return -ENODEV;
> >  
> > +	hw_portsc_configure(ci);
> > +
> > +	mdelay(10);
> is usleep_range ok?

I will change that.

> Why host needs 10ms delay, but peripheral mode doesn't?

I didn't figure out why this is needed. However, we prefer to move this
hunk to be in ci_hdrc_probe just before ci_role_start gets called. So
hw_portsc_configure will be called only there in the beginning. As the
phy setup doesn't change, we need no further call and can take the delay
unconditionally of the role.

> > +
> >  	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> >  	if (!hcd)
> >  		return -ENOMEM;
> > diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> > index 906d259..cafca23 100644
> > --- a/include/linux/usb/chipidea.h
> > +++ b/include/linux/usb/chipidea.h
> > @@ -21,6 +21,12 @@ struct ci13xxx_platform_data {
> >  #define CI13XXX_DISABLE_STREAMING	BIT(3)
> >  #define CI13XXX_DR_MODE_HOST		BIT(4)
> >  #define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
> > +#define CI13XXX_PORTSC_PTW_8BIT		BIT(6)
> > +#define CI13XXX_PORTSC_PTW_16BIT	BIT(7)
> > +#define CI13XXX_PORTSC_PTS_UTMI		BIT(8)
> > +#define CI13XXX_PORTSC_PTS_ULPI		BIT(9)
> > +#define CI13XXX_PORTSC_PTS_FSLS		BIT(10)
> > +
> >  #define CI13XXX_DR_MODE_MASK \
> >  	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL)
> >  
> > @@ -42,4 +48,7 @@ void ci13xxx_remove_device(struct platform_device *pdev);
> >  /* Parse of-tree "dr_mode" property */
> >  void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
> >  
> > +/* Parse of-tree "flags" */
> > +void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
> > +
> >  #endif
> > -- 
> > 1.7.10.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
