From: nm@ti.com (Nishanth Menon)
Date: Wed, 27 Jul 2011 15:02:32 -0500
Subject: [PATCH] OMAP: hwmod: add omap_hwmod_to_device
Message-ID: <mailman.37.1311832438.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_hwmod_to_device is useful for drivers when they need to
look up the device associated with a hwmod name to map back
into the device structure pointers. These ideally should
be used by drivers in mach directory. This could in effect
replace apis such as omap2_get_mpuss_device,
omap2_get_iva_device, omap2_get_l3_device, omap4_get_dsp_device
etc..

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..77d01a2 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -142,6 +142,7 @@
 #include "powerdomain.h"
 #include <plat/clock.h>
 #include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 #include <plat/prcm.h>
 
 #include "cm2xxx_3xxx.h"
@@ -2369,3 +2370,35 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_to_device() - convert a hwmod name to device pointer
+ * @oh_name: name of the hwmod device
+ *
+ * returns back a struct device * pointer associated with a hwmod
+ * device represented by a hwmod_name
+ */
+struct device *omap_hwmod_to_device(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+
+	if (!oh_name) {
+		WARN(1, "%s: no hwmod name!\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	oh = _lookup(oh_name);
+	if (IS_ERR_OR_NULL(oh)) {
+		WARN(1, "%s: no hwmod for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(-ENODEV);
+	}
+	if (IS_ERR_OR_NULL(oh->od)) {
+		WARN(1, "%s: no omap_device for %s\n", __func__,
+			oh_name);
+		return ERR_PTR(-ENODEV);
+	}
+
+	return &oh->od->pdev.dev;
+}
+EXPORT_SYMBOL(omap_hwmod_to_device);
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..b9eec08 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -611,4 +611,6 @@ extern int omap2430_hwmod_init(void);
 extern int omap3xxx_hwmod_init(void);
 extern int omap44xx_hwmod_init(void);
 
+extern struct device *omap_hwmod_to_device(const char *oh_name);
+
 #endif
-- 
1.7.4.1
