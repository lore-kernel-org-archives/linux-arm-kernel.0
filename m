From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Feb 2011 21:45:22 +0000
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <20110202.133831.193702414.davem@davemloft.net>
References: <201102021700.20683.arnd@arndb.de>
	<20110202163702.GA23240@n2100.arm.linux.org.uk>
	<20110202.133831.193702414.davem@davemloft.net>
Message-ID: <20110202214522.GG31043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 01:38:31PM -0800, David Miller wrote:
> From: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Date: Wed, 2 Feb 2011 16:37:02 +0000
> 
> > 1. there's no way to tell GCC that the inline assembly is a load
> >    instruction and therefore it needs to schedule the following
> >    instructions appropriately.
> 
> Just add a dummy '"m" (pointer)' asm input argument to the inline asm
> statement.  Just make sure "typeof(pointer)" has a size matching the
> size of the load your are performing.

That involves this problematical cast from a packed struct pointer to
an unsigned long pointer, which according to the C standard and GCC
folk is undefined.

> > 2. GCC will needlessly reload pointers from structures and other such
> >    behaviour because it can't be told clearly what the inline assembly
> >    is doing, so the inline asm needs to have a "memory" clobber.
> 
> This behavior is correct, and in fact needed.  Writing to chip registers
> can trigger changes to arbitrary main memory locations.

That is really not an argument which stands up to analysis.

When does main memory locations change as a result of a write to a chip
register?  The answer is: when DMA is performed - which could be
many microseconds or even milliseconds after you've written the
register, which would be long after you've exited the function doing
the writing.

Not only that, but we have the DMA API to deal with the implications of
that.  On ARM, that's a function call, and GCC can't make any assumptions
about memory contents across function calls where it doesn't know what
the function does.

Practice over the last 15 years on ARM has also shown that this is not
necessary.
