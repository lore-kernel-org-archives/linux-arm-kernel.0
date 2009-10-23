From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Oct 2009 10:41:21 +0100
Subject: [PATCH] Use Normal uncached memory rather than Strongly Ordered on
	ARMv6+
Message-ID: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv6 onwards requires that there are no aliases to the same physical
location using different memory types (i.e. Normal vs Strongly Ordered).
Access to SO mappings when the unaligned accesses are handled in
hardware is also Unpredictable (pgprot_noncached() mappings in user
space).

The patch modifies the pgprot_noncached() for ARMv6+ architecture
versions to generate Normal uncached memory attributes rather than
Strongly Ordered. The patch also modifies the mandatory barriers to use
dmb() rather than being simple compiler barriers.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Abhijeet <adharmap@codeaurora.org>
Cc: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/include/asm/pgtable.h |   12 ++++++++++++
 arch/arm/include/asm/system.h  |   10 ++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 8429868..c3cd7d4 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -372,11 +372,23 @@ PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
+#if __LINUX_ARM_ARCH__ < 6
 /*
  * Mark the prot value as uncacheable and unbufferable.
  */
 #define pgprot_noncached(prot) \
 	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_UNCACHED)
+#else
+/*
+ * Mark the prot value as uncacheable, bufferable (Normal uncached memory).
+ * ARMv6 onwards requires that there are no aliases to the same physical
+ * location using different memory types (i.e. Normal vs Strongly Ordered).
+ * Access to SO mappings when the unaligned accesses are handled in hardware
+ * is also Unpredictable (pgprot_noncached() mappings in user space).
+ */
+#define pgprot_noncached(prot) \
+	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_BUFFERABLE)
+#endif
 #define pgprot_writecombine(prot) \
 	__pgprot((pgprot_val(prot) & ~L_PTE_MT_MASK) | L_PTE_MT_BUFFERABLE)
 
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index d65b2f5..cc89848 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -139,9 +139,19 @@ extern unsigned int user_debug;
 #endif
 
 #ifndef CONFIG_SMP
+#if __LINUX_ARM_ARCH__ < 6
 #define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
 #define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#else
+/*
+ * pgprot_noncached() creates Normal uncached mappings, therefore mandatory
+ * barriers are needed.
+ */
+#define mb()		dmb()
+#define rmb()		dmb()
+#define wmb()		dmb()
+#endif
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
