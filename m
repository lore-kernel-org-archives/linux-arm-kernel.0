From: tbaicar@codeaurora.org (Tyler Baicar)
Date: Fri,  7 Oct 2016 15:31:18 -0600
Subject: [PATCH V3 06/10] acpi: apei: panic OS with fatal error status block
In-Reply-To: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
References: <1475875882-2604-1-git-send-email-tbaicar@codeaurora.org>
Message-ID: <1475875882-2604-7-git-send-email-tbaicar@codeaurora.org>
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
---
 drivers/acpi/apei/ghes.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 28d5a09..36894c8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -141,6 +141,8 @@ static unsigned long ghes_estatus_pool_size_request;
 static struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
 
+static int ghes_panic_timeout __read_mostly = 30;
+
 static int ghes_ioremap_init(void)
 {
 	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
@@ -715,6 +717,12 @@ static int ghes_proc(struct ghes *ghes)
 		if (ghes_print_estatus(NULL, ghes->generic, ghes->estatus))
 			ghes_estatus_cache_add(ghes->generic, ghes->estatus);
 	}
+	if (ghes_severity(ghes->estatus->error_severity) >= GHES_SEV_PANIC) {
+		if (panic_timeout == 0)
+			panic_timeout = ghes_panic_timeout;
+		panic("Fatal hardware error!");
+	}
+
 	ghes_do_proc(ghes, ghes->estatus);
 
 	if (ghes->generic_v2) {
@@ -859,8 +867,6 @@ static atomic_t ghes_in_nmi = ATOMIC_INIT(0);
 
 static LIST_HEAD(ghes_nmi);
 
-static int ghes_panic_timeout	__read_mostly = 30;
-
 static void ghes_proc_in_irq(struct irq_work *irq_work)
 {
 	struct llist_node *llnode, *next;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
