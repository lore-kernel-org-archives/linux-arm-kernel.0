From: eric.auger@linaro.org (Eric Auger)
Date: Thu, 19 Mar 2015 15:55:40 +0100
Subject: [RFC v5 02/13] VFIO: platform: test forwarded state when selecting
 IRQ handler
In-Reply-To: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
References: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1426776951-24901-3-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case the IRQ is forwarded, the VFIO platform IRQ handler does not
need to disable the IRQ anymore.

When setting the IRQ handler we now also test the forwarded state. In
case the IRQ is forwarded we select the vfio_irq_handler.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

v3 -> v4:
- change title

v2 -> v3:
- forwarded state was tested in the handler. Now the forwarded state
  is tested before setting the handler. This definitively limits
  the dynamics of forwarded state changes but I don't think there is
  a use case where we need to be able to change the state at any time.

Conflicts:
	drivers/vfio/platform/vfio_platform_irq.c
---
 drivers/vfio/platform/vfio_platform_irq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
index 88bba57..132bb3f 100644
--- a/drivers/vfio/platform/vfio_platform_irq.c
+++ b/drivers/vfio/platform/vfio_platform_irq.c
@@ -229,8 +229,13 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
 {
 	struct vfio_platform_irq *irq = &vdev->irqs[index];
 	irq_handler_t handler;
+	struct irq_data *d;
+	bool is_forwarded;
 
-	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED)
+	d = irq_get_irq_data(irq->hwirq);
+	is_forwarded = irqd_irq_forwarded(d);
+
+	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_AUTOMASKED && !is_forwarded)
 		handler = vfio_automasked_irq_handler;
 	else
 		handler = vfio_irq_handler;
-- 
1.9.1
