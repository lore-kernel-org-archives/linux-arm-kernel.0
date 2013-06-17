From: lauraa@codeaurora.org (Laura Abbott)
Date: Mon, 17 Jun 2013 10:29:13 -0700
Subject: [PATCHv2 2/3] arm: mm: Define set_memory_* functions for ARM
In-Reply-To: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
References: <1371490154-11041-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1371490154-11041-3-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other architectures define various set_memory functions to allow
attributes to be changed (e.g. set_memory_x, set_memory_rw, etc.)
Currently, these functions are missing on ARM. Define these in an
appropriate manner for ARM.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/include/asm/cacheflush.h |    5 ++++
 arch/arm/mm/mmu.c                 |   38 +++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index bff7138..55ed26b 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -438,4 +438,9 @@ static inline void __sync_cache_range_r(volatile void *p, size_t size)
 #define sync_cache_w(ptr) __sync_cache_range_w(ptr, sizeof *(ptr))
 #define sync_cache_r(ptr) __sync_cache_range_r(ptr, sizeof *(ptr))
 
+int set_memory_ro(unsigned long addr, int numpages);
+int set_memory_rw(unsigned long addr, int numpages);
+int set_memory_x(unsigned long addr, int numpages);
+int set_memory_nx(unsigned long addr, int numpages);
+
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e0d8565..53b0de4 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -335,6 +335,44 @@ const struct mem_type *get_mem_type(unsigned int type)
 }
 EXPORT_SYMBOL(get_mem_type);
 
+#define PTE_SET_FN(_name, pteop) \
+static int pte_set_##_name(pte_t *ptep, pgtable_t token, unsigned long addr, \
+			void *data) \
+{ \
+	pte_t pte = pteop(*ptep); \
+\
+	set_pte_ext(ptep, pte, 0); \
+	return 0; \
+} \
+
+#define SET_MEMORY_FN(_name, callback) \
+int set_memory_##_name(unsigned long addr, int numpages) \
+{ \
+	unsigned long start = addr; \
+	unsigned long size = PAGE_SIZE*numpages; \
+	unsigned end = start + size; \
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
+SET_MEMORY_FN(rw, pte_set_rw)
+SET_MEMORY_FN(x, pte_set_x)
+SET_MEMORY_FN(nx, pte_set_nx)
+
 /*
  * Adjust the PMD section entries according to the CPU in use.
  */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
