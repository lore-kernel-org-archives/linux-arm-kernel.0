From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 00:18:09 -0400 (EDT)
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <20110917162046.GK16381@n2100.arm.linux.org.uk>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-17-git-send-email-nico@fluxnic.net>
	<20110917151953.GJ16381@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109171150320.20358@xanadu.home>
	<20110917162046.GK16381@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109190013120.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:

> On Sat, Sep 17, 2011 at 12:05:02PM -0400, Nicolas Pitre wrote:
> > On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:
> > 
> > > Any reason not to adapt early_alloc() ?
> > 
> > It uses the size for the alignment argument.  This is way too large an 
> > alignment in this case.  The size as alignment makes perfect sense in 
> > the other cases, and providing it explicitly for those cases might look 
> > strange.  But if you prefer that I'll just do it.
> 
> Just change early_alloc() to also take the alignment and then fix up the
> existing callers.  It's silly to open-code the __va() + memset().
> 
> > > This is silly.  You're defining VMALLOC_END to be 0xff000000UL, and
> > > then defining this to be 0xf0000000UL - 8MB.  Why hide the 240MB
> > > inside these constants?  Why not set it to VMALLOC_END - 240MB -
> > > VMALLOC_OFFSET - making the size in their _explicit_ instead of hidden?
> > 
> > Actually I care more about the absolute start address than the size this 
> > ends up creating.  This is to accommodate some of the static mappings 
> > that starts at 0xf0000000 on machines with a potential to have enough 
> > RAM that could map higher than that.  It just happens that this 
> > corresponds to 240MB.
> 
> We should stick to dealing with the size of vmalloc area rather than an
> absolute address range as that's what we present to users via the
> vmalloc= argument to the kernel.
> 
> > > > @@ -977,6 +991,12 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
> > > >  	}
> > > >  
> > > >  	/*
> > > > +	 * Clear the vmalloc area.
> > > > +	 */
> > > > +	for (addr = VMALLOC_START; addr < VMALLOC_END; addr += PGDIR_SIZE)
> > > > +		pmd_clear(pmd_off_k(addr));
> > > 
> > > Why not combine this with the clearance above:
> > > 
> > >         for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
> > >                 pmd_clear(pmd_off_k(addr));
> > > 
> > > ?
> > 
> > Because I wanted to keep the mapping for the DEBUG_LL code alive as long 
> > as possible.
> 
> You can't put DEUBG_LL code into create_mapping() anyway because at some
> point it will be called without the mapping in place, even with your
> modified code.
> 
> It's not like we have a lot of code between those two points - we've
> done most of the allocation (eg vectors page), so the only failure point
> is if L2 page table allocation fails - but that's true of almost any
> create_mapping() call.
> 
> So, I don't see the benefit of delaying the clearance.

OK, here we go with version 2:

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH v2] ARM: move iotable mappings within the vmalloc region

In order to remove the build time variation between different SOCs with
regards to VMALLOC_END, the iotable mappings are now allocated inside
the vmalloc region.  This allows for VMALLOC_END to be identical across
all machines.

The value for VMALLOC_END is now set to 0xff000000 which is right where
the consistent DMA area starts.

To accommodate all static mappings on machines with possible highmem usage,
the default vmalloc area size is changed to 240 MB so that VMALLOC_START
is no higher than 0xf0000000 by default in that case.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 Documentation/arm/memory.txt   |   11 +++----
 arch/arm/include/asm/pgtable.h |    8 +-----
 arch/arm/mm/mmu.c              |   46 +++++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 771d48d3b3..caee992bb8 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -51,15 +51,14 @@ ffc00000	ffefffff	DMA memory mapping region.  Memory returned
 ff000000	ffbfffff	Reserved for future expansion of DMA
 				mapping region.
 
-VMALLOC_END	feffffff	Free for platform use, recommended.
-				VMALLOC_END must be aligned to a 2MB
-				boundary.
-
 VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
 				Memory returned by vmalloc/ioremap will
 				be dynamically placed in this region.
-				VMALLOC_START may be based upon the value
-				of the high_memory variable.
+				Machine specific static mappings are also
+				located here through iotable_init().
+				VMALLOC_START is based upon the value
+				of the high_memory variable, and VMALLOC_END
+				is at the beginning of the DMA mapping region.
 
 PAGE_OFFSET	high_memory-1	Kernel direct-mapped RAM region.
 				This maps the platforms RAM, and typically
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5750704e02..950dee3ce2 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -21,7 +21,6 @@
 #else
 
 #include <asm/memory.h>
-#include <mach/vmalloc.h>
 #include <asm/pgtable-hwdef.h>
 
 /*
@@ -31,15 +30,10 @@
  * any out-of-bounds memory accesses will hopefully be caught.
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
  * area for the same reason. ;)
- *
- * Note that platforms may override VMALLOC_START, but they must provide
- * VMALLOC_END.  VMALLOC_END defines the (exclusive) limit of this space,
- * which may not overlap IO space.
  */
-#ifndef VMALLOC_START
 #define VMALLOC_OFFSET		(8*1024*1024)
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-#endif
+#define VMALLOC_END		0xff000000UL
 
 /*
  * Hardware-wise, we have a two level page table structure, where the first
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index eefb8ed5de..b3842a448a 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -15,6 +15,7 @@
 #include <linux/nodemask.h>
 #include <linux/memblock.h>
 #include <linux/fs.h>
+#include <linux/vmalloc.h>
 
 #include <asm/cputype.h>
 #include <asm/sections.h>
@@ -521,13 +522,18 @@ EXPORT_SYMBOL(phys_mem_access_prot);
 
 #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
 
-static void __init *early_alloc(unsigned long sz)
+static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
 {
-	void *ptr = __va(memblock_alloc(sz, sz));
+	void *ptr = __va(memblock_alloc(sz, align));
 	memset(ptr, 0, sz);
 	return ptr;
 }
 
+static void __init *early_alloc(unsigned long sz)
+{
+	return early_alloc_aligned(sz, sz);
+}
+
 static pte_t * __init early_pte_alloc(pmd_t *pmd, unsigned long addr, unsigned long prot)
 {
 	if (pmd_none(*pmd)) {
@@ -677,9 +683,10 @@ static void __init create_mapping(struct map_desc *md)
 	}
 
 	if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
-	    md->virtual >= PAGE_OFFSET && md->virtual < VMALLOC_END) {
+	    md->virtual >= PAGE_OFFSET &&
+	    (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
 		printk(KERN_WARNING "BUG: mapping for 0x%08llx"
-		       " at 0x%08lx overlaps vmalloc space\n",
+		       " at 0x%08lx out of vmalloc space\n",
 		       (long long)__pfn_to_phys((u64)md->pfn), md->virtual);
 	}
 
@@ -721,18 +728,29 @@ static void __init create_mapping(struct map_desc *md)
  */
 void __init iotable_init(struct map_desc *io_desc, int nr)
 {
-	int i;
+	struct map_desc *md;
+	struct vm_struct *vm;
 
-	for (i = 0; i < nr; i++)
-		create_mapping(io_desc + i);
+	vm = early_alloc_aligned(sizeof(*vm) * nr, __alignof__(*vm));
+
+	for (md = io_desc; nr; md++, nr--) {
+		create_mapping(md);
+		vm->addr = (void *)(md->virtual & PAGE_MASK);
+		vm->size = PAGE_ALIGN(md->length + (md->virtual & ~PAGE_MASK));
+		vm->phys_addr = __pfn_to_phys(md->pfn); 
+		vm->flags = VM_IOREMAP;
+		vm->caller = iotable_init;
+		vm_area_add_early(vm++);
+	}
 }
 
-static void * __initdata vmalloc_min = (void *)(VMALLOC_END - SZ_128M);
+static void * __initdata vmalloc_min =
+	(void *)(VMALLOC_END - (240 << 20) - VMALLOC_OFFSET);
 
 /*
  * vmalloc=size forces the vmalloc area to be exactly 'size'
  * bytes. This can be used to increase (or decrease) the vmalloc
- * area - the default is 128m.
+ * area - the default is 240m.
  */
 static int __init early_vmalloc(char *arg)
 {
@@ -883,10 +901,10 @@ static inline void prepare_page_table(void)
 
 	/*
 	 * Clear out all the kernel space mappings, except for the first
-	 * memory bank, up to the end of the vmalloc region.
+	 * memory bank, up to the vmalloc region.
 	 */
 	for (addr = __phys_to_virt(end);
-	     addr < VMALLOC_END; addr += PGDIR_SIZE)
+	     addr < VMALLOC_START; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
 }
 
@@ -911,8 +929,8 @@ void __init arm_mm_memblock_reserve(void)
 }
 
 /*
- * Set up device the mappings.  Since we clear out the page tables for all
- * mappings above VMALLOC_END, we will remove any debug device mappings.
+ * Set up the device mappings.  Since we clear out the page tables for all
+ * mappings above VMALLOC_START, we will remove any debug device mappings.
  * This means you have to be careful how you debug this function, or any
  * called function.  This means you can't use any function or debugging
  * method which may touch any device, otherwise the kernel _will_ crash.
@@ -927,7 +945,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 */
 	vectors_page = early_alloc(PAGE_SIZE);
 
-	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
+	for (addr = VMALLOC_START; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
