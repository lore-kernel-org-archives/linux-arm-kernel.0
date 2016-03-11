From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 11 Mar 2016 16:49:54 -0500
Subject: [PATCH 4/4] dma: qcom_hidma: read the channel id from HW
In-Reply-To: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
References: <1457732994-11175-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1457732994-11175-5-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the flexibility to choose the event channel as there is no real
use case right now. We have been using the values in ACPI that match the HW
defaults. OS is reading the event-channel from the HW register now.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  3 --
 drivers/dma/qcom/hidma.c                           | 39 +---------------------
 2 files changed, 1 insertion(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index e3677a5..fd5618b 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -51,7 +51,6 @@ Required properties:
 - reg: Addresses for the transfer and event channel
 - interrupts: Should contain the event interrupt
 - desc-count: Number of asynchronous requests this channel can handle
-- channel-index: The HW event channel completions will be delivered.
 - iommus: required a iommu node
 
 Example:
@@ -75,7 +74,6 @@ Hypervisor OS configuration:
 			interrupts = <0 389 0>;
 			desc-count = <10>;
 			iommus = <&system_mmu>;
-			channel-index = <4>;
 		};
 	};
 
@@ -87,6 +85,5 @@ Guest OS configuration:
 		      <0 0x5c0b0000 0x0 0x1000>;
 		interrupts = <0 389 0>;
 		desc-count = <10>;
-		channel-index = <4>;
 		iommus = <&system_mmu>;
 	};
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index ac20bdb..7180367 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -101,26 +101,6 @@ static unsigned int nr_desc_prm;
 module_param(nr_desc_prm, uint, 0644);
 MODULE_PARM_DESC(nr_desc_prm, "number of descriptors (default: 0)");
 
-#define HIDMA_MAX_CHANNELS	64
-static int channel_idx[HIDMA_MAX_CHANNELS] = {
-	[0 ... (HIDMA_MAX_CHANNELS - 1)] = -1
-};
-
-/*
- * Each DMA channel is associated with an event channel for interrupt
- * delivery. The event channel index usually comes from the firmware through
- * ACPI/DT. When a HIDMA channel is executed in the guest machine context (QEMU)
- * the device tree gets auto-generated based on the memory and IRQ resources
- * this driver uses on the host machine. Any device specific paraemeter such as
- * channel-index gets ignored by the QEMU.
- * We are using this command line parameter to pass the event channel index to
- * the guest machine.
- */
-static unsigned int num_channel_idx;
-module_param_array_named(channel_idx, channel_idx, int, &num_channel_idx,
-			 0644);
-MODULE_PARM_DESC(channel_idx, "channel index array for the notifications");
-static atomic_t channel_ref_count;
 
 /* process completed descriptors */
 static void hidma_process_completed(struct hidma_chan *mchan)
@@ -592,7 +572,6 @@ static int hidma_probe(struct platform_device *pdev)
 	struct resource *trca_resource;
 	struct resource *evca_resource;
 	int chirq;
-	int current_channel_index = atomic_read(&channel_ref_count);
 	void __iomem *evca;
 	void __iomem *trca;
 	int rc;
@@ -668,22 +647,7 @@ static int hidma_probe(struct platform_device *pdev)
 		goto dmafree;
 	}
 
-	if (current_channel_index > HIDMA_MAX_CHANNELS) {
-		rc = -EINVAL;
-		goto dmafree;
-	}
-
-	dmadev->chidx = -1;
-	device_property_read_u32(&pdev->dev, "channel-index", &dmadev->chidx);
-
-	/* kernel command line override for the guest machine */
-	if (channel_idx[current_channel_index] != -1)
-		dmadev->chidx = channel_idx[current_channel_index];
-
-	if (dmadev->chidx == -1) {
-		rc = -EINVAL;
-		goto dmafree;
-	}
+	dmadev->chidx = readl(dmadev->dev_trca + 0x28);
 
 	/* Set DMA mask to 64 bits. */
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -724,7 +688,6 @@ static int hidma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dmadev);
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
-	atomic_inc(&channel_ref_count);
 	return 0;
 
 uninit:
-- 
1.8.2.1
