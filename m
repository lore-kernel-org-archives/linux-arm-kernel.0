From: sr@denx.de (Stefan Roese)
Date: Tue, 22 Mar 2016 17:24:53 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
Message-ID: <1458663893-13766-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the direct access mode to the Orion SPI
driver which is used on the Marvell Armada based SoCs. In this direct
mode, all data written to (or read from) a specifically mapped MBus
window (linked to one SPI chip-select on one of the SPI controllers)
will be transferred directly to the SPI bus. Without the need to control
the SPI registers in between. This can improve the SPI transfer rate in
such cases.

Both, direct-read and -write mode are supported. But only the write
mode has been tested. This mode especially benefits from the SPI direct
mode, as the data bytes are written head-to-head to the SPI bus,
without any additional addresses.

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
Mark, sorry for the huge delay for v2 of this direct-access patch.
I was busy with other tasks in the meantime. And only found now
the time to address (hopefully all) of your comments.

v2:
- Use one MBus window for each SPI controller instead of one for
  for each SPI device. This MBus window is re-assigned, once the
  CS changes.
- Assert the CS over the entire message
- Don't restrict the direct access mode to only direct write mode
- Add check for max size before using memcpy()
- Remove spidev from DT bindings documentation

 .../devicetree/bindings/spi/spi-orion.txt          |  21 +++
 drivers/spi/spi-orion.c                            | 142 ++++++++++++++++++++-
 2 files changed, 161 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-orion.txt b/Documentation/devicetree/bindings/spi/spi-orion.txt
index 98bc698..b46ea0f 100644
--- a/Documentation/devicetree/bindings/spi/spi-orion.txt
+++ b/Documentation/devicetree/bindings/spi/spi-orion.txt
@@ -12,6 +12,13 @@ Required properties:
 - cell-index : Which of multiple SPI controllers is this.
 Optional properties:
 - interrupts : Is currently not used.
+- da-reg : The physical memory area that will be used for the direct
+           access mode, if enabled in one of the SPI devices.
+
+Per SPI device:
+- da-target-attribute : The target and attribute value for a specific
+                        SPI-controller / SPI-device combination.
+			E.g. <0x01 0x5e>: SPI0-CS1 target and attribute
 
 Example:
        spi at 10600 {
@@ -23,3 +30,17 @@ Example:
 	       interrupts = <23>;
 	       status = "disabled";
        };
+
+Example with direct access mode:
+	spi at 10600 {
+		compatible = "marvell,orion-spi";
+		status = "okay";
+		da-reg = <0xf2000000 0x100000>;
+
+		spi-fpga at 1 {
+			compatible = "altera,stratix-v";
+			reg = <1>;
+			/* 0x01 0x5e: SPI0-CS1 target and attribute */
+			da-target-attribute = <0x01 0x5e>;
+		};
+	};
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index a87cfd4..8b23198 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -15,9 +15,11 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
+#include <linux/mbus.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/clk.h>
 #include <linux/sizes.h>
@@ -43,6 +45,9 @@
 #define ORION_SPI_INT_CAUSE_REG		0x10
 #define ORION_SPI_TIMING_PARAMS_REG	0x18
 
+/* Register for the "Direct Mode" */
+#define SPI_DIRECT_WRITE_CONFIG_REG	0x20
+
 #define ORION_SPI_TMISO_SAMPLE_MASK	(0x3 << 6)
 #define ORION_SPI_TMISO_SAMPLE_1	(1 << 6)
 #define ORION_SPI_TMISO_SAMPLE_2	(2 << 6)
@@ -78,11 +83,24 @@ struct orion_spi_dev {
 	bool			is_errata_50mhz_ac;
 };
 
+struct target_attribute {
+	bool			enabled;
+	u32			tar;
+	u32			attr;
+};
+
 struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
 	struct clk              *clk;
 	const struct orion_spi_dev *devdata;
+
+	/* Direct access */
+	int			da_active_cs;
+	phys_addr_t		da_base;
+	u32			da_size;
+	void __iomem		*da_vaddr;
+	struct target_attribute	da_tarattr[ORION_NUM_CHIPSELECTS];
 };
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
@@ -277,18 +295,44 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 static void orion_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	struct orion_spi *orion_spi;
+	int cs = spi->chip_select;
 
 	orion_spi = spi_master_get_devdata(spi->master);
 
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS_MASK);
-	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG,
-				ORION_SPI_CS(spi->chip_select));
+	orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, ORION_SPI_CS(cs));
 
 	/* Chip select logic is inverted from spi_set_cs */
 	if (!enable)
 		orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
 	else
 		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+
+	/* Remap the MBus window for direct access if enabled */
+	if (orion_spi->da_tarattr[cs].enabled) {
+		int rc;
+
+		/* Nothing to do if the cs is not changed */
+		if (orion_spi->da_active_cs == cs)
+			return;
+
+		/* Map MBus window for the new CS */
+		mvebu_mbus_del_window(orion_spi->da_base, orion_spi->da_size);
+		rc = mvebu_mbus_add_window_by_id(orion_spi->da_tarattr[cs].tar,
+						 orion_spi->da_tarattr[cs].attr,
+						 orion_spi->da_base,
+						 orion_spi->da_size);
+		if (rc) {
+			dev_err(&spi->dev,
+				"unable to map direct access MBus window (%d)\n",
+				rc);
+			/* Disable direct-access if mapping failed */
+			orion_spi->da_tarattr[cs].enabled = false;
+			return;
+		}
+
+		orion_spi->da_active_cs = cs;
+	}
 }
 
 static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
@@ -372,10 +416,41 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	unsigned int count;
 	int word_len;
+	struct orion_spi *orion_spi;
 
 	word_len = spi->bits_per_word;
 	count = xfer->len;
 
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	/* Use SPI direct access mode if enabled via DT */
+	if (orion_spi->da_tarattr[spi->chip_select].enabled) {
+		if (count > orion_spi->da_size) {
+			dev_err(&spi->dev,
+				"max transfer size exceeded (%d > %d)\n",
+				count, orion_spi->da_size);
+			return 0;
+		}
+
+		if (xfer->tx_buf) {
+			/*
+			 * Send the tx-data to the SPI device via the direct
+			 * mapped address window
+			 */
+			memcpy(orion_spi->da_vaddr, xfer->tx_buf, count);
+		}
+
+		if (xfer->rx_buf) {
+			/*
+			 * Read the rx-data from the SPI device via the direct
+			 * mapped address window
+			 */
+			memcpy(xfer->rx_buf, orion_spi->da_vaddr, count);
+		}
+
+		return count;
+	}
+
 	if (word_len == 8) {
 		const u8 *tx = xfer->tx_buf;
 		u8 *rx = xfer->rx_buf;
@@ -425,6 +500,10 @@ static int orion_spi_reset(struct orion_spi *orion_spi)
 {
 	/* Verify that the CS is deasserted */
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+
+	/* Don't deassert CS between the direct mapped SPI transfers */
+	writel(0, spi_reg(orion_spi, SPI_DIRECT_WRITE_CONFIG_REG));
+
 	return 0;
 }
 
@@ -504,6 +583,9 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
+	struct device_node *np;
+	const __be32 *ranges;
+	int rlen;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (master == NULL) {
@@ -576,6 +658,62 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out_rel_clk;
 	}
 
+	/* Check if direct-access is enabled for this controller */
+	ranges = of_get_property(pdev->dev.of_node, "da-reg", &rlen);
+	if (ranges) {
+		rlen /= sizeof(*ranges);
+
+		if (rlen != 2) {
+			dev_err(&pdev->dev, "invalid da-reg property!\n");
+			goto out_rel_clk;
+		}
+
+		/* Store the address to use it later for the direct access */
+		spi->da_base = be32_to_cpup(&ranges[0]);
+		spi->da_size = be32_to_cpup(&ranges[1]);
+		spi->da_vaddr = devm_ioremap(&pdev->dev,
+					     spi->da_base, spi->da_size);
+		spi->da_active_cs = -1;
+
+		/*
+		 * Scan all SPI devices of this controller for direct mapped
+		 * devices. We need to save the target and attribute for
+		 * each CS as they map the SPI-controller/SPI-device to a
+		 * specific MBus window. For example on the Armada XP,
+		 * target 0x01 and attribute 0x5e map this window to SPI
+		 * controller #0 and CS #1.
+		 */
+		for_each_available_child_of_node(pdev->dev.of_node, np) {
+			u32 reg[2];
+			int rc;
+
+			/* Get "da-target-attribute" property */
+			rc = of_property_read_u32_array(np,
+							"da-target-attribute",
+							reg, ARRAY_SIZE(reg));
+			if (!rc) {
+				u32 cs;
+				int rc;
+
+				/*
+				 * Get chip-select number from the "reg"
+				 * property
+				 */
+				rc = of_property_read_u32(np, "reg", &cs);
+				if (rc) {
+					dev_err(&pdev->dev,
+						"%s has no valid 'reg' property (%d)\n",
+						np->full_name, rc);
+					continue;
+				}
+
+				spi->da_tarattr[cs].enabled = true;
+				spi->da_tarattr[cs].tar = reg[0];
+				spi->da_tarattr[cs].attr = reg[1];
+			}
+		}
+	}
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-- 
2.7.4
