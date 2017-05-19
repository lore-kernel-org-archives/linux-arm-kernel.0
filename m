From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Fri, 19 May 2017 14:32:09 -0600
Subject: [PATCH V17 07/11] acpi: apei: panic OS with fatal error status block
In-Reply-To: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
References: <1495225933-4410-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <1495225933-4410-8-git-send-email-tbaicar@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

Even if an error status block's severity is fatal, the kernel does not
honor the severity level and panic.

With the firmware first model, the platform could inform the OS about a
fatal hardware error through the non-NMI GHES notification type. The OS
should panic when a hardware error record is received with this
severity.

Call panic() after CPER data in error status block is printed if
severity is fatal, before each error section is handled.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
Reviewed-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7e59a73..fadfb43 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -135,6 +135,8 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+static int ghes_panic_timeout __read_mostly = 30;
+
 static int ghes_ioremap_init(void)
 {
 	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
@@ -691,6 +693,16 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 	return apei_write(val, &gv2->read_ack_register);
 }
 
+static void __ghes_panic(struct ghes *ghes)
+{
+	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
+
+	/* reboot to log the error! */
+	if (!panic_timeout)
+		panic_timeout = ghes_panic_timeout;
+	panic("Fatal hardware error!");
+}
+
 static int ghes_proc(struct ghes *ghes)
 {
 	int rc;
@@ -698,6 +710,11 @@ static int ghes_proc(struct ghes *ghes)
 	rc = ghes_read_estatus(ghes, 0);
 	if (rc)
 		goto out;
+
+	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
+		__ghes_panic(ghes);
+	}
+
 	if (!ghes_estatus_cached(ghes->estatus)) {
 		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
 			ghes_estatus_cache_add(ghes->generic, ghes->estatus);
@@ -838,8 +855,6 @@ static inline void ghes_sea_remove(struct ghes *ghes)
 
 static LIST_HEAD(ghes_nmi);
 
-static int ghes_panic_timeout	__read_mostly = 30;
-
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
@@ -925,18 +940,6 @@ static void __process_error(struct ghes *ghes)
 #endif
 }
 
-static void __ghes_panic(struct ghes *ghes)
-{
-	oops_begin();
-	ghes_print_queued_estatus();
-	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
-
-	/* reboot to log the error! */
-	if (panic_timeout == 0)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
-}
-
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 {
 	struct ghes *ghes;
@@ -954,8 +957,11 @@ static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
 		}
 
 		sev = ghes_severity(ghes->estatus->error_severity);
-		if (sev >= GHES_SEV_PANIC)
+		if (sev >= GHES_SEV_PANIC) {
+			oops_begin();
+			ghes_print_queued_estatus();
 			__ghes_panic(ghes);
+		}
 
 		if (!(ghes->flags & GHES_TO_CLEAR))
 			continue;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
