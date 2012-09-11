From: afzal@ti.com (Afzal Mohammed)
Date: Tue, 11 Sep 2012 15:26:59 +0530
Subject: [PATCH v9 2/3] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <cover.1347355380.git.afzal@ti.com>
References: <cover.1347355380.git.afzal@ti.com>
Message-ID: <16f0c80689d98fb713f1824ec4df6a12606847e4.1347355380.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create API for platforms to adapt GPMC to HWMOD

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/gpmc.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 055ae8b..5462666 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -31,10 +31,13 @@
 #include <plat/cpu.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
+#include <plat/omap_device.h>
 
 #include "soc.h"
 #include "common.h"
 
+#define	DEVICE_NAME		"omap-gpmc"
+
 /* GPMC register offsets */
 #define GPMC_REVISION		0x00
 #define GPMC_SYSCONFIG		0x10
@@ -898,6 +901,25 @@ static int __init gpmc_init(void)
 }
 postcore_initcall(gpmc_init);
 
+static int __init omap_gpmc_init(void)
+{
+	struct omap_hwmod *oh;
+	struct platform_device *pdev;
+	char *oh_name = "gpmc";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return -ENODEV;
+	}
+
+	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0, NULL, 0, 0);
+	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
+
+	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
+}
+postcore_initcall(omap_gpmc_init);
+
 static irqreturn_t gpmc_handle_irq(int irq, void *dev)
 {
 	int i;
-- 
1.7.0.4
