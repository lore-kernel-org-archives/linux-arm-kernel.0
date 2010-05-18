From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Tue, 18 May 2010 10:47:57 +0300
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <20100517173715.GA5818@atomide.com>
References: <20100513211951.GH3428@atomide.com>
	<20100513215825.GC13001@n2100.arm.linux.org.uk>
	<20100513220139.GO3428@atomide.com>
	<20100513221229.GD13001@n2100.arm.linux.org.uk>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C54F0247@dbde02.ent.ti.com>
	<AANLkTikZvfvjY9e2QNWRwVcJcTvn58Ly_DgzrcXKu2iJ@mail.gmail.com>
	<20100514101615.GF10339@n2100.arm.linux.org.uk>
	<AANLkTinY9M2cHKw86hTLaMUCvBX57o8AioBtrENB-JhK@mail.gmail.com>
	<20100517094421.GG23118@n2100.arm.linux.org.uk>
	<1274091978.2307.49.camel@tubuntu.research.nokia.com>
	<20100517173715.GA5818@atomide.com>
Message-ID: <1274168877.2307.70.camel@tubuntu.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-17 at 19:37 +0200, ext Tony Lindgren wrote:

> Sorry if I've been confused about what vram.c is doing.
> 
> How about change vram.c to use dma_alloc_coherent for now? That would
> break the non-standard behaviour to preserve the log set by the
> bootloader, but that should be OK until we know how to deal with that
> properly.
> 
> After that you could just optionally reserve the bootloader memory
> area using LMB based on some flags in the platform init data.

>From vram.c's commit log about features vram.c supports but dma_alloc_*
doesn't:

    - Support for OMAP2's SRAM
    - Allocate without ioremapping
    - Allocate at defined physical addresses
    - Allows larger VRAM area and larger allocations

I haven't heard anybody using OMAP2's SRAM for framebuffer, so that's
probably not an issue.

Reserving the memory at defined physical address is needed for the
bootloader-framebuffer, but I think it's only used on N900's product
kernel with some additional hacks. So that's probably not an issue
either.

Allocating without ioremapping... dma_alloc_* always ioremaps the
allocated area, even though it's never used (in some cases). I think
this is the case when using OMAP's VRFB rotation HW. This may or may not
be an issue, depending on the amount of memory allocated and the
available virtual mem area.

And the last point, I think there was a limit of about 8MB when
allocating with dma_alloc_* (I may remember wrong). This could be a
problem for some use cases.

So, I guess it's possible to use dma_alloc_*, but there may be some
complications.

I still haven't found time to look at the LMB stuff, but I hope I'll
manage to do that this week.

 Tomi
