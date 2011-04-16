From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 16 Apr 2011 21:01:26 +0800
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <20110415130607.GM1611@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikJwFRenjwnws+4J2ep9G0Nv-9aXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 9:06 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
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
> ? ? ? ?- physical address of sram
> ? ? ? ?- size of sram
> ? ? ? ?- allocation granularity
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
> ? ? ? ?virt = map sram(phys, size)
> ? ? ? ?create sram pool(virt, phys, size, min_alloc_order)
>
> Another question is whether we should allow multiple SRAM pools or not -
> this code does allow multiple pools, but so far we only have one pool
> per SoC. ?Overdesign? ?Maybe, but it prevents SoCs wanting to duplicate
> it if they want to partition the SRAM, or have peripheral-local SRAMs.
>
> Lastly, uio_pruss should probably take the SRAM pool pointer via
> platform data so that it doesn't have to include Davinci specific
> includes.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This common sram driver is good for us. It can benefit us on DMA usage.
I just have one question on SRAM for storing instruction. We still need to
copy code into SRAM and flush cache & TLB with this SRAM driver.

TCM driver can allocate code into SRAM section in link stage. It needs to
update link file and virtual memory layout. Is it worth to make SRAM driver
support this behavior? The case of using SRAM as memory for instruction
is switching frequency or entering/exiting low power mode in PXA silicons.

Thanks
Haojian
