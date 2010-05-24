From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 24 May 2010 18:57:19 +0530
Subject: [PATCH 7/7] mop500: add basic pin configuration
In-Reply-To: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
References: <1274707639-28285-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1274707639-28285-7-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly added infrastructure to configure the SSP0 and I2C[0-3]
pins on the MOP500 board.

The u8500_init_devices() call needed to be moved up in order to register
the GPIO device first.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 072196c..b36dbe8 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/pl022.h>
 #include <linux/spi/spi.h>
@@ -20,12 +21,32 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <plat/pincfg.h>
 #include <plat/i2c.h>
 
+#include "db8500-pins.h"
 #include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 
+static pin_cfg_t mop500_pins[] = {
+	/* SSP0 */
+	GPIO143_SSP0_CLK,
+	GPIO144_SSP0_FRM,
+	GPIO145_SSP0_RXD,
+	GPIO146_SSP0_TXD,
+
+	/* I2C */
+	GPIO147_I2C0_SCL,
+	GPIO148_I2C0_SDA,
+	GPIO16_I2C1_SCL,
+	GPIO17_I2C1_SDA,
+	GPIO10_I2C2_SDA,
+	GPIO11_I2C2_SCL,
+	GPIO229_I2C3_SDA,
+	GPIO230_I2C3_SCL,
+};
+
 static void ab4500_spi_cs_control(u32 command)
 {
 	/* set the FRM signal, which is CS  - TODO */
@@ -118,6 +139,10 @@ static void __init u8500_init_machine(void)
 {
 	int i;
 
+	u8500_init_devices();
+
+	nmk_config_pins(mop500_pins, ARRAY_SIZE(mop500_pins));
+
 	u8500_i2c0_device.dev.platform_data = &u8500_i2c0_data;
 	ux500_i2c1_device.dev.platform_data = &u8500_i2c1_data;
 	ux500_i2c2_device.dev.platform_data = &u8500_i2c2_data;
@@ -133,8 +158,6 @@ static void __init u8500_init_machine(void)
 
 	spi_register_board_info(u8500_spi_devices,
 			ARRAY_SIZE(u8500_spi_devices));
-
-	u8500_init_devices();
 }
 
 MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
-- 
1.7.0
