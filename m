From: khilman@ti.com (Kevin Hilman)
Date: Thu,  1 Sep 2011 11:12:02 -0700
Subject: [PATCH] OMAP: omap_device: fix !CONFIG_SUSPEND case in _noirq handlers
Message-ID: <1314900722-10252-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend/resume _noirq handlers were #ifdef'd out in the
!CONFIG_SUSPEND case, but were still assigned to the dev_pm_ops
struct.  Fix by defining them to NULL in the !CONFIG_SUSPEND case.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.1-rc4.

 arch/arm/plat-omap/omap_device.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 9a6a538..02609ee 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -615,6 +615,9 @@ static int _od_resume_noirq(struct device *dev)
 
 	return pm_generic_resume_noirq(dev);
 }
+#else
+#define _od_suspend_noirq NULL
+#define _od_resume_noirq NULL
 #endif
 
 static struct dev_pm_domain omap_device_pm_domain = {
-- 
1.7.6
