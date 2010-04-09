From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 09 Apr 2010 08:46:58 +0200
Subject: [PATCH] ARM: Samsung: Add platform support code for OneNAND controller
Message-ID: <1270795618-2093-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds setup code for Samsung OneNAND controller driver. The
driver needs to be aware on which SoC it is running, so the actual
device id is being changed in cpu init code. S3C64xx SoCs have 2 OneNAND
controllers while S5PC100 and S5PC110 has only one.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

---

The patch has been prepared in assumtion that my previous patches for
S5PC100 platform moves are applied. When these patches will be finally
merged I will rebase it for the clean merge.

The is the second attempt on posting OneNAND driver. In this version all
cpu conditional code in the driver has been redesigned from cpu_is_xxx()
macros to actual device ids.

The Samsung OneNAND driver itself will be posted also to the Linux MTD
mailing list (linux-mtd at lists.infradead.org).


 arch/arm/mach-s3c64xx/Kconfig                     |    5 ++
 arch/arm/mach-s3c64xx/Makefile                    |    1 +
 arch/arm/mach-s3c64xx/dev-onenand1.c              |   50 ++++++++++++++
 arch/arm/mach-s3c64xx/include/mach/irqs.h         |    4 +
 arch/arm/mach-s3c64xx/s3c6400.c                   |    4 +
 arch/arm/mach-s3c64xx/s3c6410.c                   |    4 +
 arch/arm/mach-s5pc100/cpu.c                       |    3 +
 arch/arm/mach-s5pv210/Kconfig                     |    5 ++
 arch/arm/mach-s5pv210/Makefile                    |    2 +
 arch/arm/mach-s5pv210/dev-onenand.c               |   45 ++++++++++++
 arch/arm/plat-samsung/Kconfig                     |    5 ++
 arch/arm/plat-samsung/Makefile                    |    1 +
 arch/arm/plat-samsung/dev-onenand.c               |   50 ++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h         |    3 +
 arch/arm/plat-samsung/include/plat/onenand-core.h |   37 ++++++++++
 arch/arm/plat-samsung/include/plat/regs-onenand.h |   75 +++++++++++++++++++++
 16 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/dev-onenand1.c
 create mode 100644 arch/arm/mach-s5pv210/dev-onenand.c
 create mode 100644 arch/arm/plat-samsung/dev-onenand.c
 create mode 100644 arch/arm/plat-samsung/include/plat/onenand-core.h
 create mode 100644 arch/arm/plat-samsung/include/plat/regs-onenand.h

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 959df38..f9202c9 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -35,6 +35,11 @@ config S3C64XX_SETUP_SDHCI
 	  Internal configuration for default SDHCI setup for S3C6400 and
 	  S3C6410 SoCs.
 
+config S3C64XX_DEV_ONENAND1
+	bool
+	help
+	  Compile in platform device definition for OneNAND1 controller
+
 # platform specific device setup
 
 config S3C64XX_SETUP_I2C0
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 3758e15..c6d8c7c 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -60,3 +60,4 @@ obj-y				+= dev-rtc.o
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+obj-$(CONFIG_S3C64XX_DEV_ONENAND1)	+= dev-onenand1.o
diff --git a/arch/arm/mach-s3c64xx/dev-onenand1.c b/arch/arm/mach-s3c64xx/dev-onenand1.c
new file mode 100644
index 0000000..8cad1b5
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/dev-onenand1.c
@@ -0,0 +1,50 @@
+/*
+ * linux/arch/arm/mach-s3c64xx/dev-onenand1.c
+ *
+ *  Copyright (c) 2008-2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S3C64XX series device definition for OneNAND devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+
+#include <mach/irqs.h>
+#include <plat/regs-onenand.h>
+
+static struct resource s3c64xx_onenand1_resources[] = {
+	[0] = {
+		.start	= S3C64XX_ONENAND1_BASE,
+		.end	= S3C64XX_ONENAND1_BASE + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_ONENAND1,
+		.end	= IRQ_ONENAND1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c64xx_device_onenand1 = {
+	.name		= "samsung-onenand",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s3c64xx_onenand1_resources),
+	.resource	= s3c64xx_onenand1_resources,
+};
+
+void s3c64xx_onenand1_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	s3c_device_onenand1.dev.platform_data = pd;
+}
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c64xx/include/mach/irqs.h
index e9ab4ac..8e2df26 100644
--- a/arch/arm/mach-s3c64xx/include/mach/irqs.h
+++ b/arch/arm/mach-s3c64xx/include/mach/irqs.h
@@ -212,5 +212,9 @@
 
 #define NR_IRQS	(IRQ_BOARD_END + 1)
 
+/* Compatibility */
+
+#define IRQ_ONENAND	IRQ_ONENAND0
+
 #endif /* __ASM_MACH_S3C64XX_IRQS_H */
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 707e34e..5e93fe3 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -37,6 +37,7 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
+#include <plat/onenand-core.h>
 #include <mach/s3c6400.h>
 
 void __init s3c6400_map_io(void)
@@ -51,6 +52,9 @@ void __init s3c6400_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 
 	s3c_device_nand.name = "s3c6400-nand";
+
+	s3c_onenand_setname("s3c6400-onenand");
+	s3c64xx_onenand1_setname("s3c6400-onenand");
 }
 
 void __init s3c6400_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 59635d1..3f28f46 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -38,6 +38,7 @@
 #include <plat/clock.h>
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
+#include <plat/onenand-core.h>
 #include <mach/s3c6400.h>
 #include <mach/s3c6410.h>
 
@@ -53,6 +54,9 @@ void __init s3c6410_map_io(void)
 	s3c_i2c1_setname("s3c2440-i2c");
 
 	s3c_device_nand.name = "s3c6400-nand";
+
+	s3c_onenand_setname("s3c6410-onenand");
+	s3c64xx_onenand1_setname("s3c6410-onenand");
 }
 
 void __init s3c6410_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pc100/cpu.c b/arch/arm/mach-s5pc100/cpu.c
index d424a9f..cc47c3a 100644
--- a/arch/arm/mach-s5pc100/cpu.c
+++ b/arch/arm/mach-s5pc100/cpu.c
@@ -39,6 +39,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/iic-core.h>
+#include <plat/onenand-core.h>
 #include <plat/sdhci.h>
 #include <plat/s5pc100.h>
 
@@ -88,6 +89,8 @@ void __init s5pc100_map_io(void)
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
+
+	s3c_onenand_setname("s5pc100-onenand");
 }
 
 void __init s5pc100_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 16fbc06..6774f5e 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -41,6 +41,11 @@ config S5PV210_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config S5PC110_DEV_ONENAND
+	bool
+	help
+	  Compile in platform device definition for OneNAND1 controller
+
 config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 11b5ab6..f53b694 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -23,6 +23,8 @@ obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
+obj-$(CONFIG_S5PC110_DEV_ONENAND)	+= dev-onenand.o
+
 # machine support
 
 obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
diff --git a/arch/arm/mach-s5pv210/dev-onenand.c b/arch/arm/mach-s5pv210/dev-onenand.c
new file mode 100644
index 0000000..3f93ca0
--- /dev/null
+++ b/arch/arm/mach-s5pv210/dev-onenand.c
@@ -0,0 +1,45 @@
+/*
+ * linux/arch/arm/mach-s5pv210/dev-onenand.c
+ *
+ *  Copyright (c) 2008-2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S5PC110 series device definition for OneNAND devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+
+#include <mach/irqs.h>
+#include <plat/regs-onenand.h>
+
+static struct resource s5pc110_onenand_resources[] = {
+	{
+		.start	= S5PC110_ONENAND_BASE,
+		.end	= S5PC110_ONENAND_BASE + SZ_128K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device s5pc110_device_onenand = {
+	.name		= "s5pc110-onenand",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s5pc110_onenand_resources),
+	.resource	= s5pc110_onenand_resources,
+};
+
+void s5pc110_onenand_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	s5pc110_device_onenand.dev.platform_data = pd;
+}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 74fe5d6..c086bce 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -185,6 +185,11 @@ config S3C_DEV_NAND
 	help
 	  Compile in platform device definition for NAND controller
 
+config S3C_DEV_ONENAND
+	bool
+	help
+	  Compile in platform device definition for OneNAND controller
+
 config S3C64XX_DEV_SPI
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 22c89d0..66f16e5 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -40,6 +40,7 @@ obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
 obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
+obj-$(CONFIG_S3C_DEV_ONENAND)	+= dev-onenand.o
 
 # DMA support
 
diff --git a/arch/arm/plat-samsung/dev-onenand.c b/arch/arm/plat-samsung/dev-onenand.c
new file mode 100644
index 0000000..f0b0d2b
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-onenand.c
@@ -0,0 +1,50 @@
+/*
+ * linux/arch/arm/plat-samsung/dev-onenand.c
+ *
+ *  Copyright (c) 2008-2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * S3C64XX/S5PC1XX series device definition for OneNAND devices
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/onenand.h>
+
+#include <mach/irqs.h>
+#include <plat/regs-onenand.h>
+
+static struct resource s3c_onenand_resources[] = {
+	[0] = {
+		.start	= SAMSUNG_ONENAND_BASE,
+		.end	= SAMSUNG_ONENAND_BASE + 0x400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_ONENAND,
+		.end	= IRQ_ONENAND,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_onenand = {
+	.name		= "samsung-onenand",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s3c_onenand_resources),
+	.resource	= s3c_onenand_resources,
+};
+
+void s3c_onenand_set_platdata(struct onenand_platform_data *pdata)
+{
+	struct onenand_platform_data *pd;
+
+	pd = kmemdup(pdata, sizeof(struct onenand_platform_data), GFP_KERNEL);
+	if (!pd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	s3c_device_onenand.dev.platform_data = pd;
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 796d242..42dc955 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -60,6 +60,9 @@ extern struct platform_device s3c_device_spi1;
 extern struct platform_device s3c_device_hwmon;
 
 extern struct platform_device s3c_device_nand;
+extern struct platform_device s3c_device_onenand;
+extern struct platform_device s3c64xx_device_onenand1;
+extern struct platform_device s5pc110_device_onenand;
 
 extern struct platform_device s3c_device_usbgadget;
 extern struct platform_device s3c_device_usb_hsotg;
diff --git a/arch/arm/plat-samsung/include/plat/onenand-core.h b/arch/arm/plat-samsung/include/plat/onenand-core.h
new file mode 100644
index 0000000..7701cb7
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/onenand-core.h
@@ -0,0 +1,37 @@
+/*
+ * linux/arch/arm/plat-samsung/onenand-core.h
+ *
+ *  Copyright (c) 2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *  Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * Samsung OneNAD Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_ONENAND_CORE_H
+#define __ASM_ARCH_ONENAND_CORE_H __FILE__
+
+/* These functions are only for use with the core support code, such as
+ * the cpu specific initialisation code
+ */
+
+/* re-define device name depending on support. */
+static inline void s3c_onenand_setname(char *name)
+{
+#ifdef CONFIG_S3C_DEV_ONENAND
+	s3c_device_onenand.name = name;
+#endif
+}
+
+static inline void s3c64xx_onenand1_setname(char *name)
+{
+#ifdef CONFIG_S3C64XX_DEV_ONENAND1
+	s3c64xx_device_onenand1.name = name;
+#endif
+}
+
+#endif /* __ASM_ARCH_ONENAND_CORE_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-onenand.h b/arch/arm/plat-samsung/include/plat/regs-onenand.h
new file mode 100644
index 0000000..64acc2d
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/regs-onenand.h
@@ -0,0 +1,75 @@
+/*
+ * linux/arch/arm/plat-s3c/include/plat/regs-onenand.h
+ *
+ *  Copyright (C) 2008-2010 Samsung Electronics
+ *  Kyungmin Park <kyungmin.park@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __SAMSUNG_ONENAND_H__
+#define __SAMSUNG_ONENAND_H__
+
+#include <mach/hardware.h>
+
+/*
+ * OneNAND Controller
+ */
+#define S3C64XX_ONENAND0_BASE	0x70100000
+#define S3C64XX_ONENAND1_BASE	0x70200000
+#define S5PC100_ONENAND_BASE	0xE7100000
+#define S5PC110_ONENAND_BASE	0xB0000000
+
+#ifdef CONFIG_ARCH_S3C64XX
+#define SAMSUNG_ONENAND_BASE	S3C64XX_ONENAND0_BASE
+#endif
+#ifdef CONFIG_ARCH_S5PC100
+#define SAMSUNG_ONENAND_BASE	S5PC100_ONENAND_BASE
+#endif
+
+#define MEM_CFG_OFFSET		0x0000
+#define BURST_LEN_OFFSET	0x0010
+#define MEM_RESET_OFFSET	0x0020
+#define INT_ERR_STAT_OFFSET	0x0030
+#define INT_ERR_MASK_OFFSET	0x0040
+#define INT_ERR_ACK_OFFSET	0x0050
+#define ECC_ERR_STAT_OFFSET	0x0060
+#define MANUFACT_ID_OFFSET	0x0070
+#define DEVICE_ID_OFFSET	0x0080
+#define DATA_BUF_SIZE_OFFSET	0x0090
+#define BOOT_BUF_SIZE_OFFSET	0x00A0
+#define BUF_AMOUNT_OFFSET	0x00B0
+#define TECH_OFFSET		0x00C0
+#define FBA_WIDTH_OFFSET	0x00D0
+#define FPA_WIDTH_OFFSET	0x00E0
+#define FSA_WIDTH_OFFSET	0x00F0
+#define TRANS_SPARE_OFFSET	0x0140
+#define DBS_DFS_WIDTH_OFFSET	0x0160
+#define INT_PIN_ENABLE_OFFSET	0x01A0
+#define ACC_CLOCK_OFFSET	0x01C0
+#define FLASH_VER_ID_OFFSET	0x01F0
+#define FLASH_AUX_CNTRL_OFFSET	0x0300		/* s3c64xx only */
+
+#define ONENAND_MEM_RESET_HOT	0x3
+#define ONENAND_MEM_RESET_COLD	0x2
+#define ONENAND_MEM_RESET_WARM	0x1
+
+#define CACHE_OP_ERR		(1 << 13)
+#define RST_CMP			(1 << 12)
+#define RDY_ACT			(1 << 11)
+#define INT_ACT			(1 << 10)
+#define UNSUP_CMD		(1 << 9)
+#define LOCKED_BLK		(1 << 8)
+#define BLK_RW_CMP		(1 << 7)
+#define ERS_CMP			(1 << 6)
+#define PGM_CMP			(1 << 5)
+#define LOAD_CMP		(1 << 4)
+#define ERS_FAIL		(1 << 3)
+#define PGM_FAIL		(1 << 2)
+#define INT_TO			(1 << 1)
+#define LD_FAIL_ECC_ERR		(1 << 0)
+
+#define TSRF			(1 << 0)
+
+#endif
-- 
1.6.4
