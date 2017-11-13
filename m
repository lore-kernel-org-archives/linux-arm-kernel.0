From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 13 Nov 2017 18:27:38 +0100
Subject: [PATCH v2 1/2] ARM: pxa: move declarations to proper place
In-Reply-To: <20171113172739.1996-1-wsa@the-dreams.de>
References: <20171113172739.1996-1-wsa@the-dreams.de>
Message-ID: <20171113172739.1996-2-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data is not the right place for such declarations, use
devices.h in the mach-directory where the rest is located. Note that the
some board files needed an additional include for this to work.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Change since V1:
	* 3 more boards needed additional include

 arch/arm/mach-pxa/devices.h         |  9 +++++++++
 arch/arm/mach-pxa/littleton.c       |  1 +
 arch/arm/mach-pxa/xcep.c            |  1 +
 arch/arm/mach-pxa/zeus.c            |  1 +
 arch/arm/mach-pxa/zylonite_pxa300.c |  1 +
 include/linux/i2c/pxa-i2c.h         | 11 -----------
 6 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 04580c407276cd..dfd0d121fc1799 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -55,3 +55,12 @@ extern struct platform_device pxa93x_device_gpio;
 
 void __init pxa_register_device(struct platform_device *dev, void *data);
 void __init pxa2xx_set_dmac_info(int nb_channels, int nb_requestors);
+
+struct i2c_pxa_platform_data;
+extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
+#ifdef CONFIG_PXA27x
+extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
+#ifdef CONFIG_PXA3xx
+extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
+#endif
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index fae38fdc8d8e56..23aea72b4117ce 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -42,6 +42,7 @@
 #include <asm/mach/irq.h>
 
 #include "pxa300.h"
+#include "devices.h"
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/keypad-pxa27x.h>
diff --git a/arch/arm/mach-pxa/xcep.c b/arch/arm/mach-pxa/xcep.c
index 056369ef250e8a..fa21951bc9f041 100644
--- a/arch/arm/mach-pxa/xcep.c
+++ b/arch/arm/mach-pxa/xcep.c
@@ -32,6 +32,7 @@
 #include <mach/smemc.h>
 
 #include "generic.h"
+#include "devices.h"
 
 #define XCEP_ETH_PHYS		(PXA_CS3_PHYS + 0x00000300)
 #define XCEP_ETH_PHYS_END	(PXA_CS3_PHYS + 0x000fffff)
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ecbcaee5a2d5f8..8b16ba46c8c3bf 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -40,6 +40,7 @@
 #include <asm/mach/map.h>
 
 #include "pxa27x.h"
+#include "devices.h"
 #include <mach/regs-uart.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index e247acf1400a90..4fb1c556499a82 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -22,6 +22,7 @@
 #include <linux/gpio.h>
 
 #include "pxa300.h"
+#include "devices.h"
 #include "zylonite.h"
 
 #include "generic.h"
diff --git a/include/linux/i2c/pxa-i2c.h b/include/linux/i2c/pxa-i2c.h
index 53aab243cbd834..5236f216dfaefd 100644
--- a/include/linux/i2c/pxa-i2c.h
+++ b/include/linux/i2c/pxa-i2c.h
@@ -71,15 +71,4 @@ struct i2c_pxa_platform_data {
 	unsigned char		master_code;
 	unsigned long		rate;
 };
-
-extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
-
-#ifdef CONFIG_PXA27x
-extern void pxa27x_set_i2c_power_info(struct i2c_pxa_platform_data *info);
-#endif
-
-#ifdef CONFIG_PXA3xx
-extern void pxa3xx_set_i2c_power_info(struct i2c_pxa_platform_data *info);
-#endif
-
 #endif
-- 
2.11.0
