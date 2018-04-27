From: james.morse@arm.com (James Morse)
Date: Fri, 27 Apr 2018 16:35:02 +0100
Subject: [PATCH v3 04/12] ACPI / APEI: Switch NOTIFY_SEA to use the estatus
 queue
In-Reply-To: <20180427153510.5799-1-james.morse@arm.com>
References: <20180427153510.5799-1-james.morse@arm.com>
Message-ID: <20180427153510.5799-5-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the estatus queue can be used by more than one notification
method, we can move notifications that have NMI-like behaviour over to
it, and start abstracting GHES's single in_nmi() path.

Switch NOTIFY_SEA over to use the estatus queue. This makes it behave
in the same way as x86's NOTIFY_NMI.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Punit Agrawal <punit.agrawal@arm.com>
---
 drivers/acpi/apei/ghes.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ed8ad9898365..1859f27c37ff 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -58,6 +58,10 @@
 
 #define GHES_PFX	"GHES: "
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
+#define WANT_NMI_ESTATUS_QUEUE	1
+#endif
+
 #define GHES_ESTATUS_MAX_SIZE		65536
 #define GHES_ESOURCE_PREALLOC_MAX_SIZE	65536
 
@@ -681,7 +685,7 @@ static void ghes_estatus_cache_add(
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_HAVE_ACPI_APEI_NMI
+#ifdef WANT_NMI_ESTATUS_QUEUE
 /*
  * Handlers for CPER records may not be NMI safe. For example,
  * memory_failure_queue() takes spinlocks and calls schedule_work_on().
@@ -861,7 +865,7 @@ static void ghes_nmi_init_cxt(void)
 
 #else
 static inline void ghes_nmi_init_cxt(void) { }
-#endif /* CONFIG_HAVE_ACPI_APEI_NMI */
+#endif /* WANT_NMI_ESTATUS_QUEUE */
 
 static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 {
@@ -977,20 +981,13 @@ static LIST_HEAD(ghes_sea);
  */
 int ghes_notify_sea(void)
 {
-	struct ghes *ghes;
-	int ret = -ENOENT;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
-		if (!ghes_proc(ghes))
-			ret = 0;
-	}
-	rcu_read_unlock();
-	return ret;
+	return ghes_estatus_queue_notified(&ghes_sea);
 }
 
 static void ghes_sea_add(struct ghes *ghes)
 {
+	ghes_estatus_queue_grow_pool(ghes);
+
 	mutex_lock(&ghes_list_mutex);
 	list_add_rcu(&ghes->list, &ghes_sea);
 	mutex_unlock(&ghes_list_mutex);
@@ -1002,6 +999,8 @@ static void ghes_sea_remove(struct ghes *ghes)
 	list_del_rcu(&ghes->list);
 	mutex_unlock(&ghes_list_mutex);
 	synchronize_rcu();
+
+	ghes_estatus_queue_shrink_pool(ghes);
 }
 #else /* CONFIG_ACPI_APEI_SEA */
 static inline void ghes_sea_add(struct ghes *ghes) { }
-- 
2.16.2
