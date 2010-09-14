From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 14 Sep 2010 14:39:50 +0530
Subject: [PATCH] ux500: rework device registration
Message-ID: <1284455390-27081-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Ux500 devices to be dynamically allocated and added by
calling functions instead of referencing structures, thereby allowing
5500 and other derivatives' support to be added without having to
duplicate structures, use fixup functions, or use compile-time macros.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile               |    2 +-
 arch/arm/mach-ux500/board-mop500-sdi.c     |   11 +--
 arch/arm/mach-ux500/board-mop500.c         |   50 +++++------
 arch/arm/mach-ux500/board-u5500.c          |   16 ++--
 arch/arm/mach-ux500/cpu-db5500.c           |    5 +-
 arch/arm/mach-ux500/cpu-db8500.c           |    7 +-
 arch/arm/mach-ux500/cpu.c                  |   10 --
 arch/arm/mach-ux500/devices-common.c       |  107 +++++++++++++++++++++++
 arch/arm/mach-ux500/devices-common.h       |   77 ++++++++++++++++
 arch/arm/mach-ux500/devices-db5500.h       |   66 ++++++++++++++
 arch/arm/mach-ux500/devices-db8500.c       |  131 ----------------------------
 arch/arm/mach-ux500/devices-db8500.h       |   98 +++++++++++++++++++++
 arch/arm/mach-ux500/devices.c              |   63 -------------
 arch/arm/mach-ux500/include/mach/devices.h |   17 ----
 arch/arm/mach-ux500/include/mach/setup.h   |    2 +-
 15 files changed, 394 insertions(+), 268 deletions(-)
 create mode 100644 arch/arm/mach-ux500/devices-common.c
 create mode 100644 arch/arm/mach-ux500/devices-common.h
 create mode 100644 arch/arm/mach-ux500/devices-db5500.h
 create mode 100644 arch/arm/mach-ux500/devices-db8500.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 0097318..8f49492 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= clock.o cpu.o devices.o
+obj-y				:= clock.o cpu.o devices.o devices-common.o
 obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 2fbaa20..be5e8cc 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -16,6 +16,7 @@
 #include <mach/devices.h>
 #include <mach/hardware.h>
 
+#include "devices-db8500.h"
 #include "pins-db8500.h"
 #include "board-mop500.h"
 
@@ -108,7 +109,7 @@ void mop500_sdi_tc35892_init(void)
 	gpio_direction_output(GPIO_SDMMC_1V8_3V_SEL, 1);
 	gpio_direction_output(GPIO_SDMMC_EN, 0);
 
-	amba_device_register(&u8500_sdi0_device, &iomem_resource);
+	db8500_add_sdi0(&mop500_sdi0_data);
 }
 
 /*
@@ -140,15 +141,11 @@ void mop500_sdi_init(void)
 {
 	nmk_config_pins(mop500_sdi_pins, ARRAY_SIZE(mop500_sdi_pins));
 
-	u8500_sdi0_device.dev.platform_data = &mop500_sdi0_data;
-	u8500_sdi2_device.dev.platform_data = &mop500_sdi2_data;
-	u8500_sdi4_device.dev.platform_data = &mop500_sdi4_data;
-
 	if (!cpu_is_u8500ed()) {
 		nmk_config_pins(mop500_sdi2_pins, ARRAY_SIZE(mop500_sdi2_pins));
-		amba_device_register(&u8500_sdi2_device, &iomem_resource);
+		db8500_add_sdi2(&mop500_sdi2_data);
 	}
 
 	/* On-board eMMC */
-	amba_device_register(&u8500_sdi4_device, &iomem_resource);
+	db8500_add_sdi4(&mop500_sdi4_data);
 }
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4a4f936..04166cc 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -32,6 +32,7 @@
 #include <mach/devices.h>
 #include <mach/irqs.h>
 
+#include "devices-db8500.h"
 #include "pins-db8500.h"
 #include "board-mop500.h"
 
@@ -178,43 +179,36 @@ U8500_I2C_CONTROLLER(1, 0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 U8500_I2C_CONTROLLER(2,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 U8500_I2C_CONTROLLER(3,	0xe, 1, 1, 100000, I2C_FREQ_MODE_STANDARD);
 
-static struct amba_device *amba_devs[] __initdata = {
-	&ux500_uart0_device,
-	&ux500_uart1_device,
-	&ux500_uart2_device,
-	&u8500_ssp0_device,
-};
+static void __init mop500_i2c_init(void)
+{
+	db8500_add_i2c0(&u8500_i2c0_data);
+	db8500_add_i2c1(&u8500_i2c1_data);
+	db8500_add_i2c2(&u8500_i2c2_data);
+	db8500_add_i2c3(&u8500_i2c3_data);
+}
 
-/* add any platform devices here - TODO */
-static struct platform_device *platform_devs[] __initdata = {
-	&u8500_i2c0_device,
-	&ux500_i2c1_device,
-	&ux500_i2c2_device,
-	&ux500_i2c3_device,
-};
+static void __init mop500_spi_init(void)
+{
+	db8500_add_ssp0(&ssp0_platform_data);
+}
 
-static void __init u8500_init_machine(void)
+static void __init mop500_uart_init(void)
 {
-	int i;
+	db8500_add_uart0();
+	db8500_add_uart1();
+	db8500_add_uart2();
+}
 
+static void __init u8500_init_machine(void)
+{
 	u8500_init_devices();
 
 	nmk_config_pins(mop500_pins, ARRAY_SIZE(mop500_pins));
 
-	u8500_i2c0_device.dev.platform_data = &u8500_i2c0_data;
-	ux500_i2c1_device.dev.platform_data = &u8500_i2c1_data;
-	ux500_i2c2_device.dev.platform_data = &u8500_i2c2_data;
-	ux500_i2c3_device.dev.platform_data = &u8500_i2c3_data;
-
-	u8500_ssp0_device.dev.platform_data = &ssp0_platform_data;
-
-	/* Register the active AMBA devices on this board */
-	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
-		amba_device_register(amba_devs[i], &iomem_resource);
-
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
-
+	mop500_i2c_init();
 	mop500_sdi_init();
+	mop500_spi_init();
+	mop500_uart_init();
 
 	/* If HW is early drop (ED) or V1.0 then use SPI to access AB8500 */
 	if (cpu_is_u8500ed() || cpu_is_u8500v10())
diff --git a/arch/arm/mach-ux500/board-u5500.c b/arch/arm/mach-ux500/board-u5500.c
index 4430e69..fe0ce14 100644
--- a/arch/arm/mach-ux500/board-u5500.c
+++ b/arch/arm/mach-ux500/board-u5500.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/gpio.h>
+#include <linux/irq.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -17,17 +18,20 @@
 #include <mach/devices.h>
 #include <mach/setup.h>
 
-static struct amba_device *amba_board_devs[] __initdata = {
-	&ux500_uart0_device,
-	&ux500_uart1_device,
-	&ux500_uart2_device,
-};
+#include "devices-db5500.h"
+
+static void __init u5500_uart_init(void)
+{
+	db5500_add_uart0();
+	db5500_add_uart1();
+	db5500_add_uart2();
+}
 
 static void __init u5500_init_machine(void)
 {
 	u5500_init_devices();
 
-	amba_add_devices(amba_board_devs, ARRAY_SIZE(amba_board_devs));
+	u5500_uart_init();
 }
 
 MACHINE_START(U8500, "ST-Ericsson U5500 Platform")
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index e9278f6..a9a0206 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -8,6 +8,7 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 
 #include <asm/mach/map.h>
 
@@ -15,6 +16,8 @@
 #include <mach/devices.h>
 #include <mach/setup.h>
 
+#include "devices-db5500.h"
+
 static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GPIO1_BASE, SZ_4K),
@@ -44,7 +47,7 @@ void __init u5500_map_io(void)
 
 void __init u5500_init_devices(void)
 {
-	ux500_init_devices();
+	db5500_add_rtc();
 
 	platform_add_devices(u5500_platform_devs,
 			     ARRAY_SIZE(u5500_platform_devs));
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 4acab75..5966f35 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -22,6 +22,8 @@
 #include <mach/setup.h>
 #include <mach/devices.h>
 
+#include "devices-db8500.h"
+
 static struct platform_device *platform_devs[] __initdata = {
 	&u8500_gpio_devs[0],
 	&u8500_gpio_devs[1],
@@ -152,12 +154,11 @@ void __init u8500_init_devices(void)
 	else
 		pr_warning("ASIC: UNKNOWN SILICON VERSION!\n");
 
-	ux500_init_devices();
-
 	if (cpu_is_u8500ed())
 		dma40_u8500ed_fixup();
 
-	/* Register the platform devices */
+	db8500_add_rtc();
+
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
 	return ;
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index e0fd747..84d0675 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/amba/bus.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 
@@ -44,20 +43,11 @@ static struct map_desc ux500_io_desc[] __initdata = {
 	__IO_DEV_DESC(UX500_BACKUPRAM0_BASE, SZ_8K),
 };
 
-static struct amba_device *ux500_amba_devs[] __initdata = {
-	&ux500_pl031_device,
-};
-
 void __init ux500_map_io(void)
 {
 	iotable_init(ux500_io_desc, ARRAY_SIZE(ux500_io_desc));
 }
 
-void __init ux500_init_devices(void)
-{
-	amba_add_devices(ux500_amba_devs, ARRAY_SIZE(ux500_amba_devs));
-}
-
 void __init ux500_init_irq(void)
 {
 	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
new file mode 100644
index 0000000..9376a24
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -0,0 +1,107 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+
+#include <mach/hardware.h>
+
+#include "devices-common.h"
+
+struct amba_device *
+dbx500_add_amba_device(const char *name, resource_size_t base,
+		       int irq, void *pdata, unsigned int periphid)
+{
+	struct amba_device *dev;
+	int ret;
+
+	dev = kzalloc(sizeof *dev, GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->dev.init_name = name;
+
+	dev->res.start = base;
+	dev->res.end = base + SZ_4K - 1;
+	dev->res.flags = IORESOURCE_MEM;
+
+	dev->dma_mask = DMA_BIT_MASK(32);
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+
+	dev->irq[0] = irq;
+	dev->irq[1] = NO_IRQ;
+
+	dev->periphid = periphid;
+
+	dev->dev.platform_data = pdata;
+
+	ret = amba_device_register(dev, &iomem_resource);
+	if (ret) {
+		kfree(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+static struct platform_device *
+dbx500_add_platform_device(const char *name, int id, void *pdata,
+			   struct resource *res, int resnum)
+{
+	struct platform_device *dev;
+	int ret;
+
+	dev = platform_device_alloc(name, id);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
+	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
+
+	ret = platform_device_add_resources(dev, res, resnum);
+	if (ret)
+		goto out_free;
+
+	dev->dev.platform_data = pdata;
+
+	ret = platform_device_add(dev);
+	if (ret)
+		goto out_free;
+
+	return dev;
+
+out_free:
+	platform_device_put(dev);
+	return ERR_PTR(ret);
+}
+
+struct platform_device *
+dbx500_add_platform_device_4k1irq(const char *name, int id,
+				  resource_size_t base,
+				  int irq, void *pdata)
+{
+	struct resource resources[] = {
+		[0] = {
+			.start	= base,
+			.end	= base + SZ_4K - 1,
+			.flags	= IORESOURCE_MEM,
+		},
+		[1] = {
+			.start	= irq,
+			.end	= irq,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+
+	return dbx500_add_platform_device(name, id, pdata, resources,
+					  ARRAY_SIZE(resources));
+}
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
new file mode 100644
index 0000000..2e1de0e
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#ifndef __DEVICES_COMMON_H
+#define __DEVICES_COMMON_H
+
+extern struct amba_device *
+dbx500_add_amba_device(const char *name, resource_size_t base,
+		       int irq, void *pdata, unsigned int periphid);
+
+extern struct platform_device *
+dbx500_add_platform_device_4k1irq(const char *name, int id,
+				  resource_size_t base,
+				  int irq, void *pdata);
+
+struct spi_master_cntlr;
+
+static inline struct amba_device *
+dbx500_add_msp_spi(const char *name, resource_size_t base, int irq,
+		   struct spi_master_cntlr *pdata)
+{
+	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+}
+
+static inline struct amba_device *
+dbx500_add_spi(const char *name, resource_size_t base, int irq,
+				   struct spi_master_cntlr *pdata)
+{
+	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+}
+
+struct mmci_platform_data;
+
+static inline struct amba_device *
+dbx500_add_sdi(const char *name, resource_size_t base, int irq,
+	       struct mmci_platform_data *pdata)
+{
+	return dbx500_add_amba_device(name, base, irq, pdata, 0);
+}
+
+static inline struct amba_device *
+dbx500_add_uart(const char *name, resource_size_t base, int irq)
+{
+	return dbx500_add_amba_device(name, base, irq, NULL, 0);
+}
+
+struct nmk_i2c_controller;
+
+static inline struct platform_device *
+dbx500_add_i2c(int id, resource_size_t base, int irq,
+	       struct nmk_i2c_controller *pdata)
+{
+	return dbx500_add_platform_device_4k1irq("nmk-i2c", id, base, irq,
+						 pdata);
+}
+
+struct msp_i2s_platform_data;
+
+static inline struct platform_device *
+dbx500_add_msp_i2s(int id, resource_size_t base, int irq,
+		   struct msp_i2s_platform_data *pdata)
+{
+	return dbx500_add_platform_device_4k1irq("MSP_I2S", id, base, irq,
+						 pdata);
+}
+
+static inline struct amba_device *
+dbx500_add_rtc(resource_size_t base, int irq)
+{
+	return dbx500_add_amba_device("rtc-pl031", base, irq, NULL, 0);
+}
+
+#endif
diff --git a/arch/arm/mach-ux500/devices-db5500.h b/arch/arm/mach-ux500/devices-db5500.h
new file mode 100644
index 0000000..c8d7901
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-db5500.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#ifndef __DEVICES_DB5500_H
+#define __DEVICES_DB5500_H
+
+#include "devices-common.h"
+
+#define db5500_add_i2c1(pdata) \
+	dbx500_add_i2c(1, U5500_I2C1_BASE, IRQ_DB5500_I2C1, pdata)
+#define db5500_add_i2c2(pdata) \
+	dbx500_add_i2c(2, U5500_I2C2_BASE, IRQ_DB5500_I2C2, pdata)
+#define db5500_add_i2c3(pdata) \
+	dbx500_add_i2c(3, U5500_I2C3_BASE, IRQ_DB5500_I2C3, pdata)
+
+#define db5500_add_msp0_i2s(pdata) \
+	dbx500_add_msp_i2s(0, U5500_MSP0_BASE, IRQ_DB5500_MSP0, pdata)
+#define db5500_add_msp1_i2s(pdata) \
+	dbx500_add_msp_i2s(1, U5500_MSP1_BASE, IRQ_DB5500_MSP1, pdata)
+#define db5500_add_msp2_i2s(pdata) \
+	dbx500_add_msp_i2s(2, U5500_MSP2_BASE, IRQ_DB5500_MSP2, pdata)
+
+#define db5500_add_msp0_spi(pdata) \
+	dbx500_add_msp_spi("msp0", U5500_MSP0_BASE, IRQ_DB5500_MSP0, pdata)
+#define db5500_add_msp1_spi(pdata) \
+	dbx500_add_msp_spi("msp1", U5500_MSP1_BASE, IRQ_DB5500_MSP1, pdata)
+#define db5500_add_msp2_spi(pdata) \
+	dbx500_add_msp_spi("msp2", U5500_MSP2_BASE, IRQ_DB5500_MSP2, pdata)
+
+#define db5500_add_rtc() \
+	dbx500_add_rtc(U5500_RTC_BASE, IRQ_DB5500_RTC);
+
+#define db5500_add_sdi0(pdata) \
+	dbx500_add_sdi("sdi0", U5500_SDI0_BASE, IRQ_DB5500_SDMMC0, pdata)
+#define db5500_add_sdi1(pdata) \
+	dbx500_add_sdi("sdi1", U5500_SDI1_BASE, IRQ_DB5500_SDMMC1, pdata)
+#define db5500_add_sdi2(pdata) \
+	dbx500_add_sdi("sdi2", U5500_SDI2_BASE, IRQ_DB5500_SDMMC2, pdata)
+#define db5500_add_sdi3(pdata) \
+	dbx500_add_sdi("sdi3", U5500_SDI3_BASE, IRQ_DB5500_SDMMC3, pdata)
+#define db5500_add_sdi4(pdata) \
+	dbx500_add_sdi("sdi4", U5500_SDI4_BASE, IRQ_DB5500_SDMMC4, pdata)
+
+#define db5500_add_spi0(pdata) \
+	dbx500_add_spi("spi0", U5500_SPI0_BASE, IRQ_DB5500_SPI0, pdata)
+#define db5500_add_spi1(pdata) \
+	dbx500_add_spi("spi1", U5500_SPI1_BASE, IRQ_DB5500_SPI1, pdata)
+#define db5500_add_spi2(pdata) \
+	dbx500_add_spi("spi2", U5500_SPI2_BASE, IRQ_DB5500_SPI2, pdata)
+#define db5500_add_spi3(pdata) \
+	dbx500_add_spi("spi3", U5500_SPI3_BASE, IRQ_DB5500_SPI3, pdata)
+
+#define db5500_add_uart0() \
+	dbx500_add_uart("uart0", U5500_UART0_BASE, IRQ_DB5500_UART0)
+#define db5500_add_uart1() \
+	dbx500_add_uart("uart1", U5500_UART1_BASE, IRQ_DB5500_UART1)
+#define db5500_add_uart2() \
+	dbx500_add_uart("uart2", U5500_UART2_BASE, IRQ_DB5500_UART2)
+#define db5500_add_uart3() \
+	dbx500_add_uart("uart3", U5500_UART3_BASE, IRQ_DB5500_UART3)
+
+#endif
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f2e01a6..2fba75c 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -55,137 +55,6 @@ struct platform_device u8500_gpio_devs[] = {
 	GPIO_DEVICE(8),
 };
 
-struct amba_device u8500_ssp0_device = {
-	.dev = {
-		.coherent_dma_mask = ~0,
-		.init_name = "ssp0",
-	},
-	.res = {
-		.start = U8500_SSP0_BASE,
-		.end   = U8500_SSP0_BASE + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	.irq = {IRQ_DB8500_SSP0, NO_IRQ },
-	/* ST-Ericsson modified id */
-	.periphid = SSP_PER_ID,
-};
-
-static struct resource u8500_i2c0_resources[] = {
-	[0] = {
-		.start	= U8500_I2C0_BASE,
-		.end	= U8500_I2C0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_DB8500_I2C0,
-		.end	= IRQ_DB8500_I2C0,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device u8500_i2c0_device = {
-	.name		= "nmk-i2c",
-	.id		= 0,
-	.resource	= u8500_i2c0_resources,
-	.num_resources	= ARRAY_SIZE(u8500_i2c0_resources),
-};
-
-static struct resource u8500_i2c4_resources[] = {
-	[0] = {
-		.start	= U8500_I2C4_BASE,
-		.end	= U8500_I2C4_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_DB8500_I2C4,
-		.end	= IRQ_DB8500_I2C4,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-struct platform_device u8500_i2c4_device = {
-	.name		= "nmk-i2c",
-	.id		= 4,
-	.resource	= u8500_i2c4_resources,
-	.num_resources	= ARRAY_SIZE(u8500_i2c4_resources),
-};
-
-/*
- * SD/MMC
- */
-
-struct amba_device u8500_sdi0_device = {
-	.dev		= {
-		.init_name = "sdi0",
-	},
-	.res		= {
-		.start	= U8500_SDI0_BASE,
-		.end	= U8500_SDI0_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC0, NO_IRQ},
-};
-
-struct amba_device u8500_sdi1_device = {
-	.dev		= {
-		.init_name = "sdi1",
-	},
-	.res		= {
-		.start	= U8500_SDI1_BASE,
-		.end	= U8500_SDI1_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC1, NO_IRQ},
-};
-
-struct amba_device u8500_sdi2_device = {
-	.dev		= {
-		.init_name = "sdi2",
-	},
-	.res		= {
-		.start	= U8500_SDI2_BASE,
-		.end	= U8500_SDI2_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC2, NO_IRQ},
-};
-
-struct amba_device u8500_sdi3_device = {
-	.dev		= {
-		.init_name = "sdi3",
-	},
-	.res		= {
-		.start	= U8500_SDI3_BASE,
-		.end	= U8500_SDI3_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC3, NO_IRQ},
-};
-
-struct amba_device u8500_sdi4_device = {
-	.dev		= {
-		.init_name = "sdi4",
-	},
-	.res		= {
-		.start	= U8500_SDI4_BASE,
-		.end	= U8500_SDI4_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC4, NO_IRQ},
-};
-
-struct amba_device u8500_sdi5_device = {
-	.dev		= {
-		.init_name = "sdi5",
-	},
-	.res		= {
-		.start	= U8500_SDI5_BASE,
-		.end	= U8500_SDI5_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq		= {IRQ_DB8500_SDMMC5, NO_IRQ},
-};
-
 static struct resource dma40_resources[] = {
 	[0] = {
 		.start = U8500_DMA_BASE,
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
new file mode 100644
index 0000000..3a770c7
--- /dev/null
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+#ifndef __DEVICES_DB8500_H
+#define __DEVICES_DB8500_H
+
+#include "devices-common.h"
+
+struct ske_keypad_platform_data;
+struct pl022_ssp_controller;
+
+static inline struct platform_device *
+db8500_add_ske_keypad(struct ske_keypad_platform_data *pdata)
+{
+	return dbx500_add_platform_device_4k1irq("nmk-ske-keypad", -1,
+						 U8500_SKE_BASE,
+						 IRQ_DB8500_KB, pdata);
+}
+
+static inline struct amba_device *
+db8500_add_ssp(const char *name, resource_size_t base, int irq,
+	       struct pl022_ssp_controller *pdata)
+{
+	return dbx500_add_amba_device(name, base, irq, pdata, SSP_PER_ID);
+}
+
+
+#define db8500_add_i2c0(pdata) \
+	dbx500_add_i2c(0, U8500_I2C0_BASE, IRQ_DB8500_I2C0, pdata)
+#define db8500_add_i2c1(pdata) \
+	dbx500_add_i2c(1, U8500_I2C1_BASE, IRQ_DB8500_I2C1, pdata)
+#define db8500_add_i2c2(pdata) \
+	dbx500_add_i2c(2, U8500_I2C2_BASE, IRQ_DB8500_I2C2, pdata)
+#define db8500_add_i2c3(pdata) \
+	dbx500_add_i2c(3, U8500_I2C3_BASE, IRQ_DB8500_I2C3, pdata)
+#define db8500_add_i2c4(pdata) \
+	dbx500_add_i2c(4, U8500_I2C4_BASE, IRQ_DB8500_I2C4, pdata)
+
+#define db8500_add_msp0_i2s(pdata) \
+	dbx500_add_msp_i2s(0, U8500_MSP0_BASE, IRQ_DB8500_MSP0, pdata)
+#define db8500_add_msp1_i2s(pdata) \
+	dbx500_add_msp_i2s(1, U8500_MSP1_BASE, IRQ_DB8500_MSP1, pdata)
+#define db8500_add_msp2_i2s(pdata) \
+	dbx500_add_msp_i2s(2, U8500_MSP2_BASE, IRQ_DB8500_MSP2, pdata)
+#define db8500_add_msp3_i2s(pdata) \
+	dbx500_add_msp_i2s(3, U8500_MSP3_BASE, IRQ_DB8500_MSP1, pdata)
+
+#define db8500_add_msp0_spi(pdata) \
+	dbx500_add_msp_spi("msp0", U8500_MSP0_BASE, IRQ_DB8500_MSP0, pdata)
+#define db8500_add_msp1_spi(pdata) \
+	dbx500_add_msp_spi("msp1", U8500_MSP1_BASE, IRQ_DB8500_MSP1, pdata)
+#define db8500_add_msp2_spi(pdata) \
+	dbx500_add_msp_spi("msp2", U8500_MSP2_BASE, IRQ_DB8500_MSP2, pdata)
+#define db8500_add_msp3_spi(pdata) \
+	dbx500_add_msp_spi("msp3", U8500_MSP3_BASE, IRQ_DB8500_MSP1, pdata)
+
+#define db8500_add_rtc() \
+	dbx500_add_rtc(U8500_RTC_BASE, IRQ_DB8500_RTC);
+
+#define db8500_add_sdi0(pdata) \
+	dbx500_add_sdi("sdi0", U8500_SDI0_BASE, IRQ_DB8500_SDMMC0, pdata)
+#define db8500_add_sdi1(pdata) \
+	dbx500_add_sdi("sdi1", U8500_SDI1_BASE, IRQ_DB8500_SDMMC1, pdata)
+#define db8500_add_sdi2(pdata) \
+	dbx500_add_sdi("sdi2", U8500_SDI2_BASE, IRQ_DB8500_SDMMC2, pdata)
+#define db8500_add_sdi3(pdata) \
+	dbx500_add_sdi("sdi3", U8500_SDI3_BASE, IRQ_DB8500_SDMMC3, pdata)
+#define db8500_add_sdi4(pdata) \
+	dbx500_add_sdi("sdi4", U8500_SDI4_BASE, IRQ_DB8500_SDMMC4, pdata)
+#define db8500_add_sdi5(pdata) \
+	dbx500_add_sdi("sdi5", U8500_SDI5_BASE, IRQ_DB8500_SDMMC5, pdata)
+
+#define db8500_add_ssp0(pdata) \
+	db8500_add_ssp("ssp0", U8500_SSP0_BASE, IRQ_DB8500_SSP0, pdata)
+#define db8500_add_ssp1(pdata) \
+	db8500_add_ssp("ssp1", U8500_SSP1_BASE, IRQ_DB8500_SSP1, pdata)
+
+#define db8500_add_spi0(pdata) \
+	dbx500_add_spi("spi0", U8500_SPI0_BASE, IRQ_DB8500_SPI0, pdata)
+#define db8500_add_spi1(pdata) \
+	dbx500_add_spi("spi1", U8500_SPI1_BASE, IRQ_DB8500_SPI1, pdata)
+#define db8500_add_spi2(pdata) \
+	dbx500_add_spi("spi2", U8500_SPI2_BASE, IRQ_DB8500_SPI2, pdata)
+#define db8500_add_spi3(pdata) \
+	dbx500_add_spi("spi3", U8500_SPI3_BASE, IRQ_DB8500_SPI3, pdata)
+
+#define db8500_add_uart0() \
+	dbx500_add_uart("uart0", U8500_UART0_BASE, IRQ_DB8500_UART0)
+#define db8500_add_uart1() \
+	dbx500_add_uart("uart1", U8500_UART1_BASE, IRQ_DB8500_UART1)
+#define db8500_add_uart2() \
+	dbx500_add_uart("uart2", U8500_UART2_BASE, IRQ_DB8500_UART2)
+
+#endif
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index 8a26889..ea0a2f9 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -14,69 +14,6 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
-#define __MEM_4K_RESOURCE(x) \
-	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
-
-struct amba_device ux500_pl031_device = {
-	.dev = {
-		.init_name = "pl031",
-	},
-	.res = {
-		.start	= UX500_RTC_BASE,
-		.end	= UX500_RTC_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	.irq = {IRQ_RTC_RTT, NO_IRQ},
-};
-
-struct amba_device ux500_uart0_device = {
-	.dev = { .init_name = "uart0" },
-	__MEM_4K_RESOURCE(UX500_UART0_BASE),
-	.irq = {IRQ_UART0, NO_IRQ},
-};
-
-struct amba_device ux500_uart1_device = {
-	.dev = { .init_name = "uart1" },
-	__MEM_4K_RESOURCE(UX500_UART1_BASE),
-	.irq = {IRQ_UART1, NO_IRQ},
-};
-
-struct amba_device ux500_uart2_device = {
-	.dev = { .init_name = "uart2" },
-	__MEM_4K_RESOURCE(UX500_UART2_BASE),
-	.irq = {IRQ_UART2, NO_IRQ},
-};
-
-#define UX500_I2C_RESOURCES(id, size)				\
-static struct resource ux500_i2c##id##_resources[] = {		\
-	[0] = {							\
-		.start	= UX500_I2C##id##_BASE,			\
-		.end	= UX500_I2C##id##_BASE + size - 1,	\
-		.flags	= IORESOURCE_MEM,			\
-	},							\
-	[1] = {							\
-		.start	= IRQ_I2C##id,				\
-		.end	= IRQ_I2C##id,				\
-		.flags	= IORESOURCE_IRQ			\
-	}							\
-}
-
-UX500_I2C_RESOURCES(1, SZ_4K);
-UX500_I2C_RESOURCES(2, SZ_4K);
-UX500_I2C_RESOURCES(3, SZ_4K);
-
-#define UX500_I2C_PDEVICE(cid)					\
-struct platform_device ux500_i2c##cid##_device = {		\
-	.name		= "nmk-i2c",				\
-	.id		= cid,					\
-	.num_resources	= 2,					\
-	.resource	= ux500_i2c##cid##_resources,		\
-}
-
-UX500_I2C_PDEVICE(1);
-UX500_I2C_PDEVICE(2);
-UX500_I2C_PDEVICE(3);
-
 void __init amba_add_devices(struct amba_device *devs[], int num)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/include/mach/devices.h b/arch/arm/mach-ux500/include/mach/devices.h
index 33a120c..7611067 100644
--- a/arch/arm/mach-ux500/include/mach/devices.h
+++ b/arch/arm/mach-ux500/include/mach/devices.h
@@ -14,26 +14,9 @@ extern struct platform_device u5500_gpio_devs[];
 extern struct platform_device u8500_gpio_devs[];
 
 extern struct amba_device ux500_pl031_device;
-extern struct amba_device u8500_ssp0_device;
-extern struct amba_device ux500_uart0_device;
-extern struct amba_device ux500_uart1_device;
-extern struct amba_device ux500_uart2_device;
 
-extern struct platform_device ux500_i2c1_device;
-extern struct platform_device ux500_i2c2_device;
-extern struct platform_device ux500_i2c3_device;
-
-extern struct platform_device u8500_i2c0_device;
-extern struct platform_device u8500_i2c4_device;
 extern struct platform_device u8500_dma40_device;
 
-extern struct amba_device u8500_sdi0_device;
-extern struct amba_device u8500_sdi1_device;
-extern struct amba_device u8500_sdi2_device;
-extern struct amba_device u8500_sdi3_device;
-extern struct amba_device u8500_sdi4_device;
-extern struct amba_device u8500_sdi5_device;
-
 void dma40_u8500ed_fixup(void);
 
 #endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 54bbe64..322a1c1 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -18,7 +18,6 @@ extern void __init ux500_map_io(void);
 extern void __init u5500_map_io(void);
 extern void __init u8500_map_io(void);
 
-extern void __init ux500_init_devices(void);
 extern void __init u5500_init_devices(void);
 extern void __init u8500_init_devices(void);
 
@@ -26,6 +25,7 @@ extern void __init ux500_init_irq(void);
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
+struct amba_device;
 extern void __init amba_add_devices(struct amba_device *devs[], int num);
 
 struct sys_timer;
-- 
1.7.2.dirty
