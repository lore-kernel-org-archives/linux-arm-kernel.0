From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Nov 2015 14:53:56 +0000
Subject: [PATCH v4 06/13] VFIO: platform: add vfio_platform_irq_is_active
In-Reply-To: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
References: <1447944843-17731-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1447944843-17731-7-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function returns whether the IRQ is active at irqchip level or
VFIO masked. If either is true, the IRQ is considered active.
Currently there is no way to differentiate userspace masked IRQ from
automasked IRQ. There might be false detection of activity. However
it is currently acceptable to have false detection.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v3 -> v4:
- rename vfio_platform_is_active into vfio_platform_irq_is_active
- remove BUG_ON and return the error if irq_get_irqchip_state fails
---
 drivers/vfio/platform/vfio_platform_irq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 257200b..cb7d5e9 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -203,6 +203,25 @@ static int vfio_platform_set_forwarded(struct vfio_platform_irq *irq,
 	return 0;
 }
 
+static int vfio_platform_irq_is_active(struct vfio_platform_irq *irq)
+{
+	unsigned long flags;
+	bool active;
+	int ret;
+
+	spin_lock_irqsave(&irq->lock, flags);
+
+	ret = irq_get_irqchip_state(irq->hwirq, IRQCHIP_STATE_ACTIVE, &active);
+	if (ret)
+		goto out;
+
+	ret = active || irq->masked;
+
+out:
+	spin_unlock_irqrestore(&irq->lock, flags);
+	return ret;
+}
+
 static void vfio_platform_irq_bypass_stop(struct irq_bypass_producer *prod)
 {
 }
-- 
1.9.1
