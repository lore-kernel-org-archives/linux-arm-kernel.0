From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 05 Feb 2010 09:57:55 +1300
Subject: [PATCH] ep93xx: Add support for Snapper CL15 module
Message-ID: <4B6B34D3.1010704@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Bluewater Systems Snapper CL15 single board computer
module.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
Cc: Hartley Sweeten <hartleys@visionengravers.com>

---

diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 9167c3d..71eabca 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -168,6 +168,13 @@ config MACH_TS72XX
 	  Say 'Y' here if you want your kernel to support the
 	  Technologic Systems TS-72xx board.
 
+config MACH_SNAPPER_CL15
+	bool "Support Bluewater Systems Snapper CL15 Module"
+	depends on EP93XX_SDCE0_PHYS_OFFSET
+	help
+	  Say 'Y' here if you want your kernel to support the Bluewater
+	  Systems Snapper CL15 Module.
+
 choice
 	prompt "Select a UART for early kernel messages"
 
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
index eae6199..41e5d85 100644
--- a/arch/arm/mach-ep93xx/Makefile
+++ b/arch/arm/mach-ep93xx/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
 obj-$(CONFIG_MACH_GESBC9312)	+= gesbc9312.o
 obj-$(CONFIG_MACH_MICRO9)	+= micro9.o
 obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
+obj-$(CONFIG_MACH_SNAPPER_CL15)	+= snappercl15.o
diff --git a/arch/arm/mach-ep93xx/snappercl15.c b/arch/arm/mach-ep93xx/snappercl15.c
new file mode 100644
index 0000000..2805f4d
--- /dev/null
+++ b/arch/arm/mach-ep93xx/snappercl15.c
@@ -0,0 +1,185 @@
+/*
+ * arch/arm/mach-ep93xx/snappercl15.c
+ * Bluewater Systems Snapper CL15 system module
+ *
+ * Copyright (C) 2009 Bluewater Systems Ltd
+ * Author: Ryan Mallon <ryan@bluewatersys.com>
+ *
+ * NAND code adapted from driver by:
+ *   Andre Renaud <andre@bluewatersys.com>
+ *   James R. McKaskill
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/fb.h>
+
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
+#include <mach/hardware.h>
+#include <mach/fb.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#define SNAPPERCL15_NAND_BASE	(EP93XX_CS7_PHYS_BASE + 0x01000000)
+
+#define SNAPPERCL15_NAND_CTRL	(1 << 6)
+#define SNAPPERCL15_NAND_WPN	(1 << 8)
+#define SNAPPERCL15_NAND_ALE	(1 << 9)
+#define SNAPPERCL15_NAND_CLE	(1 << 10)
+#define SNAPPERCL15_NAND_CEN	(1 << 11)
+#define SNAPPERCL15_NAND_RDY	(1 << 14)
+
+#define NAND_CTRL_ADDR(chip)						\
+	((void __iomem *)((unsigned long)chip->IO_ADDR_W + 0x40))
+
+static unsigned long nand_state;
+
+static void snappercl15_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+				      unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+	static int first = 1;
+	unsigned set;
+
+	if (first) {
+		nand_state = SNAPPERCL15_NAND_CEN | SNAPPERCL15_NAND_WPN;
+		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
+		first = 0;
+	}
+
+	if (ctrl & NAND_CTRL_CHANGE) {
+		set = SNAPPERCL15_NAND_CEN;
+
+		if (ctrl & NAND_NCE)
+			set &= ~SNAPPERCL15_NAND_CEN;
+		if (ctrl & NAND_CLE)
+			set |= SNAPPERCL15_NAND_CLE;
+		if (ctrl & NAND_ALE)
+			set |= SNAPPERCL15_NAND_ALE;
+
+		nand_state &= ~(SNAPPERCL15_NAND_CEN |
+				SNAPPERCL15_NAND_CLE |
+				SNAPPERCL15_NAND_ALE);
+		nand_state |= set;
+		__raw_writew(nand_state, NAND_CTRL_ADDR(chip));
+	}
+
+	if (cmd != NAND_CMD_NONE)
+		__raw_writew((cmd & 0xff) | nand_state, chip->IO_ADDR_W);
+}
+
+static int snappercl15_nand_dev_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+
+	return !!(__raw_readw(NAND_CTRL_ADDR(chip)) & SNAPPERCL15_NAND_RDY);
+}
+
+static struct mtd_partition snappercl15_nand_partitions[] = {
+	{
+		.name		= "Kernel",
+		.offset		= 0,
+		.size		= SZ_2M,
+	},
+	{
+		.name		= "Filesystem",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+static void snappercl15_nand_set_parts(uint64_t size,
+				       struct platform_nand_chip *chip)
+{
+	pr_info("Snapper CL15: %llu bytes NAND\n", size);
+	chip->partitions = snappercl15_nand_partitions;
+	chip->nr_partitions = ARRAY_SIZE(snappercl15_nand_partitions);
+}
+
+static struct platform_nand_data snappercl15_nand_data = {
+	.chip = {
+		.nr_chips	= 1,
+		.set_parts	= snappercl15_nand_set_parts,
+		.options	= NAND_NO_AUTOINCR,
+		.chip_delay	= 25,
+	},
+	.ctrl = {
+		.dev_ready	= snappercl15_nand_dev_ready,
+		.cmd_ctrl	= snappercl15_nand_cmd_ctrl,
+	},
+};
+
+static struct resource snappercl15_nand_resource[] = {
+	{
+		.start		= SNAPPERCL15_NAND_BASE,
+		.end		= SNAPPERCL15_NAND_BASE + SZ_4K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device snappercl15_nand_device = {
+	.name			= "gen_nand",
+	.id			= -1,
+	.dev.platform_data	= &snappercl15_nand_data,
+	.resource		= snappercl15_nand_resource,
+	.num_resources		= ARRAY_SIZE(snappercl15_nand_resource),
+};
+
+static struct ep93xx_eth_data snappercl15_eth_data = {
+	.phy_id			= 1,
+};
+
+static struct i2c_gpio_platform_data snappercl15_i2c_gpio_data = {
+	.sda_pin		= EP93XX_GPIO_LINE_EEDAT,
+	.sda_is_open_drain	= 0,
+	.scl_pin		= EP93XX_GPIO_LINE_EECLK,
+	.scl_is_open_drain	= 0,
+	.udelay			= 0,
+	.timeout		= 0,
+};
+
+static struct i2c_board_info __initdata snappercl15_i2c_data[] = {
+	{
+		/* Audio codec */
+		I2C_BOARD_INFO("tlv320aic23", 0x1a),
+	},
+};
+
+static struct ep93xxfb_mach_info snappercl15_fb_info = {
+	.num_modes		= EP93XXFB_USE_MODEDB,
+	.bpp			= 16,
+};
+
+static void __init snappercl15_init_machine(void)
+{
+	ep93xx_init_devices();
+	ep93xx_register_eth(&snappercl15_eth_data, 1);
+	ep93xx_register_i2c(&snappercl15_i2c_gpio_data, snappercl15_i2c_data,
+			    ARRAY_SIZE(snappercl15_i2c_data));
+	ep93xx_register_fb(&snappercl15_fb_info);
+	platform_device_register(&snappercl15_nand_device);
+}
+
+MACHINE_START(SNAPPER_CL15, "Bluewater Systems Snapper CL15")
+	/* Maintainer: Ryan Mallon <ryan@bluewatersys.com> */
+	.phys_io	= EP93XX_APB_PHYS_BASE,
+	.io_pg_offst	= ((EP93XX_APB_VIRT_BASE) >> 18) & 0xfffc,
+	.boot_params	= EP93XX_SDCE0_PHYS_BASE + 0x100,
+	.map_io		= ep93xx_map_io,
+	.init_irq	= ep93xx_init_irq,
+	.timer 		= &ep93xx_timer,
+	.init_machine	= snappercl15_init_machine,
+MACHINE_END
