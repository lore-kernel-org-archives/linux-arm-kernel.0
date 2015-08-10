From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 10 Aug 2015 15:20:56 +0200
Subject: [PATCH v3 02/10] VFIO: platform: test forwarded state when selecting
 the IRQ handler
In-Reply-To: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
References: <1439212864-12954-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1439212864-12954-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new forwarded flag in vfio_platform_irq.  In case the IRQ
is forwarded, the VFIO platform IRQ handler does not need to
disable the IRQ anymore.

When setting the IRQ handler we now also test the forwarded state. In
case the IRQ is forwarded we select the vfio_irq_handler.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v2:
- add a new forwarded flag and do not use irqd_irq_forwarded anymore
---
 drivers/vfio/platform/vfio_platform_irq.c     | 3 ++-
 drivers/vfio/platform/vfio_platform_private.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index b5cb8c7..40f057a 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -262,7 +262,8 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 	struct vfio_platform_irq *irq = &vdev->irqs[index];
 	irq_handler_t handler;
 
-	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED)
+	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED &&
+			!irq->forwarded)
 		handler = vfio_automasked_irq_handler;
 	else
 		handler = vfio_irq_handler;
diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
index 1d2d4d6..8b4f814 100644
--- a/drivers/vfio/platform/vfio_platform_private.h
+++ b/drivers/vfio/platform/vfio_platform_private.h
@@ -39,6 +39,7 @@ struct vfio_platform_irq {
 	struct virqfd		*unmask;
 	struct virqfd		*mask;
 	struct irq_bypass_producer producer;
+	bool			forwarded;
 };
 
 struct vfio_platform_region {
-- 
1.9.1
