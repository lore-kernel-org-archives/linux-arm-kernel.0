From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:36 +0530
Subject: [PATCH V6 08/17] ST SPEAr3xx: EMI (External Memory Interface)
	controller driver
In-Reply-To: <cover.1298977727.git.viresh.kumar@st.com>
References: <cover.1298977727.git.viresh.kumar@st.com>
Message-ID: <9a62fbc7caf77d7f80ad62f88944019f05b1ddf7.1298977728.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

Two SPEAr platform SoCs(spear310 and spear320) support an External Memory
Interface controller. This controller is used to interface with
Parallel NOR Flash devices.

This patch adds just the platform code needed for EMI (mainly EMI
initialization). The driver being used is driver/mtd/maps/physmap.c

Reviewed-by: Stanley Miao <stanley.miao@windriver.com>
Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mach-spear3xx/Makefile                |    4 +
 arch/arm/mach-spear3xx/emi.c                   |   98 ++++++++++++++++++++++++
 arch/arm/mach-spear3xx/include/mach/emi.h      |   61 +++++++++++++++
 arch/arm/mach-spear3xx/include/mach/spear310.h |    9 ++
 arch/arm/mach-spear3xx/include/mach/spear320.h |    6 ++
 arch/arm/mach-spear3xx/spear310_evb.c          |   35 +++++++++
 arch/arm/mach-spear3xx/spear320_evb.c          |   35 +++++++++
 7 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-spear3xx/emi.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h

diff --git a/arch/arm/mach-spear3xx/Makefile b/arch/arm/mach-spear3xx/Makefile
index b248624..d38ae47 100644
--- a/arch/arm/mach-spear3xx/Makefile
+++ b/arch/arm/mach-spear3xx/Makefile
@@ -24,3 +24,7 @@ obj-$(CONFIG_MACH_SPEAR320) += spear320.o
 
 # spear320 boards files
 obj-$(CONFIG_BOARD_SPEAR320_EVB) += spear320_evb.o
+
+# specific files
+obj-$(CONFIG_MACH_SPEAR310) += emi.o
+obj-$(CONFIG_MACH_SPEAR320) += emi.o
diff --git a/arch/arm/mach-spear3xx/emi.c b/arch/arm/mach-spear3xx/emi.c
new file mode 100644
index 0000000..4d01322
--- /dev/null
+++ b/arch/arm/mach-spear3xx/emi.c
@@ -0,0 +1,98 @@
+/*
+ * arch/arm/mach-spear3xx/emi.c
+ *
+ * EMI (External Memory Interface) file
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
+#include <linux/io.h>
+#include <asm/mach-types.h>
+#include <mach/emi.h>
+
+int __init emi_init(unsigned long base, u32 bank, u32 width)
+{
+	void __iomem *emi_reg_base;
+	struct clk *clk;
+	int ret;
+	u32 ack_reg, max_banks;
+	/* u32 timeout_reg, irq_reg; */
+
+	/* fixing machine dependent values */
+	if (machine_is_spear310()) {
+		ack_reg = SPEAR310_ACK_REG;
+		max_banks = SPEAR310_EMI_MAX_BANKS;
+		/* timeout_reg = SPEAR310_TIMEOUT_REG; */
+		/* irq_reg = SPEAR310_IRQ_REG; */
+	} else {
+		ack_reg = SPEAR320_ACK_REG;
+		max_banks = SPEAR320_EMI_MAX_BANKS;
+		/* timeout_reg = SPEAR320_TIMEOUT_REG; */
+		/* irq_reg = SPEAR320_IRQ_REG; */
+	}
+
+	if (bank > (max_banks - 1))
+		return -EINVAL;
+
+	emi_reg_base = ioremap(base, EMI_REG_SIZE);
+	if (!emi_reg_base)
+		return -ENOMEM;
+
+	clk = clk_get(NULL, "emi");
+	if (IS_ERR(clk)) {
+		iounmap(emi_reg_base);
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_enable(clk);
+	if (ret) {
+		iounmap(emi_reg_base);
+		return ret;
+	}
+
+	/*
+	 * Note: These are relaxed NOR device timings. Nor devices on spear
+	 * eval machines are working fine with these timings. Specific board
+	 * files can optimize these timings based on devices found on board.
+	 */
+	writel(0x10, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TAP_REG);
+	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TSDP_REG);
+	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPW_REG);
+	writel(0x0a, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDPR_REG);
+	writel(0x05, emi_reg_base + (EMI_BANK_REG_SIZE * bank) + TDCS_REG);
+
+	switch (width) {
+	case EMI_FLASH_WIDTH8:
+		width = EMI_CNTL_WIDTH8;
+		break;
+
+	case EMI_FLASH_WIDTH16:
+		width = EMI_CNTL_WIDTH16;
+		break;
+
+	case EMI_FLASH_WIDTH32:
+		width = EMI_CNTL_WIDTH32;
+		break;
+	default:
+		width = EMI_CNTL_WIDTH8;
+		break;
+	}
+	/* set the data width */
+	writel(width | EMI_CNTL_ENBBYTERW,
+		emi_reg_base + (EMI_BANK_REG_SIZE * bank) + CTRL_REG);
+
+	/* disable all the acks */
+	writel(0x3f, emi_reg_base + ack_reg);
+
+	iounmap(emi_reg_base);
+
+	return 0;
+}
diff --git a/arch/arm/mach-spear3xx/include/mach/emi.h b/arch/arm/mach-spear3xx/include/mach/emi.h
new file mode 100644
index 0000000..c15b12e
--- /dev/null
+++ b/arch/arm/mach-spear3xx/include/mach/emi.h
@@ -0,0 +1,61 @@
+/*
+ * arch/arm/mach-spear3xx/include/mach/emi.h
+ *
+ * EMI macros for SPEAr platform
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Vipin Kumar <vipin.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __MACH_EMI_H
+#define __MACH_EMI_H
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/physmap.h>
+
+#define EMI_FLASH_WIDTH8	1
+#define EMI_FLASH_WIDTH16	2
+#define EMI_FLASH_WIDTH32	4
+
+#define EMI_REG_SIZE		0x100
+#define EMI_BANK_REG_SIZE	0x18
+
+#define TAP_REG			(0x0)
+#define TSDP_REG		(0x4)
+#define TDPW_REG		(0x8)
+#define TDPR_REG		(0xC)
+#define TDCS_REG		(0x10)
+#define CTRL_REG		(0x14)
+
+#if defined(CONFIG_MACH_SPEAR310)
+#define SPEAR310_TIMEOUT_REG	(0x90)
+#define SPEAR310_ACK_REG	(0x94)
+#define SPEAR310_IRQ_REG	(0x98)
+
+#define SPEAR310_EMI_MAX_BANKS	6
+#endif
+
+#if defined(CONFIG_MACH_SPEAR320)
+#define SPEAR320_TIMEOUT_REG	(0x60)
+#define SPEAR320_ACK_REG	(0x64)
+#define SPEAR320_IRQ_REG	(0x68)
+
+#define SPEAR320_EMI_MAX_BANKS	4
+
+#endif
+
+/* Control register definitions */
+#define EMI_CNTL_WIDTH8		(0 << 0)
+#define EMI_CNTL_WIDTH16	(1 << 0)
+#define EMI_CNTL_WIDTH32	(2 << 0)
+#define EMI_CNTL_ENBBYTEW	(1 << 2)
+#define EMI_CNTL_ENBBYTER	(1 << 3)
+#define EMI_CNTL_ENBBYTERW	(EMI_CNTL_ENBBYTER | EMI_CNTL_ENBBYTEW)
+
+extern int __init emi_init(unsigned long base, u32 bank, u32 width);
+#endif
diff --git a/arch/arm/mach-spear3xx/include/mach/spear310.h b/arch/arm/mach-spear3xx/include/mach/spear310.h
index 1567d0da..0780c47 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear310.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear310.h
@@ -18,6 +18,15 @@
 
 #define SPEAR310_NAND_BASE		UL(0x40000000)
 #define SPEAR310_FSMC_BASE		UL(0x44000000)
+#define SPEAR310_EMI_REG_BASE		UL(0x4F000000)
+#define SPEAR310_EMI_MEM_0_BASE		UL(0x50000000)
+#define SPEAR310_EMI_MEM_1_BASE		UL(0x60000000)
+#define SPEAR310_EMI_MEM_2_BASE		UL(0x70000000)
+#define SPEAR310_EMI_MEM_3_BASE		UL(0x80000000)
+#define SPEAR310_EMI_MEM_4_BASE		UL(0x90000000)
+#define SPEAR310_EMI_MEM_5_BASE		UL(0xA0000000)
+#define SPEAR310_EMI_MEM_SIZE		UL(0x10000000)
+
 #define SPEAR310_UART1_BASE		UL(0xB2000000)
 #define SPEAR310_UART2_BASE		UL(0xB2080000)
 #define SPEAR310_UART3_BASE		UL(0xB2100000)
diff --git a/arch/arm/mach-spear3xx/include/mach/spear320.h b/arch/arm/mach-spear3xx/include/mach/spear320.h
index 8cfa83f..30ea941 100644
--- a/arch/arm/mach-spear3xx/include/mach/spear320.h
+++ b/arch/arm/mach-spear3xx/include/mach/spear320.h
@@ -17,6 +17,12 @@
 #define __MACH_SPEAR320_H
 
 #define SPEAR320_EMI_CTRL_BASE		UL(0x40000000)
+#define SPEAR320_EMI_MEM_0_BASE		UL(0x44000000)
+#define SPEAR320_EMI_MEM_1_BASE		UL(0x45000000)
+#define SPEAR320_EMI_MEM_2_BASE		UL(0x46000000)
+#define SPEAR320_EMI_MEM_3_BASE		UL(0x47000000)
+#define SPEAR320_EMI_MEM_SIZE		UL(0x01000000)
+
 #define SPEAR320_FSMC_BASE		UL(0x4C000000)
 #define SPEAR320_NAND_BASE		UL(0x50000000)
 #define SPEAR320_I2S_BASE		UL(0x60000000)
diff --git a/arch/arm/mach-spear3xx/spear310_evb.c b/arch/arm/mach-spear3xx/spear310_evb.c
index 36fb611..8d5becb 100644
--- a/arch/arm/mach-spear3xx/spear310_evb.c
+++ b/arch/arm/mach-spear3xx/spear310_evb.c
@@ -13,9 +13,40 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
+/* emi nor flash resources registeration */
+static struct resource emi_nor_resources[] = {
+	{
+		.start	= SPEAR310_EMI_MEM_0_BASE,
+		.end	= SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct physmap_flash_data emi_norflash_data = {
+	.parts = partition_info,
+	.nr_parts = ARRAY_SIZE(partition_info),
+	.width = 4,
+};
+static struct platform_device spear310_emi_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev.platform_data = &emi_norflash_data,
+	.resource = emi_nor_resources,
+	.num_resources = ARRAY_SIZE(emi_nor_resources),
+};
+
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
@@ -58,6 +89,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear3xx specific devices */
 
 	/* spear310 specific devices */
+	&spear310_emi_nor_device,
 	&spear310_plgpio_device,
 };
 
@@ -68,6 +100,9 @@ static void __init spear310_evb_init(void)
 	/* call spear310 machine init function */
 	spear310_init(NULL, pmx_devs, ARRAY_SIZE(pmx_devs));
 
+	/* Initialize emi regiters */
+	emi_init(SPEAR310_EMI_REG_BASE, 0, EMI_FLASH_WIDTH32);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
diff --git a/arch/arm/mach-spear3xx/spear320_evb.c b/arch/arm/mach-spear3xx/spear320_evb.c
index f2c3cd3..8addd5f 100644
--- a/arch/arm/mach-spear3xx/spear320_evb.c
+++ b/arch/arm/mach-spear3xx/spear320_evb.c
@@ -13,9 +13,40 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
+#include <mach/emi.h>
 #include <mach/generic.h>
 #include <mach/hardware.h>
 
+#define PARTITION(n, off, sz)	{.name = n, .offset = off, .size = sz}
+static struct mtd_partition partition_info[] = {
+	PARTITION("X-loader", 0, 1 * 0x20000),
+	PARTITION("U-Boot", 0x20000, 3 * 0x20000),
+	PARTITION("Kernel", 0x80000, 24 * 0x20000),
+	PARTITION("Root File System", 0x380000, 84 * 0x20000),
+};
+
+/* emi nor flash resources registeration */
+static struct resource emi_nor_resources[] = {
+	{
+		.start	= SPEAR320_EMI_MEM_0_BASE,
+		.end	= SPEAR320_EMI_MEM_0_BASE + SPEAR320_EMI_MEM_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct physmap_flash_data emi_norflash_data = {
+	.parts = partition_info,
+	.nr_parts = ARRAY_SIZE(partition_info),
+	.width = 2,
+};
+static struct platform_device spear320_emi_nor_device = {
+	.name	= "physmap-flash",
+	.id	= -1,
+	.dev.platform_data = &emi_norflash_data,
+	.resource = emi_nor_resources,
+	.num_resources = ARRAY_SIZE(emi_nor_resources),
+};
+
 /* padmux devices to enable */
 static struct pmx_dev *pmx_devs[] = {
 	/* spear3xx specific devices */
@@ -54,6 +85,7 @@ static struct platform_device *plat_devs[] __initdata = {
 	/* spear320 specific devices */
 	&spear320_can0_device,
 	&spear320_can1_device,
+	&spear320_emi_nor_device,
 	&spear320_plgpio_device,
 	&spear320_pwm_device,
 };
@@ -66,6 +98,9 @@ static void __init spear320_evb_init(void)
 	spear320_init(&spear320_auto_net_mii_mode, pmx_devs,
 			ARRAY_SIZE(pmx_devs));
 
+	/* Initialize emi regiters */
+	emi_init(SPEAR320_EMI_CTRL_BASE, 0, EMI_FLASH_WIDTH16);
+
 	/* Add Platform Devices */
 	platform_add_devices(plat_devs, ARRAY_SIZE(plat_devs));
 
-- 
1.7.2.2
