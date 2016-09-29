From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 28 Sep 2016 22:12:45 -0400
Subject: [PATCH V4 08/10] dmaengine: qcom_hidma: add a common API to setup the
 interrupt
In-Reply-To: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
References: <1475115167-5898-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1475115167-5898-9-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introducing the hidma_ll_setup_irq function to set up the interrupt
type externally from the OS interface.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma.h    |  2 ++
 drivers/dma/qcom/hidma_ll.c | 27 +++++++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/hidma.h b/drivers/dma/qcom/hidma.h
index 3f2ddd4..181f7e0 100644
--- a/drivers/dma/qcom/hidma.h
+++ b/drivers/dma/qcom/hidma.h
@@ -46,6 +46,7 @@ struct hidma_tre {
 };
 
 struct hidma_lldev {
+	bool msi_support;		/* flag indicating MSI support    */
 	bool initialized;		/* initialized flag               */
 	u8 trch_state;			/* trch_state of the device	  */
 	u8 evch_state;			/* evch_state of the device	  */
@@ -145,6 +146,7 @@ int hidma_ll_disable(struct hidma_lldev *lldev);
 int hidma_ll_enable(struct hidma_lldev *llhndl);
 void hidma_ll_set_transfer_params(struct hidma_lldev *llhndl, u32 tre_ch,
 	dma_addr_t src, dma_addr_t dest, u32 len, u32 flags);
+void hidma_ll_setup_irq(struct hidma_lldev *lldev, bool msi);
 int hidma_ll_setup(struct hidma_lldev *lldev);
 struct hidma_lldev *hidma_ll_init(struct device *dev, u32 max_channels,
 			void __iomem *trca, void __iomem *evca,
diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 088935f..f0630e0 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -672,17 +672,36 @@ int hidma_ll_setup(struct hidma_lldev *lldev)
 	writel(HIDMA_EVRE_SIZE * nr_tres,
 			lldev->evca + HIDMA_EVCA_RING_LEN_REG);
 
-	/* support IRQ only for now */
+	/* configure interrupts */
+	hidma_ll_setup_irq(lldev, lldev->msi_support);
+
+	rc = hidma_ll_enable(lldev);
+	if (rc)
+		return rc;
+
+	return rc;
+}
+
+void hidma_ll_setup_irq(struct hidma_lldev *lldev, bool msi)
+{
+	u32 val;
+
+	lldev->msi_support = msi;
+
+	/* disable interrupts again after reset */
+	writel(0, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
+	writel(0, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
+
+	/* support IRQ by default */
 	val = readl(lldev->evca + HIDMA_EVCA_INTCTRL_REG);
 	val &= ~0xF;
-	val |= 0x1;
+	if (!lldev->msi_support)
+		val = val | 0x1;
 	writel(val, lldev->evca + HIDMA_EVCA_INTCTRL_REG);
 
 	/* clear all pending interrupts and enable them */
 	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_CLR_REG);
 	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
-
-	return hidma_ll_enable(lldev);
 }
 
 struct hidma_lldev *hidma_ll_init(struct device *dev, u32 nr_tres,
-- 
1.9.1
