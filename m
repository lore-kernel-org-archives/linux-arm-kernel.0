From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 10 Dec 2010 12:05:28 +0100
Subject: [PATCH 2/2] OMAP1: Amstrad Delta: reserve memory for camera
In-Reply-To: <201012101159.21845.jkrzyszt@tis.icnet.pl>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
	<201012101159.21845.jkrzyszt@tis.icnet.pl>
Message-ID: <201012101205.29696.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 1/2 from this set provides a possibility to reserve a block of memory 
for use as the OMAP1 camera dedicated dma coherent memory. Use this 
functionality to avoid the camera driver switching form videobuf_contig mode 
to less efficient videobuf_sg mode in case of dma coherent memory allocation 
failure after system memory gets fragmented.

Created and tested against linux-2.6.27-rc4 on top of patch 1/2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/board-ams-delta.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- linux-2.6.37-rc4/arch/arm/mach-omap1/board-ams-delta.c.orig	2010-12-04 18:05:25.000000000 +0100
+++ linux-2.6.37-rc4/arch/arm/mach-omap1/board-ams-delta.c	2010-12-04 22:19:39.000000000 +0100
@@ -262,6 +262,16 @@ static struct omap1_cam_platform_data am
 	.lclk_khz_max	= 1334,		/* results in 5fps CIF, 10fps QCIF */
 };
 
+void __init amsdelta_reserve(void)
+{
+#if defined(CONFIG_VIDEO_OMAP1) || defined(CONFIG_VIDEO_OMAP1_MODULE)
+	omap1_camera_reserve(PAGE_SIZE << get_order(352 * 288 * 2 *
+			OMAP1_CAMERA_MIN_BUF_COUNT(OMAP1_CAM_DMA_CONTIG)));
+#endif
+
+	omap_reserve();
+}
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_kp_device,
 	&ams_delta_lcd_device,
@@ -366,7 +376,7 @@ MACHINE_START(AMS_DELTA, "Amstrad E3 (De
 	/* Maintainer: Jonathan McDowell <noodles@earth.li> */
 	.boot_params	= 0x10000100,
 	.map_io		= ams_delta_map_io,
-	.reserve	= omap_reserve,
+	.reserve	= amsdelta_reserve,
 	.init_irq	= ams_delta_init_irq,
 	.init_machine	= ams_delta_init,
 	.timer		= &omap_timer,
