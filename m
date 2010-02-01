From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon,  1 Feb 2010 17:01:35 +0100
Subject: [PATCH 8/8] imx/mx25: rename files defining a machine to mach-$mach.c
In-Reply-To: <20100201155625.GA22413@pengutronix.de>
References: <20100201155625.GA22413@pengutronix.de>
Message-ID: <1265040095-31656-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mx25/Makefile       |    2 +-
 arch/arm/mach-mx25/mach-mx25pdk.c |  119 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mx25/mx25pdk.c      |  119 -------------------------------------
 3 files changed, 120 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/mach-mx25/mach-mx25pdk.c
 delete mode 100644 arch/arm/mach-mx25/mx25pdk.c

diff --git a/arch/arm/mach-mx25/Makefile b/arch/arm/mach-mx25/Makefile
index fe23836..10cebc5 100644
--- a/arch/arm/mach-mx25/Makefile
+++ b/arch/arm/mach-mx25/Makefile
@@ -1,3 +1,3 @@
 obj-y				:= mm.o devices.o
 obj-$(CONFIG_ARCH_MX25)		+= clock.o
-obj-$(CONFIG_MACH_MX25_3DS)	+= mx25pdk.o
+obj-$(CONFIG_MACH_MX25_3DS)	+= mach-mx25pdk.o
diff --git a/arch/arm/mach-mx25/mach-mx25pdk.c b/arch/arm/mach-mx25/mach-mx25pdk.c
new file mode 100644
index 0000000..10be38e
--- /dev/null
+++ b/arch/arm/mach-mx25/mach-mx25pdk.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor,
+ * Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/fec.h>
+#include <linux/platform_device.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/memory.h>
+#include <asm/mach/map.h>
+#include <mach/common.h>
+#include <mach/imx-uart.h>
+#include <mach/mx25.h>
+#include <mach/mxc_nand.h>
+#include "devices.h"
+#include <mach/iomux.h>
+
+static struct imxuart_platform_data uart_pdata = {
+	.flags = IMXUART_HAVE_RTSCTS,
+};
+
+static struct pad_desc mx25pdk_pads[] = {
+	MX25_PAD_FEC_MDC__FEC_MDC,
+	MX25_PAD_FEC_MDIO__FEC_MDIO,
+	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
+	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
+	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
+	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
+	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
+	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
+	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
+	MX25_PAD_A17__GPIO_2_3, /* FEC_EN, GPIO 35 */
+	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
+};
+
+static struct fec_platform_data mx25_fec_pdata = {
+        .phy    = PHY_INTERFACE_MODE_RMII,
+};
+
+#define FEC_ENABLE_GPIO		35
+#define FEC_RESET_B_GPIO	104
+
+static void __init mx25pdk_fec_reset(void)
+{
+	gpio_request(FEC_ENABLE_GPIO, "FEC PHY enable");
+	gpio_request(FEC_RESET_B_GPIO, "FEC PHY reset");
+
+	gpio_direction_output(FEC_ENABLE_GPIO, 0);  /* drop PHY power */
+	gpio_direction_output(FEC_RESET_B_GPIO, 0); /* assert reset */
+	udelay(2);
+
+	/* turn on PHY power and lift reset */
+	gpio_set_value(FEC_ENABLE_GPIO, 1);
+	gpio_set_value(FEC_RESET_B_GPIO, 1);
+}
+
+static struct mxc_nand_platform_data mx25pdk_nand_board_info = {
+	.width		= 1,
+	.hw_ecc		= 1,
+	.flash_bbt	= 1,
+};
+
+static void __init mx25pdk_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
+			ARRAY_SIZE(mx25pdk_pads));
+
+	mxc_register_device(&mxc_uart_device0, &uart_pdata);
+	mxc_register_device(&mxc_usbh2, NULL);
+	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
+	mxc_register_device(&mx25_rtc_device, NULL);
+
+	mx25pdk_fec_reset();
+	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
+}
+
+static void __init mx25pdk_timer_init(void)
+{
+	mx25_clocks_init();
+}
+
+static struct sys_timer mx25pdk_timer = {
+	.init   = mx25pdk_timer_init,
+};
+
+MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
+	/* Maintainer: Freescale Semiconductor, Inc. */
+	.phys_io	= MX25_AIPS1_BASE_ADDR,
+	.io_pg_offst	= ((MX25_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
+	.boot_params    = MX25_PHYS_OFFSET + 0x100,
+	.map_io         = mx25_map_io,
+	.init_irq       = mx25_init_irq,
+	.init_machine   = mx25pdk_init,
+	.timer          = &mx25pdk_timer,
+MACHINE_END
+
diff --git a/arch/arm/mach-mx25/mx25pdk.c b/arch/arm/mach-mx25/mx25pdk.c
deleted file mode 100644
index 10be38e..0000000
--- a/arch/arm/mach-mx25/mx25pdk.c
+++ /dev/null
@@ -1,119 +0,0 @@
-/*
- * Copyright 2009 Sascha Hauer, <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor,
- * Boston, MA  02110-1301, USA.
- */
-
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/clk.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/fec.h>
-#include <linux/platform_device.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/time.h>
-#include <asm/memory.h>
-#include <asm/mach/map.h>
-#include <mach/common.h>
-#include <mach/imx-uart.h>
-#include <mach/mx25.h>
-#include <mach/mxc_nand.h>
-#include "devices.h"
-#include <mach/iomux.h>
-
-static struct imxuart_platform_data uart_pdata = {
-	.flags = IMXUART_HAVE_RTSCTS,
-};
-
-static struct pad_desc mx25pdk_pads[] = {
-	MX25_PAD_FEC_MDC__FEC_MDC,
-	MX25_PAD_FEC_MDIO__FEC_MDIO,
-	MX25_PAD_FEC_TDATA0__FEC_TDATA0,
-	MX25_PAD_FEC_TDATA1__FEC_TDATA1,
-	MX25_PAD_FEC_TX_EN__FEC_TX_EN,
-	MX25_PAD_FEC_RDATA0__FEC_RDATA0,
-	MX25_PAD_FEC_RDATA1__FEC_RDATA1,
-	MX25_PAD_FEC_RX_DV__FEC_RX_DV,
-	MX25_PAD_FEC_TX_CLK__FEC_TX_CLK,
-	MX25_PAD_A17__GPIO_2_3, /* FEC_EN, GPIO 35 */
-	MX25_PAD_D12__GPIO_4_8, /* FEC_RESET_B, GPIO 104 */
-};
-
-static struct fec_platform_data mx25_fec_pdata = {
-        .phy    = PHY_INTERFACE_MODE_RMII,
-};
-
-#define FEC_ENABLE_GPIO		35
-#define FEC_RESET_B_GPIO	104
-
-static void __init mx25pdk_fec_reset(void)
-{
-	gpio_request(FEC_ENABLE_GPIO, "FEC PHY enable");
-	gpio_request(FEC_RESET_B_GPIO, "FEC PHY reset");
-
-	gpio_direction_output(FEC_ENABLE_GPIO, 0);  /* drop PHY power */
-	gpio_direction_output(FEC_RESET_B_GPIO, 0); /* assert reset */
-	udelay(2);
-
-	/* turn on PHY power and lift reset */
-	gpio_set_value(FEC_ENABLE_GPIO, 1);
-	gpio_set_value(FEC_RESET_B_GPIO, 1);
-}
-
-static struct mxc_nand_platform_data mx25pdk_nand_board_info = {
-	.width		= 1,
-	.hw_ecc		= 1,
-	.flash_bbt	= 1,
-};
-
-static void __init mx25pdk_init(void)
-{
-	mxc_iomux_v3_setup_multiple_pads(mx25pdk_pads,
-			ARRAY_SIZE(mx25pdk_pads));
-
-	mxc_register_device(&mxc_uart_device0, &uart_pdata);
-	mxc_register_device(&mxc_usbh2, NULL);
-	mxc_register_device(&mxc_nand_device, &mx25pdk_nand_board_info);
-	mxc_register_device(&mx25_rtc_device, NULL);
-
-	mx25pdk_fec_reset();
-	mxc_register_device(&mx25_fec_device, &mx25_fec_pdata);
-}
-
-static void __init mx25pdk_timer_init(void)
-{
-	mx25_clocks_init();
-}
-
-static struct sys_timer mx25pdk_timer = {
-	.init   = mx25pdk_timer_init,
-};
-
-MACHINE_START(MX25_3DS, "Freescale MX25PDK (3DS)")
-	/* Maintainer: Freescale Semiconductor, Inc. */
-	.phys_io	= MX25_AIPS1_BASE_ADDR,
-	.io_pg_offst	= ((MX25_AIPS1_BASE_ADDR_VIRT) >> 18) & 0xfffc,
-	.boot_params    = MX25_PHYS_OFFSET + 0x100,
-	.map_io         = mx25_map_io,
-	.init_irq       = mx25_init_irq,
-	.init_machine   = mx25pdk_init,
-	.timer          = &mx25pdk_timer,
-MACHINE_END
-
-- 
1.6.6
