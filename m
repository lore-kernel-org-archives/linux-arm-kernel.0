From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:53:52 +0000
Subject: [PATCH v4 02/13] VFIO: platform: registration of a dummy IRQ bypass
 producer
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register a dummy producer with void callbacks

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---
v3 -> v3:
- replace WARN_ON by pr_info() in case irq_bypass_register_producer
  fails

v2 -> v3:
- rename vfio_platform_irq_bypass_resume into *_start
---
 drivers/vfio/platform/vfio_platform_irq.c     | 34 +++++++++++++++++++++++++++
 drivers/vfio/platform/vfio_platform_private.h |  2 ++
 2 files changed, 36 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 46d4750..ab7658a 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -20,6 +20,7 @@
 #include <linux/types.h>
 #include <linux/vfio.h>
 #include <linux/irq.h>
+#include <linux/irqbypass.h>
 
 #include "vfio_platform_private.h"
 
@@ -177,6 +178,27 @@ static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
+{
+}
+
+static void vfio_platform_irq_bypass_start(struct irq_bypass_producer *prod)
+{
+}
+
+static int vfio_platform_irq_bypass_add_consumer(
+			struct irq_bypass_producer *prod,
+			struct irq_bypass_consumer *cons)
+{
+	return 0;
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
@@ -187,6 +209,7 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 	if (irq->trigger) {
 		irq_clear_status_flags(irq->hwirq, IRQ_NOAUTOEN);
 		free_irq(irq->hwirq, irq);
+		irq_bypass_unregister_producer(&irq->producer);
 		kfree(irq->name);
 		eventfd_ctx_put(irq->trigger);
 		irq->trigger = NULL;
@@ -217,6 +240,17 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
 		return ret;
 	}
 
+	irq->producer.token = (void *)trigger;
+	irq->producer.irq = irq->hwirq;
+	irq->producer.add_consumer = vfio_platform_irq_bypass_add_consumer;
+	irq->producer.del_consumer = vfio_platform_irq_bypass_del_consumer;
+	irq->producer.stop = vfio_platform_irq_bypass_stop;
+	irq->producer.start = vfio_platform_irq_bypass_start;
+	ret = irq_bypass_register_producer(&irq->producer);
+	if (ret)
+		pr_info("irq bypass producer (token %p) registration fails: %d\n",
+			irq->producer.token, ret);
+
 	if (!irq->masked)
 		enable_irq(irq->hwirq);
 
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 42816dd..979c191 100644
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
