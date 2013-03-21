From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 21 Mar 2013 13:13:10 +0100
Subject: [BUGFIX PATCH] ARM: OMAP: fix type of return values in
 omap_device_get_by_hwmod_name()
Message-ID: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The merge bda5e141fbe96295c669692114d18687730269fb erroneously changed
the return value of some error exits of omap_device_get_by_hwmod_name()
from ERR_PTR() to -ENODEV.

This fixes the warnings:
arch/arm/mach-omap2/omap_device.c: In function 'omap_device_get_by_hwmod_name':
arch/arm/mach-omap2/omap_device.c:821:3: warning: return makes pointer from integer without a cast
arch/arm/mach-omap2/omap_device.c:826:3: warning: return makes pointer from integer without a cast


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/mach-omap2/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
index 2448c7a..eeea4fa 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -818,12 +818,12 @@ struct device *omap_device_get_by_hwmod_name(const char *oh_name)
 	if (!oh) {
 		WARN(1, "%s: no hwmod for %s\n", __func__,
 			oh_name);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 	if (!oh->od) {
 		WARN(1, "%s: no omap_device for %s\n", __func__,
 			oh_name);
-		return -ENODEV;
+		return ERR_PTR(-ENODEV);
 	}
 
 	return &oh->od->pdev->dev;
-- 
1.7.2.5
