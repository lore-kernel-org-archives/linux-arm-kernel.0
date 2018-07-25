From: anders.roxell@linaro.org (Anders Roxell)
Date: Wed, 25 Jul 2018 11:55:57 +0200
Subject: [PATCH] arm: asm/tlb.h: Fix build error implicit func declaration
Message-ID: <20180725095557.19668-1-anders.roxell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building on arm 32 with LPAE enabled we don't include asm-generic/tlb.h,
where we have tlb_flush_remove_tables_local and tlb_flush_remove_tables
defined.
mm/memory.c: In function ?tlb_remove_table_smp_sync?:
mm/memory.c:339:2: error: implicit declaration of function ?tlb_flush_remove_tables_local?; did you mean ?tlb_remove_table?? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables_local(mm);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table
mm/memory.c: In function ?tlb_table_flush?:
mm/memory.c:372:2: error: implicit declaration of function ?tlb_flush_remove_tables?; did you mean ?tlb_remove_table?? [-Werror=implicit-function-declaration]
  tlb_flush_remove_tables(tlb->mm);
  ^~~~~~~~~~~~~~~~~~~~~~~
  tlb_remove_table

To fix this issue we define them in arm 32's specific asm/tlb.h file.

Fixes: 2ff6ddf19c0e ("x86/mm/tlb: Leave lazy TLB mode at page table free time")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

Ingo, would it make sense for you to pick it up into the x86 tree since
that contains the bug ?

Cheers,
Anders

 arch/arm/include/asm/tlb.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index d5562f9ce600..f854148c8d7c 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -292,5 +292,13 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 {
 }
 
+static inline void tlb_flush_remove_tables(struct mm_struct *mm)
+{
+}
+
+static inline void tlb_flush_remove_tables_local(void *arg)
+{
+}
+
 #endif /* CONFIG_MMU */
 #endif
-- 
2.18.0
