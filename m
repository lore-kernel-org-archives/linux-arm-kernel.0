From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Oct 2013 00:28:01 +0200
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
In-Reply-To: <20131003220037.GH12758@n2100.arm.linux.org.uk>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131003220037.GH12758@n2100.arm.linux.org.uk>
Message-ID: <20131003222801.GE10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Oct 03, 2013 at 11:00:38PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 30, 2013 at 11:49:34AM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > this series makes it possible to benefit from the MULTIPLATFORM stuff
> > also for my v7-M machine (that is not yet supported in mainline).
> 
> The big problem I have with this is that the single zImage project is
> forcing itself onto stuff like the small embedded stuff where it's not
> appropriate for it to be.
> 
> Much of the multiplatform infrastructure relies on the ability to do
> tricks with the MMU - placing various peripherals at known virtual
> addresses.  Such tricks don't work on no-MMU platforms.
Actually it's not for the multi-platform ability itself I selected it
for, but to benefit from other stuff that is currently only available
for it, i.e. I don't need a Makefile.boot, I don't need some mach/
headers.
 
> NoMMU platforms are inherently much more restricted and specialised,
> and having multiplatform on them just doesn't make sense.  Yes, it
> may give you the ability to increase compilation coverage, but will
> the resulting image even work on the platform you're trying to target,
> or will one of the other multi-platforms take over some settings and
> screw it for you - like the link address.
Well, the way things are suggested in my patches you can only select
other v7m machines alongside the efm32 platform. The bets are much
better there not to screw it for me. But of course I cannot proof this
as there is only one Cortex-M3 type supported in my tree.
 
> XIP kernel is inherently limited to a single class of platforms.
> Think about it - it's a very specialised.  XIP kernel needs several
> things - it needs the kernel built in a special way such that the
> data segment is separate from the text segment.  It needs to map the
> flash memory storing the kernel code separately from the SDRAM.
Right, but do we agree that it should be possible to create an XIP image
for i.MX6? If so: You currently cannot, because i.MX6 isn't configurable
without MULTIPLATFORM. Also in the times before MULTIPLATFORM XIP was
special. Already back than you could create a kernel for 2 (or more)
different machines (sharing the same SoC family) with XIP enabled. That
didn't necessarily made it work on both machines, maybe only one of them
had NOR flash.

So maybe the only problem is that the symbol is misnamed or at least
gives expectations that are not necessarily true. So you can configure a
MULTIPLATFORM kernel for a single machine only just fine.

> It needs to know where the IRQ controller is and how to access it
> to check for pending interrupts.
I didn't configure that, maybe this is only needed for writing to the
flash holding the XIP image?

> None of that is provided by the majority of multiplatform.
> 
> So, enabling the multiplatform Kconfig on such specialist platforms is
> just opening up a huge can of worms.  Why anyone thinks this is a good
> idea is way beyond me.
> 
> Also think about the argument you're making.  You need XIP kernel
> because you have limited RAM, but you're willing to enable multiplatform
> support which will allow you to build a kernel much larger than is
> necessary for your platform by including other platforms in it.  Sorry,
> that's just stupid.
Right, it will allow me to build a much bigger kernel (but I don't need
to). And it allows me a few more things (yes please).

Note I'm not 100% convinced that multiplatform is a sane idea for v7-M,
but still I see some advantages so I wouldn't call it stupid.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
