From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 22 Jul 2013 15:31:16 +0530
Subject: [PATCH 3/4] ARM: OMAP2+: Avoid idling memory controllers with no
 drivers
In-Reply-To: <1374487277-26099-1-git-send-email-rnayak@ti.com>
References: <1374487277-26099-1-git-send-email-rnayak@ti.com>
Message-ID: <1374487277-26099-4-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory controllers in OMAP (like GPMC and EMIF) have the hwmods marked with
HWMOD_INIT_NO_IDLE and are left in enabled state post initial setup.

Even if they have drivers missing, avoid idling them as part of
omap_device_late_idle()

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_device.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 5cc9287..1c82cde 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -842,6 +842,7 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_device *od = to_omap_device(pdev);
+	int i;
 
 	if (!od)
 		return 0;
@@ -850,6 +851,15 @@ static int __init omap_device_late_idle(struct device *dev, void *data)
 	 * If omap_device state is enabled, but has no driver bound,
 	 * idle it.
 	 */
+
+	/*
+	 * Some devices (like memory controllers) are always kept
+	 * enabled, and should not be idled even with no drivers.
+	 */
+	for (i = 0; i < od->hwmods_cnt; i++)
+		if (od->hwmods[i]->flags & HWMOD_INIT_NO_IDLE)
+			return 0;
+
 	if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
 		if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
 			dev_warn(dev, "%s: enabled but no driver.  Idling\n",
-- 
1.7.9.5
