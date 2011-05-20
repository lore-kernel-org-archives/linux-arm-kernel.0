From: stephen.neuendorffer@xilinx.com (Stephen Neuendorffer)
Date: Fri, 20 May 2011 09:08:17 -0700
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DD68614.6090209@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com><20110519233958.GB18181@ponder.secretlab.ca><4DD66B8A.5040404@gmail.com>
	<201105201621.03801.arnd@arndb.de> <4DD68614.6090209@gmail.com>
Message-ID: <a42f0c27-2811-4b68-bedf-7dfaa7bff6ff@VA3EHSMHS025.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From:
devicetree-discuss-bounces+stephen.neuendorffer=xilinx.com at lists.ozlabs.
org [mailto:devicetree-
> discuss-bounces+stephen.neuendorffer=xilinx.com at lists.ozlabs.org] On
Behalf Of Rob Herring
> Sent: Friday, May 20, 2011 8:18 AM
> To: Arnd Bergmann
> Cc: devicetree-discuss at lists.ozlabs.org; Jeremy Kerr;
linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/2] drivers/amba: probe via device tree
> 
> Arnd,
> 
> On 05/20/2011 09:21 AM, Arnd Bergmann wrote:
> > On Friday 20 May 2011 15:24:26 Rob Herring wrote:
> >> Maybe we are looking this in the wrong way.
> >>
> >> AMBA is not really the bus, but certain types of devices on the
bus.
> >> Granted, it may actually be an AMBA bus vs. vendor bus (i.MX AIPS),
but
> >> that is really transparent to s/w. Separating AMBA devices in the
> >> devicetree is really Linux requirements defining the devicetree
> >> structure. It is certainly conceivable that an OS could make no
> >> distinction. In my case, there is a mixture of regular platform
devices
> >> and AMBA(Primecell really) devices all interleaved on the same bus.
> >
> > I don't see how that would work. If the bus is AMBA, it should
> > only have AMBA devices on it, otherwise how would they be connected?
> >
> The ARM definition of AMBA encompasses a lot of things. It is the
> definition of the AXI, AHB and APB buses. It also has the definition
of
> the peripheral ID register definitions which primarily only ARM Ltd
> peripherals implement. You can have those bus types yet not have any
> peripherals with the ID registers. The Linux amba bus primarily deals
> with just the peripheral ID for probe matching. There is also bus
clock
> handling, but that's not really unique to an AMBA bus. Arguably the
> platform bus could have bus clock handling as well.

I tried to bring up exactly this issue, but I don't think I got my point
across
effectively.  (probably because I started off with "why the hell does
this exist???")
(face palm)  The amba_bus driver really deals with a bunch of issues
that
are specific to a very small number of platforms and the style of cores
from ARM.

> > Whether software is supposed to know care about this is a different
> > question. The device tree should generally reflect the block
> > diagram of the hardware,
> 
> Agreed.
> 
> > and I would expect the AMBA devices be
> > on a different level from the rest there.
> >
> But this part is not true.
> 
> >> Based on this, I think of_platform_populate should always just
match
> >> against "simple-bus" and make the matches parameter define the
device
> >> creation hook rather than the bus type. Or you could have both
> >> bus_matches and dev_matches parameters.
> >
> > I think it would be much better to only look at the parent bus for
> > device to add, never at the device itself.
> >
> > If the bus is AMBA, add all devices as amba_device, if it's
simple-bus,
> > add all devices as platform_device.
> >
> That is how it is currently, but the reality is that I only have 1 bus
> with both ARM Primecell peripherals and other peripherals which are
> standard platform bus devices. i2c-designware is one example. It is on
> the APB just like the pl011 uart. So do you propose I create a amba
> driver for it? It has no peripheral ID registers, so that may not even
work.

Same here.  I don't know what the right solution for it is, but I find
amba_bus
solution to get in the way more than help.  I had to hack the etm/etb
driver
and the amba_bus to shreds to get it to work for me at all.
I think most of what amba_bus does could be better handled by:
1) generic support in platform bus for clock enabling/power domains.
These are system concerns that most drivers shouldn't really know/care
about, and
will likely vary between SOCs.
2) helper functions for drivers for primecell devices that does the
peripheral id checking.

I realize that this is to some extent, jumping to a solution (which got
me into trouble
the first time around), but if someone has a better suggestion for a
better way to do it,
then I'm all ears.

Steve


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
