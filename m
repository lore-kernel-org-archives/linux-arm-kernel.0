From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Tue,  3 Jul 2012 14:34:25 +0200
Subject: [PATCH 2/3] ARM: dts: dove: Add devicetree-based board setup
In-Reply-To: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <1341318868-24567-4-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree-based board setup files for Marvell Dove and
currently supported boards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-dove/board-cm-a510.c |   86 +++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/board-dove-db.c |   92 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/board-dt.c      |   73 ++++++++++++++++++++++++++++
 3 files changed, 251 insertions(+)
 create mode 100644 arch/arm/mach-dove/board-cm-a510.c
 create mode 100644 arch/arm/mach-dove/board-dove-db.c
 create mode 100644 arch/arm/mach-dove/board-dt.c

diff --git a/arch/arm/mach-dove/board-cm-a510.c b/arch/arm/mach-dove/board-cm-a510.c
new file mode 100644
index 0000000..1eda62f
--- /dev/null
+++ b/arch/arm/mach-dove/board-cm-a510.c
@@ -0,0 +1,86 @@
+/*
+ * arch/arm/mach-dove/board-cm-a510.c
+ *
+ * Copyright (C) 2010 CompuLab, Ltd.
+ * Konstantin Sinyuk <kostyas@compulab.co.il>
+ *
+ * Compulab CM-A510 Board Init
+ * for drivers not converted to flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <mach/dove.h>
+
+#include "common.h"
+
+static struct mv643xx_eth_platform_data cm_a510_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
+};
+
+static struct mv_sata_platform_data cm_a510_sata_data = {
+	.n_ports        = 1,
+};
+
+/*
+ * SPI Devices:
+ * SPI0: 1M Flash Winbond w25q32bv
+ */
+static const struct flash_platform_data cm_a510_spi_flash_data = {
+	.type		= "w25q32bv",
+};
+
+static struct spi_board_info __initdata cm_a510_spi_flash_info[] = {
+	{
+		.modalias       = "m25p80",
+		.platform_data  = &cm_a510_spi_flash_data,
+		.irq            = -1,
+		.max_speed_hz   = 20000000,
+		.bus_num        = 0,
+		.chip_select    = 0,
+	},
+};
+
+static int __init cm_a510_pci_init(void)
+{
+	if (machine_is_cm_a510())
+		dove_pcie_init(1, 1);
+
+	return 0;
+}
+
+subsys_initcall(cm_a510_pci_init);
+
+/* Board Init */
+void __init cm_a510_init(void)
+{
+	/*
+	 * Basic Dove setup. Needs to be called early.
+	 */
+	dove_init();
+
+	dove_ge00_init(&cm_a510_ge00_data);
+	dove_ehci0_init();
+	dove_ehci1_init();
+	dove_sata_init(&cm_a510_sata_data);
+	dove_sdio0_init();
+	dove_sdio1_init();
+	dove_spi0_init();
+	dove_spi1_init();
+	dove_i2c_init();
+	spi_register_board_info(cm_a510_spi_flash_info,
+				ARRAY_SIZE(cm_a510_spi_flash_info));
+}
diff --git a/arch/arm/mach-dove/board-dove-db.c b/arch/arm/mach-dove/board-dove-db.c
new file mode 100644
index 0000000..21094d4
--- /dev/null
+++ b/arch/arm/mach-dove/board-dove-db.c
@@ -0,0 +1,92 @@
+/*
+ * arch/arm/mach-dove/board-dove-db.c
+ *
+ * Marvell DB-MV88AP510-BP Development Board Init
+ * for drivers not converted to flattened device tree yet.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/nand.h>
+#include <linux/timer.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/i2c.h>
+#include <linux/pci.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/gpio.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/dove.h>
+#include "common.h"
+
+static struct mv643xx_eth_platform_data dove_db_ge00_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR_DEFAULT,
+};
+
+static struct mv_sata_platform_data dove_db_sata_data = {
+	.n_ports        = 1,
+};
+
+/*****************************************************************************
+ * SPI Devices:
+ *     SPI0: 4M Flash ST-M25P32-VMF6P
+ ****************************************************************************/
+static const struct flash_platform_data dove_db_spi_flash_data = {
+	.type		= "m25p64",
+};
+
+static struct spi_board_info __initdata dove_db_spi_flash_info[] = {
+	{
+		.modalias       = "m25p80",
+		.platform_data  = &dove_db_spi_flash_data,
+		.irq            = -1,
+		.max_speed_hz   = 20000000,
+		.bus_num        = 0,
+		.chip_select    = 0,
+	},
+};
+
+/*****************************************************************************
+ * PCI
+ ****************************************************************************/
+static int __init dove_db_pci_init(void)
+{
+	if (machine_is_dove_db())
+		dove_pcie_init(1, 1);
+
+	return 0;
+}
+
+subsys_initcall(dove_db_pci_init);
+
+/*****************************************************************************
+ * Board Init
+ ****************************************************************************/
+void __init dove_db_init(void)
+{
+	/*
+	 * Basic Dove setup. Needs to be called early.
+	 */
+	dove_init();
+
+	dove_ge00_init(&dove_db_ge00_data);
+	dove_ehci0_init();
+	dove_ehci1_init();
+	dove_sata_init(&dove_db_sata_data);
+	dove_sdio0_init();
+	dove_sdio1_init();
+	dove_spi0_init();
+	dove_spi1_init();
+	dove_i2c_init();
+	spi_register_board_info(dove_db_spi_flash_info,
+				ARRAY_SIZE(dove_db_spi_flash_info));
+}
diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
new file mode 100644
index 0000000..7b5d481
--- /dev/null
+++ b/arch/arm/mach-dove/board-dt.c
@@ -0,0 +1,73 @@
+/*
+ * Copyright 2012 (C)
+ *   Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
+ *
+ * arch/arm/mach-dove/board-dt.c
+ *
+ * Flattened Device Tree board initialization
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/kexec.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/bridge-regs.h>
+#include "common.h"
+
+static struct of_device_id dove_dt_match_table[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ }
+};
+
+static void __init dove_dt_init(void)
+{
+	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
+		(dove_tclk + 499999) / 1000000);
+
+#ifdef CONFIG_CACHE_TAUROS2
+	tauros2_init();
+#endif
+	dove_setup_cpu_mbus();
+
+	/* Setup root of clk tree */
+	dove_clk_init();
+
+	/* internal devices that every board has */
+	dove_xor0_init();
+	dove_xor1_init();
+
+	if (of_machine_is_compatible("marvell,dove-db"))
+		dove_db_init();
+
+	if (of_machine_is_compatible("compulab,cm-a510"))
+		cm_a510_init();
+
+	of_platform_populate(NULL, dove_dt_match_table, NULL, NULL);
+}
+
+static const char * const dove_dt_board_compat[] = {
+	"marvell,dove-db",
+	"compulab,cm-a510",
+	NULL
+};
+
+DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
+	/* Maintainer:  Sebastian Hesselbarth
+	 *              <sebastian.hesselbarth@googlemail.com>
+	 */
+	.map_io		= dove_map_io,
+	.init_early	= dove_init_early,
+	.init_irq	= dove_init_irq,
+	.timer		= &dove_timer,
+	.init_machine	= dove_dt_init,
+	.restart	= dove_restart,
+	.dt_compat	= dove_dt_board_compat,
+MACHINE_END
+
-- 
1.7.10
