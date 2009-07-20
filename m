From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 20 Jul 2009 11:18:43 +0200
Subject: [PATCH] video: add PXA3xx accelerator ID
Message-ID: <mailman.4.1252589202.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ID 99 for PXA3xx frame buffers and report it in the pxa frame buffer
conditionally, depending on a new flag in struct pxafb_mach_info.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Eric Miao <eric.miao@marvell.com>
Cc: linux-fbdev-devel at lists.sourceforge.net
Cc: Dennis Oliver Kropp <dok@directfb.org>
Cc: Sven Neumann <s.neumann@raumfeld.com>
---
 arch/arm/mach-pxa/include/mach/pxafb.h |    3 ++-
 drivers/video/pxafb.c                  |    3 +++
 include/linux/fb.h                     |    1 +
 3 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h b/arch/arm/mach-pxa/include/mach/pxafb.h
index 6932720..f73061c 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -118,7 +118,8 @@ struct pxafb_mach_info {
 	u_int		fixed_modes:1,
 			cmap_inverse:1,
 			cmap_static:1,
-			unused:29;
+			acceleration_enabled:1,
+			unused:28;
 
 	/* The following should be defined in LCCR0
 	 *      LCCR0_Act or LCCR0_Pas          Active or Passive
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 3951cc5..b65cc2d 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -2083,6 +2083,9 @@ static int __devinit pxafb_probe(struct platform_device *dev)
 		goto failed;
 	}
 
+	if (cpu_is_pxa3xx() && inf->acceleration_enabled)
+		fbi->fb.fix.accel = FB_ACCEL_PXA3XX;
+
 	fbi->backlight_power = inf->pxafb_backlight_power;
 	fbi->lcd_power = inf->pxafb_lcd_power;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f847df9..a34bdf5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -133,6 +133,7 @@ struct dentry;
 #define FB_ACCEL_NEOMAGIC_NM2230 96	/* NeoMagic NM2230              */
 #define FB_ACCEL_NEOMAGIC_NM2360 97	/* NeoMagic NM2360              */
 #define FB_ACCEL_NEOMAGIC_NM2380 98	/* NeoMagic NM2380              */
+#define FB_ACCEL_PXA3XX		 99	/* PXA3xx			*/
 
 #define FB_ACCEL_SAVAGE4        0x80	/* S3 Savage4                   */
 #define FB_ACCEL_SAVAGE3D       0x81	/* S3 Savage3D                  */
-- 
1.6.3.3
