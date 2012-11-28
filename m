From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 28 Nov 2012 09:26:54 +0800
Subject: [PATCH 6/9] usb: chipidea: add PTW and PTS handling
In-Reply-To: <20121127095432.GC31008@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-7-git-send-email-m.grzeschik@pengutronix.de>
 <20121127011210.GA17856@nchen-desktop>
 <20121127095432.GC31008@pengutronix.de>
Message-ID: <20121128012653.GB18593@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 10:54:32AM +0100, Michael Grzeschik wrote:
> 
> I didn't figure out why this is needed. However, we prefer to move this
> hunk to be in ci_hdrc_probe just before ci_role_start gets called. So
> hw_portsc_configure will be called only there in the beginning. As the
> phy setup doesn't change, we need no further call and can take the delay
> unconditionally of the role.

I agree, as configure phy is common future, it is ok at ci_hdrc_probe.
Below initialization sequence is ok:

configure_phy
delay for phy stable
role_start(init)

> 
> > > +
> > >  	hcd = usb_create_hcd(&ci_ehci_hc_driver, ci->dev, dev_name(ci->dev));
> > >  	if (!hcd)
> > >  		return -ENOMEM;
> > > diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> > > index 906d259..cafca23 100644
> > > --- a/include/linux/usb/chipidea.h
> > > +++ b/include/linux/usb/chipidea.h
> > > @@ -21,6 +21,12 @@ struct ci13xxx_platform_data {
> > >  #define CI13XXX_DISABLE_STREAMING	BIT(3)
> > >  #define CI13XXX_DR_MODE_HOST		BIT(4)
> > >  #define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
> > > +#define CI13XXX_PORTSC_PTW_8BIT		BIT(6)
> > > +#define CI13XXX_PORTSC_PTW_16BIT	BIT(7)
> > > +#define CI13XXX_PORTSC_PTS_UTMI		BIT(8)
> > > +#define CI13XXX_PORTSC_PTS_ULPI		BIT(9)
> > > +#define CI13XXX_PORTSC_PTS_FSLS		BIT(10)
> > > +
> > >  #define CI13XXX_DR_MODE_MASK \
> > >  	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL)
> > >  
> > > @@ -42,4 +48,7 @@ void ci13xxx_remove_device(struct platform_device *pdev);
> > >  /* Parse of-tree "dr_mode" property */
> > >  void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
> > >  
> > > +/* Parse of-tree "flags" */
> > > +void ci13xxx_get_dr_flags(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
> > > +
> > >  #endif
> > > -- 
> > > 1.7.10.4
> > > 
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

-- 

Best Regards,
Peter Chen
