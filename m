From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 16 Jul 2017 10:30:37 -0400
Subject: [PATCH 1/2] dmaengine: qcom_hidma: correct overriding message
Message-ID: <1500215438-30672-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A false overriding information is being presented during boot
under this scenario.

1. First object checks for kernel command line value against zero.
2. It doesn't find it, it sets the command line variable to the
value coming from ACPI/DT.
3. Second object is being probed.
4. Second object sees that the value of kernel command line
override is non-zero, it prints an overriding message even though
value matches ACPI/DT value.

hidma-mgmt QCOM8060:03: overriding max-write-burst-bytes: 1024

Add an additional check to verify that kernel command line value
is different from the ACPI/DT value.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_mgmt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 5a0991b..d51cd34 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -227,7 +227,8 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (max_write_request) {
+	if (max_write_request &&
+			(max_write_request != mgmtdev->max_write_request)) {
 		dev_info(&pdev->dev, "overriding max-write-burst-bytes: %d\n",
 			max_write_request);
 		mgmtdev->max_write_request = max_write_request;
@@ -240,7 +241,8 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "max-read-burst-bytes missing\n");
 		goto out;
 	}
-	if (max_read_request) {
+	if (max_read_request &&
+			(max_read_request != mgmtdev->max_read_request)) {
 		dev_info(&pdev->dev, "overriding max-read-burst-bytes: %d\n",
 			max_read_request);
 		mgmtdev->max_read_request = max_read_request;
@@ -253,7 +255,8 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "max-write-transactions missing\n");
 		goto out;
 	}
-	if (max_wr_xactions) {
+	if (max_wr_xactions &&
+			(max_wr_xactions != mgmtdev->max_wr_xactions)) {
 		dev_info(&pdev->dev, "overriding max-write-transactions: %d\n",
 			max_wr_xactions);
 		mgmtdev->max_wr_xactions = max_wr_xactions;
@@ -266,7 +269,8 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "max-read-transactions missing\n");
 		goto out;
 	}
-	if (max_rd_xactions) {
+	if (max_rd_xactions &&
+			(max_rd_xactions != mgmtdev->max_rd_xactions)) {
 		dev_info(&pdev->dev, "overriding max-read-transactions: %d\n",
 			max_rd_xactions);
 		mgmtdev->max_rd_xactions = max_rd_xactions;
-- 
1.9.1
