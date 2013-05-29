From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 29 May 2013 10:42:22 +0400
Subject: [PATCH] SPI: Unify simple platform data for some controllers
Message-ID: <1369809742-4220-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch unifies simple pdata for some SPI controllers where only
array of GPIOs is used for define chipselects.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/devices/devices-common.h      |  4 ++--
 arch/arm/mach-imx/devices/platform-spi_imx.c    |  2 +-
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |  2 +-
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c  |  2 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  |  2 +-
 arch/arm/mach-imx/hardware.h                    | 11 ++++++++++
 arch/arm/mach-imx/mach-cpuimx51sd.c             |  2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c               |  4 ++--
 arch/arm/mach-imx/mach-mx31_3ds.c               |  4 ++--
 arch/arm/mach-imx/mach-mx31lilly.c              |  4 ++--
 arch/arm/mach-imx/mach-mx31lite.c               |  2 +-
 arch/arm/mach-imx/mach-mx31moboard.c            |  4 ++--
 arch/arm/mach-imx/mach-mx51_babbage.c           |  2 +-
 arch/arm/mach-imx/mach-pca100.c                 |  2 +-
 arch/arm/mach-imx/mach-pcm037_eet.c             |  2 +-
 arch/arm/mach-imx/mach-pcm038.c                 |  2 +-
 arch/arm/mach-imx/mx31lite-db.c                 |  2 +-
 drivers/spi/spi-clps711x.c                      |  4 ++--
 drivers/spi/spi-imx.c                           |  4 ++--
 include/linux/platform_data/spi-clps711x.h      | 21 -------------------
 include/linux/platform_data/spi-generic-pdata.h | 14 +++++++++++++
 include/linux/platform_data/spi-imx.h           | 27 -------------------------
 22 files changed, 50 insertions(+), 73 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h
 create mode 100644 include/linux/platform_data/spi-generic-pdata.h
 delete mode 100644 include/linux/platform_data/spi-imx.h

diff --git a/arch/arm/mach-imx/devices/devices-common.h b/arch/arm/mach-imx/devices/devices-common.h
index 453e20b..2f32b79 100644
--- a/arch/arm/mach-imx/devices/devices-common.h
+++ b/arch/arm/mach-imx/devices/devices-common.h
@@ -328,7 +328,7 @@ struct platform_device *__init imx_add_sdhci_esdhc_imx(
 		const struct imx_sdhci_esdhc_imx_data *data,
 		const struct esdhc_platform_data *pdata);
 
-#include <linux/platform_data/spi-imx.h>
+#include <linux/platform_data/spi-generic-pdata.h>
 struct imx_spi_imx_data {
 	const char *devid;
 	int id;
@@ -338,7 +338,7 @@ struct imx_spi_imx_data {
 };
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata);
+		const struct spi_generic_pdata *pdata);
 
 struct platform_device *imx_add_imx_dma(char *name, resource_size_t iobase,
 					int irq, int irq_err);
diff --git a/arch/arm/mach-imx/devices/platform-spi_imx.c b/arch/arm/mach-imx/devices/platform-spi_imx.c
index 8880bcb..f33a49f 100644
--- a/arch/arm/mach-imx/devices/platform-spi_imx.c
+++ b/arch/arm/mach-imx/devices/platform-spi_imx.c
@@ -108,7 +108,7 @@ const struct imx_spi_imx_data imx53_ecspi_data[] __initconst = {
 
 struct platform_device *__init imx_add_spi_imx(
 		const struct imx_spi_imx_data *data,
-		const struct spi_imx_master *pdata)
+		const struct spi_generic_pdata *pdata)
 {
 	struct resource res[] = {
 		{
diff --git a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
index b2f08bf..40d7c7c 100644
--- a/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimx27-baseboard.c
@@ -273,7 +273,7 @@ static struct spi_board_info __maybe_unused
 
 static int eukrea_mbimx27_spi_cs[] = {GPIO_PORTD | 28};
 
-static const struct spi_imx_master eukrea_mbimx27_spi0_data __initconst = {
+static const struct spi_generic_pdata eukrea_mbimx27_spi0_data __initconst = {
 	.chipselect	= eukrea_mbimx27_spi_cs,
 	.num_chipselect = ARRAY_SIZE(eukrea_mbimx27_spi_cs),
 };
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
index e2b70f4c..ab65190 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c
@@ -258,7 +258,7 @@ static struct spi_board_info eukrea_mbimxsd25_spi_board_info[] __initdata = {
 
 static int eukrea_mbimxsd25_spi_cs[] = {GPIO_SPI1_SS0, GPIO_SPI1_SS1};
 
-static const struct spi_imx_master eukrea_mbimxsd25_spi0_data __initconst = {
+static const struct spi_generic_pdata eukrea_mbimxsd25_spi0_data __initconst = {
 	.chipselect     = eukrea_mbimxsd25_spi_cs,
 	.num_chipselect = ARRAY_SIZE(eukrea_mbimxsd25_spi_cs),
 };
diff --git a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
index 5a2d5ef..e6ffb7d 100644
--- a/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
+++ b/arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
@@ -264,7 +264,7 @@ static struct spi_board_info eukrea_mbimxsd35_spi_board_info[] __initdata = {
 
 static int eukrea_mbimxsd35_spi_cs[] = {GPIO_SPI1_SS0, GPIO_SPI1_SS1};
 
-static const struct spi_imx_master eukrea_mbimxsd35_spi0_data __initconst = {
+static const struct spi_generic_pdata eukrea_mbimxsd35_spi0_data __initconst = {
 	.chipselect     = eukrea_mbimxsd35_spi_cs,
 	.num_chipselect = ARRAY_SIZE(eukrea_mbimxsd35_spi_cs),
 };
diff --git a/arch/arm/mach-imx/hardware.h b/arch/arm/mach-imx/hardware.h
index a3b0b04..d3b5a59 100644
--- a/arch/arm/mach-imx/hardware.h
+++ b/arch/arm/mach-imx/hardware.h
@@ -125,4 +125,15 @@
 /* range e.g. GPIO_1_5 is gpio 5 under linux */
 #define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
 
+/* Macro for using internal CSPI chipselects. Normally you */
+/* want to use gpio based chip selects as the CSPI module tries to be */
+/* intelligent about when to assert the chipselect: The CSPI module */
+/* deasserts the chipselect once it runs out of input data. The other */
+/* problem that it is not possible to mix between high active and low */
+/* active chipselects on one single bus using the internal chipselects. */
+/* Unfortunately Freescale decided to put some chipselects on dedicated */
+/* pins which are not usable as gpios, so we have to support the internal */
+/* chipselects. */
+#define MXC_SPI_CS(no)			((no) - 32)
+
 #endif /* __ASM_ARCH_MXC_HARDWARE_H__ */
diff --git a/arch/arm/mach-imx/mach-cpuimx51sd.c b/arch/arm/mach-imx/mach-cpuimx51sd.c
index 9b5ddf5..7950151 100644
--- a/arch/arm/mach-imx/mach-cpuimx51sd.c
+++ b/arch/arm/mach-imx/mach-cpuimx51sd.c
@@ -264,7 +264,7 @@ static int cpuimx51sd_spi1_cs[] = {
 	CAN_NCS,
 };
 
-static const struct spi_imx_master cpuimx51sd_ecspi1_pdata __initconst = {
+static const struct spi_generic_pdata cpuimx51sd_ecspi1_pdata __initconst = {
 	.chipselect	= cpuimx51sd_spi1_cs,
 	.num_chipselect	= ARRAY_SIZE(cpuimx51sd_spi1_cs),
 };
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 25b3e4c..2e7cf1c 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -357,14 +357,14 @@ static struct imx_ssi_platform_data mx27_3ds_ssi_pdata = {
 /* SPI */
 static int spi1_chipselect[] = {SPI1_SS0};
 
-static const struct spi_imx_master spi1_pdata __initconst = {
+static const struct spi_generic_pdata spi1_pdata __initconst = {
 	.chipselect	= spi1_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi1_chipselect),
 };
 
 static int spi2_chipselect[] = {SPI2_SS0};
 
-static const struct spi_imx_master spi2_pdata __initconst = {
+static const struct spi_generic_pdata spi2_pdata __initconst = {
 	.chipselect	= spi2_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi2_chipselect),
 };
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
index 1ed9161..2ac1974 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -510,7 +510,7 @@ static int spi0_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static const struct spi_imx_master spi0_pdata __initconst = {
+static const struct spi_generic_pdata spi0_pdata __initconst = {
 	.chipselect	= spi0_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi0_internal_chipselect),
 };
@@ -520,7 +520,7 @@ static int spi1_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static const struct spi_imx_master spi1_pdata __initconst = {
+static const struct spi_generic_pdata spi1_pdata __initconst = {
 	.chipselect	= spi1_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi1_internal_chipselect),
 };
diff --git a/arch/arm/mach-imx/mach-mx31lilly.c b/arch/arm/mach-imx/mach-mx31lilly.c
index 832b1e2..426f14a 100644
--- a/arch/arm/mach-imx/mach-mx31lilly.c
+++ b/arch/arm/mach-imx/mach-mx31lilly.c
@@ -211,12 +211,12 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static const struct spi_imx_master spi0_pdata __initconst = {
+static const struct spi_generic_pdata spi0_pdata __initconst = {
 	.chipselect = spi_internal_chipselect,
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
 
-static const struct spi_imx_master spi1_pdata __initconst = {
+static const struct spi_generic_pdata spi1_pdata __initconst = {
 	.chipselect = spi_internal_chipselect,
 	.num_chipselect = ARRAY_SIZE(spi_internal_chipselect),
 };
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach-mx31lite.c
index bea0729..12f1479 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -106,7 +106,7 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(0),
 };
 
-static const struct spi_imx_master spi1_pdata __initconst = {
+static const struct spi_generic_pdata spi1_pdata __initconst = {
 	.chipselect	= spi_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index dae4cd7..cf03cc6 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -168,7 +168,7 @@ static int moboard_spi1_cs[] = {
 	MXC_SPI_CS(2),
 };
 
-static const struct spi_imx_master moboard_spi1_pdata __initconst = {
+static const struct spi_generic_pdata moboard_spi1_pdata __initconst = {
 	.chipselect	= moboard_spi1_cs,
 	.num_chipselect	= ARRAY_SIZE(moboard_spi1_cs),
 };
@@ -316,7 +316,7 @@ static int moboard_spi2_cs[] = {
 	MXC_SPI_CS(1),
 };
 
-static const struct spi_imx_master moboard_spi2_pdata __initconst = {
+static const struct spi_generic_pdata moboard_spi2_pdata __initconst = {
 	.chipselect	= moboard_spi2_cs,
 	.num_chipselect	= ARRAY_SIZE(moboard_spi2_cs),
 };
diff --git a/arch/arm/mach-imx/mach-mx51_babbage.c b/arch/arm/mach-imx/mach-mx51_babbage.c
index f3d264a..a01c76a 100644
--- a/arch/arm/mach-imx/mach-mx51_babbage.c
+++ b/arch/arm/mach-imx/mach-mx51_babbage.c
@@ -336,7 +336,7 @@ static int mx51_babbage_spi_cs[] = {
 	BABBAGE_ECSPI1_CS1,
 };
 
-static const struct spi_imx_master mx51_babbage_spi_pdata __initconst = {
+static const struct spi_generic_pdata mx51_babbage_spi_pdata __initconst = {
 	.chipselect     = mx51_babbage_spi_cs,
 	.num_chipselect = ARRAY_SIZE(mx51_babbage_spi_cs),
 };
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index b8b15bb..47580c4 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -203,7 +203,7 @@ static struct spi_board_info pca100_spi_board_info[] __initdata = {
 
 static int pca100_spi_cs[] = {SPI1_SS0, SPI1_SS1};
 
-static const struct spi_imx_master pca100_spi0_data __initconst = {
+static const struct spi_generic_pdata pca100_spi0_data __initconst = {
 	.chipselect	= pca100_spi_cs,
 	.num_chipselect = ARRAY_SIZE(pca100_spi_cs),
 };
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 8fd8255..3a6cbcd 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -58,7 +58,7 @@ static struct spi_board_info pcm037_spi_dev[] = {
 /* Platform Data for MXC CSPI */
 static int pcm037_spi1_cs[] = {MXC_SPI_CS(1), IOMUX_TO_GPIO(MX31_PIN_KEY_COL7)};
 
-static const struct spi_imx_master pcm037_spi1_pdata __initconst = {
+static const struct spi_generic_pdata pcm037_spi1_pdata __initconst = {
 	.chipselect = pcm037_spi1_cs,
 	.num_chipselect = ARRAY_SIZE(pcm037_spi1_cs),
 };
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
index e805ac2..8c034d8 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -204,7 +204,7 @@ static struct i2c_board_info pcm038_i2c_devices[] = {
 
 static int pcm038_spi_cs[] = {GPIO_PORTD + 28};
 
-static const struct spi_imx_master pcm038_spi0_data __initconst = {
+static const struct spi_generic_pdata pcm038_spi0_data __initconst = {
 	.chipselect = pcm038_spi_cs,
 	.num_chipselect = ARRAY_SIZE(pcm038_spi_cs),
 };
diff --git a/arch/arm/mach-imx/mx31lite-db.c b/arch/arm/mach-imx/mx31lite-db.c
index 5a160b7..4b5f3b1 100644
--- a/arch/arm/mach-imx/mx31lite-db.c
+++ b/arch/arm/mach-imx/mx31lite-db.c
@@ -154,7 +154,7 @@ static int spi_internal_chipselect[] = {
 	MXC_SPI_CS(2),
 };
 
-static const struct spi_imx_master spi0_pdata __initconst = {
+static const struct spi_generic_pdata spi0_pdata __initconst = {
 	.chipselect	= spi_internal_chipselect,
 	.num_chipselect	= ARRAY_SIZE(spi_internal_chipselect),
 };
diff --git a/drivers/spi/spi-clps711x.c b/drivers/spi/spi-clps711x.c
index 6859a02..0cd0f00 100644
--- a/drivers/spi/spi-clps711x.c
+++ b/drivers/spi/spi-clps711x.c
@@ -18,7 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
-#include <linux/platform_data/spi-clps711x.h>
+#include <linux/platform_data/spi-generic-pdata.h>
 
 #include <mach/hardware.h>
 
@@ -168,7 +168,7 @@ static int spi_clps711x_probe(struct platform_device *pdev)
 	int i, ret;
 	struct spi_master *master;
 	struct spi_clps711x_data *hw;
-	struct spi_clps711x_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct spi_generic_pdata *pdata = dev_get_platdata(&pdev->dev);
 
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platform data supplied\n");
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 1e99b57..ad93086 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -38,7 +38,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
-#include <linux/platform_data/spi-imx.h>
+#include <linux/platform_data/spi-generic-pdata.h>
 
 #define DRIVER_NAME "spi_imx"
 
@@ -754,7 +754,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_id =
 			of_match_device(spi_imx_dt_ids, &pdev->dev);
-	struct spi_imx_master *mxc_platform_info =
+	struct spi_generic_pdata *mxc_platform_info =
 			dev_get_platdata(&pdev->dev);
 	struct spi_master *master;
 	struct spi_imx_data *spi_imx;
diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index 301956e..0000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
diff --git a/include/linux/platform_data/spi-generic-pdata.h b/include/linux/platform_data/spi-generic-pdata.h
new file mode 100644
index 0000000..6c45a55
--- /dev/null
+++ b/include/linux/platform_data/spi-generic-pdata.h
@@ -0,0 +1,14 @@
+#ifndef _LINUX_PLATFORM_DATA_SPI_GENERIC_PDATA_H
+#define _LINUX_PLATFORM_DATA_SPI_GENERIC_PDATA_H
+
+/*
+ * struct spi_generic_pdata - device.platform_data for SPI controller devices.
+ * @chipselect: Array of chipselects for this master.
+ * @num_chipselect: ARRAY_SIZE(chipselect)
+ */
+struct spi_generic_pdata {
+	int	*chipselect;
+	int	num_chipselect;
+};
+
+#endif
diff --git a/include/linux/platform_data/spi-imx.h b/include/linux/platform_data/spi-imx.h
deleted file mode 100644
index 08be445..0000000
--- a/include/linux/platform_data/spi-imx.h
+++ /dev/null
@@ -1,27 +0,0 @@
-
-#ifndef __MACH_SPI_H_
-#define __MACH_SPI_H_
-
-/*
- * struct spi_imx_master - device.platform_data for SPI controller devices.
- * @chipselect: Array of chipselects for this master. Numbers >= 0 mean gpio
- *              pins, numbers < 0 mean internal CSPI chipselects according
- *              to MXC_SPI_CS(). Normally you want to use gpio based chip
- *              selects as the CSPI module tries to be intelligent about
- *              when to assert the chipselect: The CSPI module deasserts the
- *              chipselect once it runs out of input data. The other problem
- *              is that it is not possible to mix between high active and low
- *              active chipselects on one single bus using the internal
- *              chipselects. Unfortunately Freescale decided to put some
- *              chipselects on dedicated pins which are not usable as gpios,
- *              so we have to support the internal chipselects.
- * @num_chipselect: ARRAY_SIZE(chipselect)
- */
-struct spi_imx_master {
-	int	*chipselect;
-	int	num_chipselect;
-};
-
-#define MXC_SPI_CS(no)	((no) - 32)
-
-#endif /* __MACH_SPI_H_*/
-- 
1.8.1.5
