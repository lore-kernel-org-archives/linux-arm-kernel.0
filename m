From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Mon, 28 Aug 2017 18:38:17 +0800
Subject: [PATCH v6 3/7] acpi: apei: remove the unused code
In-Reply-To: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <1503916701-13516-4-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current code logic, the two functions ghes_sea_add() and
ghes_sea_remove() are only called when CONFIG_ACPI_APEI_SEA
is defined. If not, it will return errors in the ghes_probe()
and not contiue. Hence, remove the unnecessary handling when
CONFIG_ACPI_APEI_SEI is not defined.

change since v5:
1. remove the SEI notification type handling, because the SEI is
   asynchronous exception and the address is not accurate. so
   not call memory_failure() to handle it.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 drivers/acpi/apei/ghes.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d452b238..c15a08db2c7c 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -813,7 +813,6 @@ static struct notifier_block ghes_notifier_hed = {
 	.notifier_call = ghes_notify_hed,
 };
 
-#ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
 
 /*
@@ -848,19 +847,6 @@ static void ghes_sea_remove(struct ghes *ghes)
 	mutex_unlock(&ghes_list_mutex);
 	synchronize_rcu();
 }
-#else /* CONFIG_ACPI_APEI_SEA */
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
-#endif /* CONFIG_ACPI_APEI_SEA */
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
-- 
2.14.1
