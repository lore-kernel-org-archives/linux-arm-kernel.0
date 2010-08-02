From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 2 Aug 2010 17:44:30 +0200
Subject: [RFC] dove: fix __io() definition to use bus based offset
In-Reply-To: <20100802112403.GE30670@n2100.arm.linux.org.uk>
References: <AANLkTinuXRH0XeD=3b0Wmq32SEEBxdevfj58EmSybcWu@mail.gmail.com>
	<201008021259.58376.arnd@arndb.de>
	<20100802112403.GE30670@n2100.arm.linux.org.uk>
Message-ID: <201008021744.30560.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 August 2010, Russell King - ARM Linux wrote:
> On Mon, Aug 02, 2010 at 12:59:58PM +0200, Arnd Bergmann wrote:
>
> > Ideally those functions should only be called when CONFIG_HAS_IOPORT
> > is set (I've started driver patches for that) and we should
> > set CONFIG_NO_IOPORT when there is no support for PIO, rather than
> > defining a bogus mapping to low memory.
>
> Even more weird setups involve 8-bit IO peripherals having a spacing
> of 4 between each register, but 16-bit IO peripherals having registers
> at offset 0,1,2,3 at 0,1,4,5 on the bus - and games played to access
> the odd address registers.  These don't support ioport mapping.
> 
> These platforms, Al's patch added a 'select NO_IOPORT' to - but this
> does not mean they don't have ISA IO support.

Ok, I see. It seems that some platforms are working around this by
calling the inb/outb functions from ioread/iowrite when a special
magic I/O space token is passed in, which probably would work on
those as well that currently set NO_IOPORT, but doing so would mean
more work across all architectures, so I'll leave it alone for now.

> > > which gives us the behaviour we desire.  I'd ideally like IOMEM() to
> > > be in some generic header, but I don't think asm/io.h makes much sense
> > > for that - neither does creating a new header just for it.  What do
> > > other architectures do for accessing system device registers (excluding
> > > x86 which of course uses ISA IO macros)?  I wonder if somewhere under
> > > linux/ would be appropriate for it.
> > 
> > From what I've seen in other architectures, few others really use
> > static memory space mappings, except for the legacy ISA range that
> > includes the VGA memory space and the PCI/ISA IO space mapping if that
> > is memory mapped. Both are normally only defined in one place though,
> > since they are not board specific, so there is no need for a macro
> > to abstract that.
> 
> Do no other architectures have system peripherals in MMIO space then?
> I guess those which do have their system peripherals standardized
> across all supported platforms?

I think that is mostly done on nommu architectures, but the far more
common pattern that I have seen is to use ioremap() for everything,
even if that all that does is a type conversion like __typesafe_io().

> > Then we can do one platform at a time, moving all definitions from
> > integer constants to pointer constants.
> > 
> > When the last use of map_desc->virtual is gone, we can remove the
> > union again (that could be in the same patch series).
> 
> I think you missed my point.
> 
> map_desc->virtual really wants to be an integer type:
> 
> static void __init create_mapping(struct map_desc *md)
> {
>         if (md->virtual != vectors_base() && md->virtual < TASK_SIZE) {
> 
>         if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
>             md->virtual >= PAGE_OFFSET && md->virtual < VMALLOC_END) {
> 
>         addr = md->virtual & PAGE_MASK;
> }
> 
> static void __init devicemaps_init(struct machine_desc *mdesc)
> {
>         map.virtual = MODULES_VADDR;
>         map.virtual = FLUSH_BASE;
>         map.virtual = FLUSH_BASE_MINICACHE;
>         map.virtual = 0xffff0000;
>                 map.virtual = 0;
> }

Right, I didn't realize that map_desc is used for both MT_DEVICE and
non-IO memory remapping.

> all end up needing casts.  If we make MODULES_VADDR a void __iomem pointer,
> then (a) it's wrong because it's not a pointer to IOMEM, and (b):
> 
> arch/arm/mm/init.c:     BUILD_BUG_ON(TASK_SIZE                          > MODULES_VADDR);
> arch/arm/mm/init.c:     BUG_ON(TASK_SIZE                                > MODULES_VADDR);
> 
> would need casts to unsigned long, as would:
> 
>         for (addr = 0; addr < MODULES_VADDR; addr += PGDIR_SIZE)
>                 pmd_clear(pmd_off_k(addr));
> 
> and so the game of chasing casts around the kernel will continue.
> 
> static inline void map_memory_bank(struct membank *bank)
> {
>         map.virtual = __phys_to_virt(bank_phys_start(bank));
> }
> 
> can just become phys_to_virt() - but then sparse will complain about
> differing address spaces.
> 
> There's no real answer here - whatever we do, we'll end up with casts
> _somewhere_ for this structure.  As the underlying code naturally wants
> it to be unsigned long, I think that's the correct type for it.
> 
> Maybe the solution is to have a macro to initialize its entries, which
> contain the cast to unsigned long for 'virtual' ?

Yes, that would work, though I would prefer to find a solution that works
without new macros.

In other places in the kernel, we try hard to avoid mixing __iomem pointers
with other pointers. Maybe we can change iotable_init/map_desc to only operate
on actual __iomem regions.

Since there are very few places that actually need a non-__iomem remapping
outside of mmu.c, we could slightly reorganize the code so we only
need a single cast in iotable_init(), and perhaps find a different way
to map the omap/davinci sram.

The example patch below unfortunately grows the kernel image by 56 bytes,
but also shrinks the source by a few lines and doing the same without
growing the image would require more source code.

	Arnd

---
 arch/arm/include/asm/mach/map.h |    2 +
 arch/arm/kernel/tcm.c           |   25 ++-------
 arch/arm/mm/mmu.c               |  108 +++++++++++++++++---------------------
 3 files changed, 55 insertions(+), 80 deletions(-)

diff --git a/arch/arm/include/asm/mach/map.h b/arch/arm/include/asm/mach/map.h
index 742c2aa..1f0ceb5 100644
--- a/arch/arm/include/asm/mach/map.h
+++ b/arch/arm/include/asm/mach/map.h
@@ -30,6 +30,8 @@ struct map_desc {
 
 #ifdef CONFIG_MMU
 extern void iotable_init(struct map_desc *, int);
+void __init create_mapping(unsigned long virtual, unsigned long pfn,
+			   size_t length, unsigned int mtype);
 
 struct mem_type;
 extern const struct mem_type *get_mem_type(unsigned int type);
diff --git a/arch/arm/kernel/tcm.c b/arch/arm/kernel/tcm.c
index e503038..dd9ca37 100644
--- a/arch/arm/kernel/tcm.c
+++ b/arch/arm/kernel/tcm.c
@@ -48,24 +48,6 @@ static struct resource itcm_res = {
 	.flags = IORESOURCE_MEM
 };
 
-static struct map_desc dtcm_iomap[] __initdata = {
-	{
-		.virtual	= DTCM_OFFSET,
-		.pfn		= __phys_to_pfn(DTCM_OFFSET),
-		.length		= (DTCM_END - DTCM_OFFSET + 1),
-		.type		= MT_UNCACHED
-	}
-};
-
-static struct map_desc itcm_iomap[] __initdata = {
-	{
-		.virtual	= ITCM_OFFSET,
-		.pfn		= __phys_to_pfn(ITCM_OFFSET),
-		.length		= (ITCM_END - ITCM_OFFSET + 1),
-		.type		= MT_UNCACHED
-	}
-};
-
 /*
  * Allocate a chunk of TCM memory
  */
@@ -162,7 +144,8 @@ void __init tcm_init(void)
 		setup_tcm_bank(0, DTCM_OFFSET,
 			       (DTCM_END - DTCM_OFFSET + 1) >> 10);
 		request_resource(&iomem_resource, &dtcm_res);
-		iotable_init(dtcm_iomap, 1);
+		create_mapping(DTCM_OFFSET, __phys_to_pfn(DTCM_OFFSET),
+				(DTCM_END - DTCM_OFFSET + 1), MT_UNCACHED);
 		/* Copy data from RAM to DTCM */
 		start = &__sdtcm_data;
 		end   = &__edtcm_data;
@@ -176,7 +159,9 @@ void __init tcm_init(void)
 		setup_tcm_bank(1, ITCM_OFFSET,
 			       (ITCM_END - ITCM_OFFSET + 1) >> 10);
 		request_resource(&iomem_resource, &itcm_res);
-		iotable_init(itcm_iomap, 1);
+		create_mapping(ITCM_OFFSET, __phys_to_pfn(ITCM_OFFSET),
+			       (ITCM_END - ITCM_OFFSET + 1),
+			       MT_UNCACHED);
 		/* Copy code from RAM to ITCM */
 		start = &__sitcm_text;
 		end   = &__eitcm_text;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2858941..08ca541 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -539,20 +539,20 @@ static void __init alloc_init_section(pgd_t *pgd, unsigned long addr,
 	}
 }
 
-static void __init create_36bit_mapping(struct map_desc *md,
+static void __init create_36bit_mapping(unsigned long addr,
+					unsigned long pfn, size_t length,
 					const struct mem_type *type)
 {
-	unsigned long phys, addr, length, end;
+	unsigned long phys, end;
 	pgd_t *pgd;
 
-	addr = md->virtual;
-	phys = (unsigned long)__pfn_to_phys(md->pfn);
-	length = PAGE_ALIGN(md->length);
+	phys = (unsigned long)__pfn_to_phys(pfn);
+	length = PAGE_ALIGN(length);
 
 	if (!(cpu_architecture() >= CPU_ARCH_ARMv6 || cpu_is_xsc3())) {
 		printk(KERN_ERR "MM: CPU does not support supersection "
 		       "mapping for 0x%08llx at 0x%08lx\n",
-		       __pfn_to_phys((u64)md->pfn), addr);
+		       __pfn_to_phys((u64)pfn), addr);
 		return;
 	}
 
@@ -565,14 +565,14 @@ static void __init create_36bit_mapping(struct map_desc *md,
 	if (type->domain) {
 		printk(KERN_ERR "MM: invalid domain in supersection "
 		       "mapping for 0x%08llx at 0x%08lx\n",
-		       __pfn_to_phys((u64)md->pfn), addr);
+		       __pfn_to_phys((u64)pfn), addr);
 		return;
 	}
 
-	if ((addr | length | __pfn_to_phys(md->pfn)) & ~SUPERSECTION_MASK) {
+	if ((addr | length | __pfn_to_phys(pfn)) & ~SUPERSECTION_MASK) {
 		printk(KERN_ERR "MM: cannot create mapping for "
 		       "0x%08llx at 0x%08lx invalid alignment\n",
-		       __pfn_to_phys((u64)md->pfn), addr);
+		       __pfn_to_phys((u64)pfn), addr);
 		return;
 	}
 
@@ -580,7 +580,7 @@ static void __init create_36bit_mapping(struct map_desc *md,
 	 * Shift bits [35:32] of address into bits [23:20] of PMD
 	 * (See ARMv6 spec).
 	 */
-	phys |= (((md->pfn >> (32 - PAGE_SHIFT)) & 0xF) << 20);
+	phys |= (((pfn >> (32 - PAGE_SHIFT)) & 0xF) << 20);
 
 	pgd = pgd_offset_k(addr);
 	end = addr + length;
@@ -604,44 +604,45 @@ static void __init create_36bit_mapping(struct map_desc *md,
  * offsets, and we take full advantage of sections and
  * supersections.
  */
-static void __init create_mapping(struct map_desc *md)
+void __init create_mapping(unsigned long virtual, unsigned long pfn,
+			   size_t length, unsigned int mtype)
 {
-	unsigned long phys, addr, length, end;
+	unsigned long phys, addr, end;
 	const struct mem_type *type;
 	pgd_t *pgd;
 
-	if (md->virtual != vectors_base() && md->virtual < TASK_SIZE) {
+	if (virtual != vectors_base() && virtual < TASK_SIZE) {
 		printk(KERN_WARNING "BUG: not creating mapping for "
 		       "0x%08llx@0x%08lx in user region\n",
-		       __pfn_to_phys((u64)md->pfn), md->virtual);
+		       __pfn_to_phys((u64)pfn), virtual);
 		return;
 	}
 
-	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
-	    md->virtual >= PAGE_OFFSET && md->virtual < VMALLOC_END) {
+	if ((mtype == MT_DEVICE || mtype == MT_ROM) &&
+	    virtual >= PAGE_OFFSET && virtual < VMALLOC_END) {
 		printk(KERN_WARNING "BUG: mapping for 0x%08llx@0x%08lx "
 		       "overlaps vmalloc space\n",
-		       __pfn_to_phys((u64)md->pfn), md->virtual);
+		       __pfn_to_phys((u64)pfn), virtual);
 	}
 
-	type = &mem_types[md->type];
+	type = &mem_types[mtype];
 
 	/*
 	 * Catch 36-bit addresses
 	 */
-	if (md->pfn >= 0x100000) {
-		create_36bit_mapping(md, type);
+	if (pfn >= 0x100000) {
+		create_36bit_mapping(virtual, pfn, length, type);
 		return;
 	}
 
-	addr = md->virtual & PAGE_MASK;
-	phys = (unsigned long)__pfn_to_phys(md->pfn);
-	length = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
+	addr = virtual & PAGE_MASK;
+	phys = (unsigned long)__pfn_to_phys(pfn);
+	length = PAGE_ALIGN(length + (virtual & ~PAGE_MASK));
 
 	if (type->prot_l1 == 0 && ((addr | phys | length) & ~SECTION_MASK)) {
 		printk(KERN_WARNING "BUG: map for 0x%08lx at 0x%08lx can not "
 		       "be mapped using pages, ignoring.\n",
-		       __pfn_to_phys(md->pfn), addr);
+		       __pfn_to_phys(pfn), addr);
 		return;
 	}
 
@@ -665,9 +666,14 @@ void __init iotable_init(struct map_desc *io_desc, int nr)
 	int i;
 
 	for (i = 0; i < nr; i++)
-		create_mapping(io_desc + i);
+		create_mapping((unsigned long)io_desc->virtual,
+			       io_desc->pfn,
+			       io_desc->length,
+			       io_desc->type);
 }
 
+
+
 static unsigned long __initdata vmalloc_reserve = SZ_128M;
 
 /*
@@ -933,7 +939,6 @@ void __init reserve_node_zero(pg_data_t *pgdat)
  */
 static void __init devicemaps_init(struct machine_desc *mdesc)
 {
-	struct map_desc map;
 	unsigned long addr;
 	void *vectors;
 
@@ -950,29 +955,23 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 * It is always first in the modulearea.
 	 */
 #ifdef CONFIG_XIP_KERNEL
-	map.pfn = __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK);
-	map.virtual = MODULES_VADDR;
-	map.length = ((unsigned long)_etext - map.virtual + ~SECTION_MASK) & SECTION_MASK;
-	map.type = MT_ROM;
-	create_mapping(&map);
+	create_mapping(MODULES_VADDR,
+		       __phys_to_pfn(CONFIG_XIP_PHYS_ADDR & SECTION_MASK),
+		       ((unsigned long)_etext - virtual + ~SECTION_MASK) & SECTION_MASK,
+		       MT_ROM);
 #endif
 
 	/*
 	 * Map the cache flushing regions.
 	 */
 #ifdef FLUSH_BASE
-	map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS);
-	map.virtual = FLUSH_BASE;
-	map.length = SZ_1M;
-	map.type = MT_CACHECLEAN;
-	create_mapping(&map);
+	create_mapping(FLUSH_BASE, __phys_to_pfn(FLUSH_BASE_PHYS), SZ_1M
+			MT_CACHECLEAN);
 #endif
 #ifdef FLUSH_BASE_MINICACHE
-	map.pfn = __phys_to_pfn(FLUSH_BASE_PHYS + SZ_1M);
-	map.virtual = FLUSH_BASE_MINICACHE;
-	map.length = SZ_1M;
-	map.type = MT_MINICLEAN;
-	create_mapping(&map);
+	create_mapping(FLUSH_BASE_MINICACHE,
+		       __phys_to_pfn(FLUSH_BASE_PHYS + SZ_1M), SZ_1M,
+		       MT_MINICLEAN);
 #endif
 
 	/*
@@ -980,17 +979,12 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 * location (0xffff0000).  If we aren't using high-vectors, also
 	 * create a mapping at the low-vectors virtual address.
 	 */
-	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
-	map.virtual = 0xffff0000;
-	map.length = PAGE_SIZE;
-	map.type = MT_HIGH_VECTORS;
-	create_mapping(&map);
-
-	if (!vectors_high()) {
-		map.virtual = 0;
-		map.type = MT_LOW_VECTORS;
-		create_mapping(&map);
-	}
+	create_mapping(0xffff0000, __phys_to_pfn(virt_to_phys(vectors)),
+		       PAGE_SIZE, MT_HIGH_VECTORS);
+
+	if (!vectors_high())
+		create_mapping(0, __phys_to_pfn(virt_to_phys(vectors)),
+		       PAGE_SIZE, MT_LOW_VECTORS);
 
 	/*
 	 * Ask the machine support to map in the statically mapped devices.
@@ -1021,14 +1015,8 @@ static void __init kmap_init(void)
 
 static inline void map_memory_bank(struct membank *bank)
 {
-	struct map_desc map;
-
-	map.pfn = bank_pfn_start(bank);
-	map.virtual = __phys_to_virt(bank_phys_start(bank));
-	map.length = bank_phys_size(bank);
-	map.type = MT_MEMORY;
-
-	create_mapping(&map);
+	create_mapping(__phys_to_virt(bank_phys_start(bank)),
+		       bank_pfn_start(bank), bank_phys_size(bank), MT_MEMORY);
 }
 
 static void __init map_lowmem(void)
