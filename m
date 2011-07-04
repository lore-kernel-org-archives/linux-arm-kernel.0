From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 05 Jul 2011 01:10:11 +0200
Subject: Future of S3C6410 platform
In-Reply-To: <20110704213921.GL21138@trinity.fluff.org>
References: <2635745.FvrjgPkNLz@flatron> <201107042239.41833.arnd@arndb.de>
	<20110704213921.GL21138@trinity.fluff.org>
Message-ID: <1695702.ThOPKvqyiE@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 of July 2011 22:39:22 Ben Dooks wrote:
> On Mon, Jul 04, 2011 at 10:39:41PM +0200, Arnd Bergmann wrote:
> > On Monday 04 July 2011 21:14:19 Tomasz Figa wrote:
> > > I am writing to ask what is the planned future for the (now
> > > obsolete?) S3C6410 platform. Is there any ongoing work on bringing
> > > more feature-complete support for it?
> > 
> > I guess you should ask the maintainer directly, now on Cc. I wouldn't
> > call s3c6410 obsolete, we have much much older platforms that are still
> > supported well. Of course, many people are overworked and need to set
> > priorities, so it's understandable if there are fewer patches to
> > improve the less current platforms.
> 
> We've still got shipping products with these chips, they're actively used
> and still being manufactured.

OK, that's good, as I'm really interested in feature-complete support for this 
platform.

> > > The platform is really far behind its newer friends and here is what
> > > bothers me most:
> > > - missing basic features as NOHZ support
> 
> hardly a basic feature.

For mobile phones running Android requiring high interactivity and power 
efficiency this paired with hrtimers (both depending on GENERIC_CLOCKEVENTS) 
becomes a must.

> > > - buggy drivers (in mainline!, s3c-fb requesting irq before fully
> > > initializing driver data, same goes for the adc driver)
> 
> never seen any bug reports for these items.

In this case all the boards based on s3c6410 supported by Linux don't suffer 
from a broken bootloader which leaves half of the hardware in a definitely not 
clean state.

For me (on GT-i5700) both fb and adc, after leaving the bootloader, end up 
with unhandled interrupts and calling request_irq leads to kernel crash 
because an interrupt fires before all driver data get initialized.

> > > - totally broken usb gadget driver - I could not get it to work on
> > > my platform in any way (Samsung GT-i5700 phone; I am getting a
> > > Tiny6410 soon, so I will check whether it is not a board specific
> > > issue) without rewriting control endpoint handling code, not even
> > > mentioning about DMA support, which I still cannot get to work
> > > - poor OneNAND support (mostly in terms of performance)
> 
> I've not seen any s3c6410 systems with OnenNAND on.

This is mostly the case on systems with S3C6410 PoP packages (such as the GT-
i5700 phone). By default OneNAND is handled by proprietary XSR driver 
(including a block mapping layer, called BML and a proprietary FTL called 
STL), about quality of which I will not judge here, but it performs far better 
than the stock OneNAND driver from mainline in terms of speed, but provides 
only a block interface, which makes it incompatible with modern flash 
filesystems like yaffs2 or ubifs.

> The UDC driver actually works most of the time for me, there are a few
> corner cases that require work on for cases where it does not handle
> unexpected events from the hardware. Newer SoCs do not tend to produce
> these cases due to different synthesis options, and thus not all are
> dealt with.

I will send a separate message regarding this topic, but this will happen once 
I receive the Tiny6410 board and check how it looks there.

> > > - no power domain support
> 
> runtime pm should make this easier.

I have already implemented sort of power domain management based on code for 
one from S5P SoCs (from one of Android kernel trees), which defines a voltage 
regulator (with constant voltage) for each power domain and sets of power 
supplies for each driver using each power domain. Runtime PM should get really 
useful on driver side, though.

> > > - no support for advanced features of the chip (ie. functionality
> > > provided by old, and really _bad_, s3c modules)
> 
> old? some of these IP blocks have not changed much since their original
> s3c2400 incarnations. The blocks that have changed have been re-written
> to deal with this.

Yes, I'm aware of that.

> You're really endearing yourself to me by calling s3c modules "really
> _bad_".

To make sure I'm being understood correctly, I'm talking about a set of kernel 
modules provided by Samsung for their original s3c kernels, adding support for 
all the "multimedia" IPs embedded in S3C6410.

> > > I have already added NOHZ support, fixed fb and adc bugs, refactored
> > > control endpoint handling in udc driver (no DMA yet), done some
> > > improvement to OneNAND driver (still a big work in progress though,
> > > this is a topic for another message) and implemented power domain
> > > management + other minor changes/fixes.
> 
> the usb gadget driver already has some of the DMA support code in it,
> but the s3c6410 compilation of that hardware does not do unaligned
> buffers making it difficult to use for most of the current gadget
> drivers.  My view is that bounce-buffers are probably not going to
> help much, so it was never a priority.
> 
> Unfortunately there's not a lot I can do with this driver as I am at the
> limit of the documenation I can currently get my hands on.

It seems like the only problematic gadget would be the ethernet one, at least 
only to this one Samsung had added bounce buffers in their s3c kernel for GT-
i5700, which contained their original USB Gadget driver with DMA (and some 
bugs) enabled. Maybe it really should be refactored to be more DMA friendly?

> Some of this will probably be obsoleted soon anyway due to the massive
> restructuring in arch/arm land.

What exactly do you mean?

> > > All of this is available in my tree at
> > > git://github.com/tom3q/spica-2.6.38.git, but I am going to prepare
> > > patches containing all the changes a bit later, after I rebase all
> > > my work to latest Linux sources, as I worked mostly on Android
> > > 2.6.38 sources.
> 
> Is there a browsable list of changes that you've got?

Nothing complete yet. You might get some idea by looking at 
https://github.com/tom3q/spica-2.6.38/wiki/Status .

Anyway, as written in my last message, I'm going to rebase my work (from 
2.6.38) to latest, clean Linux sources (without Android patches) and then 
format and send the patches here.

Best regards,
Tomasz Figa
