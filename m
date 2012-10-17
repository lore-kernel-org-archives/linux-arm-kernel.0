From: balbi@ti.com (Felipe Balbi)
Date: Wed, 17 Oct 2012 15:39:53 -0000
Subject: [RFC/NOT FOR MERGING 2/5] arm: omap: don't forcefully runtime suspend
 a device
In-Reply-To: <1350488043-5053-1-git-send-email-balbi@ti.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
Message-ID: <1350488043-5053-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

device drivers should be smart enough to provide
->suspend/->resume callbacks when needed and they
should take care of doing whatever needs to be
done in order to allow a device to be suspended.

Calling pm_runtime_* from system suspend isn't
the right way to achieve that, as it creates a
situation where OMAP's PM has different requirements
and semantics than all other architectures.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/omap_device.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 935f416..cd84eac 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -817,11 +817,9 @@ static int _od_suspend_noirq(struct device *dev)
 	ret = pm_generic_suspend_noirq(dev);
 
 	if (!ret && !pm_runtime_status_suspended(dev)) {
-		if (pm_generic_runtime_suspend(dev) == 0) {
-			if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
-				omap_device_idle(pdev);
-			od->flags |= OMAP_DEVICE_SUSPENDED;
-		}
+		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
+			omap_device_idle(pdev);
+		od->flags |= OMAP_DEVICE_SUSPENDED;
 	}
 
 	return ret;
@@ -841,7 +839,6 @@ static int _od_resume_noirq(struct device *dev)
 		od->flags &= ~OMAP_DEVICE_SUSPENDED;
 		if (!(od->flags & OMAP_DEVICE_NO_IDLE_ON_SUSPEND))
 			omap_device_enable(pdev);
-		pm_generic_runtime_resume(dev);
 	}
 
 	return pm_generic_resume_noirq(dev);
-- 
1.8.0.rc0
