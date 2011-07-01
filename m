From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  1 Jul 2011 11:46:33 +0200
Subject: [RFC PATCH 2/3] ARM: imx/mx31moboard: convert to new baseboard
	handling
In-Reply-To: <1309513594-31016-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110701094403.GT11559@pengutronix.de>
	<1309513594-31016-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1309513594-31016-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old mx31moboard way to pass the board is still supported but will go
away later saving aa few more lines.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/mach-mx31moboard.c               |   48 +++++++++++++-------
 arch/arm/mach-imx/mx31moboard-devboard.c           |    5 +-
 arch/arm/mach-imx/mx31moboard-marxbot.c            |    5 +-
 arch/arm/mach-imx/mx31moboard-smartbot.c           |   18 +++-----
 arch/arm/plat-mxc/include/mach/board-mx31moboard.h |   16 +++----
 6 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 59c97a3..98bb0ca 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -463,6 +463,7 @@ config MACH_MX31_3DS_MXC_NAND_USE_BBT
 
 config MACH_MX31MOBOARD
 	bool "Support mx31moboard platforms (EPFL Mobots group)"
+	select BASEBOARD
 	select SOC_IMX31
 	select IMX_HAVE_PLATFORM_FSL_USB2_UDC
 	select IMX_HAVE_PLATFORM_IMX_I2C
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index eaa51e4..802595b 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -499,6 +499,31 @@ err:
 
 }
 
+static const struct baseboard_entry
+		mx31moboard_baseboard_map[] __initconst = {
+	{
+		.name = "devboard",
+		.initfunc = mx31moboard_devboard_init,
+	}, {
+		.name = "eyebot",
+		.initfunc = mx31moboard_smartbot_init,
+		.initdata = (void *)MX31MOBOARD_SMARTBOT_USB_OTG,
+	}, {
+		.name = "marxbot",
+		.initfunc = mx31moboard_marxbot_init,
+	}, {
+		.name = "smartbot",
+		.initfunc = mx31moboard_smartbot_init,
+	},
+};
+
+static const char *baseboardnames[] = {
+	"",
+	"devboard",
+	"marxbot",
+	"smartbot",
+	"eyebot",
+};
 static int mx31moboard_baseboard;
 core_param(mx31moboard_baseboard, mx31moboard_baseboard, int, 0444);
 
@@ -534,23 +559,14 @@ static void __init mx31moboard_init(void)
 
 	moboard_usbh2_init();
 
-	switch (mx31moboard_baseboard) {
-	case MX31NOBOARD:
-		break;
-	case MX31DEVBOARD:
-		mx31moboard_devboard_init();
-		break;
-	case MX31MARXBOT:
-		mx31moboard_marxbot_init();
-		break;
-	case MX31SMARTBOT:
-	case MX31EYEBOT:
-		mx31moboard_smartbot_init(mx31moboard_baseboard);
-		break;
-	default:
-		printk(KERN_ERR "Illegal mx31moboard_baseboard type %d\n",
-			mx31moboard_baseboard);
+	if (mx31moboard_baseboard > 0 &&
+			mx31moboard_baseboard < ARRAY_SIZE(baseboardnames)) {
+		pr_warn("mx31moboard_baseboard=<id> is deprecated, use baseboard=<fullname>\n");
+		baseboard_select(baseboardnames[mx31moboard_baseboard]);
 	}
+
+	baseboard_setup(mx31moboard_baseboard_map,
+			ARRAY_SIZE(mx31moboard_baseboard_map));
 }
 
 static void __init mx31moboard_timer_init(void)
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 0aa2536..0fdb79d 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -26,6 +26,7 @@
 #include <mach/iomux-mx3.h>
 #include <mach/hardware.h>
 #include <mach/ulpi.h>
+#include <mach/board-mx31moboard.h>
 
 #include "devices-imx31.h"
 
@@ -223,7 +224,7 @@ static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 /*
  * system init for baseboard usage. Will be called by mx31moboard init.
  */
-void __init mx31moboard_devboard_init(void)
+int __init mx31moboard_devboard_init(const struct baseboard_entry *unused)
 {
 	printk(KERN_INFO "Initializing mx31devboard peripherals\n");
 
@@ -238,5 +239,5 @@ void __init mx31moboard_devboard_init(void)
 
 	imx31_add_fsl_usb2_udc(&usb_pdata);
 
-	devboard_usbh1_init();
+	return devboard_usbh1_init();
 }
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index bb639cb..ed943a1 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -28,6 +28,7 @@
 #include <mach/hardware.h>
 #include <mach/iomux-mx3.h>
 #include <mach/ulpi.h>
+#include <mach/board-mx31moboard.h>
 
 #include <media/soc_camera.h>
 
@@ -336,7 +337,7 @@ static const struct fsl_usb2_platform_data usb_pdata __initconst = {
 /*
  * system init for baseboard usage. Will be called by mx31moboard init.
  */
-void __init mx31moboard_marxbot_init(void)
+int __init mx31moboard_marxbot_init(const struct baseboard_entry *unused)
 {
 	printk(KERN_INFO "Initializing mx31marxbot peripherals\n");
 
@@ -362,5 +363,5 @@ void __init mx31moboard_marxbot_init(void)
 
 	imx31_add_fsl_usb2_udc(&usb_pdata);
 
-	marxbot_usbh1_init();
+	return marxbot_usbh1_init();
 }
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index fabb801..9afc630 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -181,7 +181,7 @@ static void smartbot_resets_init(void)
 /*
  * system init for baseboard usage. Will be called by mx31moboard init.
  */
-void __init mx31moboard_smartbot_init(int board)
+int __init mx31moboard_smartbot_init(const struct baseboard_entry *entry)
 {
 	printk(KERN_INFO "Initializing mx31smartbot peripherals\n");
 
@@ -190,20 +190,14 @@ void __init mx31moboard_smartbot_init(int board)
 
 	imx31_add_imx_uart1(&uart_pdata);
 
-	switch (board) {
-	case MX31SMARTBOT:
-		imx31_add_fsl_usb2_udc(&usb_pdata);
-		break;
-	case MX31EYEBOT:
+	if ((unsigned long)entry->initdata & MX31MOBOARD_SMARTBOT_USB_OTG)
 		smartbot_otg_host_init();
-		break;
-	default:
-		printk(KERN_WARNING "Unknown board %d, USB OTG not initialized",
-			board);
-	}
+	else
+		imx31_add_fsl_usb2_udc(&usb_pdata);
 
 	smartbot_resets_init();
 
 	smartbot_cam_init();
-	platform_add_devices(smartbot_cameras, ARRAY_SIZE(smartbot_cameras));
+	return platform_add_devices(smartbot_cameras,
+			ARRAY_SIZE(smartbot_cameras));
 }
diff --git a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
index de14543..8d33d47 100644
--- a/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
+++ b/arch/arm/plat-mxc/include/mach/board-mx31moboard.h
@@ -19,24 +19,20 @@
 #ifndef __ASM_ARCH_MXC_BOARD_MX31MOBOARD_H__
 #define __ASM_ARCH_MXC_BOARD_MX31MOBOARD_H__
 
+#include <asm/baseboard.h>
+
 #ifndef __ASSEMBLY__
 
-enum mx31moboard_boards {
-	MX31NOBOARD	= 0,
-	MX31DEVBOARD	= 1,
-	MX31MARXBOT	= 2,
-	MX31SMARTBOT	= 3,
-	MX31EYEBOT	= 4,
-};
+#define MX31MOBOARD_SMARTBOT_USB_OTG	1UL
 
 /*
  * This CPU module needs a baseboard to work. After basic initializing
  * its own devices, it calls the baseboard's init function.
  */
 
-extern void mx31moboard_devboard_init(void);
-extern void mx31moboard_marxbot_init(void);
-extern void mx31moboard_smartbot_init(int board);
+int mx31moboard_devboard_init(const struct baseboard_entry *);
+int mx31moboard_marxbot_init(const struct baseboard_entry *);
+int mx31moboard_smartbot_init(const struct baseboard_entry *);
 
 #endif
 
-- 
1.7.5.3
