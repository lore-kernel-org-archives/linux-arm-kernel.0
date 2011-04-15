From: dv@vollmann.ch (Detlef Vollmann)
Date: Fri, 15 Apr 2011 16:50:49 +0200
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <4DA85B49.60209@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/11 15:06, Russell King - ARM Linux wrote:
> This is work in progress.
Thanks, very useful.

> This uses the physical address, and unlike Davinci's dma address usage,
> it always wants to have the physical address, and will always return
> the corresponding physical address when passed that pointer.
Good.

> OMAP could probably do with some more work to make the omapfb and other
> allocations use the sram allocator, rather than hooking in before the
> sram allocator is initialized - and then further cleanups so that we
> have an initialization function which just does
>
> sram_create(phys, size)
> 	virt = map sram(phys, size)
> 	create sram pool(virt, phys, size, min_alloc_order)
I'd love to have the mapping inside the create pool, but that might
not be possible in general.

> Another question is whether we should allow multiple SRAM pools or not -
> this code does allow multiple pools, but so far we only have one pool
> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
> it if they want to partition the SRAM, or have peripheral-local SRAMs.
Having the option to partition the SRAM is probably useful.
What I'm missing is sram_pool_add: on AT91SAM9G20 you have two banks
of SRAM, and you might want to combine them into a single pool.

>   arch/arm/common/sram-pool.c                 |   69 +++++++++++++++++++++++++++
>   arch/arm/include/asm/sram-pool.h            |   20 ++++++++
Waht is ARM specific about this code?
Why not put it into lib/ and include/linux, respectively?

   Detlef
