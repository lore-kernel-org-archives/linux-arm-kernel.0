From: sr@denx.de (Stefan Roese)
Date: Tue, 12 Jan 2016 10:02:19 +0100
Subject: [PATCH RFC] spi: orion.c: Add direct write mode
Message-ID: <1452589339-21402-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the direct write mode to the Orion SPI
driver which is used on the Marvell Armada based SoCs. In this direct
mode, all data written to a specifically mapped MBus window (linked
to only one SPI chip-select on one of the SPI controllers) will be
transferred directly to the SPI bus. Without the need to control the
SPI registers in between. This can improve the SPI transfer rate in
such cases.

Currently only the direct write mode is supported. This mode especially
benefits from the SPI direct mode, as the data bytes are written
head-to-head to the SPI bus, without any additional addresses, that
are also written in the direct read mode.

One use-case for this direct write mode is, programming a FPGA bitstream
image into the FPGA connected to the SPI bus at maximum speed.

This mode is described in chapter "22.5.2 Direct Write to SPI" in the
Marvell Armada XP Functional Spec Datasheet.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Nadav Haklai <nadavh@marvell.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>
---

 .../devicetree/bindings/spi/spi-orion.txt          | 26 ++++++++++
 drivers/spi/spi-orion.c                            | 59 ++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index 98bc698..b22ebc5 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -12,6 +12,8 @@ Required properties:
 - cell-index : Which of multiple SPI controllers is this.
 Optional properties:
 - interrupts : Is currently not used.
+- direct-addr : The phandle to the node containing the base address
+                of the direct-mapped MBus window for this SPI device.
 
 Example:
        spi at 10600 {
@@ -23,3 +25,27 @@ Example:
 	       interrupts = <23>;
 	       status = "disabled";
        };
+
+Example with direct-write mode:
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000	/* internal regs */
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000	/* BootROM       */
+			  MBUS_ID(0x01, 0x5e) 0 0 0xf2000000 0x100000>;	/* SPI0 CS1      */
+
+		spi0_cs1: spi at 015e {
+			compatible = "marvell,spi-direct-mode";
+			reg = <MBUS_ID(0x01, 0x5e) 0 0x100000>;
+		};
+
+	...
+
+	spi at 10600 {
+		compatible = "marvell,orion-spi";
+		status = "okay";
+
+		spidev at 1 {
+			compatible = "spidev";
+			direct-addr = <&spi0_cs1>;
+			reg = <1>;
+		};
+	};
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index a87cfd4..c028679 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
@@ -43,6 +44,9 @@
 #define ORION_SPI_INT_CAUSE_REG		0x10
 #define ORION_SPI_TIMING_PARAMS_REG	0x18
 
+/* Register for the "Direct Mode" */
+#define SPI_DIRECT_WRITE_CONFIG_REG	0x20
+
 #define ORION_SPI_TMISO_SAMPLE_MASK	(0x3 << 6)
 #define ORION_SPI_TMISO_SAMPLE_1	(1 << 6)
 #define ORION_SPI_TMISO_SAMPLE_2	(2 << 6)
@@ -83,6 +87,7 @@ struct orion_spi {
 	void __iomem		*base;
 	struct clk              *clk;
 	const struct orion_spi_dev *devdata;
+	void __iomem		*slave_direct_addr[8];
 };
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
@@ -372,10 +377,29 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	unsigned int count;
 	int word_len;
+	struct orion_spi *orion_spi;
+	void __iomem *direct_addr;
 
 	word_len = spi->bits_per_word;
 	count = xfer->len;
 
+	/* Use SPI direct write mode if such an address is provided via DT */
+	orion_spi = spi_master_get_devdata(spi->master);
+	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
+	if (direct_addr && xfer->tx_buf) {
+		/* Deassert CS between the SPI transfers */
+		writel(0x00010000, spi_reg(orion_spi,
+					   SPI_DIRECT_WRITE_CONFIG_REG));
+
+		/*
+		 * Send the tx-data to the SPI device via the direct mapped
+		 * address window
+		 */
+		memcpy(direct_addr, xfer->tx_buf, count);
+
+		return count;
+	}
+
 	if (word_len == 8) {
 		const u8 *tx = xfer->tx_buf;
 		u8 *rx = xfer->rx_buf;
@@ -501,6 +525,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	const struct orion_spi_dev *devdata;
 	struct spi_master *master;
 	struct orion_spi *spi;
+	struct device_node *np;
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
@@ -576,6 +601,40 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out_rel_clk;
 	}
 
+	/*
+	 * Scan all SPI devices of this controller for direct mapped devices
+	 */
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		struct device_node *direct_addr_np;
+
+		/*
+		 * Get "direct-addr" device node with the mapping info
+		 */
+		direct_addr_np = of_parse_phandle(np, "direct-addr", 0);
+		if (direct_addr_np) {
+			struct resource res;
+			u32 cs;
+			int rc;
+
+			/* Get chip-select number from the "reg" property */
+			rc = of_property_read_u32(np, "reg", &cs);
+			if (rc) {
+				dev_err(&pdev->dev,
+					"%s has no valid 'reg' property (%d)\n",
+					direct_addr_np->full_name, rc);
+				continue;
+			}
+
+			/*
+			 * Store the address to use it later for the direct
+			 * access
+			 */
+			rc = of_address_to_resource(direct_addr_np, 0, &res);
+			spi->slave_direct_addr[cs] =
+				devm_ioremap_resource(&pdev->dev, &res);
+		}
+	}
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-- 
2.6.5
