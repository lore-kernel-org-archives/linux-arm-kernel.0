From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Jun 2015 07:54:30 -0700
Subject: [PATCH RFC 2/2] ARM: add soc memory barrier extension
In-Reply-To: <20150603134307.GD7557@n2100.arm.linux.org.uk>
References: <E1Z07tA-0001TV-As@rmk-PC.arm.linux.org.uk>
 <20150603131525.GD18604@e104818-lin.cambridge.arm.com>
 <20150603134307.GD7557@n2100.arm.linux.org.uk>
Message-ID: <20150603145430.GN30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150603 06:44]:
> On Wed, Jun 03, 2015 at 02:15:25PM +0100, Catalin Marinas wrote:
> > On Wed, Jun 03, 2015 at 01:35:20PM +0100, Russell King wrote:
> > > Add an extension to the heavy barrier code to allow a SoC specific
> > > memory barrier function to be provided.  This is needed for platforms
> > > where the interconnect has weak ordering, and thus needs assistance
> > > to ensure that memory writes are properly visible in the correct order
> > > to other parts of the system.
> > 
> > Do you have an example of where this is needed? Were they previously
> > handled by hijacking outer_cache.sync?
> 
> Look for omap_bus_sync() - you need to go back through the kernel history
> as it has been half-heartedly removed (OMAP's mach/barriers.h still exists
> but it isn't used by anything, and omap_bus_sync() is now just an assembly
> stub.)

With multiarch support, the code for errata i688 became unselectable.
That's mostly commit 137d105d50f6 ("ARM: OMAP4: Fix errata i688 with MPU
interconnect barriers.").
 
> Basically, OMAP used to set CONFIG_ARCH_HAS_BARRIERS, which caused OMAPs
> mach/barriers.h to be picked up.  This contained:
> 
> #define rmb()		dsb()
> #define wmb()		do { dsb(); outer_sync(); omap_bus_sync(); } while (0)
> #define mb()		wmb()
> 
> and omap_bus_sync() was implemented arch/arm/mach-omap2/omap4-common.c
> as:
> 
> void __iomem *dram_sync, *sram_sync;
> 
> void omap_bus_sync(void)
> {
> 	if (dram_sync && sram_sync) {
> 		writel_relaxed(readl_relaxed(dram_sync), dram_sync);
> 		writel_relaxed(readl_relaxed(sram_sync), sram_sync);
> 		isb();
> 	}
> }
> EXPORT_SYMBOL(omap_bus_sync);
> 
> with the initialisation:
> 
> 	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
> 	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
> 	dram_io_desc[0].length = size;
> 	dram_io_desc[0].type = MT_MEMORY_RW_SO;
> 	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
> 	dram_sync = (void __iomem *) dram_io_desc[0].virtual;
> 
> and:
> 
> 		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
> 
> 
> which has the effect of issuing a strongly ordered access out to memory,
> which cause the OMAP interconnects to be flushed.
> 
> The message I'm hearing from TI is that the removal of this from mainline
> is a mistake (it sounds to me like it's caused a regression), and it needs
> to be restored, otherwise data accesses via various paths to DRAM can end
> up being seen out of order.

Yes we need a multiarch safe way to do the interconnect barriers, it's not
limited to just erratum i688 on omaps.

Regards,

Tony
