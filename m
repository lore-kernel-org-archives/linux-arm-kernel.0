From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 19 Sep 2015 18:02:33 +0800
Subject: [PATCH 2/5] pinctrl: berlin: add the berlin4ct pinctrl driver
In-Reply-To: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
References: <1442656956-5740-1-git-send-email-jszhang@marvell.com>
Message-ID: <1442656956-5740-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the pin-controller driver for Marvell Berlin BG4CT SoC, with definition
of its groups and functions. This uses the core Berlin pinctrl driver.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/berlin/Kconfig     |   5 +
 drivers/pinctrl/berlin/Makefile    |   1 +
 drivers/pinctrl/berlin/berlin4ct.c | 503 +++++++++++++++++++++++++++++++++++++
 3 files changed, 509 insertions(+)
 create mode 100644 drivers/pinctrl/berlin/berlin4ct.c

diff --git a/drivers/pinctrl/berlin/Kconfig b/drivers/pinctrl/berlin/Kconfig
index b18322b..eac4d28 100644
--- a/drivers/pinctrl/berlin/Kconfig
+++ b/drivers/pinctrl/berlin/Kconfig
@@ -17,4 +17,9 @@ config PINCTRL_BERLIN_BG2Q
 	bool
 	select PINCTRL_BERLIN
 
+config PINCTRL_BERLIN4CT
+	depends on OF && (ARCH_BERLIN || COMPILE_TEST)
+	bool "Marvell berlin4ct pin controller driver"
+	select PINCTRL_BERLIN
+
 endif
diff --git a/drivers/pinctrl/berlin/Makefile b/drivers/pinctrl/berlin/Makefile
index deb0c6b..c8fe2a0 100644
--- a/drivers/pinctrl/berlin/Makefile
+++ b/drivers/pinctrl/berlin/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PINCTRL_BERLIN)		+= berlin.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG2)	+= berlin-bg2.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG2CD)	+= berlin-bg2cd.o
 obj-$(CONFIG_PINCTRL_BERLIN_BG2Q)	+= berlin-bg2q.o
+obj-$(CONFIG_PINCTRL_BERLIN4CT)		+= berlin4ct.o
diff --git a/drivers/pinctrl/berlin/berlin4ct.c b/drivers/pinctrl/berlin/berlin4ct.c
new file mode 100644
index 0000000..2960e16
--- /dev/null
+++ b/drivers/pinctrl/berlin/berlin4ct.c
@@ -0,0 +1,503 @@
+/*
+ * Marvell berlin4ct pinctrl driver
+ *
+ * Copyright (C) 2015 Marvell Technology Group Ltd.
+ *
+ * Jisheng Zhang <jszhang@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include "berlin.h"
+
+static const struct berlin_desc_group berlin4ct_soc_pinctrl_groups[] = {
+	BERLIN_PINCTRL_GROUP("EMMC_RSTn", 0x0, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "emmc_rstn"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio47")),
+	BERLIN_PINCTRL_GROUP("NAND_IO0", 0x0, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io0"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxd0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio0")),
+	BERLIN_PINCTRL_GROUP("NAND_IO1", 0x0, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io1"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxd1"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_cdn"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio1")),
+	BERLIN_PINCTRL_GROUP("NAND_IO2", 0x0, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxd2"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_dat0"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio2")),
+	BERLIN_PINCTRL_GROUP("NAND_IO3", 0x0, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io3"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxd3"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_dat1"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio3")),
+	BERLIN_PINCTRL_GROUP("NAND_IO4", 0x0, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io4"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxc"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_dat2"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio4")),
+	BERLIN_PINCTRL_GROUP("NAND_IO5", 0x0, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io5"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_rxctl"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_dat3"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio5")),
+	BERLIN_PINCTRL_GROUP("NAND_IO6", 0x0, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io6"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_mdc"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_cmd"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio6")),
+	BERLIN_PINCTRL_GROUP("NAND_IO7", 0x0, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_io7"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_mdio"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sd1_wp"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio7")),
+	BERLIN_PINCTRL_GROUP("NAND_ALE", 0x0, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_ale"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txd0"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio8")),
+	BERLIN_PINCTRL_GROUP("NAND_CLE", 0x4, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_cle"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txd1"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio9")),
+	BERLIN_PINCTRL_GROUP("NAND_WEn", 0x4, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_wen"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txd2"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio10")),
+	BERLIN_PINCTRL_GROUP("NAND_REn", 0x4, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_ren"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txd3"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio11")),
+	BERLIN_PINCTRL_GROUP("NAND_WPn", 0x4, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_wpn"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio12")),
+	BERLIN_PINCTRL_GROUP("NAND_CEn", 0x4, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_cen"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txc"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio13")),
+	BERLIN_PINCTRL_GROUP("NAND_RDY", 0x4, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "nand_rdy"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "rgmii_txctl"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "gpio14")),
+	BERLIN_PINCTRL_GROUP("SD0_CLK", 0x4, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio29"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts4_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg8"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg8")),
+	BERLIN_PINCTRL_GROUP("SD0_DAT0", 0x4, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio30"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_dat0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts4_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg9"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg9")),
+	BERLIN_PINCTRL_GROUP("SD0_DAT1", 0x4, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio31"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_dat1"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts4_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg10"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg10")),
+	BERLIN_PINCTRL_GROUP("SD0_DAT2", 0x4, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio32"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_dat2"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts4_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg11"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg11")),
+	BERLIN_PINCTRL_GROUP("SD0_DAT3", 0x8, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio33"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_dat3"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts5_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg12"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg12")),
+	BERLIN_PINCTRL_GROUP("SD0_CDn", 0x8, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio34"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_cdn"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts5_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg13"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg13")),
+	BERLIN_PINCTRL_GROUP("SD0_CMD", 0x8, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio35"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_cmd"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts5_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg14"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg14")),
+	BERLIN_PINCTRL_GROUP("SD0_WP", 0x8, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio36"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd0_wp"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts5_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg15"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg15")),
+	BERLIN_PINCTRL_GROUP("STS0_CLK", 0x8, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio21"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts0_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "cpupll_clko"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg0"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg0")),
+	BERLIN_PINCTRL_GROUP("STS0_SOP", 0x8, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio22"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts0_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "syspll_clko"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg1"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg1")),
+	BERLIN_PINCTRL_GROUP("STS0_SD", 0x8, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio23"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts0_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "mempll_clko"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg2"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg2")),
+	BERLIN_PINCTRL_GROUP("STS0_VALD", 0x8, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio24"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts0_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg3"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg3")),
+	BERLIN_PINCTRL_GROUP("STS1_CLK", 0x8, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio25"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts1_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm0"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg4"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg4")),
+	BERLIN_PINCTRL_GROUP("STS1_SOP", 0x8, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio26"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts1_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm1"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg5"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg5")),
+	BERLIN_PINCTRL_GROUP("STS1_SD", 0xc, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio27"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts1_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm2"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg6"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg6")),
+	BERLIN_PINCTRL_GROUP("STS1_VALD", 0xc, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio28"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sts1_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm3"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "v4g_dbg7"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "phy_dbg7")),
+	BERLIN_PINCTRL_GROUP("SCRD0_RST", 0xc, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio15"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_rst"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_clk")),
+	BERLIN_PINCTRL_GROUP("SCRD0_DCLK", 0xc, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio16"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_dclk"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_cmd")),
+	BERLIN_PINCTRL_GROUP("SCRD0_GPIO0", 0xc, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio17"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_gpio0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sif_dio"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_dat0")),
+	BERLIN_PINCTRL_GROUP("SCRD0_GPIO1", 0xc, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio18"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_gpio1"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sif_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_dat1")),
+	BERLIN_PINCTRL_GROUP("SCRD0_DIO", 0xc, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio19"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_dio"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sif_den"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sd1a_dat2")),
+	BERLIN_PINCTRL_GROUP("SCRD0_CRD_PRES", 0xc, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio20"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "scrd0_crd_pres"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sd1a_dat3")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS0n", 0xc, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_ss0n"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio37"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts2_clk")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS1n", 0xc, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_ss1n"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio38"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts2_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm1")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS2n", 0x10, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_ss2n"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio39"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts2_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "pwm0")),
+	BERLIN_PINCTRL_GROUP("SPI1_SS3n", 0x10, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_ss3n"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio40"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts2_vald")),
+	BERLIN_PINCTRL_GROUP("SPI1_SCLK", 0x10, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_sclk"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio41"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts3_clk")),
+	BERLIN_PINCTRL_GROUP("SPI1_SDO", 0x10, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_sdo"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio42"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts3_sop")),
+	BERLIN_PINCTRL_GROUP("SPI1_SDI", 0x10, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "spi1_sdi"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "gpio43"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts3_sd")),
+	BERLIN_PINCTRL_GROUP("USB0_DRV_VBUS", 0x10, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio44"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "usb0_drv_vbus"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sts3_vald")),
+	BERLIN_PINCTRL_GROUP("TW0_SCL", 0x10, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio45"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw0_scl")),
+	BERLIN_PINCTRL_GROUP("TW0_SDA", 0x10, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "gpio46"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "tw0_sda")),
+};
+
+static const struct berlin_desc_group berlin4ct_soc_aviopinctrl_groups[] = {
+	BERLIN_PINCTRL_GROUP("TX_EDDC_SCL", 0x0, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio0"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "tx_eddc_scl"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "tw1_scl")),
+	BERLIN_PINCTRL_GROUP("TX_EDDC_SDA", 0x0, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio1"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "tx_eddc_sda"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "tw1_sda")),
+	BERLIN_PINCTRL_GROUP("I2S1_LRCKO", 0x0, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio2"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1_lrcko"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts6_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_dbg0"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "avio_dbg0")),
+	BERLIN_PINCTRL_GROUP("I2S1_BCLKO", 0x0, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio3"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1_bclko"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts6_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_dbg1"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_cmd"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "avio_dbg1")),
+	BERLIN_PINCTRL_GROUP("I2S1_DO", 0x0, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio4"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1_do"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts6_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_dbg2"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_dat0"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "avio_dbg2")),
+	BERLIN_PINCTRL_GROUP("I2S1_MCLK", 0x0, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio5"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s1_mclk"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts6_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_test_mclk"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_dat1"),
+			BERLIN_PINCTRL_FUNCTION(0x7, "avio_dbg3")),
+	BERLIN_PINCTRL_GROUP("SPDIFO", 0x0, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio6"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "spdifo"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "avpll_clko"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_dbg3")),
+	BERLIN_PINCTRL_GROUP("I2S2_MCLK", 0x0, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio7"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2_mclk"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "hdmi_fbclk"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "pdm_clko")),
+	BERLIN_PINCTRL_GROUP("I2S2_LRCKI", 0x0, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio8"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2_lrcki"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm0"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts7_clk"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_test_lrck"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_dat2")),
+	BERLIN_PINCTRL_GROUP("I2S2_BCLKI", 0x0, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio9"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2_bclki"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm1"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts7_sop"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_test_bclk"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_dat3")),
+	BERLIN_PINCTRL_GROUP("I2S2_DI0", 0x4, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio10"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2_di0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm2"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts7_sd"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_test_sdin"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "pdm_di0"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_cdn")),
+	BERLIN_PINCTRL_GROUP("I2S2_DI1", 0x4, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "avio_gpio11"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "i2s2_di1"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm3"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "sts7_vald"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "adac_test_pwmclk"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "pdm_di1"),
+			BERLIN_PINCTRL_FUNCTION(0x6, "sd1b_wp")),
+};
+
+static const struct berlin_desc_group berlin4ct_sysmgr_pinctrl_groups[] = {
+	BERLIN_PINCTRL_GROUP("SM_TW2_SCL", 0x0, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio19"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw2_scl")),
+	BERLIN_PINCTRL_GROUP("SM_TW2_SDA", 0x0, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio20"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw2_sda")),
+	BERLIN_PINCTRL_GROUP("SM_TW3_SCL", 0x0, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio21"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw3_scl")),
+	BERLIN_PINCTRL_GROUP("SM_TW3_SDA", 0x0, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio22"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_tw3_sda")),
+	BERLIN_PINCTRL_GROUP("SM_TMS", 0x0, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tms"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio0"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm0")),
+	BERLIN_PINCTRL_GROUP("SM_TDI", 0x0, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tdi"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio1"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "pwm1")),
+	BERLIN_PINCTRL_GROUP("SM_TDO", 0x0, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_tdo"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio2")),
+	BERLIN_PINCTRL_GROUP("SM_URT0_TXD", 0x0, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_urt0_txd"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio3")),
+	BERLIN_PINCTRL_GROUP("SM_URT0_RXD", 0x0, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_urt0_rxd"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio4")),
+	BERLIN_PINCTRL_GROUP("SM_URT1_TXD", 0x0, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio5"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_urt1_txd"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "eth1_rxclk"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm2"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "sm_timer0"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "clk_25m")),
+	BERLIN_PINCTRL_GROUP("SM_URT1_RXD", 0x4, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio6"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_urt1_rxd"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm3"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "sm_timer1")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SS0n", 0x4, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_spi2_ss0n"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio7")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SS1n", 0x4, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio8"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_spi2_ss1n")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SS2n", 0x4, 0x3, 0x09,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio9"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_spi2_ss2n"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "eth1_mdc"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm0"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "sm_timer0"),
+			BERLIN_PINCTRL_FUNCTION(0x5, "clk_25m")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SS3n", 0x4, 0x3, 0x0c,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio10"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_spi2_ss3n"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "eth1_mdio"),
+			BERLIN_PINCTRL_FUNCTION(0x3, "pwm1"),
+			BERLIN_PINCTRL_FUNCTION(0x4, "sm_timer1")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SDO", 0x4, 0x3, 0x0f,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_spi2_sdo"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio11")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SDI", 0x4, 0x3, 0x12,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_spi2_sdi"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio12")),
+	BERLIN_PINCTRL_GROUP("SM_SPI2_SCLK", 0x4, 0x3, 0x15,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_spi2_sclk"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio13")),
+	BERLIN_PINCTRL_GROUP("SM_FE_LED0", 0x4, 0x3, 0x18,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio14"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sm_fe_led0")),
+	BERLIN_PINCTRL_GROUP("SM_FE_LED1", 0x4, 0x3, 0x1b,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_pwr_ok"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_gpio15"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sm_fe_led1")),
+	BERLIN_PINCTRL_GROUP("SM_FE_LED2", 0x8, 0x3, 0x00,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio16"),
+			BERLIN_PINCTRL_FUNCTION(0x2, "sm_fe_led2")),
+	BERLIN_PINCTRL_GROUP("SM_HDMI_HPD", 0x8, 0x3, 0x03,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio17"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_hdmi_hpd")),
+	BERLIN_PINCTRL_GROUP("SM_HDMI_CEC", 0x8, 0x3, 0x06,
+			BERLIN_PINCTRL_FUNCTION(0x0, "sm_gpio18"),
+			BERLIN_PINCTRL_FUNCTION(0x1, "sm_hdmi_cec")),
+};
+
+static const struct berlin_pinctrl_desc berlin4ct_soc_pinctrl_data = {
+	.groups = berlin4ct_soc_pinctrl_groups,
+	.ngroups = ARRAY_SIZE(berlin4ct_soc_pinctrl_groups),
+};
+
+static const struct berlin_pinctrl_desc berlin4ct_soc_aviopinctrl_data = {
+	.groups = berlin4ct_soc_aviopinctrl_groups,
+	.ngroups = ARRAY_SIZE(berlin4ct_soc_aviopinctrl_groups),
+};
+
+static const struct berlin_pinctrl_desc berlin4ct_sysmgr_pinctrl_data = {
+	.groups = berlin4ct_sysmgr_pinctrl_groups,
+	.ngroups = ARRAY_SIZE(berlin4ct_sysmgr_pinctrl_groups),
+};
+
+static const struct of_device_id berlin4ct_pinctrl_match[] = {
+	{
+		.compatible = "marvell,berlin4ct-soc-pinctrl",
+		.data = &berlin4ct_soc_pinctrl_data,
+	},
+	{
+		.compatible = "marvell,berlin4ct-avio-pinctrl",
+		.data = &berlin4ct_soc_aviopinctrl_data,
+	},
+	{
+		.compatible = "marvell,berlin4ct-sm-pinctrl",
+		.data = &berlin4ct_sysmgr_pinctrl_data,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, berlin4ct_pinctrl_match);
+
+static int berlin4ct_pinctrl_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match =
+		of_match_device(berlin4ct_pinctrl_match, &pdev->dev);
+	struct regmap_config *rmconfig;
+	struct regmap *regmap;
+	struct resource *res;
+	void __iomem *base;
+
+	rmconfig = devm_kzalloc(&pdev->dev, sizeof(*rmconfig), GFP_KERNEL);
+	if (!rmconfig)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rmconfig->reg_bits = 32,
+	rmconfig->val_bits = 32,
+	rmconfig->reg_stride = 4,
+	rmconfig->max_register = resource_size(res);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base, rmconfig);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return berlin_pinctrl_probe(pdev, regmap, match->data);
+}
+
+static struct platform_driver berlin4ct_pinctrl_driver = {
+	.probe	= berlin4ct_pinctrl_probe,
+	.driver	= {
+		.name = "berlin4ct-pinctrl",
+		.of_match_table = berlin4ct_pinctrl_match,
+	},
+};
+module_platform_driver(berlin4ct_pinctrl_driver);
+
+MODULE_AUTHOR("Jisheng Zhang <jszhang@marvell.com>");
+MODULE_DESCRIPTION("Marvell berlin4ct pinctrl driver");
+MODULE_LICENSE("GPL");
-- 
2.5.1
