From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 24 Oct 2012 18:44:39 +0200
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210241233040.1282-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210241233040.1282-100000@iolanthe.rowland.org>
Message-ID: <2721213.h9kKFkpVW0@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012 12:38:42 Alan Stern wrote:
> On Wed, 24 Oct 2012, Stephen Warren wrote:
> 
> > On 10/24/2012 09:26 AM, Sebastian Andrzej Siewior wrote:
> > > On Wed, Oct 24, 2012 at 10:57:00AM -0400, Alan Stern wrote:
> > >> Under the circumstances, do we really need a new binding document for 
> > >> the ehci-platform driver?
> > 
> > It seems reasonable to add the new properties to usb-ehci.txt, since
> > they do describe the HW.
> > 
> > >> We should be able to use the existing 
> > >> usb-ehci binding, perhaps with some new properties added:
> > >>
> > >> 	has-synopsys-hc-bug
> > >> 	no-io-watchdog
> > >> 	has-tt
> > 
> > That sounds fine to me.
> > 
> > However, there is an implementation issue here. I believe the way Linux
> > searches for a driver for a particular node is:
> > 
> > for every driver that's registered
> >     if the driver's supported compatible list matches the device
> >         use the driver
> > 
> > (See drivers/base/platform.c:platform_match() which implements the if
> > statement above, and I assume the driver core implements the outer for
> > loop above)
> 
> Yes, it does.
> 
> > That means that if the generic driver supports compatible="usb-ehci", it
> > may "steal" device nodes that have
> > compatible="something-custom","usb-ehci", even if there's a driver
> > specifically for "something-custom". We would need to re-arrange the
> > driver matching code to:
> > 
> > for each compatible value in the node:
> >     for each driver that's registered:
> >         if the driver supports the compatible value:
> >             use the driver.
> 
> Which might be difficult since the inner loop would be controlled by
> the outer code in the driver core.
> 
> How do we determine which existing drivers claim to support usb-ehci?  
> A quick search under arch/ and drivers/ turns up nothing but
> drivers/usb/host/ehci-ppc-of.c.  Changing it to a more HW-specific
> match should be easy enough, and then "usb-ehci" would be safe to use
> in ehci-platform.c.

As long as no one enables both ehci-platform and ehci-ppc-of at the same time
there is no problem. ehci-ppc-of should be removed in favor of ehci-platform
and make sure that the specific quirk in ehci-ppc-of also gets ported, other 
that I see no issue using "usb-ehci" as the least detailed compatible property
name.
--
Florian
