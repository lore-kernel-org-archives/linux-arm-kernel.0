From: lho@apm.com (Loc Ho)
Date: Thu, 20 Jul 2017 14:36:03 -0700
Subject: [PATCH v5 1/1] acpi: apei: Enable APEI multiple GHES source to share
 an single external IRQ
In-Reply-To: <1500586563-7088-1-git-send-email-lho@apm.com>
References: <1500586563-7088-1-git-send-email-lho@apm.com>
Message-ID: <1500586563-7088-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows APEI generic error source table with external
IRQ to share a single IRQ.

Co-authored-by: Tuan Phan <tphan@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
---
 drivers/acpi/apei/ghes.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index d661d45..eed09fc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1157,7 +1157,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			       generic->header.source_id);
 			goto err_edac_unreg;
 		}
-		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
+		rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
+				 "GHES IRQ", ghes);
 		if (rc) {
 			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
 			       generic->header.source_id);
-- 
1.8.3.1
