From: james.morse@arm.com (James Morse)
Date: Mon,  6 Nov 2017 18:44:25 +0000
Subject: [PATCH 2/4] ACPI / APEI: Remove ghes_ioremap_area
In-Reply-To: <20171106184427.31905-1-james.morse@arm.com>
References: <20171106184427.31905-1-james.morse@arm.com>
Message-ID: <20171106184427.31905-3-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that nothing is using the ghes_ioremap_area pages, rip them out.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 drivers/acpi/apei/ghes.c | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f3269816b997..1a4f16b10052 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -114,19 +114,7 @@ static DEFINE_MUTEX(ghes_list_mutex);
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
  * the fixmap is used instead.
- */
-
-/*
- * Two virtual pages are used, one for IRQ/PROCESS context, the other for
- * NMI context (optionally).
- */
-#define GHES_IOREMAP_PAGES           2
-#define GHES_IOREMAP_IRQ_PAGE(base)	(base)
-#define GHES_IOREMAP_NMI_PAGE(base)	((base) + PAGE_SIZE)
-
-/* virtual memory area for atomic ioremap */
-static struct vm_struct *ghes_ioremap_area;
-/*
+ *
  * These 2 spinlocks are used to prevent the fixmap entries from being used
  * simultaneously.
  */
@@ -141,23 +129,6 @@ static atomic_t ghes_estatus_cache_alloced;
 
 static int ghes_panic_timeout __read_mostly = 30;
 
-static int ghes_ioremap_init(void)
-{
-	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
-		VM_IOREMAP, VMALLOC_START, VMALLOC_END);
-	if (!ghes_ioremap_area) {
-		pr_err(GHES_PFX "Failed to allocate virtual memory area for atomic ioremap.\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void ghes_ioremap_exit(void)
-{
-	free_vm_area(ghes_ioremap_area);
-}
-
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
 	phys_addr_t paddr;
@@ -1270,13 +1241,9 @@ static int __init ghes_init(void)
 
 	ghes_nmi_init_cxt();
 
-	rc = ghes_ioremap_init();
-	if (rc)
-		goto err;
-
 	rc = ghes_estatus_pool_init();
 	if (rc)
-		goto err_ioremap_exit;
+		goto err;
 
 	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
 				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
@@ -1300,8 +1267,6 @@ static int __init ghes_init(void)
 	return 0;
 err_pool_exit:
 	ghes_estatus_pool_exit();
-err_ioremap_exit:
-	ghes_ioremap_exit();
 err:
 	return rc;
 }
-- 
2.15.0.rc2
