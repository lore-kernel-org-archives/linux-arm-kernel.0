From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 4 Dec 2009 10:05:14 -0500
Subject: [PATCH] [ARM] mmp: add device support in armada610
Message-ID: <mailman.73.1260166814.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add uart, twsi devie support in armada610. Add mfp configuration in armada610.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Makefile                     |    1 +
 arch/arm/mach-mmp/armada610.c                  |   83 ++++++++
 arch/arm/mach-mmp/include/mach/armada610.h     |   60 ++++++
 arch/arm/mach-mmp/include/mach/devices.h       |   12 ++
 arch/arm/mach-mmp/include/mach/mfp-armada610.h |  241 ++++++++++++++++++++++++
 5 files changed, 397 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/armada610.c
 create mode 100644 arch/arm/mach-mmp/include/mach/armada610.h
 create mode 100644 arch/arm/mach-mmp/include/mach/mfp-armada610.h

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 6883e65..a6da617 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -7,6 +7,7 @@ obj-y				+= common.o clock.o devices.o irq.o time.o
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
+obj-$(CONFIG_CPU_ARMADA610)	+= armada610.o

 # board support
 obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
diff --git a/arch/arm/mach-mmp/armada610.c b/arch/arm/mach-mmp/armada610.c
new file mode 100644
index 0000000..2d05040
--- /dev/null
+++ b/arch/arm/mach-mmp/armada610.c
@@ -0,0 +1,83 @@
+/*
+ * linux/arch/arm/mach-mmp/armada610.c
+ *
+ * code specific to ARMADA610 aka MMP2
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+
+#include <mach/addr-map.h>
+#include <mach/regs-apbc.h>
+#include <mach/regs-apmu.h>
+#include <mach/cputype.h>
+#include <mach/irqs.h>
+#include <mach/mfp.h>
+#include <mach/devices.h>
+
+#include "common.h"
+#include "clock.h"
+
+#define MFPR_VIRT_BASE	(APB_VIRT_BASE + 0x1e000)
+
+/* APB peripheral clocks */
+static APBC_CLK(uart1, ARMADA610_UART1, 1, 26000000);
+static APBC_CLK(uart2, ARMADA610_UART2, 1, 26000000);
+static APBC_CLK(uart3, ARMADA610_UART3, 1, 26000000);
+static APBC_CLK(uart4, ARMADA610_UART4, 1, 26000000);
+static APBC_CLK(twsi1, ARMADA610_TWSI1, 0, 26000000);
+static APBC_CLK(twsi2, ARMADA610_TWSI2, 0, 26000000);
+static APBC_CLK(twsi3, ARMADA610_TWSI3, 0, 26000000);
+static APBC_CLK(twsi4, ARMADA610_TWSI4, 0, 26000000);
+static APBC_CLK(twsi5, ARMADA610_TWSI5, 0, 26000000);
+static APBC_CLK(twsi6, ARMADA610_TWSI6, 0, 26000000);
+static APBC_CLK(rtc, ARMADA610_RTC, 0, 32768);
+
+static APMU_CLK(nand, NAND, 0xbf, 100000000);
+
+static struct clk_lookup armada610_clkregs[] = {
+	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
+	INIT_CLKREG(&clk_uart2, "pxa2xx-uart.1", NULL),
+	INIT_CLKREG(&clk_uart3, "pxa2xx-uart.2", NULL),
+	INIT_CLKREG(&clk_uart4, "pxa2xx-uart.3", NULL),
+	INIT_CLKREG(&clk_twsi1, "pxa2xx-i2c.0", NULL),
+	INIT_CLKREG(&clk_twsi2, "pxa2xx-i2c.1", NULL),
+	INIT_CLKREG(&clk_twsi3, "pxa2xx-i2c.2", NULL),
+	INIT_CLKREG(&clk_twsi4, "pxa2xx-i2c.3", NULL),
+	INIT_CLKREG(&clk_twsi5, "pxa2xx-i2c.4", NULL),
+	INIT_CLKREG(&clk_twsi6, "pxa2xx-i2c.5", NULL),
+	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+};
+
+static int __init armada610_init(void)
+{
+	if (cpu_is_armada610()) {
+		mfp_init_base(MFPR_VIRT_BASE);
+		clks_register(ARRAY_AND_SIZE(armada610_clkregs));
+	}
+
+	return 0;
+}
+postcore_initcall(armada610_init);
+
+/* on-chip devices */
+ARMADA610_DEVICE(uart1, "pxa2xx-uart", 0, UART1, 0xd4030000, 0x30, 4, 5);
+ARMADA610_DEVICE(uart2, "pxa2xx-uart", 1, UART2, 0xd4017000, 0x30, 20, 21);
+ARMADA610_DEVICE(uart3, "pxa2xx-uart", 2, UART3, 0xd4018000, 0x30, 22, 23);
+ARMADA610_DEVICE(uart4, "pxa2xx-uart", 3, UART4, 0xd4016000, 0x30, 18, 19);
+ARMADA610_DEVICE(twsi1, "pxa2xx-i2c", 0, TWSI1, 0xd4011000, 0x70);
+ARMADA610_DEVICE(twsi2, "pxa2xx-i2c", 1, TWSI2, 0xd4031000, 0x70);
+ARMADA610_DEVICE(twsi3, "pxa2xx-i2c", 2, TWSI3, 0xd4032000, 0x70);
+ARMADA610_DEVICE(twsi4, "pxa2xx-i2c", 3, TWSI4, 0xd4033000, 0x70);
+ARMADA610_DEVICE(twsi5, "pxa2xx-i2c", 4, TWSI5, 0xd4033800, 0x70);
+ARMADA610_DEVICE(twsi6, "pxa2xx-i2c", 5, TWSI6, 0xd4034000, 0x70);
+ARMADA610_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x100, 28, 29);
+
diff --git a/arch/arm/mach-mmp/include/mach/armada610.h
b/arch/arm/mach-mmp/include/mach/armada610.h
new file mode 100644
index 0000000..6f2d499
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/armada610.h
@@ -0,0 +1,60 @@
+#ifndef __ASM_MACH_ARMADA610_H
+#define __ASM_MACH_ARMADA610_H
+
+#include <linux/i2c.h>
+#include <mach/devices.h>
+#include <plat/i2c.h>
+
+extern struct pxa_device_desc armada610_device_uart1;
+extern struct pxa_device_desc armada610_device_uart2;
+extern struct pxa_device_desc armada610_device_uart3;
+extern struct pxa_device_desc armada610_device_uart4;
+extern struct pxa_device_desc armada610_device_twsi1;
+extern struct pxa_device_desc armada610_device_twsi2;
+extern struct pxa_device_desc armada610_device_twsi3;
+extern struct pxa_device_desc armada610_device_twsi4;
+extern struct pxa_device_desc armada610_device_twsi5;
+extern struct pxa_device_desc armada610_device_twsi6;
+
+static inline int armada610_add_uart(int id)
+{
+	struct pxa_device_desc *d = NULL;
+
+	switch (id) {
+	case 1: d = &armada610_device_uart1; break;
+	case 2: d = &armada610_device_uart2; break;
+	case 3: d = &armada610_device_uart3; break;
+	case 4: d = &armada610_device_uart4; break;
+	default:
+		return -EINVAL;
+	}
+
+	return pxa_register_device(d, NULL, 0);
+}
+
+static inline int armada610_add_twsi(int id, struct
i2c_pxa_platform_data *data,
+				  struct i2c_board_info *info, unsigned size)
+{
+	struct pxa_device_desc *d = NULL;
+	int ret;
+
+	switch (id) {
+	case 0: d = &armada610_device_twsi1; break;
+	case 1: d = &armada610_device_twsi2; break;
+	case 2: d = &armada610_device_twsi3; break;
+	case 3: d = &armada610_device_twsi4; break;
+	case 4: d = &armada610_device_twsi5; break;
+	case 5: d = &armada610_device_twsi6; break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = i2c_register_board_info(id, info, size);
+	if (ret)
+		return ret;
+
+	return pxa_register_device(d, data, sizeof(*data));
+}
+
+#endif /* __ASM_MACH_ARMADA610_H */
+
diff --git a/arch/arm/mach-mmp/include/mach/devices.h
b/arch/arm/mach-mmp/include/mach/devices.h
index 2458539..a991618 100644
--- a/arch/arm/mach-mmp/include/mach/devices.h
+++ b/arch/arm/mach-mmp/include/mach/devices.h
@@ -34,4 +34,16 @@ struct pxa_device_desc pxa910_device_##_name
__initdata = {		\
 	.size		= _size,					\
 	.dma		= { _dma },					\
 };
+
+#define ARMADA610_DEVICE(_name, _drv, _id, _irq, _start, _size, _dma...)   \
+struct pxa_device_desc armada610_device_##_name __initdata = {             \
+	.dev_name       = "armada610-" #_name,                             \
+	.drv_name       = _drv,                                         \
+	.id             = _id,                                          \
+	.irq            = IRQ_ARMADA610_##_irq,                            \
+	.start          = _start,                                       \
+	.size           = _size,                                        \
+	.dma            = { _dma },                                     \
+}
+
 extern int pxa_register_device(struct pxa_device_desc *, void *, size_t);
diff --git a/arch/arm/mach-mmp/include/mach/mfp-armada610.h
b/arch/arm/mach-mmp/include/mach/mfp-armada610.h
new file mode 100644
index 0000000..3a27fb4
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/mfp-armada610.h
@@ -0,0 +1,241 @@
+#ifndef __ASM_MACH_MFP_ARMADA610_H
+#define __ASM_MACH_MFP_ARMADA610_H
+
+#include <mach/mfp.h>
+
+#define MFP_DRIVE_VERY_SLOW	(0x0 << 13)
+#define MFP_DRIVE_SLOW		(0x2 << 13)
+#define MFP_DRIVE_MEDIUM	(0x4 << 13)
+#define MFP_DRIVE_FAST		(0x8 << 13)
+
+/* GPIO */
+
+/* DFI */
+#define GPIO108_DFI_D15		MFP_CFG(GPIO108, AF0)
+#define GPIO109_DFI_D14		MFP_CFG(GPIO109, AF0)
+#define GPIO110_DFI_D13		MFP_CFG(GPIO110, AF0)
+#define GPIO161_DFI_D12		MFP_CFG(GPIO161, AF0)
+#define GPIO162_DFI_D11		MFP_CFG(GPIO162, AF0)
+#define GPIO163_DFI_D10		MFP_CFG(GPIO163, AF0)
+#define GPIO164_DFI_D9		MFP_CFG(GPIO164, AF0)
+#define GPIO111_DFI_D8		MFP_CFG(GPIO111, AF0)
+#define GPIO104_DFI_D7		MFP_CFG(GPIO104, AF0)
+#define GPIO105_DFI_D6		MFP_CFG(GPIO105, AF0)
+#define GPIO106_DFI_D5		MFP_CFG(GPIO106, AF0)
+#define GPIO107_DFI_D4		MFP_CFG(GPIO107, AF0)
+#define GPIO165_DFI_D3		MFP_CFG(GPIO165, AF0)
+#define GPIO166_DFI_D2		MFP_CFG(GPIO166, AF0)
+#define GPIO167_DFI_D1		MFP_CFG(GPIO167, AF0)
+#define GPIO168_DFI_D0		MFP_CFG(GPIO168, AF0)
+#define GPIO143_ND_nCS0		MFP_CFG(GPIO143, AF0)
+#define GPIO144_ND_nCS1		MFP_CFG(GPIO144, AF0)
+#define GPIO147_ND_nWE		MFP_CFG(GPIO147, AF0)
+#define GPIO148_ND_nRE		MFP_CFG(GPIO148, AF0)
+#define GPIO150_ND_ALE		MFP_CFG(GPIO150, AF0)
+#define GPIO149_ND_CLE		MFP_CFG(GPIO149, AF0)
+#define GPIO112_ND_RDY0		MFP_CFG(GPIO112, AF0)
+#define GPIO160_ND_RDY1		MFP_CFG(GPIO160, AF0)
+
+/* Static Memory Controller */
+#define GPIO145_SMC_nCS0	MFP_CFG(GPIO145, AF0)
+#define GPIO146_SMC_nCS1	MFP_CFG(GPIO146, AF0)
+#define GPIO152_SMC_BE0		MFP_CFG(GPIO152, AF0)
+#define GPIO153_SMC_BE1		MFP_CFG(GPIO153, AF0)
+#define GPIO154_SMC_IRQ		MFP_CFG(GPIO154, AF0)
+#define GPIO113_SMC_RDY		MFP_CFG(GPIO113, AF0)
+#define GPIO151_SMC_SCLK	MFP_CFG(GPIO151, AF0)
+
+/* Ethernet */
+#define GPIO155_SM_ADVMUX	MFP_CFG(GPIO155, AF2)
+#define GPIO155_GPIO155		MFP_CFG(GPIO155, AF1)
+
+/* UART1 */
+#define GPIO45_UART1_RXD	MFP_CFG(GPIO45, AF1)
+#define GPIO46_UART1_TXD	MFP_CFG(GPIO46, AF1)
+#define GPIO29_UART1_RXD	MFP_CFG(GPIO29, AF1)
+#define GPIO30_UART1_TXD	MFP_CFG(GPIO30, AF1)
+#define GPIO31_UART1_CTS	MFP_CFG(GPIO31, AF1)
+#define GPIO32_UART1_RTS	MFP_CFG(GPIO32, AF1)
+
+/* UART2 */
+#define GPIO47_UART2_RXD	MFP_CFG(GPIO47, AF1)
+#define GPIO48_UART2_TXD	MFP_CFG(GPIO48, AF1)
+#define GPIO49_UART2_CTS	MFP_CFG(GPIO49, AF1)
+#define GPIO50_UART2_RTS	MFP_CFG(GPIO50, AF1)
+
+/* UART3 */
+#define GPIO51_UART3_RXD	MFP_CFG(GPIO51, AF1)
+#define GPIO52_UART3_TXD	MFP_CFG(GPIO52, AF1)
+#define GPIO53_UART3_CTS	MFP_CFG(GPIO53, AF1)
+#define GPIO54_UART3_RTS	MFP_CFG(GPIO54, AF1)
+
+/* MMC1 */
+#define GPIO124_MMC1_DAT7	MFP_CFG_DRV(GPIO124, AF1, FAST)
+#define GPIO125_MMC1_DAT6	MFP_CFG_DRV(GPIO125, AF1, FAST)
+#define GPIO129_MMC1_DAT5	MFP_CFG_DRV(GPIO129, AF1, FAST)
+#define GPIO130_MMC1_DAT4	MFP_CFG_DRV(GPIO130, AF1, FAST)
+#define GPIO131_MMC1_DAT3	MFP_CFG_DRV(GPIO131, AF1, FAST)
+#define GPIO132_MMC1_DAT2	MFP_CFG_DRV(GPIO132, AF1, FAST)
+#define GPIO133_MMC1_DAT1	MFP_CFG_DRV(GPIO133, AF1, FAST)
+#define GPIO134_MMC1_DAT0	MFP_CFG_DRV(GPIO134, AF1, FAST)
+#define GPIO136_MMC1_CMD	MFP_CFG_DRV(GPIO136, AF1, FAST)
+#define GPIO139_MMC1_CLK	MFP_CFG_DRV(GPIO139, AF1, FAST)
+#define GPIO140_MMC1_CD		MFP_CFG_DRV(GPIO140, AF1, FAST)
+#define GPIO141_MMC1_WP		MFP_CFG_DRV(GPIO141, AF1, FAST)
+
+/*MMC2*/
+#define GPIO37_MMC2_DAT3	MFP_CFG_DRV(GPIO37, AF1, FAST)
+#define GPIO38_MMC2_DAT2	MFP_CFG_DRV(GPIO38, AF1, FAST)
+#define GPIO39_MMC2_DAT1	MFP_CFG_DRV(GPIO39, AF1, FAST)
+#define GPIO40_MMC2_DAT0	MFP_CFG_DRV(GPIO40, AF1, FAST)
+#define GPIO41_MMC2_CMD		MFP_CFG_DRV(GPIO41, AF1, FAST)
+#define GPIO42_MMC2_CLK		MFP_CFG_DRV(GPIO42, AF1, FAST)
+
+/*MMC3*/
+#define GPIO165_MMC3_DAT7	MFP_CFG_DRV(GPIO165, AF2, FAST)
+#define GPIO162_MMC3_DAT6	MFP_CFG_DRV(GPIO162, AF2, FAST)
+#define GPIO166_MMC3_DAT5	MFP_CFG_DRV(GPIO166, AF2, FAST)
+#define GPIO163_MMC3_DAT4	MFP_CFG_DRV(GPIO163, AF2, FAST)
+#define GPIO167_MMC3_DAT3	MFP_CFG_DRV(GPIO167, AF2, FAST)
+#define GPIO164_MMC3_DAT2	MFP_CFG_DRV(GPIO164, AF2, FAST)
+#define GPIO168_MMC3_DAT1	MFP_CFG_DRV(GPIO168, AF2, FAST)
+#define GPIO111_MMC3_DAT0	MFP_CFG_DRV(GPIO111, AF2, FAST)
+#define GPIO112_MMC3_CMD	MFP_CFG_DRV(GPIO112, AF2, FAST)
+#define GPIO151_MMC3_CLK	MFP_CFG_DRV(GPIO151, AF2, FAST)
+
+/* LCD */
+#define GPIO74_LCD_FCLK		MFP_CFG_DRV(GPIO74, AF1, FAST)
+#define GPIO75_LCD_LCLK		MFP_CFG_DRV(GPIO75, AF1, FAST)
+#define GPIO76_LCD_PCLK		MFP_CFG_DRV(GPIO76, AF1, FAST)
+#define GPIO77_LCD_DENA		MFP_CFG_DRV(GPIO77, AF1, FAST)
+#define GPIO78_LCD_DD0		MFP_CFG_DRV(GPIO78, AF1, FAST)
+#define GPIO79_LCD_DD1		MFP_CFG_DRV(GPIO79, AF1, FAST)
+#define GPIO80_LCD_DD2		MFP_CFG_DRV(GPIO80, AF1, FAST)
+#define GPIO81_LCD_DD3		MFP_CFG_DRV(GPIO81, AF1, FAST)
+#define GPIO82_LCD_DD4		MFP_CFG_DRV(GPIO82, AF1, FAST)
+#define GPIO83_LCD_DD5		MFP_CFG_DRV(GPIO83, AF1, FAST)
+#define GPIO84_LCD_DD6		MFP_CFG_DRV(GPIO84, AF1, FAST)
+#define GPIO85_LCD_DD7		MFP_CFG_DRV(GPIO85, AF1, FAST)
+#define GPIO86_LCD_DD8		MFP_CFG_DRV(GPIO86, AF1, FAST)
+#define GPIO87_LCD_DD9		MFP_CFG_DRV(GPIO87, AF1, FAST)
+#define GPIO88_LCD_DD10		MFP_CFG_DRV(GPIO88, AF1, FAST)
+#define GPIO89_LCD_DD11		MFP_CFG_DRV(GPIO89, AF1, FAST)
+#define GPIO90_LCD_DD12		MFP_CFG_DRV(GPIO90, AF1, FAST)
+#define GPIO91_LCD_DD13		MFP_CFG_DRV(GPIO91, AF1, FAST)
+#define GPIO92_LCD_DD14		MFP_CFG_DRV(GPIO92, AF1, FAST)
+#define GPIO93_LCD_DD15		MFP_CFG_DRV(GPIO93, AF1, FAST)
+#define GPIO94_LCD_DD16		MFP_CFG_DRV(GPIO94, AF1, FAST)
+#define GPIO95_LCD_DD17		MFP_CFG_DRV(GPIO95, AF1, FAST)
+#define GPIO96_LCD_DD18		MFP_CFG_DRV(GPIO96, AF1, FAST)
+#define GPIO97_LCD_DD19		MFP_CFG_DRV(GPIO97, AF1, FAST)
+#define GPIO98_LCD_DD20		MFP_CFG_DRV(GPIO98, AF1, FAST)
+#define GPIO99_LCD_DD21		MFP_CFG_DRV(GPIO99, AF1, FAST)
+#define GPIO100_LCD_DD22	MFP_CFG_DRV(GPIO100, AF1, FAST)
+#define GPIO101_LCD_DD23	MFP_CFG_DRV(GPIO101, AF1, FAST)
+#define GPIO94_SPI_DCLK		MFP_CFG_DRV(GPIO94, AF3, FAST)
+#define GPIO95_SPI_CS0		MFP_CFG_DRV(GPIO95, AF3, FAST)
+#define GPIO96_SPI_DIN		MFP_CFG_DRV(GPIO96, AF3, FAST)
+#define GPIO97_SPI_DOUT		MFP_CFG_DRV(GPIO97, AF3, FAST)
+#define GPIO98_LCD_RST		MFP_CFG_DRV(GPIO98, AF0, FAST)
+
+#define GPIO114_MN_CLK_OUT	MFP_CFG_DRV(GPIO114, AF1, FAST)
+
+/*LCD TV path*/
+#define GPIO124_LCD_DD24	MFP_CFG_DRV(GPIO124, AF2, FAST)
+#define GPIO125_LCD_DD25	MFP_CFG_DRV(GPIO125, AF2, FAST)
+#define GPIO126_LCD_DD33	MFP_CFG_DRV(GPIO126, AF2, FAST)
+#define GPIO127_LCD_DD26	MFP_CFG_DRV(GPIO127, AF2, FAST)
+#define GPIO128_LCD_DD27	MFP_CFG_DRV(GPIO128, AF2, FAST)
+#define GPIO129_LCD_DD28	MFP_CFG_DRV(GPIO129, AF2, FAST)
+#define GPIO130_LCD_DD29	MFP_CFG_DRV(GPIO130, AF2, FAST)
+#define GPIO135_LCD_DD30	MFP_CFG_DRV(GPIO135, AF2, FAST)
+#define GPIO137_LCD_DD31	MFP_CFG_DRV(GPIO137, AF2, FAST)
+#define GPIO138_LCD_DD32	MFP_CFG_DRV(GPIO138, AF2, FAST)
+#define GPIO140_LCD_DD34	MFP_CFG_DRV(GPIO140, AF2, FAST)
+#define GPIO141_LCD_DD35	MFP_CFG_DRV(GPIO141, AF2, FAST)
+
+/* I2C */
+#define TWSI1_SCL		MFP_CFG_DRV(TWSI1_SCL, AF0, SLOW)
+#define TWSI1_SDA		MFP_CFG_DRV(TWSI1_SDA, AF0, SLOW)
+#define GPIO43_TWSI2_SCL	MFP_CFG_DRV(GPIO43, AF1, SLOW)
+#define GPIO44_TWSI2_SDA	MFP_CFG_DRV(GPIO44, AF1, SLOW)
+#define GPIO71_TWSI3_SCL	MFP_CFG_DRV(GPIO71, AF1, SLOW)
+#define GPIO72_TWSI3_SDA	MFP_CFG_DRV(GPIO72, AF1, SLOW)
+#define TWSI4_SCL		MFP_CFG_DRV(TWSI4_SCL, AF0, SLOW)
+#define TWSI4_SDA		MFP_CFG_DRV(TWSI4_SDA, AF0, SLOW)
+#define GPIO99_TWSI5_SCL	MFP_CFG_DRV(GPIO99, AF4, SLOW)
+#define GPIO100_TWSI5_SDA	MFP_CFG_DRV(GPIO100, AF4, SLOW)
+#define GPIO97_TWSI6_SCL	MFP_CFG_DRV(GPIO97, AF2, SLOW)
+#define GPIO98_TWSI6_SDA	MFP_CFG_DRV(GPIO98, AF2, SLOW)
+
+/* SSPA1 */
+#define GPIO24_I2S_SYSCLK	MFP_CFG(GPIO24, AF1)
+#define GPIO25_I2S_BITCLK	MFP_CFG(GPIO25, AF1)
+#define GPIO26_I2S_SYNC		MFP_CFG(GPIO26, AF1)
+#define GPIO27_I2S_DATA_OUT	MFP_CFG(GPIO27, AF1)
+#define GPIO28_I2S_SDATA_IN	MFP_CFG(GPIO28, AF1)
+#define GPIO114_I2S_MCLK	MFP_CFG(GPIO114, AF1)
+#define CLK_REQ			MFP_CFG(CLK_REQ, AF0)
+
+/* SSPA2 */
+#define GPIO33_SSPA2_CLK	MFP_CFG(GPIO33, AF1)
+#define GPIO34_SSPA2_FRM	MFP_CFG(GPIO34, AF1)
+#define GPIO35_SSPA2_TXD	MFP_CFG(GPIO35, AF1)
+#define GPIO36_SSPA2_RXD	MFP_CFG(GPIO36, AF1)
+
+/* Keypad */
+#define GPIO00_KP_MKIN0		MFP_CFG(GPIO0, AF1)
+#define GPIO01_KP_MKOUT0	MFP_CFG(GPIO1, AF1)
+#define GPIO02_KP_MKIN1		MFP_CFG(GPIO2, AF1)
+#define GPIO03_KP_MKOUT1	MFP_CFG(GPIO3, AF1)
+#define GPIO04_KP_MKIN2		MFP_CFG(GPIO4, AF1)
+#define GPIO05_KP_MKOUT2	MFP_CFG(GPIO5, AF1)
+#define GPIO06_KP_MKIN3		MFP_CFG(GPIO6, AF1)
+#define GPIO07_KP_MKOUT3	MFP_CFG(GPIO7, AF1)
+#define GPIO08_KP_MKIN4		MFP_CFG(GPIO8, AF1)
+#define GPIO09_KP_MKOUT4	MFP_CFG(GPIO9, AF1)
+#define GPIO10_KP_MKIN5		MFP_CFG(GPIO10, AF1)
+#define GPIO11_KP_MKOUT5	MFP_CFG(GPIO11, AF1)
+#define GPIO12_KP_MKIN6		MFP_CFG(GPIO12, AF1)
+#define GPIO13_KP_MKOUT6	MFP_CFG(GPIO13, AF1)
+#define GPIO14_KP_MKIN7		MFP_CFG(GPIO14, AF1)
+#define GPIO15_KP_MKOUT7	MFP_CFG(GPIO15, AF1)
+#define GPIO16_KP_DKIN0		MFP_CFG(GPIO16, AF1)
+#define GPIO17_KP_DKIN1		MFP_CFG(GPIO17, AF1)
+#define GPIO18_KP_DKIN2		MFP_CFG(GPIO18, AF1)
+#define GPIO19_KP_DKIN3		MFP_CFG(GPIO19, AF1)
+#define GPIO20_KP_DKIN4		MFP_CFG(GPIO20, AF1)
+#define GPIO21_KP_DKIN5		MFP_CFG(GPIO21, AF1)
+#define GPIO22_KP_DKIN6		MFP_CFG(GPIO22, AF1)
+#define GPIO23_KP_DKIN7		MFP_CFG(GPIO23, AF1)
+
+/* CAMERA */
+#define GPIO59_CCIC_IN7		MFP_CFG_DRV(GPIO59, AF1, FAST)
+#define GPIO60_CCIC_IN6		MFP_CFG_DRV(GPIO60, AF1, FAST)
+#define GPIO61_CCIC_IN5		MFP_CFG_DRV(GPIO61, AF1, FAST)
+#define GPIO62_CCIC_IN4		MFP_CFG_DRV(GPIO62, AF1, FAST)
+#define GPIO63_CCIC_IN3		MFP_CFG_DRV(GPIO63, AF1, FAST)
+#define GPIO64_CCIC_IN2		MFP_CFG_DRV(GPIO64, AF1, FAST)
+#define GPIO65_CCIC_IN1		MFP_CFG_DRV(GPIO65, AF1, FAST)
+#define GPIO66_CCIC_IN0		MFP_CFG_DRV(GPIO66, AF1, FAST)
+#define GPIO67_CAM_HSYNC	MFP_CFG_DRV(GPIO67, AF1, FAST)
+#define GPIO68_CAM_VSYNC	MFP_CFG_DRV(GPIO68, AF1, FAST)
+#define GPIO69_CAM_MCLK		MFP_CFG_DRV(GPIO69, AF1, FAST)
+#define GPIO70_CAM_PCLK		MFP_CFG_DRV(GPIO70, AF1, FAST)
+
+/* Wifi */
+#define GPIO45_GPIO45		MFP_CFG(GPIO45, AF0)
+#define GPIO46_GPIO46		MFP_CFG(GPIO46, AF0)
+#define GPIO21_GPIO21		MFP_CFG(GPIO21, AF0)
+#define GPIO22_GPIO22		MFP_CFG(GPIO22, AF0)
+#define GPIO55_GPIO55		MFP_CFG(GPIO55, AF0)
+#define GPIO56_GPIO56		MFP_CFG(GPIO56, AF0)
+#define GPIO57_GPIO57		MFP_CFG(GPIO57, AF0)
+#define GPIO58_GPIO58		MFP_CFG(GPIO58, AF0)
+
+/* Codec*/
+#define GPIO23_GPIO23		MFP_CFG(GPIO23, AF0)
+
+
+#endif /* __ASM_MACH_MFP_ARMADA610_H */
+
-- 
1.5.6.5
