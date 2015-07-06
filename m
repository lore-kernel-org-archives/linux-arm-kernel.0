From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  6 Jul 2015 15:24:35 +0200
Subject: [RFC v2 1/9] VFIO: platform: registration of a dummy IRQ bypass
 producer
In-Reply-To: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
References: <1436189083-32527-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1436189083-32527-2-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register a dummy producer with void callbacks

Signed-off-by: Eric Auger <eric.auger@linaro.org>
---
 drivers/vfio/platform/vfio_platform_irq.c     | 31 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 88bba57..4b059bf 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 #include <linux/irq.h>
+#include <linux/irqbypass.h>
 
 #include "vfio_platform_private.h"
 
@@ -177,6 +178,26 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
+{
+}
+
+static void vfio_platform_irq_bypass_resume(struct irq_bypass_producer *prod)
+{
+}
+
+static void vfio_platform_irq_bypass_add_consumer(
+			struct irq_bypass_producer *prod,
+			struct irq_bypass_consumer *cons)
+{
+}
+
+static void vfio_platform_irq_bypass_del_consumer(
+			struct irq_bypass_producer *prod,
+			struct irq_bypass_consumer *cons)
+{
+}
+
 static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 			    int fd, irq_handler_t handler)
 {
@@ -186,6 +207,7 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 
 	if (irq->trigger) {
 		free_irq(irq->hwirq, irq);
+		irq_bypass_unregister_producer(&irq->producer);
 		kfree(irq->name);
 		eventfd_ctx_put(irq->trigger);
 		irq->trigger = NULL;
@@ -216,6 +238,15 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 		return ret;
 	}
 
+	irq->producer.token = (void *)trigger;
+	irq->producer.irq = irq->hwirq;
+	irq->producer.add_consumer = vfio_platform_irq_bypass_add_consumer;
+	irq->producer.del_consumer = vfio_platform_irq_bypass_del_consumer;
+	irq->producer.stop = vfio_platform_irq_bypass_stop;
+	irq->producer.resume = vfio_platform_irq_bypass_resume;
+	ret = irq_bypass_register_producer(&irq->producer);
+	WARN_ON(ret);
+
 	if (!irq->masked)
 		enable_irq(irq->hwirq);
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 1c9b3d5..1d2d4d6 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -17,6 +17,7 @@
 
 #include <linux/types.h>
 #include <linux/interrupt.h>
+#include <linux/irqbypass.h>
 
 #define VFIO_PLATFORM_OFFSET_SHIFT   40
 #define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) << VFIO_PLATFORM_OFFSET_SHIFT) - 1)
@@ -37,6 +38,7 @@ struct vfio_platform_irq {
 	spinlock_t		lock;
 	struct virqfd		*unmask;
 	struct virqfd		*mask;
+	struct irq_bypass_producer producer;
 };
 
 struct vfio_platform_region {
-- 
1.9.1
