From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 2 Feb 2011 18:39:17 +0100
Subject: ARM unaligned MMIO access with attribute((packed))
In-Reply-To: <20110202163702.GA23240@n2100.arm.linux.org.uk>
References: <201102021700.20683.arnd@arndb.de>
	<20110202163702.GA23240@n2100.arm.linux.org.uk>
Message-ID: <201102021839.17223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 February 2011 17:37:02 Russell King - ARM Linux wrote:
> We used to use inline assembly at one point, but that got chucked out.
> The problem is that using asm() for this causes GCC to generate horrid
> code.
> 
> 1. there's no way to tell GCC that the inline assembly is a load
>    instruction and therefore it needs to schedule the following
>    instructions appropriately.
> 
> 2. GCC will needlessly reload pointers from structures and other such
>    behaviour because it can't be told clearly what the inline assembly
>    is doing, so the inline asm needs to have a "memory" clobber.
> 
> 3. It seems to misses out using the pre-index addressing, prefering to
>    create add/sub instructions prior to each inline assembly load/store.
> 
> 4. There are no (documented) constraints in GCC to allow you to represent
>    the offset format for the half-word instructions.
> 
> Overall, it means greater register pressure, more instructions, larger
> functions, greater instruction cache pressure, etc.

Another solution would be to declare the readl function extern and define
it out of line, but I assume that this would be at least as bad as an
inline assembly for all the points you brought up, right?

Would it be possible to add the proper constraints for defining readl
in an efficient way to a future version of gcc? That wouldn't help us
in the near future, but we could at some points use those in a number
of places.

	Arnd
