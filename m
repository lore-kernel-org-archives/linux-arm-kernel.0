From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 17 Oct 2017 16:02:20 +0800
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for SEA/NMI
 notification type
Message-ID: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the SEA notification, the two functions ghes_sea_add() and
ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
is defined. If not, it will return errors in the ghes_probe()
and not continue. If the probe is failed, the ghes_sea_remove()
also has no chance to be called. Hence, remove the unnecessary
handling when CONFIG_ACPI_APEI_SEA is not defined.

For the NMI notification, it has the same issue as SEA notification,
so also remove the unused dead-code for it.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/acpi/apei/ghes.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..3eee30a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -849,17 +849,8 @@ static void ghes_sea_remove(struct ghes *ghes)
 	synchronize_rcu();
 }
 #else /* CONFIG_ACPI_APEI_SEA */
-static inline void ghes_sea_add(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to add SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
-
-static inline void ghes_sea_remove(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to remove SEA notification which is not supported\n",
-	       ghes->generic->header.source_id);
-}
+static inline void ghes_sea_add(struct ghes *ghes) { }
+static inline void ghes_sea_remove(struct ghes *ghes) { }
 #endif /* CONFIG_ACPI_APEI_SEA */
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
@@ -1061,23 +1052,9 @@ static void ghes_nmi_init_cxt(void)
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
 #else /* CONFIG_HAVE_ACPI_APEI_NMI */
-static inline void ghes_nmi_add(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
-	       ghes->generic->header.source_id);
-	BUG();
-}
-
-static inline void ghes_nmi_remove(struct ghes *ghes)
-{
-	pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
-	       ghes->generic->header.source_id);
-	BUG();
-}
-
-static inline void ghes_nmi_init_cxt(void)
-{
-}
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+static inline void ghes_nmi_init_cxt(void) { }
 #endif /* CONFIG_HAVE_ACPI_APEI_NMI */
 
 static int ghes_probe(struct platform_device *ghes_dev)
-- 
2.10.1
