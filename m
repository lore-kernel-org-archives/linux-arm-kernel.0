From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 30 Mar 2011 14:05:28 +0800
Subject: [PATCH v2 1/1] ARM: imx: add gpu device
Message-ID: <1301465128-401-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@linaro.org>

Add mxc_gpu devices for imx35/50/51/53, so external gpu driver module built
for the kernel can work.

Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/mach-mx3/Kconfig                       |    1 +
 arch/arm/mach-mx3/devices-imx35.h               |    4 +
 arch/arm/mach-mx3/mach-mx35_3ds.c               |    3 +
 arch/arm/mach-mx5/Kconfig                       |    6 ++
 arch/arm/mach-mx5/board-mx50_rdp.c              |    3 +
 arch/arm/mach-mx5/board-mx51_3ds.c              |    3 +
 arch/arm/mach-mx5/board-mx51_babbage.c          |    3 +
 arch/arm/mach-mx5/board-mx53_loco.c             |    9 ++
 arch/arm/mach-mx5/devices-imx50.h               |    4 +
 arch/arm/mach-mx5/devices-imx51.h               |    4 +
 arch/arm/mach-mx5/devices-imx53.h               |    4 +
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    1 +
 arch/arm/plat-mxc/devices/platform-mxc_gpu.c    |   94 +++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/devices-common.h |   12 +++
 arch/arm/plat-mxc/include/mach/mx35.h           |    4 +-
 arch/arm/plat-mxc/include/mach/mx51.h           |    9 +-
 arch/arm/plat-mxc/include/mach/mx53.h           |    1 +
 18 files changed, 163 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/plat-mxc/devices/platform-mxc_gpu.c

diff --git a/arch/arm/mach-mx3/Kconfig b/arch/arm/mach-mx3/Kconfig
index 340809a..197ba67 100644
--- a/arch/arm/mach-mx3/Kconfig
+++ b/arch/arm/mach-mx3/Kconfig
@@ -187,6 +187,7 @@ config MACH_MX35_3DS
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_EHCI
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_MXC_NAND
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	help
diff --git a/arch/arm/mach-mx3/devices-imx35.h b/arch/arm/mach-mx3/devices-imx35.h
index d545d86..e6fb746 100644
--- a/arch/arm/mach-mx3/devices-imx35.h
+++ b/arch/arm/mach-mx3/devices-imx35.h
@@ -74,3 +74,7 @@ extern const struct imx_spi_imx_data imx35_cspi_data[] __initconst;
 	imx_add_spi_imx(&imx35_cspi_data[id], pdata)
 #define imx35_add_spi_imx0(pdata)	imx35_add_cspi(0, pdata)
 #define imx35_add_spi_imx1(pdata)	imx35_add_cspi(1, pdata)
+
+extern const struct imx_mxc_gpu_data imx35_gpu_data;
+#define imx35_add_mxc_gpu(pdata) \
+	imx_add_mxc_gpu(&imx35_gpu_data, pdata)
diff --git a/arch/arm/mach-mx3/mach-mx35_3ds.c b/arch/arm/mach-mx3/mach-mx35_3ds.c
index ff5fe23..1987311 100644
--- a/arch/arm/mach-mx3/mach-mx35_3ds.c
+++ b/arch/arm/mach-mx3/mach-mx35_3ds.c
@@ -175,6 +175,8 @@ static const struct imxi2c_platform_data mx35_3ds_i2c0_data __initconst = {
 	.bitrate = 100000,
 };
 
+static int z160_revision __initdata;
+
 /*
  * Board specific initialization.
  */
@@ -203,6 +205,7 @@ static void __init mx35_3ds_init(void)
 		pr_warn("Init of the debugboard failed, all "
 				"devices on the debugboard are unusable.\n");
 	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
+	imx35_add_mxc_gpu(&z160_revision);
 }
 
 static void __init mx35pdk_timer_init(void)
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 159340d..a3873ac 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -41,6 +41,7 @@ config MACH_MX51_BABBAGE
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -54,6 +55,7 @@ config MACH_MX51_3DS
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select MXC_DEBUG_BOARD
@@ -142,6 +144,7 @@ config MACH_MX53_EVK
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_IMX_I2C
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	help
@@ -154,6 +157,7 @@ config MACH_MX53_SMD
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	help
 	  Include support for MX53 SMD platform. This includes specific
 	  configurations for the board and its peripherals.
@@ -164,6 +168,7 @@ config MACH_MX53_LOCO
 	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_GPIO_KEYS
 	help
@@ -176,6 +181,7 @@ config MACH_MX50_RDP
 	select SOC_IMX50
 	select IMX_HAVE_PLATFORM_IMX_I2C
 	select IMX_HAVE_PLATFORM_IMX_UART
+	select IMX_HAVE_PLATFORM_MXC_GPU
 	select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
 	select IMX_HAVE_PLATFORM_SPI_IMX
 	select IMX_HAVE_PLATFORM_FEC
diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index dedf7f2..90742ce 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -188,6 +188,8 @@ static const struct imxi2c_platform_data i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static int z160_revision __initdata = 1;
+
 /*
  * Board specific initialization.
  */
@@ -203,6 +205,7 @@ static void __init mx50_rdp_board_init(void)
 	imx50_add_imx_i2c(0, &i2c_data);
 	imx50_add_imx_i2c(1, &i2c_data);
 	imx50_add_imx_i2c(2, &i2c_data);
+	imx50_add_mxc_gpu(&z160_revision);
 }
 
 static void __init mx50_rdp_timer_init(void)
diff --git a/arch/arm/mach-mx5/board-mx51_3ds.c b/arch/arm/mach-mx5/board-mx51_3ds.c
index 63dfbea..19b91f8 100644
--- a/arch/arm/mach-mx5/board-mx51_3ds.c
+++ b/arch/arm/mach-mx5/board-mx51_3ds.c
@@ -130,6 +130,8 @@ static struct spi_board_info mx51_3ds_spi_nor_device[] = {
 	 .platform_data = NULL,},
 };
 
+static int z160_revision __initdata;
+
 /*
  * Board specific initialization.
  */
@@ -153,6 +155,7 @@ static void __init mx51_3ds_init(void)
 	imx51_add_sdhci_esdhc_imx(0, NULL);
 	imx51_add_imx_keypad(&mx51_3ds_map_data);
 	imx51_add_imx2_wdt(0, NULL);
+	imx51_add_mxc_gpu(&z160_revision);
 }
 
 static void __init mx51_3ds_timer_init(void)
diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
index bea4e41..4d0c00d 100644
--- a/arch/arm/mach-mx5/board-mx51_babbage.c
+++ b/arch/arm/mach-mx5/board-mx51_babbage.c
@@ -337,6 +337,8 @@ static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
 
+static int z160_revision __initdata;
+
 /*
  * Board specific initialization.
  */
@@ -387,6 +389,7 @@ static void __init mx51_babbage_init(void)
 		ARRAY_SIZE(mx51_babbage_spi_board_info));
 	imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
 	imx51_add_imx2_wdt(0, NULL);
+	imx51_add_mxc_gpu(&z160_revision);
 }
 
 static void __init mx51_babbage_timer_init(void)
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 10a1bea..e689643 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -227,6 +227,8 @@ static const struct imxi2c_platform_data mx53_loco_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+static int z160_revision __initdata;
+
 static void __init mx53_loco_board_init(void)
 {
 	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
@@ -240,6 +242,13 @@ static void __init mx53_loco_board_init(void)
 	imx53_add_sdhci_esdhc_imx(0, NULL);
 	imx53_add_sdhci_esdhc_imx(2, NULL);
 	imx_add_gpio_keys(&loco_button_data);
+
+	/*GPU*/
+	if (mx53_revision() >= IMX_CHIP_REVISION_2_0)
+		z160_revision = 1;
+	else
+		z160_revision = 0;
+	imx53_add_mxc_gpu(&z160_revision);
 }
 
 static void __init mx53_loco_timer_init(void)
diff --git a/arch/arm/mach-mx5/devices-imx50.h b/arch/arm/mach-mx5/devices-imx50.h
index c9e4282..6059b2c 100644
--- a/arch/arm/mach-mx5/devices-imx50.h
+++ b/arch/arm/mach-mx5/devices-imx50.h
@@ -32,3 +32,7 @@ extern const struct imx_fec_data imx50_fec_data __initconst;
 extern const struct imx_imx_i2c_data imx50_imx_i2c_data[] __initconst;
 #define imx50_add_imx_i2c(id, pdata)	\
 	imx_add_imx_i2c(&imx50_imx_i2c_data[id], pdata)
+
+extern const struct imx_mxc_gpu_data imx50_gpu_data;
+#define imx50_add_mxc_gpu(pdata) \
+	imx_add_mxc_gpu(&imx50_gpu_data, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devices-imx51.h
index 7fff485..c32adc2 100644
--- a/arch/arm/mach-mx5/devices-imx51.h
+++ b/arch/arm/mach-mx5/devices-imx51.h
@@ -55,3 +55,7 @@ extern const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst;
 extern const struct imx_imx_keypad_data imx51_imx_keypad_data __initconst;
 #define imx51_add_imx_keypad(pdata)	\
 	imx_add_imx_keypad(&imx51_imx_keypad_data, pdata)
+
+extern const struct imx_mxc_gpu_data imx51_gpu_data;
+#define imx51_add_mxc_gpu(pdata) \
+	imx_add_mxc_gpu(&imx51_gpu_data, pdata)
diff --git a/arch/arm/mach-mx5/devices-imx53.h b/arch/arm/mach-mx5/devices-imx53.h
index 9251008..6472215 100644
--- a/arch/arm/mach-mx5/devices-imx53.h
+++ b/arch/arm/mach-mx5/devices-imx53.h
@@ -33,3 +33,7 @@ extern const struct imx_spi_imx_data imx53_ecspi_data[] __initconst;
 extern const struct imx_imx2_wdt_data imx53_imx2_wdt_data[] __initconst;
 #define imx53_add_imx2_wdt(id, pdata)	\
 	imx_add_imx2_wdt(&imx53_imx2_wdt_data[id])
+
+extern const struct imx_mxc_gpu_data imx53_gpu_data;
+#define imx53_add_mxc_gpu(pdata) \
+	imx_add_mxc_gpu(&imx53_gpu_data, pdata)
diff --git a/arch/arm/plat-mxc/devices/Kconfig b/arch/arm/plat-mxc/devices/Kconfig
index b9ab1d5..db1bfad 100644
--- a/arch/arm/plat-mxc/devices/Kconfig
+++ b/arch/arm/plat-mxc/devices/Kconfig
@@ -50,6 +50,9 @@ config IMX_HAVE_PLATFORM_MX2_CAMERA
 config IMX_HAVE_PLATFORM_MXC_EHCI
 	bool
 
+config IMX_HAVE_PLATFORM_MXC_GPU
+	bool
+
 config IMX_HAVE_PLATFORM_MXC_MMC
 	bool
 
diff --git a/arch/arm/plat-mxc/devices/Makefile b/arch/arm/plat-mxc/devices/Makefile
index 75cd2ec..c2ce086 100644
--- a/arch/arm/plat-mxc/devices/Makefile
+++ b/arch/arm/plat-mxc/devices/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_IMX_HAVE_PLATFORM_IMX_UDC) += platform-imx_udc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX1_CAMERA) += platform-mx1-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MX2_CAMERA) += platform-mx2-camera.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_EHCI) += platform-mxc-ehci.o
+obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_GPU) +=  platform-mxc_gpu.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_MMC) += platform-mxc-mmc.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_NAND) += platform-mxc_nand.o
 obj-$(CONFIG_IMX_HAVE_PLATFORM_MXC_PWM) += platform-mxc_pwm.o
diff --git a/arch/arm/plat-mxc/devices/platform-mxc_gpu.c b/arch/arm/plat-mxc/devices/platform-mxc_gpu.c
new file mode 100644
index 0000000..550d4c9
--- /dev/null
+++ b/arch/arm/plat-mxc/devices/platform-mxc_gpu.c
@@ -0,0 +1,94 @@
+/*
+ * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+#define imx_mxc_gpu_entry_3d_2d(soc)					\
+	{								\
+		.irq_3d = soc ## _INT_GPU,				\
+		.irq_2d = soc ## _INT_GPU2_IRQ,				\
+		.iobase_3d = soc ## _GPU_BASE_ADDR,			\
+		.iobase_2d = soc ## _GPU2D_BASE_ADDR,			\
+		.gmem_base = soc ## _GPU_GMEM_BASE_ADDR,		\
+		.gmem_size = soc ## _GPU_GMEM_SIZE,			\
+	}
+
+#define imx_mxc_gpu_entry_2d(soc)					\
+	{								\
+		.irq_2d = soc ## _INT_GPU2_IRQ,				\
+		.iobase_2d = soc ## _GPU2D_BASE_ADDR,			\
+	}
+
+#ifdef CONFIG_SOC_IMX35
+const struct imx_mxc_gpu_data imx35_gpu_data __initconst =
+	imx_mxc_gpu_entry_2d(MX35);
+#endif
+
+#ifdef CONFIG_SOC_IMX50
+const struct imx_mxc_gpu_data imx50_gpu_data __initconst =
+	imx_mxc_gpu_entry_2d(MX50);
+#endif
+
+#ifdef CONFIG_SOC_IMX51
+const struct imx_mxc_gpu_data imx51_gpu_data __initconst =
+	imx_mxc_gpu_entry_3d_2d(MX51);
+#endif
+
+#ifdef CONFIG_SOC_IMX53
+const struct imx_mxc_gpu_data imx53_gpu_data __initconst =
+	imx_mxc_gpu_entry_3d_2d(MX53);
+#endif
+
+struct platform_device *__init imx_add_mxc_gpu(
+		const struct imx_mxc_gpu_data *data,
+		const int *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = data->irq_2d,
+			.end = data->irq_2d,
+			.name = "gpu_2d_irq",
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.start = data->irq_3d,
+			.end = data->irq_3d,
+			.name = "gpu_3d_irq",
+			.flags = IORESOURCE_IRQ,
+		},
+		{
+			.start = data->iobase_2d,
+			.end = data->iobase_2d + SZ_4K - 1,
+			.name = "gpu_2d_registers",
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.start = data->iobase_3d,
+			.end = data->iobase_3d + SZ_128K - 1,
+			.name = "gpu_3d_registers",
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.start = data->gmem_base,
+			.end = data->gmem_base + data->gmem_size - 1,
+			.name = "gpu_graphics_mem",
+			.flags = IORESOURCE_MEM,
+		},
+		{
+			.start = 0,
+			.end = 0,
+			.name = "gpu_reserved_mem",
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	return imx_add_platform_device_dmamask("mxc_gpu", 0,
+			res, ARRAY_SIZE(res),
+			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
diff --git a/arch/arm/plat-mxc/include/mach/devices-common.h b/arch/arm/plat-mxc/include/mach/devices-common.h
index 8658c9c..1c8ed19 100644
--- a/arch/arm/plat-mxc/include/mach/devices-common.h
+++ b/arch/arm/plat-mxc/include/mach/devices-common.h
@@ -264,3 +264,15 @@ struct imx_spi_imx_data {
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
 		const struct spi_imx_master *pdata);
+
+struct imx_mxc_gpu_data {
+	resource_size_t irq_2d;
+	resource_size_t irq_3d;
+	resource_size_t iobase_2d;
+	resource_size_t iobase_3d;
+	resource_size_t gmem_base;
+	resource_size_t gmem_size;
+};
+struct platform_device *__init imx_add_mxc_gpu(
+		const struct imx_mxc_gpu_data *data,
+		const int *pdata);
diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index d13dbfe..e2954ab 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -7,6 +7,8 @@
 #define MX35_IRAM_BASE_ADDR		0x10000000	/* internal ram */
 #define MX35_IRAM_SIZE			SZ_128K
 
+#define MX35_GPU2D_BASE_ADDR		0x20000000
+
 #define MX35_L2CC_BASE_ADDR		0x30000000
 #define MX35_L2CC_SIZE			SZ_1M
 
@@ -133,7 +135,7 @@
 #define MX35_INT_CSPI2		13
 #define MX35_INT_CSPI1		14
 #define MX35_INT_ATA		15
-#define MX35_INT_GPU2D		16
+#define MX35_INT_GPU2_IRQ	16
 #define MX35_INT_ASRC		17
 #define MX35_INT_UART3		18
 #define MX35_INT_IIM		19
diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
index dede19a..cab469a 100644
--- a/arch/arm/plat-mxc/include/mach/mx51.h
+++ b/arch/arm/plat-mxc/include/mach/mx51.h
@@ -14,8 +14,9 @@
 #define MX51_IRAM_PARTITIONS		16
 #define MX51_IRAM_SIZE		(MX51_IRAM_PARTITIONS * SZ_8K)	/* 128KB */
 
-#define MX51_GPU_BASE_ADDR		0x20000000
-#define MX51_GPU_CTRL_BASE_ADDR		0x30000000
+#define MX51_GPU_GMEM_BASE_ADDR		0x20000000
+#define MX51_GPU_GMEM_SIZE		SZ_128K
+#define MX51_GPU_BASE_ADDR		0x30000000
 #define MX51_IPU_CTRL_BASE_ADDR		0x40000000
 
 #define MX51_DEBUG_BASE_ADDR		0x60000000
@@ -253,7 +254,7 @@
 #define MX51_MXC_INT_VPU		9
 #define MX51_INT_IPU_ERR		10
 #define MX51_INT_IPU_SYN		11
-#define MX51_MXC_INT_GPU		12
+#define MX51_INT_GPU			12
 #define MX51_MXC_INT_RESV13		13
 #define MX51_MXC_INT_USB_H1		14
 #define MX51_MXC_INT_EMI		15
@@ -325,7 +326,7 @@
 #define MX51_MXC_INT_MCG_ERR		81
 #define MX51_MXC_INT_MCG_TMR		82
 #define MX51_MXC_INT_MCG_FUNC		83
-#define MX51_MXC_INT_GPU2_IRQ		84
+#define MX51_INT_GPU2_IRQ		84
 #define MX51_MXC_INT_GPU2_BUSY		85
 #define MX51_MXC_INT_RESV86		86
 #define MX51_INT_FEC			87
diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index ace1786..01dd210 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -35,6 +35,7 @@
 #define MX53_GPU2D_BASE_ADDR		0x20000000
 #define MX53_GPU_BASE_ADDR		0x30000000
 #define MX53_GPU_GMEM_BASE_ADDR	0xF8020000
+#define MX53_GPU_GMEM_SIZE	SZ_256K
 
 #define MX53_DEBUG_BASE_ADDR		0x40000000
 #define MX53_DEBUG_SIZE		SZ_1M
-- 
1.7.1
