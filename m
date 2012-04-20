From: mgr@pengutronix.de (Michael Grzeschik)
Date: Fri, 20 Apr 2012 18:36:26 +0200
Subject: [RFC PATCH 00/10 V3] MXS: Add i.MX28 USB Host driver
In-Reply-To: <20120420132647.GQ3852@pengutronix.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <20120420094805.GS20478@pengutronix.de>
 <CAL411-onyB8SJEBoJ2XK=wyHKR0C7SyJtCsoJCDZGatP8HmYZg@mail.gmail.com>
 <201204201444.49184.marex@denx.de>
 <20120420132647.GQ3852@pengutronix.de>
Message-ID: <20120420163626.GL14876@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 03:26:47PM +0200, Sascha Hauer wrote:
> On Fri, Apr 20, 2012 at 02:44:48PM +0200, Marek Vasut wrote:
> > Dear Peter Chen,
> > 
> > > On Fri, Apr 20, 2012 at 5:48 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > >> btw /wrt USB Gadget etc -- how does the
> > > >> drivers/usb/gadget/fsl_udc_core.c and drivers/usb/gadget/ci13xxx_* fit
> > > >> into the big picture? We're gonna use the ci13xxx stuff for Gadget on
> > > >> mx28, correct? Then how does fsl_udc_core.c fit in?
> > > > 
> > > > From what I have been told by a collegue the ci13xxx driver works
> > > > better, and from what I have seen the code looks better. So I think mxs
> > > > should use it. i.MX can then use it later aswell. We won't need the
> > > > fsl_udc_core driver anymore then.
> > > 
> > > Oh, I find I lost many discussions using company email.
> > > From the function and quality level, fsl_udc_core.c is absolutely the
> > > best one for all
> > > i.mx SoCs, as both internal and upstream fsl code use it.
> > 
> > Internally though, it looks like crap.
> 
> +1 on this.

+1

We also made some tests with some gadget devices. IMHO we had troubles
with gadget_zero and testusb on the fsl_udc_core.c. I think the testusb
results should help to decide which is the most stable implementation.

> 
> > Also, ci13xxx and fsl_usb_core is duplicated stuff, correct?
> 
> Yes.
> 
> > 
> > > I will check with IC guys to see if i.mx's controller is compatible
> > > with CI13412.
> > > If fsl's compatible with CI13412, then mxs can try to use ci13xxx_udc.c to
> > > see if there are any problems, If no problems with kinds of testing,
> > > we can switch all i.mx SoC to ci13xxx_udc.c.
> > 
> > Sascha, did you need to patch this ci13xxx somehow to get it running on MXS ? Or 
> > what was it that said he got it somehow running?
> 
> It basically works out of the box. I think we have some patches for this
> driver, maybe michael can comment on this.

Yes, i have some smaller bugfix patches hanging around. I will send them
to the linux-usb mailinglist until the next week. Additionaly i have
some platform gluecode and a platform-support patch for the driver but you
probably have the same.

The ci13xxx_udc_driver has a flags element, which has to be set
appropriate to the used platform. On the mx23 for example we only were
able to get all testusb results correct, when the option
CI13XXX_DISABLE_STREAMING was set. In the OTG case the option
CI13XXX_REGS_SHARED is mandatory.

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
