From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Jul 2013 09:28:44 +0300
Subject: [PATCH 2/2] arm: omap: remove *.auto* from device names given in
 usb_bind_phy
In-Reply-To: <51F75C40.4060406@ti.com>
References: <1374829418-27503-1-git-send-email-kishon@ti.com>
 <1374829418-27503-3-git-send-email-kishon@ti.com>
 <20130729150638.GD3063@radagast> <51F68A56.8060805@ti.com>
 <20130729175413.GC4964@radagast> <51F74BC8.7020903@ti.com>
 <20130730060134.GD9155@radagast> <51F7590B.4020705@ti.com>
 <20130730061830.GE9155@radagast> <51F75C40.4060406@ti.com>
Message-ID: <20130730062844.GH9155@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 30, 2013 at 11:55:04AM +0530, Kishon Vijay Abraham I wrote:
> > On Tue, Jul 30, 2013 at 11:41:23AM +0530, Kishon Vijay Abraham I wrote:
> >>>>>>>> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
> >>>>>>>> index 244d8a5..17bb076 100644
> >>>>>>>> --- a/arch/arm/mach-omap2/board-2430sdp.c
> >>>>>>>> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> >>>>>>>> @@ -233,7 +233,7 @@ static void __init omap_2430sdp_init(void)
> >>>>>>>>  	omap_hsmmc_init(mmc);
> >>>>>>>>  
> >>>>>>>>  	omap_mux_init_signal("usb0hs_stp", OMAP_PULL_ENA | OMAP_PULL_UP);
> >>>>>>>> -	usb_bind_phy("musb-hdrc.0.auto", 0, "twl4030_usb");
> >>>>>>>> +	usb_bind_phy("musb-hdrc.0", 0, "twl4030_usb");
> >>>>>>>
> >>>>>>> how about moving usb_bind_phy() calls to omap2430.c ?
> >>>>>>>
> >>>>>>> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> >>>>>>> index f44e8b5..b6abc1a 100644
> >>>>>>> --- a/drivers/usb/musb/omap2430.c
> >>>>>>> +++ b/drivers/usb/musb/omap2430.c
> >>>>>>> @@ -544,6 +544,9 @@ static int omap2430_probe(struct platform_device *pdev)
> >>>>>>>  
> >>>>>>>  		pdata->board_data	= data;
> >>>>>>>  		pdata->config		= config;
> >>>>>>> +	} else {
> >>>>>>> +		/* bind the PHY */
> >>>>>>> +		usb_bind_phy(dev_name(&musb->dev), 0, "twl4030_usb");
> >>>>>>
> >>>>>> This looks like a hack IMHO to workaround the usb phy library. otherwise it is
> >>>>>> similar to get_phy_by_name.
> >>>>>
> >>>>> actually, this is a workaround to the fact that we're not creating all
> >>>>> platform_devices in arch/arm/mach-omap2/ :-)
> >>>>>
> >>>>> If we had the musb allocation there, we could easily handle
> >>>>> usb_bind_phy()
> >>>>>
> >>>>>>> so that's temporary. It might be better than to reintroduce the IDR in
> >>>>>>> musb_core.c.
> >>>>>>
> >>>>>> that?s needed for generic phy framework anyway :-s
> >>>>>
> >>>>> right, but generic phy framework can handle everything just fine, the
> >>>>> only problem is that names are changing.
> >>>>
> >>>> right. But if the names change, PHY framework wouldn't be able to return the
> >>>> reference to the PHY.
> >>>
> >>> with my suggestion they can change whenever they want since we're using
> >>> dev_name() of the just-created musb platform_device. Right ?
> >>
> >> right. But the PHY device can be created in a different place from where the
> >> musb devices are created. And in the PHY framework, the PHY device should have
> > 
> > this shouldn't be a problem. As long as the phy is created, all should
> > be good.
> > 
> >> the list of controller device (names) it can support (PHY framework does not
> >> maintain a separate list for binding like how we had in USB PHY library). e.g.
> >> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg92817.html. In such
> > 
> > this has nothing to do with $subject though. We talk about generic PHY
> > framework once all these PHY drivers are moved there :-)
> > 
> >> cases how do we pass the device names. Also will the MUSB core device be
> >> created before twl4030-usb PHY device?
> > 
> > and why would that be a problem ? We're telling the framework that the
> > musb device will use a phy with a name of 'twl4030'. If musb calls
> > usb_get_phy_dev() and doesn't find a phy, it'll return -EPROBE_DEFER and
> > try again later.
> 
> I think we are talking about different problems here ;-) I'm trying to tell
> using idr in MUSB core is needed for Generic PHY Framework. So in a way, the
> Generic PHY Framework series depends on this patch series or else MUSB in OMAP3
> platforms wont work after Generic PHY framework gets merged.

then you just found a limitation in your framework, right ? :-) I mean,
imagine if now we have to add an IDR to every single user of your
framework because they could end up in systems with multiple instances
of the same IP ?

Now consider that you aim to have your framework be used by Network,
USB, SATA, Graphics, etc... Have you really only considered DT
platforms ? DT is quite easy since you can require folks to pass the
proper phandle, but drivers will want to use PLATFORM_DEVID_AUTO and
your framework needs to cope with that.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/6d076c74/attachment.sig>
