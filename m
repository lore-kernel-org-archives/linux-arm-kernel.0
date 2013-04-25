From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Apr 2013 18:13:04 +0300
Subject: Multiple issues with omap4 panda es in linux next
In-Reply-To: <20130425150120.GH5184@atomide.com>
References: <20130422180316.GA10155@atomide.com> <5176A45B.5@ti.com>
 <20130423172353.GD10155@atomide.com>
 <20130423213151.GM10155@atomide.com>
 <20130423231605.GO10155@atomide.com> <517770A0.4000609@ti.com>
 <20130424190821.GB5184@atomide.com>
 <20130424192330.GC5184@atomide.com>
 <20130425090447.GK7889@arwen.pp.htv.fi>
 <20130425150120.GH5184@atomide.com>
Message-ID: <20130425151304.GK19395@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

On Thu, Apr 25, 2013 at 08:01:20AM -0700, Tony Lindgren wrote:
> > > > > >>>>>>>2. MUSB fails with legacy booting and DT on panda es
> > > > > >>>>>>>
> > > > > >>>>>>>With both legacy and DT booting I get something like:
> > > > > >>>>>>>
> > > > > >>>>>>>HS USB OTG: no transceiver configured
> > > > > >>>>>>>musb-hdrc musb-hdrc.0.auto: musb_init_controller failed with status -517
> > > > > >>>>>>
> > > > > >>>>>>The dt should work fine with https://patchwork.kernel.org/patch/2423061/.
> > > > > >>>>>
> > > > > >>>>>OK thanks for checking that.
> > > > > >
> > > > > >Kishon, I think there's also some other issue remaining
> > > > > >in linux next with MUSB and DT. I'm still getting the
> > > > > >"HS USB OTG: no transceiver configured" although the nop
> > > > > >xceiv is compiled in. Maybe give it a try against linux
> > > > > >next?
> > > > > 
> > > > > For OMAP4 MUSB, you'll need omap-usb2 phy. I've attached my .config.
> > > > 
> > > > Thanks your config helped me to track it down. Looks like I got
> > > > the PHYs the wrong way around between EHCI and MUSB..
> > > > 
> > > > In any case, I did have omap-usb2 compiled in, but I did not have
> > > > OMAP_OCP2SCP=y set. Should OMAP_USB2 depend on that?
> > > > 
> > > > Also, looks like MUSB just sits in b_idle mode though, so no more
> > > > ID pin interrupt for some reason.
> > > 
> > > OK looks like I got the ID interrupt going by enabling
> > > CONFIG_TWL6030_USB=y. Still stays in a_idle with no keyboard
> > > after plugging it in, but now changes between a and b mode.
> > 
> > come again, you ground ID pin and have no devices attached ? Then it
> > should stay in a_idle.
> 
> After playing with looks like it detects the keyboard after replugging
> the cable a few times. So it's not detecting the keyboard every time when
> plugged in, but sounds like that's not related to the DT patches. It's
> probably the session bit related issues again..

could be, that part definitely needs some clenaning.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130425/c462710c/attachment.sig>
