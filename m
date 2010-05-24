From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 May 2010 14:52:52 +0100
Subject: [PATCH 1/4] ARM: Remove the domain switching on ARMv6k/v7 CPUs
In-Reply-To: <1274707518.4720.53.camel@e102109-lin.cambridge.arm.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<20100520143004.22202.71701.stgit@e102109-lin.cambridge.arm.com>
	<20100524114546.GB21117@n2100.arm.linux.org.uk>
	<1274707518.4720.53.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1274709172.4720.57.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-05-24 at 14:25 +0100, Catalin Marinas wrote:
> On Mon, 2010-05-24 at 12:45 +0100, Russell King - ARM Linux wrote:
> > On Thu, May 20, 2010 at 03:30:04PM +0100, Catalin Marinas wrote:
> > > The user pages access rights are also modified for kernel read-only
> > > access rather than read/write so that the copy-on-write mechanism still
> > > works. CPU_USE_DOMAINS gets disabled only if HAS_TLS_REG is defined
> > > since writing the TLS value to the high vectors page isn't possible.
> >
> > When FIQ handlers are installed/removed, the vector page is also written,
> > so the above restriction is incompatible with FIQ support.
> >
> > Do we want to tell people that they can't use FIQs without domain support?
> 
> They could still be used (with an additional patch). At first, I thought
> that we could do something similar to early_trap_init() but
> set_fiq_handler() could be called from a module at run-time and it may
> temporarily enable write access to the vectors page (without an
> additional L_PTE_ bit we can't make the vectors page user RO, kernel R/W
> and I wouldn't do this anyway, for other reasons).
> 
> What about making a global vectors_page variable (initialised in
> devicemaps_init) that can be written directly when !CPU_USE_DOMAINS? On
> such CPUs, we have a non-aliasing VIPT cache anyway.

That's the additional diff which allows FIQs when !CPU_USE_DOMAINS
(assuming VIPT non-aliasing caches). I also modified the
early_trap_init() to make use of the vectors page rather than setting
the PTE as in the original patch.


diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 491960b..af5d5d1 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -27,4 +27,6 @@ static inline int in_exception_text(unsigned long ptr)
 extern void __init early_trap_init(void);
 extern void dump_backtrace_entry(unsigned long where, unsigned long from, unsigned long frame);
 
+extern void *vectors_page;
+
 #endif
diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index 6ff7919..fb1a640 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -45,6 +45,7 @@
 #include <asm/fiq.h>
 #include <asm/irq.h>
 #include <asm/system.h>
+#include <asm/traps.h>
 
 static unsigned long no_fiq_insn;
 
@@ -77,7 +78,11 @@ int show_fiq_list(struct seq_file *p, void *v)
 
 void set_fiq_handler(void *start, unsigned int length)
 {
+#if defined(CONFIG_CPU_USE_DOMAINS)
 	memcpy((void *)0xffff001c, start, length);
+#else
+	memcpy(vectors_page + 0x1c, start, length);
+#endif
 	flush_icache_range(0xffff001c, 0xffff001c + length);
 	if (!vectors_high())
 		flush_icache_range(0x1c, 0x1c + length);
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6571e19..6bc57c5 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -30,13 +30,14 @@
 #include <asm/unistd.h>
 #include <asm/traps.h>
 #include <asm/unwind.h>
-#include <asm/tlbflush.h>
 
 #include "ptrace.h"
 #include "signal.h"
 
 static const char *handler[]= { "prefetch abort", "data abort", "address exception", "interrupt" };
 
+void *vectors_page;
+
 #ifdef CONFIG_DEBUG_USER
 unsigned int user_debug;
 
@@ -746,21 +747,15 @@ void __init trap_init(void)
 
 void __init early_trap_init(void)
 {
+#if defined(CONFIG_CPU_USE_DOMAINS)
 	unsigned long vectors = CONFIG_VECTORS_BASE;
+#else
+	unsigned long vectors = (unsigned long)vectors_page;
+#endif
 	extern char __stubs_start[], __stubs_end[];
 	extern char __vectors_start[], __vectors_end[];
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-#if !defined(CONFIG_CPU_USE_DOMAINS) && defined(CONFIG_MMU)
-	pgd_t *pgd = pgd_offset_k(vectors);
-	pmd_t *pmd = pmd_offset(pgd, vectors);
-	pte_t *pte = pte_offset_kernel(pmd, vectors);
-	pte_t entry = *pte;
-
-	/* allow writing to the vectors page */
-	set_pte_ext(pte, pte_mkwrite(entry), 0);
-	local_flush_tlb_kernel_page(vectors);
-#endif
 
 	/*
 	 * Copy the vectors, stubs and kuser helpers (in entry-armv.S)
@@ -775,16 +770,10 @@ void __init early_trap_init(void)
 	 * Copy signal return handlers into the vector page, and
 	 * set sigreturn to be a pointer to these.
 	 */
-	memcpy((void *)KERN_SIGRETURN_CODE, sigreturn_codes,
-	       sizeof(sigreturn_codes));
-	memcpy((void *)KERN_RESTART_CODE, syscall_restart_code,
-	       sizeof(syscall_restart_code));
-
-#if !defined(CONFIG_CPU_USE_DOMAINS) && defined(CONFIG_MMU)
-	/* restore the vectors page permissions */
-	set_pte_ext(pte, entry, 0);
-	local_flush_tlb_kernel_page(vectors);
-#endif
+	memcpy((void *)(vectors + KERN_SIGRETURN_CODE - CONFIG_VECTORS_BASE),
+	       sigreturn_codes, sizeof(sigreturn_codes));
+	memcpy((void *)(vectors + KERN_RESTART_CODE - CONFIG_VECTORS_BASE),
+	       syscall_restart_code, sizeof(syscall_restart_code));
 
 	flush_icache_range(vectors, vectors + PAGE_SIZE);
 	modify_domain(DOMAIN_USER, DOMAIN_CLIENT);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 2858941..499e22d 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -25,6 +25,7 @@
 #include <asm/smp_plat.h>
 #include <asm/tlb.h>
 #include <asm/highmem.h>
+#include <asm/traps.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -935,12 +936,11 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 {
 	struct map_desc map;
 	unsigned long addr;
-	void *vectors;
 
 	/*
 	 * Allocate the vector page early.
 	 */
-	vectors = alloc_bootmem_low_pages(PAGE_SIZE);
+	vectors_page = alloc_bootmem_low_pages(PAGE_SIZE);
 
 	for (addr = VMALLOC_END; addr; addr += PGDIR_SIZE)
 		pmd_clear(pmd_off_k(addr));
@@ -980,7 +980,7 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 * location (0xffff0000).  If we aren't using high-vectors, also
 	 * create a mapping at the low-vectors virtual address.
 	 */
-	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
+	map.pfn = __phys_to_pfn(virt_to_phys(vectors_page));
 	map.virtual = 0xffff0000;
 	map.length = PAGE_SIZE;
 	map.type = MT_HIGH_VECTORS;



-- 
Catalin
