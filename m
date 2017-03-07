From: shiju.jose@huawei.com (Shiju Jose)
Date: Tue, 7 Mar 2017 16:07:27 +0000
Subject: {RFC PATCH v1 v4.11-rc1 1/1} acpi: apei: common handler in ghes for
 HW errors notified via hed(PNP0C33) driver
Message-ID: <86258A5CC0A3704780874CF6004BA8A62DCAF445@lhreml502-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add common handler in ghes for HW errors notified via hed(PNP0C33) driver.
1. Rename ghes_notify_sci() to ghes_notify_hed().
2. Rename struct notifier_block ghes_notifier_sci to
   struct notifier_block ghes_notifier_hed.
3. Rename ghes_sci list to ghes_hed.
4. Make ghes_notify_hed as common handler for
   notification types SCI, GSIV and GPIO.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b192b42..fd39929 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -89,14 +89,14 @@
 module_param_named(disable, ghes_disable, bool, 0);
 
 /*
- * All error sources notified with SCI shares one notifier function,
+ * All error sources notified with HED shares one notifier function,
  * so they need to be linked and checked one by one.  This is applied
  * to NMI too.
  *
  * RCU is used for these lists, so ghes_list_mutex is only used for
  * list changing, not for traversing.
  */
-static LIST_HEAD(ghes_sci);
+static LIST_HEAD(ghes_hed);
 static DEFINE_MUTEX(ghes_list_mutex);
 
 /*
@@ -702,14 +702,14 @@ static irqreturn_t ghes_irq_func(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int ghes_notify_sci(struct notifier_block *this,
+static int ghes_notify_hed(struct notifier_block *this,
 				  unsigned long event, void *data)
 {
 	struct ghes *ghes;
 	int ret = NOTIFY_DONE;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sci, list) {
+	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
@@ -718,8 +718,8 @@ static int ghes_notify_sci(struct notifier_block *this,
 	return ret;
 }
 
-static struct notifier_block ghes_notifier_sci = {
-	.notifier_call = ghes_notify_sci,
+static struct notifier_block ghes_notifier_hed = {
+	.notifier_call = ghes_notify_hed,
 };
 
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
@@ -966,6 +966,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_POLLED:
 	case ACPI_HEST_NOTIFY_EXTERNAL:
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
@@ -1026,10 +1028,12 @@ static int ghes_probe(struct platform_device *ghes_dev)
 		}
 		break;
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		mutex_lock(&ghes_list_mutex);
-		if (list_empty(&ghes_sci))
-			register_acpi_hed_notifier(&ghes_notifier_sci);
-		list_add_rcu(&ghes->list, &ghes_sci);
+		if (list_empty(&ghes_hed))
+			register_acpi_hed_notifier(&ghes_notifier_hed);
+		list_add_rcu(&ghes->list, &ghes_hed);
 		mutex_unlock(&ghes_list_mutex);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
@@ -1068,10 +1072,12 @@ static int ghes_remove(struct platform_device *ghes_dev)
 		free_irq(ghes->irq, ghes);
 		break;
 	case ACPI_HEST_NOTIFY_SCI:
+	case ACPI_HEST_NOTIFY_GSIV:
+	case ACPI_HEST_NOTIFY_GPIO:
 		mutex_lock(&ghes_list_mutex);
 		list_del_rcu(&ghes->list);
-		if (list_empty(&ghes_sci))
-			unregister_acpi_hed_notifier(&ghes_notifier_sci);
+		if (list_empty(&ghes_hed))
+			unregister_acpi_hed_notifier(&ghes_notifier_hed);
 		mutex_unlock(&ghes_list_mutex);
 		break;
 	case ACPI_HEST_NOTIFY_NMI:
-- 
1.9.1
