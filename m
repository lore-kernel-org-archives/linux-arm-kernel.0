From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 15 Nov 2015 16:01:34 -0500
Subject: [PATCH V5 2/2] dma: qcom_hidma: add self test hooks
In-Reply-To: <1447621295-6338-1-git-send-email-okaya@codeaurora.org>
References: <1447621295-6338-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1447621295-6338-3-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add hooks for the self test code into the probe routine.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/Makefile | 2 +-
 drivers/dma/qcom/hidma.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/qcom/Makefile b/drivers/dma/qcom/Makefile
index f702df1..2b68c9c 100644
--- a/drivers/dma/qcom/Makefile
+++ b/drivers/dma/qcom/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_QCOM_BAM_DMA) += bam_dma.o
 obj-$(CONFIG_QCOM_HIDMA_MGMT) += hidma_mgmt.o hidma_mgmt_sys.o
 obj-$(CONFIG_QCOM_HIDMA) +=  hdma.o
-hdma-objs        := hidma_ll.o hidma.o hidma_dbg.o
+hdma-objs        := hidma_ll.o hidma.o hidma_dbg.o ../dmaselftest.o
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 2eabc80..2820755 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -649,6 +649,10 @@ static int hidma_probe(struct platform_device *pdev)
 	if (rc)
 		goto uninit;
 
+	rc = dma_selftest_memcpy(&dmadev->ddev);
+	if (rc)
+		goto uninit;
+
 	rc = dma_async_device_register(&dmadev->ddev);
 	if (rc)
 		goto uninit;
-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
