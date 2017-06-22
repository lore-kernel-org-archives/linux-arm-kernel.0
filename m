From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 22 Jun 2017 14:59:22 -0400
Subject: [PATCH] dmaengine: qcom_hidma: allow ACPI/DT parameters to be
 overridden
Message-ID: <1498157962-27962-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Parameters like maximum read/write request size and the maximum
number of active transactions are currently configured in DT/ACPI.

This patch allows a user to override these to fine tune performance
for their application.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.c      |  7 +++++--
 drivers/dma/qcom/hidma_mgmt.c | 47 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 5072a7d..84e3699 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -1,7 +1,7 @@
 /*
  * Qualcomm Technologies HIDMA DMA engine interface
  *
- * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -795,8 +795,11 @@ static int hidma_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "desc-count",
 				 &dmadev->nr_descriptors);
 
-	if (!dmadev->nr_descriptors && nr_desc_prm)
+	if (nr_desc_prm) {
+		dev_info(&pdev->dev, "overriding number of descriptors as %d\n",
+			 nr_desc_prm);
 		dmadev->nr_descriptors = nr_desc_prm;
+	}
 
 	if (!dmadev->nr_descriptors)
 		dmadev->nr_descriptors = HIDMA_NR_DEFAULT_DESC;
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index f847d32..5a0991b 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -1,7 +1,7 @@
 /*
  * Qualcomm Technologies HIDMA DMA engine Management interface
  *
- * Copyright (c) 2015-2016, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015-2017, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -49,6 +49,26 @@
 #define HIDMA_AUTOSUSPEND_TIMEOUT	2000
 #define HIDMA_MAX_CHANNEL_WEIGHT	15
 
+static unsigned int max_write_request;
+module_param(max_write_request, uint, 0644);
+MODULE_PARM_DESC(max_write_request,
+		"maximum write burst (default: ACPI/DT value)");
+
+static unsigned int max_read_request;
+module_param(max_read_request, uint, 0644);
+MODULE_PARM_DESC(max_read_request,
+		"maximum read burst (default: ACPI/DT value)");
+
+static unsigned int max_wr_xactions;
+module_param(max_wr_xactions, uint, 0644);
+MODULE_PARM_DESC(max_wr_xactions,
+	"maximum number of write transactions (default: ACPI/DT value)");
+
+static unsigned int max_rd_xactions;
+module_param(max_rd_xactions, uint, 0644);
+MODULE_PARM_DESC(max_rd_xactions,
+	"maximum number of read transactions (default: ACPI/DT value)");
+
 int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
 {
 	unsigned int i;
@@ -207,12 +227,25 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		goto out;
 	}
 
+	if (max_write_request) {
+		dev_info(&pdev->dev, "overriding max-write-burst-bytes: %d\n",
+			max_write_request);
+		mgmtdev->max_write_request = max_write_request;
+	} else
+		max_write_request = mgmtdev->max_write_request;
+
 	rc = device_property_read_u32(&pdev->dev, "max-read-burst-bytes",
 				      &mgmtdev->max_read_request);
 	if (rc) {
 		dev_err(&pdev->dev, "max-read-burst-bytes missing\n");
 		goto out;
 	}
+	if (max_read_request) {
+		dev_info(&pdev->dev, "overriding max-read-burst-bytes: %d\n",
+			max_read_request);
+		mgmtdev->max_read_request = max_read_request;
+	} else
+		max_read_request = mgmtdev->max_read_request;
 
 	rc = device_property_read_u32(&pdev->dev, "max-write-transactions",
 				      &mgmtdev->max_wr_xactions);
@@ -220,6 +253,12 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "max-write-transactions missing\n");
 		goto out;
 	}
+	if (max_wr_xactions) {
+		dev_info(&pdev->dev, "overriding max-write-transactions: %d\n",
+			max_wr_xactions);
+		mgmtdev->max_wr_xactions = max_wr_xactions;
+	} else
+		max_wr_xactions = mgmtdev->max_wr_xactions;
 
 	rc = device_property_read_u32(&pdev->dev, "max-read-transactions",
 				      &mgmtdev->max_rd_xactions);
@@ -227,6 +266,12 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "max-read-transactions missing\n");
 		goto out;
 	}
+	if (max_rd_xactions) {
+		dev_info(&pdev->dev, "overriding max-read-transactions: %d\n",
+			max_rd_xactions);
+		mgmtdev->max_rd_xactions = max_rd_xactions;
+	} else
+		max_rd_xactions = mgmtdev->max_rd_xactions;
 
 	mgmtdev->priority = devm_kcalloc(&pdev->dev,
 					 mgmtdev->dma_channels,
-- 
1.9.1
