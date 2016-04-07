From: sr@denx.de (Stefan Roese)
Date: Thu,  7 Apr 2016 14:06:51 +0200
Subject: [PATCH v3] spi: orion.c: Add direct access mode
Message-ID: <1460030811-13787-1-git-send-email-sr@denx.de>
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
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
---
v3:
- Used static MBus windows again, as suggested by Arnd
- No new DT bindings needed for this. The MBus windows need to be
  configured in the 'reg' property of the SPI controller. This is
  done in a separate patch for the Armada platforms.
- The direct mapping is configured and enable by adding the
  specific MBus entry to the 'ranges' property of the 'soc' node
  in the board dts file.

v2:
- Use one MBus window for each SPI controller instead of one for
  for each SPI device. This MBus window is re-assigned, once the
  CS changes.
- Assert the CS over the entire message
- Don't restrict the direct access mode to only direct write mode
- Add check for max size before using memcpy()
- Remove spidev from DT bindings documentation

 drivers/spi/spi-orion.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index a87cfd4..69e710e 100644
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
@@ -78,11 +82,18 @@ struct orion_spi_dev {
 	bool			is_errata_50mhz_ac;
 };
 
+struct orion_direct_acc {
+	void __iomem		*vaddr;
+	u32			size;
+};
+
 struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
 	struct clk              *clk;
 	const struct orion_spi_dev *devdata;
+
+	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
 };
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
@@ -372,10 +383,44 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 {
 	unsigned int count;
 	int word_len;
+	struct orion_spi *orion_spi;
+	int cs = spi->chip_select;
 
 	word_len = spi->bits_per_word;
 	count = xfer->len;
 
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	/* Use SPI direct access mode if base address is available */
+	if (orion_spi->direct_access[cs].vaddr) {
+		struct orion_direct_acc *da = &orion_spi->direct_access[cs];
+
+		if (count > da->size) {
+			dev_err(&spi->dev,
+				"max transfer size exceeded (%d > %d)\n",
+				count, da->size);
+			return 0;
+		}
+
+		if (xfer->tx_buf) {
+			/*
+			 * Send the tx-data to the SPI device via the direct
+			 * mapped address window
+			 */
+			memcpy(da->vaddr, xfer->tx_buf, count);
+		}
+
+		if (xfer->rx_buf) {
+			/*
+			 * Read the rx-data from the SPI device via the direct
+			 * mapped address window
+			 */
+			memcpy(xfer->rx_buf, da->vaddr, count);
+		}
+
+		return count;
+	}
+
 	if (word_len == 8) {
 		const u8 *tx = xfer->tx_buf;
 		u8 *rx = xfer->rx_buf;
@@ -425,6 +470,10 @@ static int orion_spi_reset(struct orion_spi *orion_spi)
 {
 	/* Verify that the CS is deasserted */
 	orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+
+	/* Don't deassert CS between the direct mapped SPI transfers */
+	writel(0, spi_reg(orion_spi, SPI_DIRECT_WRITE_CONFIG_REG));
+
 	return 0;
 }
 
@@ -504,6 +553,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	struct resource *r;
 	unsigned long tclk_hz;
 	int status = 0;
+	struct device_node *np;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*spi));
 	if (master == NULL) {
@@ -576,6 +626,42 @@ static int orion_spi_probe(struct platform_device *pdev)
 		goto out_rel_clk;
 	}
 
+	/* Scan all SPI devices of this controller for direct mapped devices */
+	for_each_available_child_of_node(pdev->dev.of_node, np) {
+		u32 cs;
+
+		/* Get chip-select number from the "reg" property */
+		status = of_property_read_u32(np, "reg", &cs);
+		if (status) {
+			dev_err(&pdev->dev,
+				"%s has no valid 'reg' property (%d)\n",
+				np->full_name, status);
+			status = 0;
+			continue;
+		}
+
+		/*
+		 * Check if an address is configured for this SPI device. If
+		 * not, the MBus mapping via the 'ranges' property in the 'soc'
+		 * node is not configured and this device should not use the
+		 * direct mode. In this case, just continue with the next
+		 * device.
+		 */
+		status = of_address_to_resource(pdev->dev.of_node, cs + 1, r);
+		if (status)
+			continue;
+
+		spi->direct_access[cs].vaddr = devm_ioremap_resource(&pdev->dev,
+								     r);
+		if (IS_ERR(spi->direct_access[cs].vaddr)) {
+			status = PTR_ERR(spi->direct_access[cs].vaddr);
+			goto out_rel_clk;
+		}
+
+		spi->direct_access[cs].size = resource_size(r);
+		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
+	}
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
-- 
2.8.1
