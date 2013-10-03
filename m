From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Oct 2013 00:05:35 +0100
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
In-Reply-To: <20131003222801.GE10079@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131003220037.GH12758@n2100.arm.linux.org.uk>
 <20131003222801.GE10079@pengutronix.de>
Message-ID: <20131003230535.GI12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 12:28:01AM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Thu, Oct 03, 2013 at 11:00:38PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 30, 2013 at 11:49:34AM +0200, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > this series makes it possible to benefit from the MULTIPLATFORM stuff
> > > also for my v7-M machine (that is not yet supported in mainline).
> > 
> > The big problem I have with this is that the single zImage project is
> > forcing itself onto stuff like the small embedded stuff where it's not
> > appropriate for it to be.
> > 
> > Much of the multiplatform infrastructure relies on the ability to do
> > tricks with the MMU - placing various peripherals at known virtual
> > addresses.  Such tricks don't work on no-MMU platforms.
>
> Actually it's not for the multi-platform ability itself I selected it
> for, but to benefit from other stuff that is currently only available
> for it, i.e. I don't need a Makefile.boot, I don't need some mach/
> headers.

The only include file which MULTIPLATFORM itself hides is mach/timex.h -
the others are all optional wrt their individual NEED_xxx_H configs.
We should probably convert mach/timex.h to the NEED_xxx_H style as well.

As for not needing Makefile.boot, I guess we should allow the 'Image'
target to work if there's no Makefile.boot but disable the rest.

> > NoMMU platforms are inherently much more restricted and specialised,
> > and having multiplatform on them just doesn't make sense.  Yes, it
> > may give you the ability to increase compilation coverage, but will
> > the resulting image even work on the platform you're trying to target,
> > or will one of the other multi-platforms take over some settings and
> > screw it for you - like the link address.
> Well, the way things are suggested in my patches you can only select
> other v7m machines alongside the efm32 platform. The bets are much
> better there not to screw it for me. But of course I cannot proof this
> as there is only one Cortex-M3 type supported in my tree.

Hmm.  So, is it possible to build for the EFM32 platform and a SAM3N
in the same kernel?  The SAM3N devices are Cortex-M3 CPUs, with major
regions defined as flash in the bottom .5G, SRAM, external SRAM at
0x60000000, private peripherals at 0xe0000000, which is where the
system control block, system timer, nvic and so forth are located.

> Right, but do we agree that it should be possible to create an XIP image
> for i.MX6? If so: You currently cannot, because i.MX6 isn't configurable
> without MULTIPLATFORM. Also in the times before MULTIPLATFORM XIP was
> special.

That's one of the consequences of pushing to multiplatform support - XIP
has fallen by the way side as a result of this effort (it was discussed
previously) and we had decided that almost no one uses it anymore and it
would not be part of the multiplatform stuff.  It was only really used
by very few SA11x0 and PXA platforms anyway.

> Already back than you could create a kernel for 2 (or more)
> different machines (sharing the same SoC family) with XIP enabled. That
> didn't necessarily made it work on both machines, maybe only one of them
> had NOR flash.

That's quite a different issue from enabling MULTIPLATFORM and then
having a whole raft of completely different SoCs be configurable.
For any one SoC, it will work if you program the kernel into memory
starting at XIP_PHYS_ADDR.  The majority of platforms in any one SoC
group will have memory available at a fixed location.  For example,
on SA11x0, you can almost guarantee that there's some kind of flash
memory in flash bank 0, because that's how the system boots.  Same
for PXA.

> > It needs to know where the IRQ controller is and how to access it
> > to check for pending interrupts.
> I didn't configure that, maybe this is only needed for writing to the
> flash holding the XIP image?

Correct, which makes the flash effectively ROM.

> > None of that is provided by the majority of multiplatform.
> > 
> > So, enabling the multiplatform Kconfig on such specialist platforms is
> > just opening up a huge can of worms.  Why anyone thinks this is a good
> > idea is way beyond me.
> > 
> > Also think about the argument you're making.  You need XIP kernel
> > because you have limited RAM, but you're willing to enable multiplatform
> > support which will allow you to build a kernel much larger than is
> > necessary for your platform by including other platforms in it.  Sorry,
> > that's just stupid.
> 
> Right, it will allow me to build a much bigger kernel (but I don't need
> to). And it allows me a few more things (yes please).

"a few more things" - I count two things which you've mentioned so far,
both of which can be sorted out.  Anything else?
