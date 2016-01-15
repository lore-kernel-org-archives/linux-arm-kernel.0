From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jan 2016 11:52:54 +0100
Subject: [PATCH] drm: omap dss: add missing includes
Message-ID: <6010313.rYeAixWRHJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omapdrm dss driver currently fails to build in some configurations when
the pinctrl and seq_print declarations are not visible:

omapdrm/dss/dss.c:1268:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
omapdrm/dss/dss.c:1277:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
omapdrm/dss/hdmi_wp.c:26:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
omapdrm/dss/hdmi_pll.c:30:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
omapdrm/dss/hdmi_phy.c:34:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]

This adds the appropriate include statements.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 9960aa7cb58c ("drm/omap: move omapdss & displays under omapdrm")
---
Found on ARM randconfig builds. I assume there are also configurations in which this is
not needed because the headers get included through other headers, and I have not
investigated exactly what options cause this as the fix seems obvious and harmless.

diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index f95ff319e68e..839b1b6bdbe4 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -37,6 +37,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/suspend.h>
 #include <linux/component.h>
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
index 1f5d19c119ce..a872721a03a2 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
@@ -13,6 +13,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
+
 #include <video/omapdss.h>
 
 #include "dss.h"
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index 06e23a7c432c..f1015e8b8267 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/seq_file.h>
 
 #include <video/omapdss.h>
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
index 7c544bc56fb5..753ac305d32a 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <video/omapdss.h>
 
 #include "dss.h"
