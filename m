From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Fri, 23 Mar 2012 14:15:44 +0100
Subject: [PATCH] mm: overwrite __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
Message-ID: <274124B9C6907D4B8CE985903EAA19E91B2D579456@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ARM at least upto ARMv6 the accessed bit (YOUNG/OLD) are not
supported in hardware - they solely live in the Linux software
shadow page table.

There is no need to flush the TLB if only the young bit gets
cleared by kswapd.

There is a nasty deadlock because tlb_ops_need_broadcast() is set
and the page fault handler "double faults" resulting in IRQs turned
off.

If the kswapd decides to clear the young bit on one cpu and a
page fault is entered on the other cpu a deadlock can happen:

see
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/091116.html

Signed-off-by: Peter Waechtler <external.peter.waechtler@de.bosch.com>
---
 arch/arm/include/asm/pgtable.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1122d93..5e5d4e9 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -469,6 +469,32 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 /* FIXME: this is not correct */
 #define kern_addr_valid(addr)  (1)

+#if __LINUX_ARM_ARCH__ <= 6
+#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
+#define ptep_test_and_clear_young(__vma, __address, __ptep)            \
+({                                                                     \
+       pte_t __pte = *(__ptep);                                        \
+       int r = 1;                                                      \
+       if (!pte_young(__pte))                                          \
+               r = 0;                                                  \
+       else                                                            \
+               set_pte_at((__vma)->vm_mm, (__address),                 \
+                          (__ptep), pte_mkold(__pte));                 \
+       r;                                                              \
+})
+
+
+#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
+static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
+               unsigned long address, pte_t *ptep)
+{
+       /* No need to flush TLB
+        * On armv6 reference bits are never in TLB
+        */
+       return ptep_test_and_clear_young(vma, address, ptep);
+}
+#endif /* __LINUX_ARM_ARCH__ <= 6 */
+
 #include <asm-generic/pgtable.h>

 /*
--
1.6.0.4
