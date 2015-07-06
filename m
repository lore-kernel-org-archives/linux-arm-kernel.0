From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  6 Jul 2015 15:24:38 +0200
Subject: [RFC v2 4/9] VFIO: platform: add vfio_platform_set_automasked
In-Reply-To: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
References: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436189083-32527-5-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function makes possible to change the automasked mode.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
---
 drivers/vfio/platform/vfio_platform_irq.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 7f8d27c..aa540db 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -186,6 +186,23 @@ static irqreturn_t vfio_handler(int irq, void *dev_id)
 	return ret;
 }
 
+static int vfio_platform_set_automasked(struct vfio_platform_irq *irq,
+					   bool automasked)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&irq->lock, flags);
+	if (automasked) {
+		irq->flags |= VFIO_IRQ_INFO_AUTOMASKED;
+		irq->handler = vfio_automasked_irq_handler;
+	} else {
+		irq->flags &= ~VFIO_IRQ_INFO_AUTOMASKED;
+		irq->handler = vfio_irq_handler;
+	}
+	spin_unlock_irqrestore(&irq->lock, flags);
+	return 0;
+}
+
 static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
 {
 }
-- 
1.9.1
