From: james.morse@arm.com (James Morse)
Date: Fri, 21 Sep 2018 23:16:57 +0100
Subject: [PATCH v6 10/18] ACPI / APEI: preparatory split of ghes->estatus
In-Reply-To: <20180921221705.6478-1-james.morse@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
Message-ID: <20180921221705.6478-11-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NMI-like notifications scribble over ghes->estatus, before
copying it somewhere else. If this interrupts the ghes_probe() code
calling ghes_proc() on each struct ghes, the data is corrupted.

We want the NMI-like notifications to use a queued estatus entry
from the beginning. To that end, break up any use of "ghes->estatus"
so that all functions take the estatus as an argument.

This patch is just moving code around, no change in behaviour.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 82 ++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index adf7fd402813..586689cbc0fd 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -298,7 +298,9 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes, int silent, int fixmap_idx)
+static int ghes_read_estatus(struct ghes *ghes,
+			     struct acpi_hest_generic_status *estatus,
+			     int silent, int fixmap_idx)
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	u64 buf_paddr;
@@ -316,26 +318,26 @@ static int ghes_read_estatus(struct ghes *ghes, int silent, int fixmap_idx)
 	if (!buf_paddr)
 		return -ENOENT;
 
-	ghes_copy_tofrom_phys(ghes->estatus, buf_paddr,
-			      sizeof(*ghes->estatus), 1, fixmap_idx);
-	if (!ghes->estatus->block_status)
+	ghes_copy_tofrom_phys(estatus, buf_paddr,
+			      sizeof(*estatus), 1, fixmap_idx);
+	if (!estatus->block_status)
 		return -ENOENT;
 
 	ghes->buffer_paddr = buf_paddr;
 	ghes->flags |= GHES_TO_CLEAR;
 
 	rc = -EIO;
-	len = cper_estatus_len(ghes->estatus);
-	if (len < sizeof(*ghes->estatus))
+	len = cper_estatus_len(estatus);
+	if (len < sizeof(*estatus))
 		goto err_read_block;
 	if (len > ghes->generic->error_block_length)
 		goto err_read_block;
-	if (cper_estatus_check_header(ghes->estatus))
+	if (cper_estatus_check_header(estatus))
 		goto err_read_block;
-	ghes_copy_tofrom_phys(ghes->estatus + 1,
-			      buf_paddr + sizeof(*ghes->estatus),
-			      len - sizeof(*ghes->estatus), 1, fixmap_idx);
-	if (cper_estatus_check(ghes->estatus))
+	ghes_copy_tofrom_phys(estatus + 1,
+			      buf_paddr + sizeof(*estatus),
+			      len - sizeof(*estatus), 1, fixmap_idx);
+	if (cper_estatus_check(estatus))
 		goto err_read_block;
 	rc = 0;
 
@@ -346,13 +348,15 @@ static int ghes_read_estatus(struct ghes *ghes, int silent, int fixmap_idx)
 	return rc;
 }
 
-static void ghes_clear_estatus(struct ghes *ghes, int fixmap_idx)
+static void ghes_clear_estatus(struct ghes *ghes,
+			       struct acpi_hest_generic_status *estatus,
+			       int fixmap_idx)
 {
-	ghes->estatus->block_status = 0;
+	estatus->block_status = 0;
 	if (!(ghes->flags & GHES_TO_CLEAR))
 		return;
-	ghes_copy_tofrom_phys(ghes->estatus, ghes->buffer_paddr,
-			      sizeof(ghes->estatus->block_status), 0, fixmap_idx);
+	ghes_copy_tofrom_phys(estatus, ghes->buffer_paddr,
+			      sizeof(estatus->block_status), 0, fixmap_idx);
 	ghes->flags &= ~GHES_TO_CLEAR;
 }
 
@@ -518,9 +522,10 @@ static int ghes_print_estatus(const char *pfx,
 	return 0;
 }
 
-static void __ghes_panic(struct ghes *ghes)
+static void __ghes_panic(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
 {
-	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
+	__ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
 
 	/* reboot to log the error! */
 	if (!panic_timeout)
@@ -695,16 +700,17 @@ static void ghes_print_queued_estatus(void)
 }
 
 /* Save estatus for further processing in IRQ context */
-static void __process_error(struct ghes *ghes)
+static void __process_error(struct ghes *ghes,
+			    struct acpi_hest_generic_status *ghes_estatus)
 {
 	u32 len, node_len;
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic_status *estatus;
 
-	if (ghes_estatus_cached(ghes->estatus))
+	if (ghes_estatus_cached(ghes_estatus))
 		return;
 
-	len = cper_estatus_len(ghes->estatus);
+	len = cper_estatus_len(ghes_estatus);
 	node_len = GHES_ESTATUS_NODE_LEN(len);
 
 	estatus_node = (void *)gen_pool_alloc(ghes_estatus_pool, node_len);
@@ -714,35 +720,37 @@ static void __process_error(struct ghes *ghes)
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	memcpy(estatus, ghes->estatus, len);
+	memcpy(estatus, ghes_estatus, len);
 	llist_add(&estatus_node->llnode, &ghes_estatus_llist);
 }
 
 static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 {
 	int sev;
+	struct acpi_hest_generic_status *estatus = ghes->estatus;
 
-	if (ghes_read_estatus(ghes, 1, fixmap_idx)) {
-		ghes_clear_estatus(ghes, fixmap_idx);
+	if (ghes_read_estatus(ghes, estatus, 1, fixmap_idx)) {
+		ghes_clear_estatus(ghes, estatus, fixmap_idx);
 		return -ENOENT;
 	}
 
-	sev = ghes_severity(ghes->estatus->error_severity);
+	sev = ghes_severity(estatus->error_severity);
 	if (sev >= GHES_SEV_PANIC) {
 		ghes_print_queued_estatus();
-		__ghes_panic(ghes);
+		__ghes_panic(ghes, estatus);
 	}
 
 	if (!(ghes->flags & GHES_TO_CLEAR))
 		return 0;
 
-	__process_error(ghes);
-	ghes_clear_estatus(ghes, fixmap_idx);
+	__process_error(ghes, estatus);
+	ghes_clear_estatus(ghes, estatus, fixmap_idx);
 
 	return 0;
 }
 
-static int ghes_estatus_queue_notified(struct list_head *rcu_list, int fixmap_idx)
+static int ghes_estatus_queue_notified(struct list_head *rcu_list,
+				       int fixmap_idx)
 {
 	int ret = -ENOENT;
 	struct ghes *ghes;
@@ -853,23 +861,23 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 static int ghes_proc(struct ghes *ghes)
 {
 	int rc;
+	struct acpi_hest_generic_status *estatus = ghes->estatus;
 
-	rc = ghes_read_estatus(ghes, 0, FIX_APEI_GHES_IRQ);
+	rc = ghes_read_estatus(ghes, estatus, 0, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
-		__ghes_panic(ghes);
-	}
+	if (ghes_severity(estatus->error_severity) >= GHES_SEV_PANIC)
+		__ghes_panic(ghes, estatus);
 
-	if (!ghes_estatus_cached(ghes->estatus)) {
-		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
-			ghes_estatus_cache_add(ghes->generic, ghes->estatus);
+	if (!ghes_estatus_cached(estatus)) {
+		if (ghes_print_estatus(NULL, ghes->generic, estatus))
+			ghes_estatus_cache_add(ghes->generic, estatus);
 	}
-	ghes_do_proc(ghes, ghes->estatus);
+	ghes_do_proc(ghes, estatus);
 
 out:
-	ghes_clear_estatus(ghes, FIX_APEI_GHES_IRQ);
+	ghes_clear_estatus(ghes, estatus, FIX_APEI_GHES_IRQ);
 
 	if (rc == -ENOENT)
 		return rc;
-- 
2.19.0
