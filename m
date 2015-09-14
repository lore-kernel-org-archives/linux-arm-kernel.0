From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Mon, 14 Sep 2015 12:39:14 +0530
Subject: [PATCH] arm64, mm, numa: Adding numa balancing support for arm64.
Message-ID: <1442214554-11106-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable numa balancing for arm64 platforms.
add pte, pmd protnone helpers for use by automatic NUMA balancing.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

this patch is on top of numa v5 patchset.

---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663..d2e3c23 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_ATOMIC_RMW
+	select ARCH_SUPPORTS_NUMA_BALANCING if NUMA
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6900b2d9..0e4847d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -308,6 +308,23 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
 	return __pgprot(pgprot_val(prot) & ~PTE_TABLE_BIT);
 }
 
+#ifdef CONFIG_NUMA_BALANCING
+/*
+ * These work without NUMA balancing but the kernel does not care. See the
+ * comment in include/asm-generic/pgtable.h
+ */
+static inline int pte_protnone(pte_t pte)
+{
+	return ((pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE);
+}
+
+static inline int pmd_protnone(pmd_t pmd)
+{
+	return pte_protnone(pmd_pte(pmd));
+}
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 /*
  * THP definitions.
  */
-- 
1.8.1.4
