From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 18 Jan 2010 09:32:21 +0000
Subject: [PATCH] ARM: S3C64XX: SPI: Header for passing platform data
In-Reply-To: <1263807142-13186-1-git-send-email-ben-linux@fluff.org>
References: <1263807142-13186-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1263807142-13186-4-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jassi Brar <jassi.brar@samsung.com>

We need a way to pass controller specific information to the SPI driver.
For that purpose new headers are made.

SPI Controller is assumed 'type-s3c64xx' and can be defined for newer SoCs.
 Hence, that part is placed under plat-samsung to be shared across newer SoCs.

SoC specific part - spi source clocks, will be placed
under plat-<soc>/include/plat/

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-s3c64xx/include/plat/spi-clocks.h  |   18 ++++++
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h |   67 ++++++++++++++++++++++
 2 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
 create mode 100644 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h

diff --git a/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h b/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
new file mode 100644
index 0000000..524bdae
--- /dev/null
+++ b/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
@@ -0,0 +1,18 @@
+/* linux/arch/arm/plat-s3c64xx/include/plat/spi-clocks.h
+ *
+ * Copyright (C) 2009 Samsung Electronics Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S3C64XX_PLAT_SPI_CLKS_H
+#define __S3C64XX_PLAT_SPI_CLKS_H __FILE__
+
+#define S3C64XX_SPI_SRCCLK_PCLK		0
+#define S3C64XX_SPI_SRCCLK_SPIBUS	1
+#define S3C64XX_SPI_SRCCLK_48M		2
+
+#endif /* __S3C64XX_PLAT_SPI_CLKS_H */
diff --git a/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
new file mode 100644
index 0000000..d177241
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
@@ -0,0 +1,67 @@
+/* linux/arch/arm/plat-samsung/include/plat/s3c64xx-spi.h
+ *
+ * Copyright (C) 2009 Samsung Electronics Ltd.
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __S3C64XX_PLAT_SPI_H
+#define __S3C64XX_PLAT_SPI_H
+
+/**
+ * struct s3c64xx_spi_csinfo - ChipSelect description
+ * @fb_delay: Slave specific feedback delay.
+ *            Refer to FB_CLK_SEL register definition in SPI chapter.
+ * @line: Custom 'identity' of the CS line.
+ * @set_level: CS line control.
+ *
+ * This is per SPI-Slave Chipselect information.
+ * Allocate and initialize one in machine init code and make the
+ * spi_board_info.controller_data point to it.
+ */
+struct s3c64xx_spi_csinfo {
+	u8 fb_delay;
+	unsigned line;
+	void (*set_level)(unsigned line_id, int lvl);
+};
+
+/**
+ * struct s3c64xx_spi_info - SPI Controller defining structure
+ * @src_clk_nr: Clock source index for the CLK_CFG[SPI_CLKSEL] field.
+ * @src_clk_name: Platform name of the corresponding clock.
+ * @num_cs: Number of CS this controller emulates.
+ * @cfg_gpio: Configure pins for this SPI controller.
+ * @fifo_lvl_mask: All tx fifo_lvl fields start at offset-6
+ * @rx_lvl_offset: Depends on tx fifo_lvl field and bus number
+ * @high_speed: If the controller supports HIGH_SPEED_EN bit
+ */
+struct s3c64xx_spi_info {
+	int src_clk_nr;
+	char *src_clk_name;
+
+	int num_cs;
+
+	int (*cfg_gpio)(struct platform_device *pdev);
+
+	/* Following two fields are for future compatibility */
+	int fifo_lvl_mask;
+	int rx_lvl_offset;
+	int high_speed;
+};
+
+/**
+ * s3c64xx_spi_set_info - SPI Controller configure callback by the board
+ *				initialization code.
+ * @cntrlr: SPI controller number the configuration is for.
+ * @src_clk_nr: Clock the SPI controller is to use to generate SPI clocks.
+ * @num_cs: Number of elements in the 'cs' array.
+ *
+ * Call this from machine init code for each SPI Controller that
+ * has some chips attached to it.
+ */
+extern void s3c64xx_spi_set_info(int cntrlr, int src_clk_nr, int num_cs);
+
+#endif /* __S3C64XX_PLAT_SPI_H */
-- 
1.6.0.4
