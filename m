From: tbm@cyrius.com (Martin Michlmayr)
Date: Thu, 5 Nov 2009 20:27:46 +0000
Subject: [PATCH] Kirkwood: Remove code duplication in QNAP setup files
Message-ID: <20091105202746.GA11082@deprecation.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the code duplication found in the setup files of TS-219 and
TS-41x.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 0c79ced..9f2f67b 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -5,8 +5,8 @@ obj-$(CONFIG_MACH_RD88F6192_NAS)	+= rd88f6192-nas-setup.o
 obj-$(CONFIG_MACH_RD88F6281)		+= rd88f6281-setup.o
 obj-$(CONFIG_MACH_MV88F6281GTW_GE)	+= mv88f6281gtw_ge-setup.o
 obj-$(CONFIG_MACH_SHEEVAPLUG)		+= sheevaplug-setup.o
-obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o
-obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o
+obj-$(CONFIG_MACH_TS219)		+= ts219-setup.o tsx1x-common.o
+obj-$(CONFIG_MACH_TS41X)		+= ts41x-setup.o tsx1x-common.o
 obj-$(CONFIG_MACH_OPENRD_BASE)		+= openrd_base-setup.o
 
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
diff --git a/arch/arm/mach-kirkwood/ts219-setup.c b/arch/arm/mach-kirkwood/ts219-setup.c
index a7c209d..2830f0f 100644
--- a/arch/arm/mach-kirkwood/ts219-setup.c
+++ b/arch/arm/mach-kirkwood/ts219-setup.c
@@ -14,87 +14,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
 #include <linux/i2c.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
-#include <linux/timex.h>
-#include <linux/serial_reg.h>
-#include <linux/pci.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
-
-/****************************************************************************
- * 16 MiB NOR flash. The struct mtd_partition is not in the same order as the
- *     partitions on the device because we want to keep compatability with
- *     the QNAP firmware.
- * Layout as used by QNAP:
- *  0x00000000-0x00080000 : "U-Boot"
- *  0x00200000-0x00400000 : "Kernel"
- *  0x00400000-0x00d00000 : "RootFS"
- *  0x00d00000-0x01000000 : "RootFS2"
- *  0x00080000-0x000c0000 : "U-Boot Config"
- *  0x000c0000-0x00200000 : "NAS Config"
- *
- * We'll use "RootFS1" instead of "RootFS" to stay compatible with the layout
- * used by the QNAP TS-109/TS-209.
- *
- ***************************************************************************/
-
-static struct mtd_partition qnap_ts219_partitions[] = {
-	{
-		.name		= "U-Boot",
-		.size		= 0x00080000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,
-	}, {
-		.name		= "Kernel",
-		.size		= 0x00200000,
-		.offset		= 0x00200000,
-	}, {
-		.name		= "RootFS1",
-		.size		= 0x00900000,
-		.offset		= 0x00400000,
-	}, {
-		.name		= "RootFS2",
-		.size		= 0x00300000,
-		.offset		= 0x00d00000,
-	}, {
-		.name		= "U-Boot Config",
-		.size		= 0x00040000,
-		.offset		= 0x00080000,
-	}, {
-		.name		= "NAS Config",
-		.size		= 0x00140000,
-		.offset		= 0x000c0000,
-	},
-};
-
-static const struct flash_platform_data qnap_ts219_flash = {
-	.type		= "m25p128",
-	.name		= "spi_flash",
-	.parts		= qnap_ts219_partitions,
-	.nr_parts	= ARRAY_SIZE(qnap_ts219_partitions),
-};
-
-static struct spi_board_info __initdata qnap_ts219_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &qnap_ts219_flash,
-		.irq		= -1,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
+#include "tsx1x-common.h"
 
 static struct i2c_board_info __initdata qnap_ts219_i2c_rtc = {
 	I2C_BOARD_INFO("s35390a", 0x30),
@@ -156,33 +86,6 @@ static unsigned int qnap_ts219_mpp_config[] __initdata = {
 	0
 };
 
-
-/*****************************************************************************
- * QNAP TS-x19 specific power off method via UART1-attached PIC
- ****************************************************************************/
-
-#define UART1_REG(x)	(UART1_VIRT_BASE + ((UART_##x) << 2))
-
-void qnap_ts219_power_off(void)
-{
-	/* 19200 baud divisor */
-	const unsigned divisor = ((kirkwood_tclk + (8 * 19200)) / (16 * 19200));
-
-	pr_info("%s: triggering power-off...\n", __func__);
-
-	/* hijack UART1 and reset into sane state (19200,8n1) */
-	writel(0x83, UART1_REG(LCR));
-	writel(divisor & 0xff, UART1_REG(DLL));
-	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
-	writel(0x03, UART1_REG(LCR));
-	writel(0x00, UART1_REG(IER));
-	writel(0x00, UART1_REG(FCR));
-	writel(0x00, UART1_REG(MCR));
-
-	/* send the power-off command 'A' to PIC */
-	writel('A', UART1_REG(TX));
-}
-
 static void __init qnap_ts219_init(void)
 {
 	/*
@@ -193,9 +96,7 @@ static void __init qnap_ts219_init(void)
 
 	kirkwood_uart0_init();
 	kirkwood_uart1_init(); /* A PIC controller is connected here. */
-	spi_register_board_info(qnap_ts219_spi_slave_info,
-				ARRAY_SIZE(qnap_ts219_spi_slave_info));
-	kirkwood_spi_init();
+	qnap_tsx1x_register_flash();
 	kirkwood_i2c_init();
 	i2c_register_board_info(0, &qnap_ts219_i2c_rtc, 1);
 	kirkwood_ge00_init(&qnap_ts219_ge00_data);
@@ -203,7 +104,7 @@ static void __init qnap_ts219_init(void)
 	kirkwood_ehci_init();
 	platform_device_register(&qnap_ts219_button_device);
 
-	pm_power_off = qnap_ts219_power_off;
+	pm_power_off = qnap_tsx1x_power_off;
 
 }
 
diff --git a/arch/arm/mach-kirkwood/ts41x-setup.c b/arch/arm/mach-kirkwood/ts41x-setup.c
index a1972c9..de49c2d 100644
--- a/arch/arm/mach-kirkwood/ts41x-setup.c
+++ b/arch/arm/mach-kirkwood/ts41x-setup.c
@@ -14,87 +14,17 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/mtd/physmap.h>
-#include <linux/spi/flash.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/orion_spi.h>
 #include <linux/i2c.h>
 #include <linux/mv643xx_eth.h>
 #include <linux/ata_platform.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
-#include <linux/timex.h>
-#include <linux/serial_reg.h>
-#include <linux/pci.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
 #include "common.h"
 #include "mpp.h"
-
-/****************************************************************************
- * 16 MiB NOR flash. The struct mtd_partition is not in the same order as the
- *     partitions on the device because we want to keep compatability with
- *     the QNAP firmware.
- * Layout as used by QNAP:
- *  0x00000000-0x00080000 : "U-Boot"
- *  0x00200000-0x00400000 : "Kernel"
- *  0x00400000-0x00d00000 : "RootFS"
- *  0x00d00000-0x01000000 : "RootFS2"
- *  0x00080000-0x000c0000 : "U-Boot Config"
- *  0x000c0000-0x00200000 : "NAS Config"
- *
- * We'll use "RootFS1" instead of "RootFS" to stay compatible with the layout
- * used by the QNAP TS-109/TS-209.
- *
- ***************************************************************************/
-
-static struct mtd_partition qnap_ts41x_partitions[] = {
-	{
-		.name		= "U-Boot",
-		.size		= 0x00080000,
-		.offset		= 0,
-		.mask_flags	= MTD_WRITEABLE,
-	}, {
-		.name		= "Kernel",
-		.size		= 0x00200000,
-		.offset		= 0x00200000,
-	}, {
-		.name		= "RootFS1",
-		.size		= 0x00900000,
-		.offset		= 0x00400000,
-	}, {
-		.name		= "RootFS2",
-		.size		= 0x00300000,
-		.offset		= 0x00d00000,
-	}, {
-		.name		= "U-Boot Config",
-		.size		= 0x00040000,
-		.offset		= 0x00080000,
-	}, {
-		.name		= "NAS Config",
-		.size		= 0x00140000,
-		.offset		= 0x000c0000,
-	},
-};
-
-static const struct flash_platform_data qnap_ts41x_flash = {
-	.type		= "m25p128",
-	.name		= "spi_flash",
-	.parts		= qnap_ts41x_partitions,
-	.nr_parts	= ARRAY_SIZE(qnap_ts41x_partitions),
-};
-
-static struct spi_board_info __initdata qnap_ts41x_spi_slave_info[] = {
-	{
-		.modalias	= "m25p80",
-		.platform_data	= &qnap_ts41x_flash,
-		.irq		= -1,
-		.max_speed_hz	= 20000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-	},
-};
+#include "tsx1x-common.h"
 
 static struct i2c_board_info __initdata qnap_ts41x_i2c_rtc = {
 	I2C_BOARD_INFO("s35390a", 0x30),
@@ -180,33 +110,6 @@ static unsigned int qnap_ts41x_mpp_config[] __initdata = {
 	0
 };
 
-
-/*****************************************************************************
- * QNAP TS-x19 specific power off method via UART1-attached PIC
- ****************************************************************************/
-
-#define UART1_REG(x)	(UART1_VIRT_BASE + ((UART_##x) << 2))
-
-void qnap_ts41x_power_off(void)
-{
-	/* 19200 baud divisor */
-	const unsigned divisor = ((kirkwood_tclk + (8 * 19200)) / (16 * 19200));
-
-	pr_info("%s: triggering power-off...\n", __func__);
-
-	/* hijack UART1 and reset into sane state (19200,8n1) */
-	writel(0x83, UART1_REG(LCR));
-	writel(divisor & 0xff, UART1_REG(DLL));
-	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
-	writel(0x03, UART1_REG(LCR));
-	writel(0x00, UART1_REG(IER));
-	writel(0x00, UART1_REG(FCR));
-	writel(0x00, UART1_REG(MCR));
-
-	/* send the power-off command 'A' to PIC */
-	writel('A', UART1_REG(TX));
-}
-
 static void __init qnap_ts41x_init(void)
 {
 	/*
@@ -217,9 +120,7 @@ static void __init qnap_ts41x_init(void)
 
 	kirkwood_uart0_init();
 	kirkwood_uart1_init(); /* A PIC controller is connected here. */
-	spi_register_board_info(qnap_ts41x_spi_slave_info,
-				ARRAY_SIZE(qnap_ts41x_spi_slave_info));
-	kirkwood_spi_init();
+	qnap_tsx1x_register_flash();
 	kirkwood_i2c_init();
 	i2c_register_board_info(0, &qnap_ts41x_i2c_rtc, 1);
 	kirkwood_ge00_init(&qnap_ts41x_ge00_data);
@@ -228,7 +129,7 @@ static void __init qnap_ts41x_init(void)
 	kirkwood_ehci_init();
 	platform_device_register(&qnap_ts41x_button_device);
 
-	pm_power_off = qnap_ts41x_power_off;
+	pm_power_off = qnap_tsx1x_power_off;
 
 }
 
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.c b/arch/arm/mach-kirkwood/tsx1x-common.c
new file mode 100644
index 0000000..62a78bc
--- /dev/null
+++ b/arch/arm/mach-kirkwood/tsx1x-common.c
@@ -0,0 +1,113 @@
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <linux/serial_reg.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+
+/*
+ * QNAP TS-x1x Boards flash
+ */
+
+/****************************************************************************
+ * 16 MiB NOR flash. The struct mtd_partition is not in the same order as the
+ *     partitions on the device because we want to keep compatability with
+ *     the QNAP firmware.
+ * Layout as used by QNAP:
+ *  0x00000000-0x00080000 : "U-Boot"
+ *  0x00200000-0x00400000 : "Kernel"
+ *  0x00400000-0x00d00000 : "RootFS"
+ *  0x00d00000-0x01000000 : "RootFS2"
+ *  0x00080000-0x000c0000 : "U-Boot Config"
+ *  0x000c0000-0x00200000 : "NAS Config"
+ *
+ * We'll use "RootFS1" instead of "RootFS" to stay compatible with the layout
+ * used by the QNAP TS-109/TS-209.
+ *
+ ***************************************************************************/
+
+struct mtd_partition qnap_tsx1x_partitions[] = {
+	{
+		.name		= "U-Boot",
+		.size		= 0x00080000,
+		.offset		= 0,
+		.mask_flags	= MTD_WRITEABLE,
+	}, {
+		.name		= "Kernel",
+		.size		= 0x00200000,
+		.offset		= 0x00200000,
+	}, {
+		.name		= "RootFS1",
+		.size		= 0x00900000,
+		.offset		= 0x00400000,
+	}, {
+		.name		= "RootFS2",
+		.size		= 0x00300000,
+		.offset		= 0x00d00000,
+	}, {
+		.name		= "U-Boot Config",
+		.size		= 0x00040000,
+		.offset		= 0x00080000,
+	}, {
+		.name		= "NAS Config",
+		.size		= 0x00140000,
+		.offset		= 0x000c0000,
+	},
+};
+
+const struct flash_platform_data qnap_tsx1x_flash = {
+	.type		= "m25p128",
+	.name		= "spi_flash",
+	.parts		= qnap_tsx1x_partitions,
+	.nr_parts	= ARRAY_SIZE(qnap_tsx1x_partitions),
+};
+
+struct spi_board_info __initdata qnap_tsx1x_spi_slave_info[] = {
+	{
+		.modalias	= "m25p80",
+		.platform_data	= &qnap_tsx1x_flash,
+		.irq		= -1,
+		.max_speed_hz	= 20000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+	},
+};
+
+void qnap_tsx1x_register_flash(void)
+{
+	spi_register_board_info(qnap_tsx1x_spi_slave_info,
+				ARRAY_SIZE(qnap_tsx1x_spi_slave_info));
+	kirkwood_spi_init();
+}
+
+
+/*****************************************************************************
+ * QNAP TS-x1x specific power off method via UART1-attached PIC
+ ****************************************************************************/
+
+#define UART1_REG(x)	(UART1_VIRT_BASE + ((UART_##x) << 2))
+
+void qnap_tsx1x_power_off(void)
+{
+	/* 19200 baud divisor */
+	const unsigned divisor = ((kirkwood_tclk + (8 * 19200)) / (16 * 19200));
+
+	pr_info("%s: triggering power-off...\n", __func__);
+
+	/* hijack UART1 and reset into sane state (19200,8n1) */
+	writel(0x83, UART1_REG(LCR));
+	writel(divisor & 0xff, UART1_REG(DLL));
+	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
+	writel(0x03, UART1_REG(LCR));
+	writel(0x00, UART1_REG(IER));
+	writel(0x00, UART1_REG(FCR));
+	writel(0x00, UART1_REG(MCR));
+
+	/* send the power-off command 'A' to PIC */
+	writel('A', UART1_REG(TX));
+}
+
diff --git a/arch/arm/mach-kirkwood/tsx1x-common.h b/arch/arm/mach-kirkwood/tsx1x-common.h
new file mode 100644
index 0000000..9a59296
--- /dev/null
+++ b/arch/arm/mach-kirkwood/tsx1x-common.h
@@ -0,0 +1,7 @@
+#ifndef __ARCH_KIRKWOOD_TSX1X_COMMON_H
+#define __ARCH_KIRKWOOD_TSX1X_COMMON_H
+
+extern void qnap_tsx1x_register_flash(void);
+extern void qnap_tsx1x_power_off(void);
+
+#endif

-- 
Martin Michlmayr
http://www.cyrius.com/
