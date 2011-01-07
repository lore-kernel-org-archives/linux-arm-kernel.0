From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Fri, 7 Jan 2011 16:38:27 -0600
Subject: [PATCH] ep93xx: add framebuffer support to edb93xx boards
Message-ID: <0D753D10438DA54287A00B027084269764C41240B9@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ep9307, ep9312, and ep9315 variants of the ep93xx processor include the
raster engine needed for framebuffer support.

This allows the EDB93xx boards with those processors to use the framebuffer
driver.

Tested on an EDB9307A with the following kernel parameters:
	video=640x480-16 at 60
	video=1024x768-16 at 60

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4b04316..49e3b3d 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -32,6 +32,7 @@
 #include <linux/i2c-gpio.h>
 
 #include <mach/hardware.h>
+#include <mach/fb.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -111,6 +112,41 @@ static void __init edb93xx_register_pwm(void)
 }
 
 
+/*************************************************************************
+ * EDB93xx framebuffer
+ *************************************************************************/
+static struct ep93xxfb_mach_info __initdata edb93xxfb_info = {
+	.num_modes	= EP93XXFB_USE_MODEDB,
+	.bpp		= 16,
+	.flags		= 0,
+};
+
+static int __init edb93xx_has_fb(void)
+{
+	if (machine_is_edb9307() || machine_is_edb9307a() ||
+	    machine_is_edb9312() || machine_is_edb9315() ||
+	    machine_is_edb9315a()) {
+		/* These all have an ep93xx with video capability */
+		return 1;
+	} else {
+		/* The ep9301 and ep9302 do not have a video peripheral */
+		return 0;
+	}
+}
+
+static void __init edb93xx_register_fb(void)
+{
+	if (!edb93xx_has_fb())
+		return;
+
+	if (machine_is_edb9307a() || machine_is_edb9315a())
+		edb93xxfb_info.flags |= EP93XXFB_USE_SDCSN0;
+	else
+		edb93xxfb_info.flags |= EP93XXFB_USE_SDCSN3;
+
+	ep93xx_register_fb(&edb93xxfb_info);
+}
+
 static void __init edb93xx_init_machine(void)
 {
 	ep93xx_init_devices();
@@ -118,6 +154,7 @@ static void __init edb93xx_init_machine(void)
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
 	edb93xx_register_pwm();
+	edb93xx_register_fb();
 }
 
 
