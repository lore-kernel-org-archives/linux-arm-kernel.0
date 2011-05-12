From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 12 May 2011 20:35:08 +0200
Subject: [RFC PATCH v3] Consolidate SRAM support
In-Reply-To: <20110512174546.GB8633@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110512174546.GB8633@n2100.arm.linux.org.uk>
Message-ID: <20110512183508.GJ18952@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:45 Thu 12 May     , Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> This is work in progress.
> 
> We have two SoCs using SRAM, both with their own allocation systems,
> and both with their own ways of copying functions into the SRAM.
> 
> Let's unify this before we have additional SoCs re-implementing this
> obviously common functionality themselves.
> 
> Unfortunately, we end up with code growth through doing this, but that
> will become a win when we have another SoC using this (which I know
> there's at least one in the pipeline).
> 
> One of the considerations here is that we can easily convert sram-pool.c
> to hook into device tree stuff, which can tell the sram allocator:
> 	- physical address of sram
> 	- size of sram
> 	- allocation granularity
> and then we just need to ensure that it is appropriately mapped.
> 
> This uses the physical address, and unlike Davinci's dma address usage,
> it always wants to have the physical address, and will always return
> the corresponding physical address when passed that pointer.
> 
> OMAP could probably do with some more work to make the omapfb and other
> allocations use the sram allocator, rather than hooking in before the
> sram allocator is initialized - and then further cleanups so that we
> have an initialization function which just does
> 
> sram_create(phys, size)
> 	virt = map sram(phys, size)
> 	create sram pool(virt, phys, size, min_alloc_order)
> 
> Another question is whether we should allow multiple SRAM pools or not -
> this code does allow multiple pools, but so far we only have one pool
> per SoC.  Overdesign?  Maybe, but it prevents SoCs wanting to duplicate
> it if they want to partition the SRAM, or have peripheral-local SRAMs.
> 
> Lastly, uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> 
> This version fixes the davinci pm free, and adds updates for the
> davinci pcm driver.  As I don't know what's happening with Jean's
> patch tweaking the genpool allocator, I've kept my version.
> 
> This still suffers from the "only one region per pvpool" problem
> which I believe Jean's patch doesn't suffer.
yes excatly and on at91sam9263 I need this :(

Best Regards,
J.
