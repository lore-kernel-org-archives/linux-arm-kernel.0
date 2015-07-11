From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 12 Jul 2015 01:32:00 +0200
Subject: [PATCH] ARM: pxa: fix dm9000 platform data regression
Message-ID: <1436657520-16972-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since dm9000 driver added support for a vcc regulator, platform data
based platforms have their ethernet broken, as the regulator claiming
returns -EPROBE_DEFER and prevents dm9000 loading.

This patch fixes this for all pxa boards using dm9000, by using the
specific regulator_has_full_constraints() function.

This was discovered and tested on the cm-x300 board.

Fixes: 7994fe55a4a2 ("dm9000: Add regulator and reset support to dm9000")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/capc7117.c       | 3 +++
 arch/arm/mach-pxa/cm-x2xx.c        | 3 +++
 arch/arm/mach-pxa/cm-x300.c        | 2 ++
 arch/arm/mach-pxa/colibri-pxa270.c | 3 +++
 arch/arm/mach-pxa/em-x270.c        | 2 ++
 arch/arm/mach-pxa/icontrol.c       | 3 +++
 arch/arm/mach-pxa/trizeps4.c       | 3 +++
 arch/arm/mach-pxa/vpac270.c        | 3 +++
 arch/arm/mach-pxa/zeus.c           | 2 ++
 9 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-pxa/capc7117.c b/arch/arm/mach-pxa/capc7117.c
index c092730749b9..bf366b39fa61 100644
--- a/arch/arm/mach-pxa/capc7117.c
+++ b/arch/arm/mach-pxa/capc7117.c
@@ -24,6 +24,7 @@
 #include <linux/ata_platform.h>
 #include <linux/serial_8250.h>
 #include <linux/gpio.h>
+#include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -144,6 +145,8 @@ static void __init capc7117_init(void)
 
 	capc7117_uarts_init();
 	capc7117_ide_init();
+
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(CAPC7117,
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index bb99f59a36d8..a17a91eb8e9a 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -13,6 +13,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
+#include <linux/regulator/machine.h>
 
 #include <linux/dm9000.h>
 #include <linux/leds.h>
@@ -466,6 +467,8 @@ static void __init cmx2xx_init(void)
 	cmx2xx_init_ac97();
 	cmx2xx_init_touchscreen();
 	cmx2xx_init_leds();
+
+	regulator_has_full_constraints();
 }
 
 static void __init cmx2xx_init_irq(void)
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 4d3588d26c2a..5851f4c254c1 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -835,6 +835,8 @@ static void __init cm_x300_init(void)
 	cm_x300_init_ac97();
 	cm_x300_init_wi2wi();
 	cm_x300_init_bl();
+
+	regulator_has_full_constraints();
 }
 
 static void __init cm_x300_fixup(struct tag *tags, char **cmdline)
diff --git a/arch/arm/mach-pxa/colibri-pxa270.c b/arch/arm/mach-pxa/colibri-pxa270.c
index 5f9d9303b346..3503826333c7 100644
--- a/arch/arm/mach-pxa/colibri-pxa270.c
+++ b/arch/arm/mach-pxa/colibri-pxa270.c
@@ -18,6 +18,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/machine.h>
 #include <linux/ucb1400.h>
 
 #include <asm/mach/arch.h>
@@ -294,6 +295,8 @@ static void __init colibri_pxa270_init(void)
 		printk(KERN_ERR "Illegal colibri_pxa270_baseboard type %d\n",
 				colibri_pxa270_baseboard);
 	}
+
+	regulator_has_full_constraints();
 }
 
 /* The "Income s.r.o. SH-Dmaster PXA270 SBC" board can be booted either
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index 51531ecffca8..9d7072b04045 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -1306,6 +1306,8 @@ static void __init em_x270_init(void)
 	em_x270_init_i2c();
 	em_x270_init_camera();
 	em_x270_userspace_consumers_init();
+
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(EM_X270, "Compulab EM-X270")
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index c98511c5abd1..9b0eb0252af6 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -26,6 +26,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/can/platform/mcp251x.h>
+#include <linux/regulator/machine.h>
 
 #include "generic.h"
 
@@ -185,6 +186,8 @@ static void __init icontrol_init(void)
 	mxm_8x10_mmc_init();
 
 	icontrol_can_init();
+
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(ICONTROL, "iControl/SafeTcam boards using Embedian MXM-8x10 CoM")
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 872dcb20e757..066e3a250ee0 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -26,6 +26,7 @@
 #include <linux/dm9000.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/partitions.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c/pxa-i2c.h>
 
 #include <asm/types.h>
@@ -534,6 +535,8 @@ static void __init trizeps4_init(void)
 
 	BCR_writew(trizeps_conxs_bcr);
 	board_backlight_power(1);
+
+	regulator_has_full_constraints();
 }
 
 static void __init trizeps4_map_io(void)
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index aa89488f961e..54122a983ae3 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -24,6 +24,7 @@
 #include <linux/dm9000.h>
 #include <linux/ucb1400.h>
 #include <linux/ata_platform.h>
+#include <linux/regulator/machine.h>
 #include <linux/regulator/max1586.h>
 #include <linux/i2c/pxa-i2c.h>
 
@@ -711,6 +712,8 @@ static void __init vpac270_init(void)
 	vpac270_ts_init();
 	vpac270_rtc_init();
 	vpac270_ide_init();
+
+	regulator_has_full_constraints();
 }
 
 MACHINE_START(VPAC270, "Voipac PXA270")
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index ac2ae5c71ab4..6158566fa0f7 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -868,6 +868,8 @@ static void __init zeus_init(void)
 	i2c_register_board_info(0, ARRAY_AND_SIZE(zeus_i2c_devices));
 	pxa2xx_set_spi_info(3, &pxa2xx_spi_ssp3_master_info);
 	spi_register_board_info(zeus_spi_board_info, ARRAY_SIZE(zeus_spi_board_info));
+
+	regulator_has_full_constraints();
 }
 
 static struct map_desc zeus_io_desc[] __initdata = {
-- 
2.1.4
