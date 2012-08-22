From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Aug 2012 10:53:02 +0100
Subject: ioremap() fail on physical address 0x0 in 3.4 kernel
In-Reply-To: <50348030.9080200@codeaurora.org>
References: <50339AF6.1060601@codeaurora.org>
 <5033C428.2050607@codeaurora.org> <50348030.9080200@codeaurora.org>
Message-ID: <20120822095302.GX18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 12:16:08PM +0530, Trilok Soni wrote:
> Thanks for the patch, but how about just checking pmd_none on such  
> addresses and since there won't be any mapping created for such gaps? We  
> need to check if this is fine for all, since I remember that Nico
> added these functions for the OMAP boot issue I guess.

A better solution would be as below - this requires no changes to the
existing ioremap code, we just mark these differently.

diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
index 2e8a1ef..87fa3f2 100644
--- a/arch/arm/mm/mm.h
+++ b/arch/arm/mm/mm.h
@@ -55,6 +55,9 @@ extern void __flush_dcache_page(struct address_space *mapping, struct page *page
 /* permanent static mappings from iotable_init() */
 #define VM_ARM_STATIC_MAPPING	0x40000000
 
+/* empty mapping */
+#define VM_ARM_EMPTY_MAPPING	0x20000000
+
 /* mapping type (attributes) for permanent static mappings */
 #define VM_ARM_MTYPE(mt)		((mt) << 20)
 #define VM_ARM_MTYPE_MASK	(0x1f << 20)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index cf4528d..da90ef1 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -813,7 +813,7 @@ static void __init pmd_empty_section_gap(unsigned long addr)
 	vm = early_alloc_aligned(sizeof(*vm), __alignof__(*vm));
 	vm->addr = (void *)addr;
 	vm->size = SECTION_SIZE;
-	vm->flags = VM_IOREMAP | VM_ARM_STATIC_MAPPING;
+	vm->flags = VM_IOREMAP | VM_ARM_EMPTY_MAPPING;
 	vm->caller = pmd_empty_section_gap;
 	vm_area_add_early(vm);
 }
@@ -826,7 +826,7 @@ static void __init fill_pmd_gaps(void)
 
 	/* we're still single threaded hence no lock needed here */
 	for (vm = vmlist; vm; vm = vm->next) {
-		if (!(vm->flags & VM_ARM_STATIC_MAPPING))
+		if (!(vm->flags & (VM_ARM_STATIC_MAPPING | VM_ARM_EMPTY_MAPPING))
 			continue;
 		addr = (unsigned long)vm->addr;
 		if (addr < next)
