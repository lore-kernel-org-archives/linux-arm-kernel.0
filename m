From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Feb 2013 11:31:32 -0800
Subject: omap1_defconfig build broken in linux next
Message-ID: <20130211193132.GV4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FYI, looks like something broke compile recently, have not yet
figured out the breaking commit. Might be the same issue
with some other defconfigs too.

Probably something was indirectly included earlier?

This fixes it, still need to dig the breaking commit
for the description.

Regards,

Tony


--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -31,6 +31,8 @@
 
 #include <plat/i2c.h>
 
+#include <mach/irqs.h>
+
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
 #else
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -27,6 +27,7 @@
 #include <linux/lcd.h>
 #include <linux/gpio.h>
 
+#include <mach/hardware.h>
 #include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
--- a/drivers/video/omap/lcd_osk.c
+++ b/drivers/video/omap/lcd_osk.c
@@ -24,7 +24,10 @@
 #include <linux/platform_device.h>
 
 #include <asm/gpio.h>
+
+#include <mach/hardware.h>
 #include <mach/mux.h>
+
 #include "omapfb.h"
 
 static int osk_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
