From: james.morse@arm.com (James Morse)
Date: Tue, 26 Jun 2018 18:01:07 +0100
Subject: [PATCH v5 11/20] ACPI / APEI: Remove silent flag from
 ghes_read_estatus()
In-Reply-To: <20180626170116.25825-1-james.morse@arm.com>
References: <20180626170116.25825-1-james.morse@arm.com>
Message-ID: <20180626170116.25825-12-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsequent patches will split up ghes_read_estatus(), at which
point passing around the 'silent' flag gets annoying. This is to
suppress prink() messages, which prior to 42a0bb3f7138 ("printk/nmi:
generic solution for safe printk in NMI"), were unsafe in NMI context.

We don't need to do this anymore, remove the flag. printk() messages
are batched in a per-cpu buffer and printed via irq-work, or a call
back from panic().

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9bb00a06ba6e..7b412508b3ea 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -291,7 +291,7 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 
 static int ghes_read_estatus(struct ghes *ghes,
 			     struct acpi_hest_generic_status *estatus,
-			     int silent, int fixmap_idx)
+			     int fixmap_idx)
 {
 	struct acpi_hest_generic *g = ghes->generic;
 	u64 buf_paddr;
@@ -300,7 +300,7 @@ static int ghes_read_estatus(struct ghes *ghes,
 
 	rc = apei_read(&buf_paddr, &g->error_status_address);
 	if (rc) {
-		if (!silent && printk_ratelimit())
+		if (printk_ratelimit())
 			pr_warning(FW_WARN GHES_PFX
 "Failed to read error status block address for hardware error source: %d.\n",
 				   g->header.source_id);
@@ -333,7 +333,7 @@ static int ghes_read_estatus(struct ghes *ghes,
 	rc = 0;
 
 err_read_block:
-	if (rc && !silent && printk_ratelimit())
+	if (rc && printk_ratelimit())
 		pr_warning(FW_WARN GHES_PFX
 			   "Failed to read error status block!\n");
 	return rc;
@@ -720,7 +720,7 @@ static int _in_nmi_notify_one(struct ghes *ghes, int fixmap_idx)
 	int sev;
 	struct acpi_hest_generic_status *estatus = ghes->estatus;
 
-	if (ghes_read_estatus(ghes, estatus, 1, fixmap_idx)) {
+	if (ghes_read_estatus(ghes, estatus, fixmap_idx)) {
 		ghes_clear_estatus(ghes, estatus, fixmap_idx);
 		return -ENOENT;
 	}
@@ -857,7 +857,7 @@ static int ghes_proc(struct ghes *ghes)
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
 
-	rc = ghes_read_estatus(ghes, estatus, 0, FIX_APEI_GHES_IRQ);
+	rc = ghes_read_estatus(ghes, estatus, FIX_APEI_GHES_IRQ);
 	if (rc)
 		goto out;
 
-- 
2.17.1
