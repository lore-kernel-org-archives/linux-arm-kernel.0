From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 11 Aug 2015 11:58:47 +0200
Subject: [PATCH] spi: orion: On a38x,
 implement "50MHZ SPI AC timing" Erratum No. FE-9144572
Message-ID: <1439287127-3782-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

Description:
On Armada 38x, the device SPI interface supports frequencies of up to
50 MHz. However, due to this erratum, when the device core clock is
250 MHz and the SPI interfaces is configured for 50MHz SPI clock and
CPOL=CPHA=1, there might occur data corruption on reads from the SPI
device.

Workaround:
Work in one of the following configurations:
1. Set CPOL=CPHA=0 in "SPI Interface Configuration Register".
2. Set TMISO_SAMPLE value to 0x2 in "SPI Timing Parameters 1 Register"
before setting the interface.

[gregory.clement at free-electrons.com}: port to v4.2-rc, use
is_errata_50mhz_ac instead of using a new ARMADA_380_SPI spi type.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/spi/spi-orion.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 8cad107a5b3f..a87cfd4ba17b 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -41,6 +41,11 @@
 #define ORION_SPI_DATA_OUT_REG		0x08
 #define ORION_SPI_DATA_IN_REG		0x0c
 #define ORION_SPI_INT_CAUSE_REG		0x10
+#define ORION_SPI_TIMING_PARAMS_REG	0x18
+
+#define ORION_SPI_TMISO_SAMPLE_MASK	(0x3 << 6)
+#define ORION_SPI_TMISO_SAMPLE_1	(1 << 6)
+#define ORION_SPI_TMISO_SAMPLE_2	(2 << 6)
 
 #define ORION_SPI_MODE_CPOL		(1 << 11)
 #define ORION_SPI_MODE_CPHA		(1 << 12)
@@ -70,6 +75,7 @@ struct orion_spi_dev {
 	unsigned int		min_divisor;
 	unsigned int		max_divisor;
 	u32			prescale_mask;
+	bool			is_errata_50mhz_ac;
 };
 
 struct orion_spi {
@@ -195,6 +201,41 @@ orion_spi_mode_set(struct spi_device *spi)
 	writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
 }
 
+static void
+orion_spi_50mhz_ac_timing_erratum(struct spi_device *spi, unsigned int speed)
+{
+	u32 reg;
+	struct orion_spi *orion_spi;
+
+	orion_spi = spi_master_get_devdata(spi->master);
+
+	/*
+	 * Erratum description: (Erratum NO. FE-9144572) The device
+	 * SPI interface supports frequencies of up to 50 MHz.
+	 * However, due to this erratum, when the device core clock is
+	 * 250 MHz and the SPI interfaces is configured for 50MHz SPI
+	 * clock and CPOL=CPHA=1 there might occur data corruption on
+	 * reads from the SPI device.
+	 * Erratum Workaround:
+	 * Work in one of the following configurations:
+	 * 1. Set CPOL=CPHA=0 in "SPI Interface Configuration
+	 * Register".
+	 * 2. Set TMISO_SAMPLE value to 0x2 in "SPI Timing Parameters 1
+	 * Register" before setting the interface.
+	 */
+	reg = readl(spi_reg(orion_spi, ORION_SPI_TIMING_PARAMS_REG));
+	reg &= ~ORION_SPI_TMISO_SAMPLE_MASK;
+
+	if (clk_get_rate(orion_spi->clk) == 250000000 &&
+			speed == 50000000 && spi->mode & SPI_CPOL &&
+			spi->mode & SPI_CPHA)
+		reg |= ORION_SPI_TMISO_SAMPLE_2;
+	else
+		reg |= ORION_SPI_TMISO_SAMPLE_1; /* This is the default value */
+
+	writel(reg, spi_reg(orion_spi, ORION_SPI_TIMING_PARAMS_REG));
+}
+
 /*
  * called only when no transfer is active on the bus
  */
@@ -216,6 +257,9 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 
 	orion_spi_mode_set(spi);
 
+	if (orion_spi->devdata->is_errata_50mhz_ac)
+		orion_spi_50mhz_ac_timing_erratum(spi, speed);
+
 	rc = orion_spi_baudrate_set(spi, speed);
 	if (rc)
 		return rc;
@@ -413,6 +457,14 @@ static const struct orion_spi_dev armada_375_spi_dev_data = {
 	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
 };
 
+static const struct orion_spi_dev armada_380_spi_dev_data = {
+	.typ = ARMADA_SPI,
+	.max_hz = 50000000,
+	.max_divisor = 1920,
+	.prescale_mask = ARMADA_SPI_CLK_PRESCALE_MASK,
+	.is_errata_50mhz_ac = true,
+};
+
 static const struct of_device_id orion_spi_of_match_table[] = {
 	{
 		.compatible = "marvell,orion-spi",
@@ -428,7 +480,7 @@ static const struct of_device_id orion_spi_of_match_table[] = {
 	},
 	{
 		.compatible = "marvell,armada-380-spi",
-		.data = &armada_xp_spi_dev_data,
+		.data = &armada_380_spi_dev_data,
 	},
 	{
 		.compatible = "marvell,armada-390-spi",
-- 
2.1.0
