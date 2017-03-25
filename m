From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat, 25 Mar 2017 19:04:02 -0400
Subject: [PATCH 1/2] dmaengine: qcom_hidma: disable/enable IRQs on pause/resume
Message-ID: <1490483043-4364-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the channels are stopped, disable interrupts to make sure no new
HW interaction can happen.

Similarly, re-enable the interrupts only if we know that channel is
operational again.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/dma/qcom/hidma_ll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/qcom/hidma_ll.c b/drivers/dma/qcom/hidma_ll.c
index 6645bdf..1530a66 100644
--- a/drivers/dma/qcom/hidma_ll.c
+++ b/drivers/dma/qcom/hidma_ll.c
@@ -499,6 +499,9 @@ int hidma_ll_enable(struct hidma_lldev *lldev)
 	lldev->trch_state = HIDMA_CH_ENABLED;
 	lldev->evch_state = HIDMA_CH_ENABLED;
 
+	/* enable irqs */
+	writel(ENABLE_IRQS, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
+
 	return 0;
 }
 
@@ -596,6 +599,9 @@ int hidma_ll_disable(struct hidma_lldev *lldev)
 
 	lldev->trch_state = HIDMA_CH_SUSPENDED;
 	lldev->evch_state = HIDMA_CH_SUSPENDED;
+
+	/* disable interrupts */
+	writel(0, lldev->evca + HIDMA_EVCA_IRQ_EN_REG);
 	return 0;
 }
 
-- 
1.9.1
