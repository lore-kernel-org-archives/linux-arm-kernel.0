From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 10 Feb 2018 14:20:20 +0000
Subject: [PATCH] drm/rockchip: Set IRQ_NOAUTOEN flag before requesting the
 interrupt
Message-ID: <20180210142020.30212-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling request_irq() followed by disable_irq() is usually a bad idea,
specially if the interrupt can be pending, and you're not yet in a
position to handle it.

This is exactly what happens on my kevin system when rebooting in a
second kernel using kexec: Some interrupt is left pending from
the previous kernel, and we take it too early, before disable_irq()
could do anything.

A better way of ensuring safety is to set the IRQ_NOAUTOEN flag
on the irq before requesting it.

Cc: stable at vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 19128b4dea54..72554f404b7e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -32,6 +32,7 @@
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
+#include <linux/irq.h>
 
 #include <linux/reset.h>
 #include <linux/delay.h>
@@ -1569,14 +1570,12 @@ static int vop_bind(struct device *dev, struct device *master, void *data)
 
 	mutex_init(&vop->vsync_mutex);
 
+	irq_set_status_flags(vop->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, vop->irq, vop_isr,
 			       IRQF_SHARED, dev_name(dev), vop);
 	if (ret)
 		return ret;
 
-	/* IRQ is initially disabled; it gets enabled in power_on */
-	disable_irq(vop->irq);
-
 	ret = vop_create_crtc(vop);
 	if (ret)
 		goto err_enable_irq;
-- 
2.14.2
