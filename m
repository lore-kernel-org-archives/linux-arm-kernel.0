From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed,  5 Mar 2014 13:43:09 -0800
Subject: [PATCH] arm64: Add CONFIG_DEBUG_SET_MODULE_RONX support
Message-ID: <1394055789-31479-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar fashion to other architecture, add the infrastructure
and Kconfig to enable DEBUG_SET_MODULE_RONX support. When
enabled, module ranges will be marked read-only/no-execute as
appropriate.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig.debug            |   11 +++++++++
 arch/arm64/include/asm/cacheflush.h |    4 +++
 arch/arm64/include/asm/pgtable.h    |   12 ++++++++++
 arch/arm64/mm/mmu.c                 |   42 +++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 835c559..85d56c8 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -23,4 +23,15 @@ config PID_IN_CONTEXTIDR
 	  instructions during context switch. Say Y here only if you are
 	  planning to use hardware trace tools with this kernel.
 
+config DEBUG_SET_MODULE_RONX
+        bool "Set loadable kernel module data as NX and text as RO"
+        depends on MODULES
+        ---help---
+          This option helps catch unintended modifications to loadable
+          kernel module's text and read-only data. It also prevents execution
+          of module data. Such protection may interfere with run-time code
+          patching and dynamic kernel tracing - and they might also protect
+          against certain classes of kernel exploits.
+          If in doubt, say "N".
+
 endmenu
diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index 88932498..02d2e8d 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -150,4 +150,8 @@ static inline void flush_cache_vunmap(unsigned long start, unsigned long end)
 {
 }
 
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
 #endif
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index aa3917c..b395af6 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -188,6 +188,18 @@ static inline pte_t pte_mkspecial(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	pte_val(pte) &= ~PTE_PXN;
+	return pte;
+}
+
+static inline pte_t pte_mknexec(pte_t pte)
+{
+	pte_val(pte) |= PTE_PXN;
+	return pte;
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	*ptep = pte;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f8dc7e8..3f61cbd 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -122,6 +122,48 @@ static int __init early_cachepolicy(char *p)
 }
 early_param("cachepolicy", early_cachepolicy);
 
+#define PTE_SET_FN(_name, pteop) \
+static int pte_set_##_name(pte_t *ptep, pgtable_t token, unsigned long addr, \
+			void *data) \
+{ \
+	pte_t pte = pteop(*ptep); \
+\
+	set_pte(ptep, pte); \
+	return 0; \
+} \
+
+#define SET_MEMORY_FN(_name, callback) \
+int set_memory_##_name(unsigned long addr, int numpages) \
+{ \
+	unsigned long start = addr; \
+	unsigned long size = PAGE_SIZE*numpages; \
+	unsigned long end = start + size; \
+\
+	if (start < MODULES_VADDR || start >= MODULES_END) \
+		return -EINVAL;\
+\
+	if (end < MODULES_VADDR || end >= MODULES_END) \
+		return -EINVAL; \
+\
+	apply_to_page_range(&init_mm, start, size, callback, NULL); \
+	flush_tlb_kernel_range(start, end); \
+	return 0;\
+}
+
+PTE_SET_FN(ro, pte_wrprotect)
+PTE_SET_FN(rw, pte_mkwrite)
+PTE_SET_FN(x, pte_mkexec)
+PTE_SET_FN(nx, pte_mknexec)
+
+SET_MEMORY_FN(ro, pte_set_ro)
+EXPORT_SYMBOL(set_memory_ro);
+SET_MEMORY_FN(rw, pte_set_rw)
+EXPORT_SYMBOL(set_memory_rw);
+SET_MEMORY_FN(x, pte_set_x)
+EXPORT_SYMBOL(set_memory_x);
+SET_MEMORY_FN(nx, pte_set_nx)
+EXPORT_SYMBOL(set_memory_nx);
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
