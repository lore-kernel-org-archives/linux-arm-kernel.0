From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:09:08 +0530
Subject: [PATCH 44/74] ST SPEAr : FSMC (Flexible Static Memory Controller) NOR
	interface driver
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <3083e6913169ae3d3761be1667708c01ea2e344c.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

SPEAr1300 SoC supports FSMC to interface with various memories (NOR/NAND/SRAM).
This patch adds the support for FSMC over NOR interface.

The driver being used is driver/mtd/maps/physmap.c

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: shiraz hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear13xx/Makefile               |    2 +-
 arch/arm/mach-spear13xx/clock.c                |    2 +-
 arch/arm/mach-spear13xx/fsmc-nor.c             |   81 ++++++++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/generic.h |    1 +
 arch/arm/mach-spear13xx/spear1300_evb.c        |   17 +++++
 arch/arm/mach-spear13xx/spear13xx.c            |   20 ++++++
 arch/arm/plat-spear/include/plat/fsmc.h        |   51 +++++++++++++++-
 7 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/fsmc-nor.c

diff --git a/arch/arm/mach-spear13xx/Makefile b/arch/arm/mach-spear13xx/Makefile
index 168886e..8644c76 100644
--- a/arch/arm/mach-spear13xx/Makefile
+++ b/arch/arm/mach-spear13xx/Makefile
@@ -3,7 +3,7 @@
 #
 
 # common files
-obj-y					+= spear13xx.o clock.o
+obj-y					+= spear13xx.o clock.o fsmc-nor.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
 
diff --git a/arch/arm/mach-spear13xx/clock.c b/arch/arm/mach-spear13xx/clock.c
index 30eba05..c593608 100644
--- a/arch/arm/mach-spear13xx/clock.c
+++ b/arch/arm/mach-spear13xx/clock.c
@@ -920,7 +920,7 @@ static struct clk_lookup spear_clk_lookups[] = {
 	{.dev_id = "pcie2",		.clk = &pcie2_clk},
 	{.dev_id = "cfxd",		.clk = &cfxd_clk},
 	{.dev_id = "sdhci",		.clk = &sdhci_clk},
-	{.con_id = "fsmc",		.clk = &fsmc_clk},
+	{.dev_id = "fsmc",		.clk = &fsmc_clk},
 	{.dev_id = "sysram0",		.clk = &sysram0_clk},
 	{.dev_id = "sysram1",		.clk = &sysram1_clk},
 
diff --git a/arch/arm/mach-spear13xx/fsmc-nor.c b/arch/arm/mach-spear13xx/fsmc-nor.c
new file mode 100644
index 0000000..68f0ca0
--- /dev/null
+++ b/arch/arm/mach-spear13xx/fsmc-nor.c
@@ -0,0 +1,81 @@
+/*
+ * arch/arm/mach-spear13xx/fsmc-nor.c
+ *
+ * FSMC (Flexible Static Memory Controller) interface for NOR
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar<vipin.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <plat/fsmc.h>
+
+int __init fsmc_nor_init(struct platform_device *pdev, unsigned long base,
+		u32 bank, u32 width)
+{
+	void __iomem *fsmc_nor_base;
+	struct fsmc_regs *regs;
+	struct clk *clk;
+	int ret;
+	u32 ctrl;
+
+	if (bank > (FSMC_MAX_NOR_BANKS - 1))
+		return -EINVAL;
+
+	fsmc_nor_base = ioremap(base, FSMC_NOR_REG_SIZE);
+	if (!fsmc_nor_base)
+		return -ENOMEM;
+
+	clk = clk_get(NULL, "fsmc");
+	if (IS_ERR(clk)) {
+		iounmap(fsmc_nor_base);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_enable(clk);
+	if (ret) {
+		iounmap(fsmc_nor_base);
+		return ret;
+	}
+
+	regs = (struct fsmc_regs *)fsmc_nor_base;
+
+	ctrl = WAIT_ENB | WRT_ENABLE | WPROT | NOR_DEV | BANK_ENABLE;
+
+	switch (width) {
+	case FSMC_FLASH_WIDTH8:
+		ctrl |= WIDTH_8;
+		break;
+
+	case FSMC_FLASH_WIDTH16:
+		ctrl |= WIDTH_16;
+		break;
+
+	default:
+		ctrl |= WIDTH_8;
+		break;
+	}
+
+	writel(ctrl, &regs->nor_bank_regs[bank].ctrl);
+	writel(0x0FFFFFFF, &regs->nor_bank_regs[bank].ctrl_tim);
+	writel(ctrl | RSTPWRDWN, &regs->nor_bank_regs[bank].ctrl);
+
+	iounmap(fsmc_nor_base);
+
+	return 0;
+}
+
+void __init fsmc_init_board_info(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int width)
+{
+	fsmc_init_plat_data(pdev, partitions, nr_partitions, width);
+}
diff --git a/arch/arm/mach-spear13xx/include/mach/generic.h b/arch/arm/mach-spear13xx/include/mach/generic.h
index 6f4e6b5..dfee834 100644
--- a/arch/arm/mach-spear13xx/include/mach/generic.h
+++ b/arch/arm/mach-spear13xx/include/mach/generic.h
@@ -38,6 +38,7 @@ extern struct platform_device ehci1_device;
 extern struct platform_device i2c_device;
 extern struct platform_device kbd_device;
 extern struct platform_device nand_device;
+extern struct platform_device fsmc_nor_device;
 extern struct platform_device ohci0_device;
 extern struct platform_device ohci1_device;
 extern struct platform_device rtc_device;
diff --git a/arch/arm/mach-spear13xx/spear1300_evb.c b/arch/arm/mach-spear13xx/spear1300_evb.c
index db05747..d030a85 100644
--- a/arch/arm/mach-spear13xx/spear1300_evb.c
+++ b/arch/arm/mach-spear13xx/spear1300_evb.c
@@ -21,11 +21,21 @@
 #include <mach/generic.h>
 #include <mach/spear.h>
 #include <mach/pcie.h>
+#include <plat/fsmc.h>
 #include <plat/keyboard.h>
 #include <plat/nand.h>
 #include <plat/smi.h>
 #include <plat/spi.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
 static struct amba_device *amba_devs[] __initdata = {
 	&gpio_device[0],
 	&gpio_device[1],
@@ -143,6 +153,9 @@ static void __init spear1300_evb_init(void)
 	enable_pcie0_clk();
 	pcie_init(&spear1300_pcie_port_is_host);
 #endif
+	/* initialize fsmc related data in fsmc plat data */
+	fsmc_init_board_info(&fsmc_nor_device, partition_info,
+			ARRAY_SIZE(partition_info), FSMC_FLASH_WIDTH8);
 
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
@@ -150,6 +163,10 @@ static void __init spear1300_evb_init(void)
 	/* Add Amba Devices */
 	spear_amba_device_register(amba_devs, ARRAY_SIZE(amba_devs));
 
+	/* Initialize fsmc regiters */
+	fsmc_nor_init(&fsmc_nor_device, SPEAR13XX_FSMC_BASE, 0,
+			FSMC_FLASH_WIDTH8);
+
 	spi_init();
 }
 
diff --git a/arch/arm/mach-spear13xx/spear13xx.c b/arch/arm/mach-spear13xx/spear13xx.c
index 4563551..6d71aac 100644
--- a/arch/arm/mach-spear13xx/spear13xx.c
+++ b/arch/arm/mach-spear13xx/spear13xx.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/amba/pl022.h>
 #include <linux/amba/pl061.h>
+#include <linux/mtd/physmap.h>
 #include <linux/ptrace.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
@@ -130,6 +131,25 @@ struct platform_device i2c_device = {
 	.resource = i2c_resources,
 };
 
+/* fsmc nor flash device registeration */
+static struct physmap_flash_data fsmc_norflash_data;
+
+static struct resource fsmc_nor_resources[] = {
+	{
+		.start	= SPEAR13XX_FSMC_MEM_BASE,
+		.end	= SPEAR13XX_FSMC_MEM_BASE + SZ_16M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device fsmc_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.resource = fsmc_nor_resources,
+	.num_resources = ARRAY_SIZE(fsmc_nor_resources),
+	.dev.platform_data = &fsmc_norflash_data,
+};
+
 /* nand device registeration */
 void __init nand_mach_init(u32 busw)
 {
diff --git a/arch/arm/plat-spear/include/plat/fsmc.h b/arch/arm/plat-spear/include/plat/fsmc.h
index c0fdcd3..5909afd 100644
--- a/arch/arm/plat-spear/include/plat/fsmc.h
+++ b/arch/arm/plat-spear/include/plat/fsmc.h
@@ -15,11 +15,36 @@
 #define __PLAT_FSMC_H
 
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
 #include <linux/types.h>
 #include <asm/param.h>
 
+#define FSMC_MAX_NOR_BANKS	4
 #define FSMC_MAX_NAND_BANKS	4
 
+#define FSMC_FLASH_WIDTH8	1
+#define FSMC_FLASH_WIDTH16	2
+
+struct nor_bank_regs {
+	u32 ctrl;
+	u32 ctrl_tim;
+};
+
+/* ctrl register definitions */
+#define BANK_ENABLE		(1 << 0)
+#define MUXED			(1 << 1)
+#define NOR_DEV			(2 << 2)
+#define WIDTH_8			(0 << 4)
+#define WIDTH_16		(1 << 4)
+#define RSTPWRDWN		(1 << 6)
+#define WPROT			(1 << 7)
+#define WRT_ENABLE		(1 << 12)
+#define WAIT_ENB		(1 << 13)
+
+/* ctrl_tim register definitions */
+
 struct nand_bank_regs {
 	u32 pc;
 	u32 sts;
@@ -31,8 +56,11 @@ struct nand_bank_regs {
 	u32 ecc3;
 };
 
+#define FSMC_NOR_REG_SIZE	0x40
+
 struct fsmc_regs {
-	u8 reserved_1[0x40];
+	struct nor_bank_regs nor_bank_regs[FSMC_MAX_NOR_BANKS];
+	u8 reserved_1[0x40 - 0x20];
 	struct nand_bank_regs bank_regs[FSMC_MAX_NAND_BANKS];
 	u8 reserved_2[0xfe0 - 0xc0];
 	u32 peripid0;			/* 0xfe0 */
@@ -106,4 +134,25 @@ struct fsmc_eccplace {
 	struct fsmc_nand_eccplace eccplace[MAX_ECCPLACE_ENTRIES];
 };
 
+static inline void fsmc_init_plat_data(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int width)
+{
+	struct physmap_flash_data *fsmc_plat_data;
+	fsmc_plat_data = dev_get_platdata(&pdev->dev);
+
+	if (partitions) {
+		fsmc_plat_data->parts = partitions;
+		fsmc_plat_data->nr_parts = nr_partitions;
+	}
+
+	fsmc_plat_data->width = width;
+}
+
+extern int __init fsmc_nor_init(struct platform_device *pdev,
+		unsigned long base, u32 bank, u32 width);
+extern void __init fsmc_init_board_info(struct platform_device *pdev,
+		struct mtd_partition *partitions, unsigned int nr_partitions,
+		unsigned int width);
+
 #endif /* __PLAT_FSMC_H */
-- 
1.7.2.2
