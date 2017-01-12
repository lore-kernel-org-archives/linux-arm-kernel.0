From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Thu, 12 Jan 2017 11:15:20 -0700
Subject: [PATCH V7 06/10] acpi: apei: panic OS with fatal error status block
In-Reply-To: <1484244924-24786-1-git-send-email-tbaicar@codeaurora.org>
References: <1484244924-24786-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <1484244924-24786-7-git-send-email-tbaicar@codeaurora.org>
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
---
 drivers/acpi/apei/ghes.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 87efe26..4e9a20d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -142,6 +142,8 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+static int ghes_panic_timeout __read_mostly = 30;
+
 static int ghes_ioremap_init(void)
 {
 	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
@@ -693,6 +695,13 @@ static int ghes_ack_error(struct acpi_hest_generic_v2 *generic_v2)
 	return rc;
 }
 
+static void __ghes_call_panic(void)
+{
+	if (panic_timeout == 0)
+		panic_timeout = ghes_panic_timeout;
+	panic("Fatal hardware error!");
+}
+
 static int ghes_proc(struct ghes *ghes)
 {
 	int rc;
@@ -704,6 +713,10 @@ static int ghes_proc(struct ghes *ghes)
 		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
 			ghes_estatus_cache_add(ghes->generic, ghes->estatus);
 	}
+	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
+		__ghes_call_panic();
+	}
+
 	ghes_do_proc(ghes, ghes->estatus);
 
 	if (IS_HEST_TYPE_GENERIC_V2(ghes)) {
@@ -848,8 +861,6 @@ static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
 
-static int ghes_panic_timeout	__read_mostly = 30;
-
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
@@ -942,9 +953,7 @@ static void __ghes_panic(struct ghes *ghes)
 	__ghes_print_estatus(KERN_EMERG, ghes->generic, ghes->estatus);
 
 	/* reboot to log the error! */
-	if (panic_timeout == 0)
-		panic_timeout = ghes_panic_timeout;
-	panic("Fatal hardware error!");
+	__ghes_call_panic();
 }
 
 static int ghes_notify_nmi(unsigned int cmd, struct pt_regs *regs)
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
