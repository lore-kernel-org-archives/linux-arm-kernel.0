From: ajeet.yadav.77@gmail.com (Ajeet Yadav)
Date: Fri, 17 Feb 2012 18:57:17 +0530
Subject: [PATCH 2/2] ARM: dma-mapping: fix leak in consistent_init
Message-ID: <1329485237-26447-1-git-send-email-ajeet.yadav.77@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although the error in this case is unlikely, but logically
if error occurs then we leak memory.

Signed-off-by: Ajeet Yadav <ajeet.yadav.77@gmail.com>
---
 arch/arm/mm/dma-mapping.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 04bfa76..932d288 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -161,7 +161,6 @@ static struct arm_vmregion_head consistent_head = {
  */
 static int __init consistent_init(void)
 {
-	int ret = 0;
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
@@ -185,30 +184,31 @@ static int __init consistent_init(void)
 		pud = pud_alloc(&init_mm, pgd, base);
 		if (!pud) {
 			printk(KERN_ERR "%s: no pud tables\n", __func__);
-			ret = -ENOMEM;
-			break;
+			goto err;
 		}
 
 		pmd = pmd_alloc(&init_mm, pud, base);
 		if (!pmd) {
 			printk(KERN_ERR "%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
+			goto err;
 		}
 		WARN_ON(!pmd_none(*pmd));
 
 		pte = pte_alloc_kernel(pmd, base);
 		if (!pte) {
 			printk(KERN_ERR "%s: no pte tables\n", __func__);
-			ret = -ENOMEM;
-			break;
+			goto err;
 		}
 
 		consistent_pte[i++] = pte;
 		base += PMD_SIZE;
 	} while (base < CONSISTENT_END);
 
-	return ret;
+	return 0;
+err:
+	kfree(consistent_pte);
+	consistent_pte = NULL;
+	return -ENOMEM;
 }
 
 core_initcall(consistent_init);
-- 
1.7.8.4
