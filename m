From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:23 +0800
Subject: [PATCH 07/11] Avoid cleaning the KASan shadow area's mapping table
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-8-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrey Ryabinin <a.ryabinin@samsung.com>

 Avoid cleaning the mapping table(page table) of KASAN shadow area.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
Signed-off-by: Abbott Liu <liuwenliang@huawei.com>
---
 arch/arm/mm/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a4..f5aa1de 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1251,9 +1251,14 @@ static inline void prepare_page_table(void)
 	/*
 	 * Clear out all the mappings below the kernel image.
 	 */
-	for (addr = 0; addr < MODULES_VADDR; addr += PMD_SIZE)
+	for (addr = 0; addr < TASK_SIZE; addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
+#ifdef CONFIG_KASAN
+	/*TASK_SIZE ~ MODULES_VADDR is the KASAN's shadow area -- skip over it*/
+	addr = MODULES_VADDR;
+#endif
+
 #ifdef CONFIG_XIP_KERNEL
 	/* The XIP kernel is mapped in the module area -- skip over it */
 	addr = ((unsigned long)_exiprom + PMD_SIZE - 1) & PMD_MASK;
-- 
2.9.0
