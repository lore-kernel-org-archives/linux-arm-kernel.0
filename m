From: tony@atomide.com (Tony Lindgren)
Date: Mon, 11 Feb 2013 14:46:00 -0800
Subject: [PATCH] ARM: OMAP1: Fix build related to kgdb.h no longer
 including serial_8250.h
Message-ID: <20130211224600.GB4801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 16559ae4 (kgdb: remove #include <linux/serial_8250.h> from kgdb.h)
had a side effect of breaking omap1_defconfig build as some headers
were included indirectly:

arch/arm/mach-omap1/board-h2.c:249: error: ?INT_KEYBOARD? undeclared here (not in a function)
...

This worked earlier as linux/serial_8250.h included linux/serial_core.h,
via linux/serial_8250.h from linux/kgdb.h. Fix this by including the
necessary headers directly.

Signed-off-by: Tony Lindgren <tony@atomide.com>

---

Arnd & Olof, can you please apply this to your non-critical fixes
or some other branch that gets merged early on during the merge
window?

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
