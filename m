From: balbi@ti.com (Felipe Balbi)
Date: Mon, 27 Jan 2014 10:05:20 -0600
Subject: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library
 returns -ENODEV/-ENXIO
In-Reply-To: <20140127150855.GA17928@xps8300>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1390299099-14764-1-git-send-email-kishon@ti.com>
 <20140121144725.GF30451@saruman.home>
 <20140127150855.GA17928@xps8300>
Message-ID: <20140127160458.GF13268@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 27, 2014 at 05:08:55PM +0200, Heikki Krogerus wrote:
> > > Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
> > > do not return from probe if the USB PHY library returns -ENODEV as that
> > 
> > this isn't correct, they all have PHYs, some of them might not be
> > controllable.
> > 
> > > indicates the platform does not have PHY.
> > 
> > not really, that indicates the current platform tried to grab a PHY and
> > the PHY doesn't exist. If there's anybody with a non-controllable PHY
> > and someone gives me a really good reason for not using the generic
> > no-op PHY, then we should add a flag and we could:
> > 
> > 	if (!likely(dwc->flags & DWC3_USB2PHY_DRIVER_NOT_NEEDED))
> > 		dwc3_grab_phys(dwc);
> 
> Why would you need to know if the PHY drivers are needed or not
> explicitly in your controller driver?

because, one way or another, they all do need it. Except for quirky ones
like AM437x where a USB3 IP was hardwired into USB2-only mode, so it
really lacks a USB3 PHY.

> > But I really want to see the argument against using no-op. As far as I
> > could see, everybody needs a PHY driver one way or another, some
> > platforms just haven't sent any PHY driver upstream and have their own
> > hacked up solution to avoid using the PHY layer.
> 
> Not true in our case. Platforms using Intel's SoCs and chip sets may
> or may not have controllable USB PHY. Quite often they don't. The
> Baytrails have usually ULPI PHY for USB2, but that does not mean they
> provide any vendor specific functions or any need for a driver in any
> case.

that's different from what I heard.

> Are we talking about the old USB PHY library or the new PHY framework
> with the no-op PHY driver?
> 
> Well, in any case, I don't understand what is the purpose of the no-op
> PHY driver. What are you drying to achieve with that?

I'm trying to avoid supporting 500 different combinations for a single
driver. We already support old USB PHY layer and generic PHY layer, now
they both need to be made optional. The old USB PHY layer also provides
a no-op, now called phy-generic, which is actually pretty useful.

On top of all that, I'm sure you'll subscribe to the idea of preventing
dwc3 from becoming another MUSB which supports several different
configurations and none work correctly. I much prefer to take baby steps
which are well thought-out and very well exercised, so I'll be very
pedantic about proof of testing.

An invasive change such as $subject needs to be very well-tested in
different architectures with different Kconfig choices before I'd feel
comfortable applying it.

Also, the assumptions made in $subject are just plain wrong, which
gets me really iffy about applying it or not.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140127/afb7097a/attachment.sig>
