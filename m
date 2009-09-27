From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Sep 2009 21:29:37 +0100
Subject: Disable highmem with SMP if no h/w TLB broadcasting
Message-ID: <20090927202937.GA26521@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After trying to run highmem on my SMP board, I decided it would be a
good idea to have this patch.  This also improves things in a slightly
different way - we avoid getting repeated complaints about highmem if
we have multiple highmem banks.

If you're wondering about the reason for smp_plat.h - in the long term
I want to move things like the platform_* prototypes into there, and
the other private-to-ARM prototypes, so that we're not cluttering the
generic kernel with all that stuff.



From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: Don't allow highmem on SMP platforms without h/w TLB ops broadcast

We suffer an unfortunate combination of "features" which makes highmem
support on platforms without hardware TLB maintainence broadcast difficult:

- we need kmap_high_get() support for DMA cache coherence
- this requires kmap_high() to take a spinlock with IRQs disabled
- kmap_high() occasionally calls flush_all_zero_pkmaps() to clear
  out old mappings
- flush_all_zero_pkmaps() calls flush_tlb_kernel_range(), which
  on s/w IPI'd systems eventually calls smp_call_function_many()
- smp_call_function_many() must not be called with IRQs disabled:

WARNING: at kernel/smp.c:380 smp_call_function_many+0xc4/0x240()
Modules linked in:
Backtrace:
[<c00306f0>] (dump_backtrace+0x0/0x108) from [<c0286e6c>] (dump_stack+0x18/0x1c)
 r6:c007cd18 r5:c02ff228 r4:0000017c
[<c0286e54>] (dump_stack+0x0/0x1c) from [<c0053e08>] (warn_slowpath_common+0x50/0x80)
[<c0053db8>] (warn_slowpath_common+0x0/0x80) from [<c0053e50>] (warn_slowpath_null+0x18/0x1c)
 r7:00000003 r6:00000001 r5:c1ff4000 r4:c035fa34
[<c0053e38>] (warn_slowpath_null+0x0/0x1c) from [<c007cd18>] (smp_call_function_many+0xc4/0x240)
[<c007cc54>] (smp_call_function_many+0x0/0x240) from [<c007cec0>] (smp_call_function+0x2c/0x38)
[<c007ce94>] (smp_call_function+0x0/0x38) from [<c005980c>] (on_each_cpu+0x1c/0x38)
[<c00597f0>] (on_each_cpu+0x0/0x38) from [<c0031788>] (flush_tlb_kernel_range+0x50/0x58)
 r6:00000001 r5:00000800 r4:c05f3590
[<c0031738>] (flush_tlb_kernel_range+0x0/0x58) from [<c009c600>] (flush_all_zero_pkmaps+0xc0/0xe8)
[<c009c540>] (flush_all_zero_pkmaps+0x0/0xe8) from [<c009c6b4>] (kmap_high+0x8c/0x1e0)
[<c009c628>] (kmap_high+0x0/0x1e0) from [<c00364a8>] (kmap+0x44/0x5c)
[<c0036464>] (kmap+0x0/0x5c) from [<c0109dfc>] (cramfs_readpage+0x3c/0x194)
[<c0109dc0>] (cramfs_readpage+0x0/0x194) from [<c0090c14>] (__do_page_cache_readahead+0x1f0/0x290)
[<c0090a24>] (__do_page_cache_readahead+0x0/0x290) from [<c0090ce4>] (ra_submit+0x30/0x38)
[<c0090cb4>] (ra_submit+0x0/0x38) from [<c0089384>] (filemap_fault+0x3dc/0x438)
 r4:c1819988
[<c0088fa8>] (filemap_fault+0x0/0x438) from [<c009d21c>] (__do_fault+0x58/0x43c)
[<c009d1c4>] (__do_fault+0x0/0x43c) from [<c009e8cc>] (handle_mm_fault+0x104/0x318)
[<c009e7c8>] (handle_mm_fault+0x0/0x318) from [<c0033c98>] (do_page_fault+0x188/0x1e4)
[<c0033b10>] (do_page_fault+0x0/0x1e4) from [<c0033ddc>] (do_translation_fault+0x7c/0x84)
[<c0033d60>] (do_translation_fault+0x0/0x84) from [<c002b474>] (do_DataAbort+0x40/0xa4)
 r8:c1ff5e20 r7:c0340120 r6:00000805 r5:c1ff5e54 r4:c03400d0
[<c002b434>] (do_DataAbort+0x0/0xa4) from [<c002bcac>] (__dabt_svc+0x4c/0x60)
...

So we disable highmem support on these systems.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/smp_plat.h |   16 ++++++++++++++++
 arch/arm/kernel/smp.c           |    7 +------
 arch/arm/mm/mmu.c               |   37 +++++++++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/include/asm/smp_plat.h

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
new file mode 100644
index 0000000..59303e2
--- /dev/null
+++ b/arch/arm/include/asm/smp_plat.h
@@ -0,0 +1,16 @@
+/*
+ * ARM specific SMP header, this contains our implementation
+ * details.
+ */
+#ifndef __ASMARM_SMP_PLAT_H
+#define __ASMARM_SMP_PLAT_H
+
+#include <asm/cputype.h>
+
+/* all SMP configurations have the extended CPUID registers */
+static inline int tlb_ops_need_broadcast(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
+}
+
+#endif
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index e0d3277..9d015ee 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -36,6 +36,7 @@
 #include <asm/tlbflush.h>
 #include <asm/ptrace.h>
 #include <asm/localtimer.h>
+#include <asm/smp_plat.h>
 
 /*
  * as from 2.5, kernels no longer have an init_tasks structure
@@ -586,12 +587,6 @@ struct tlb_args {
 	unsigned long ta_end;
 };
 
-/* all SMP configurations have the extended CPUID registers */
-static inline int tlb_ops_need_broadcast(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
-}
-
 static inline void ipi_flush_tlb_all(void *ignored)
 {
 	local_flush_tlb_all();
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce551ec..02243ee 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -21,6 +21,7 @@
 #include <asm/cachetype.h>
 #include <asm/setup.h>
 #include <asm/sizes.h>
+#include <asm/smp_plat.h>
 #include <asm/tlb.h>
 #include <asm/highmem.h>
 
@@ -709,10 +710,6 @@ static void __init sanity_check_meminfo(void)
 			if (meminfo.nr_banks >= NR_BANKS) {
 				printk(KERN_CRIT "NR_BANKS too low, "
 						 "ignoring high memory\n");
-			} else if (cache_is_vipt_aliasing()) {
-				printk(KERN_CRIT "HIGHMEM is not yet supported "
-						 "with VIPT aliasing cache, "
-						 "ignoring high memory\n");
 			} else {
 				memmove(bank + 1, bank,
 					(meminfo.nr_banks - i) * sizeof(*bank));
@@ -756,6 +753,38 @@ static void __init sanity_check_meminfo(void)
 #endif
 		j++;
 	}
+#ifdef CONFIG_HIGHMEM
+	if (highmem) {
+		const char *reason = NULL;
+
+		if (cache_is_vipt_aliasing()) {
+			/*
+			 * Interactions between kmap and other mappings
+			 * make highmem support with aliasing VIPT caches
+			 * rather difficult.
+			 */
+			reason = "with VIPT aliasing cache";
+#ifdef CONFIG_SMP
+		} else if (tlb_ops_need_broadcast()) {
+			/*
+			 * kmap_high needs to occasionally flush TLB entries,
+			 * however, if the TLB entries need to be broadcast
+			 * we may deadlock:
+			 *  kmap_high(irqs off)->flush_all_zero_pkmaps->
+			 *  flush_tlb_kernel_range->smp_call_function_many
+			 *   (must not be called with irqs off)
+			 */
+			reason = "without hardware TLB ops broadcasting";
+#endif
+		}
+		if (reason) {
+			printk(KERN_CRIT "HIGHMEM is not supported %s, ignoring high memory\n",
+				reason);
+			while (j > 0 && meminfo.bank[j - 1].highmem)
+				j--;
+		}
+	}
+#endif
 	meminfo.nr_banks = j;
 }
 
-- 
1.6.2.5
