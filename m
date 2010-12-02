From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu,  2 Dec 2010 18:47:32 +0100
Subject: [PATCH 4/9] arm/pxa2xx: reorgazine SSP and SPI header files
In-Reply-To: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
References: <1291312057-7933-1-git-send-email-bigeasy@linutronix.de>
Message-ID: <1291312057-7933-5-git-send-email-bigeasy@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PXA-SPI driver relies on some files / defines which are arm specific
and are within the ARM tree. The CE4100 SoC which is x86 has also the
SPI core.
This patch moves the ssp and spi files from arm/mach-pxa and plat-pxa to
include/linux where the CE4100 can access them.

This move got verified by building the following defconfigs:
   cm_x2xx_defconfig corgi_defconfig em_x270_defconfig ezx_defconfig
   imote2_defconfig pxa3xx_defconfig spitz_defconfig zeus_defconfig
   raumfeld_defconfig magician_defconfig

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 Documentation/spi/pxa2xx                           |    4 ++--
 arch/arm/mach-pxa/cm-x255.c                        |    2 +-
 arch/arm/mach-pxa/cm-x270.c                        |    2 +-
 arch/arm/mach-pxa/corgi.c                          |    2 +-
 arch/arm/mach-pxa/devices.c                        |    2 +-
 arch/arm/mach-pxa/em-x270.c                        |    2 +-
 arch/arm/mach-pxa/hx4700.c                         |    2 +-
 arch/arm/mach-pxa/icontrol.c                       |    2 +-
 arch/arm/mach-pxa/littleton.c                      |    2 +-
 arch/arm/mach-pxa/lubbock.c                        |    2 +-
 arch/arm/mach-pxa/pcm027.c                         |    2 +-
 arch/arm/mach-pxa/poodle.c                         |    2 +-
 arch/arm/mach-pxa/spitz.c                          |    3 +--
 arch/arm/mach-pxa/stargate2.c                      |    2 +-
 arch/arm/mach-pxa/tosa.c                           |    2 +-
 arch/arm/mach-pxa/trizeps4.c                       |    1 -
 arch/arm/mach-pxa/z2.c                             |    2 +-
 arch/arm/mach-pxa/zeus.c                           |    2 +-
 arch/arm/plat-pxa/ssp.c                            |    2 +-
 drivers/spi/pxa2xx_spi.c                           |    4 +---
 .../plat/ssp.h => include/linux/pxa2xx_ssp.h       |    8 ++++----
 .../mach => include/linux/spi}/pxa2xx_spi.h        |    8 +++++---
 sound/soc/pxa/pxa-ssp.c                            |    2 +-
 23 files changed, 30 insertions(+), 32 deletions(-)
 rename arch/arm/plat-pxa/include/plat/ssp.h => include/linux/pxa2xx_ssp.h (98%)
 rename {arch/arm/mach-pxa/include/mach => include/linux/spi}/pxa2xx_spi.h (92%)

diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 6bb916d..68a4fe3 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -19,7 +19,7 @@ Declaring PXA2xx Master Controllers
 -----------------------------------
 Typically a SPI master is defined in the arch/.../mach-*/board-*.c as a
 "platform device".  The master configuration is passed to the driver via a table
-found in arch/arm/mach-pxa/include/mach/pxa2xx_spi.h:
+found in include/linux/spi/pxa2xx_spi.h:
 
 struct pxa2xx_spi_master {
 	enum pxa_ssp_type ssp_type;
@@ -94,7 +94,7 @@ using the "spi_board_info" structure found in "linux/spi/spi.h". See
 
 Each slave device attached to the PXA must provide slave specific configuration
 information via the structure "pxa2xx_spi_chip" found in
-"arch/arm/mach-pxa/include/mach/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
+"include/linux/spi/pxa2xx_spi.h".  The pxa2xx_spi master controller driver
 will uses the configuration whenever the driver communicates with the slave
 device. All fields are optional.
 
diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index f1a7703..93f59f8 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -17,13 +17,13 @@
 #include <linux/mtd/nand-gpio.h>
 
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
 #include <mach/pxa25x.h>
-#include <mach/pxa2xx_spi.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index a9926bb..b88d601 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -19,12 +19,12 @@
 #include <video/mbxfb.h>
 
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/libertas_spi.h>
 
 #include <mach/pxa27x.h>
 #include <mach/ohci.h>
 #include <mach/mmc.h>
-#include <mach/pxa2xx_spi.h>
 
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 821229a..3b8dcac 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <video/w100fb.h>
@@ -48,7 +49,6 @@
 #include <mach/irda.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/corgi.h>
 #include <mach/sharpsl_pm.h>
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index aaa1166..c4f9c71 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/spi/pxa2xx_spi.h>
 
 #include <asm/pmu.h>
 #include <mach/udc.h>
@@ -12,7 +13,6 @@
 #include <mach/irda.h>
 #include <mach/ohci.h>
 #include <plat/pxa27x_keypad.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/camera.h>
 #include <mach/audio.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index ed0dbfdb..b20b944 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -26,6 +26,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/tdo24m.h>
 #include <linux/spi/libertas_spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/power_supply.h>
 #include <linux/apm-emulation.h>
 #include <linux/i2c.h>
@@ -46,7 +47,6 @@
 #include <plat/pxa27x_keypad.h>
 #include <plat/i2c.h>
 #include <mach/camera.h>
-#include <mach/pxa2xx_spi.h>
 
 #include "generic.h"
 #include "devices.h"
diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index 76d93a2..f09526f 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -33,6 +33,7 @@
 #include <linux/regulator/max1586.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/usb/gpio_vbus.h>
 
 #include <mach/hardware.h>
@@ -43,7 +44,6 @@
 #include <mach/hx4700.h>
 #include <plat/i2c.h>
 #include <mach/irda.h>
-#include <mach/pxa2xx_spi.h>
 
 #include <video/platform_lcd.h>
 #include <video/w100fb.h>
diff --git a/arch/arm/mach-pxa/icontrol.c b/arch/arm/mach-pxa/icontrol.c
index d51ee3d..3ab6fd3 100644
--- a/arch/arm/mach-pxa/icontrol.c
+++ b/arch/arm/mach-pxa/icontrol.c
@@ -24,7 +24,7 @@
 #include <mach/mxm8x10.h>
 
 #include <linux/spi/spi.h>
-#include <mach/pxa2xx_spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/can/platform/mcp251x.h>
 
 #include "generic.h"
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 41aa89e..8051925 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/smc91x.h>
 #include <linux/i2c.h>
 #include <linux/leds.h>
@@ -42,7 +43,6 @@
 #include <mach/pxa300.h>
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
-#include <mach/pxa2xx_spi.h>
 #include <plat/pxa27x_keypad.h>
 #include <mach/littleton.h>
 #include <plat/i2c.h>
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index 1499493..4a3fe45 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -25,7 +25,7 @@
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <mach/pxa2xx_spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 
 #include <asm/setup.h>
 #include <asm/memory.h>
diff --git a/arch/arm/mach-pxa/pcm027.c b/arch/arm/mach-pxa/pcm027.c
index c77e8f3..a5596f9 100644
--- a/arch/arm/mach-pxa/pcm027.c
+++ b/arch/arm/mach-pxa/pcm027.c
@@ -25,12 +25,12 @@
 #include <linux/mtd/physmap.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/max7301.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/leds.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/pxa27x.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/pcm027.h>
 #include "generic.h"
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 93a191c..c05eee3 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -25,6 +25,7 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 
 #include <mach/hardware.h>
@@ -43,7 +44,6 @@
 #include <mach/irda.h>
 #include <mach/poodle.h>
 #include <mach/pxafb.h>
-#include <mach/pxa2xx_spi.h>
 #include <plat/i2c.h>
 
 #include <asm/hardware/scoop.h>
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index f736119..4fd5572 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -23,7 +23,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
-#include <linux/mtd/physmap.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/regulator/machine.h>
@@ -41,7 +41,6 @@
 #include <mach/mmc.h>
 #include <mach/ohci.h>
 #include <mach/pxafb.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/spitz.h>
 #include <mach/sharpsl_pm.h>
 
diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 738adc1..325f6ac 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -46,10 +46,10 @@
 #include <plat/i2c.h>
 #include <mach/mmc.h>
 #include <mach/udc.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x-udc.h>
 
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mfd/da903x.h>
 #include <linux/sht15.h>
 
diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 0ee1df4..7b5765d 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -32,6 +32,7 @@
 #include <linux/gpio.h>
 #include <linux/pda_power.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/input/matrix_keypad.h>
 
 #include <asm/setup.h>
@@ -44,7 +45,6 @@
 #include <mach/mmc.h>
 #include <mach/udc.h>
 #include <mach/tosa_bt.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/audio.h>
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 565d062..bdb02a0 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -40,7 +40,6 @@
 #include <asm/mach/flash.h>
 
 #include <mach/pxa27x.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/trizeps4.h>
 #include <mach/audio.h>
 #include <mach/pxafb.h>
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index fefde98..1b8b71b 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -20,6 +20,7 @@
 #include <linux/z2_battery.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/libertas_spi.h>
 #include <linux/spi/lms283gf05.h>
 #include <linux/power_supply.h>
@@ -38,7 +39,6 @@
 #include <mach/pxafb.h>
 #include <mach/mmc.h>
 #include <plat/pxa27x_keypad.h>
-#include <mach/pxa2xx_spi.h>
 
 #include <plat/i2c.h>
 
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index dea46a2..f5c9f30 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -20,6 +20,7 @@
 #include <linux/dm9000.h>
 #include <linux/mmc/host.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -41,7 +42,6 @@
 #include <mach/pxa27x-udc.h>
 #include <mach/udc.h>
 #include <mach/pxafb.h>
-#include <mach/pxa2xx_spi.h>
 #include <mach/mfp-pxa27x.h>
 #include <mach/pm.h>
 #include <mach/audio.h>
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index c6357e5..58b7980 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -28,11 +28,11 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
 #include <mach/hardware.h>
-#include <plat/ssp.h>
 
 static DEFINE_MUTEX(ssp_lock);
 static LIST_HEAD(ssp_list);
diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index 5508344..98d9c8b 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -23,6 +23,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
+#include <linux/spi/pxa2xx_spi.h>
 #include <linux/dma-mapping.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
@@ -35,9 +36,6 @@
 #include <asm/irq.h>
 #include <asm/delay.h>
 
-#include <mach/dma.h>
-#include <plat/ssp.h>
-#include <mach/pxa2xx_spi.h>
 
 MODULE_AUTHOR("Stephen Street");
 MODULE_DESCRIPTION("PXA2xx SSP SPI Controller");
diff --git a/arch/arm/plat-pxa/include/plat/ssp.h b/include/linux/pxa2xx_ssp.h
similarity index 98%
rename from arch/arm/plat-pxa/include/plat/ssp.h
rename to include/linux/pxa2xx_ssp.h
index 21c12ca..84465d4 100644
--- a/arch/arm/plat-pxa/include/plat/ssp.h
+++ b/include/linux/pxa2xx_ssp.h
@@ -1,5 +1,5 @@
 /*
- *  ssp.h
+ *  pxa2xx_ssp.h
  *
  *  Copyright (C) 2003 Russell King, All Rights Reserved.
  *
@@ -16,8 +16,8 @@
  *       PXA3xx     SSP1, SSP2, SSP3, SSP4
  */
 
-#ifndef __ASM_ARCH_SSP_H
-#define __ASM_ARCH_SSP_H
+#ifndef __LINUX_SSP_H
+#define __LINUX_SSP_H
 
 #include <linux/list.h>
 #include <linux/io.h>
@@ -184,4 +184,4 @@ static inline u32 pxa_ssp_read_reg(struct ssp_device *dev, u32 reg)
 
 struct ssp_device *pxa_ssp_request(int port, const char *label);
 void pxa_ssp_free(struct ssp_device *);
-#endif /* __ASM_ARCH_SSP_H */
+#endif
diff --git a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h b/include/linux/spi/pxa2xx_spi.h
similarity index 92%
rename from arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
rename to include/linux/spi/pxa2xx_spi.h
index b87cecd..471ed68 100644
--- a/arch/arm/mach-pxa/include/mach/pxa2xx_spi.h
+++ b/include/linux/spi/pxa2xx_spi.h
@@ -15,9 +15,11 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+#ifndef __linux_pxa2xx_spi_h
+#define __linux_pxa2xx_spi_h
 
-#ifndef PXA2XX_SPI_H_
-#define PXA2XX_SPI_H_
+#include <linux/pxa2xx_ssp.h>
+#include <mach/dma.h>
 
 #define PXA2XX_CS_ASSERT (0x01)
 #define PXA2XX_CS_DEASSERT (0x02)
@@ -44,4 +46,4 @@ struct pxa2xx_spi_chip {
 
 extern void pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info);
 
-#endif /*PXA2XX_SPI_H_*/
+#endif
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index b439eee..8ad93ee 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -20,6 +20,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/pxa2xx_ssp.h>
 
 #include <asm/irq.h>
 
@@ -33,7 +34,6 @@
 #include <mach/hardware.h>
 #include <mach/dma.h>
 #include <mach/audio.h>
-#include <plat/ssp.h>
 
 #include "../../arm/pxa2xx-pcm.h"
 #include "pxa-ssp.h"
-- 
1.7.3.2
