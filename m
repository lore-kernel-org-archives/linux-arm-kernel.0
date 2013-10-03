From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Oct 2013 23:00:38 +0100
Subject: [PATCH 0/3] v7-M support using MULTIPLATFORM
In-Reply-To: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1380534577-15076-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131003220037.GH12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:49:34AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this series makes it possible to benefit from the MULTIPLATFORM stuff
> also for my v7-M machine (that is not yet supported in mainline).

The big problem I have with this is that the single zImage project is
forcing itself onto stuff like the small embedded stuff where it's not
appropriate for it to be.

Much of the multiplatform infrastructure relies on the ability to do
tricks with the MMU - placing various peripherals at known virtual
addresses.  Such tricks don't work on no-MMU platforms.

NoMMU platforms are inherently much more restricted and specialised,
and having multiplatform on them just doesn't make sense.  Yes, it
may give you the ability to increase compilation coverage, but will
the resulting image even work on the platform you're trying to target,
or will one of the other multi-platforms take over some settings and
screw it for you - like the link address.

XIP kernel is inherently limited to a single class of platforms.
Think about it - it's a very specialised.  XIP kernel needs several
things - it needs the kernel built in a special way such that the
data segment is separate from the text segment.  It needs to map the
flash memory storing the kernel code separately from the SDRAM.
It needs to know where the IRQ controller is and how to access it
to check for pending interrupts.

None of that is provided by the majority of multiplatform.

So, enabling the multiplatform Kconfig on such specialist platforms is
just opening up a huge can of worms.  Why anyone thinks this is a good
idea is way beyond me.

Also think about the argument you're making.  You need XIP kernel
because you have limited RAM, but you're willing to enable multiplatform
support which will allow you to build a kernel much larger than is
necessary for your platform by including other platforms in it.  Sorry,
that's just stupid.

So no.  If multiplatform gets in the way on noMMU platforms, then
multiplatform has ended up being done wrongly, and its multiplatform
that needs to be fixed.
