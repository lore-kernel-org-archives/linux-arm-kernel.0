From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 12 Nov 2012 16:52:32 +0800
Subject: [PATCH 12/17] spi/atmel_spi: add version propety as the spi data
In-Reply-To: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
References: <1352710357-3265-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1352710357-3265-13-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To remove the function atmel_spi_is_v2() which depends on the SOC,
for future using DTS section to decide the IP version of SOC.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: grant.likely at secretlab.ca
Cc: spi-devel-general at lists.sourceforge.net
---
 drivers/spi/spi-atmel.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 0cc347c..568df5b 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -187,6 +187,7 @@
  */
 struct atmel_spi_data {
 	u8			dma_type;
+	u8			version;
 	struct at_dma_slave	dma_slave;
 };
 
@@ -264,9 +265,20 @@ static struct dma_slave_config slave_config;
  * register, but I haven't checked that it exists on all chips, and
  * this is cheaper anyway.
  */
-static bool atmel_spi_is_v2(void)
+static bool atmel_spi_is_v1(struct atmel_spi *as)
 {
-	return !cpu_is_at91rm9200();
+	if (as->data.version == 1)
+		return true;
+	else
+		return false;
+}
+
+static bool atmel_spi_is_v2(struct atmel_spi *as)
+{
+	if (as->data.version == 2)
+		return true;
+	else
+		return false;
 }
 
 /*
@@ -300,7 +312,7 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 	unsigned active = spi->mode & SPI_CS_HIGH;
 	u32 mr;
 
-	if (atmel_spi_is_v2()) {
+	if (atmel_spi_is_v2(as)) {
 		/*
 		 * Always use CSR0. This ensures that the clock
 		 * switches to the correct idle polarity before we
@@ -355,7 +367,7 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 			asd->npcs_pin, active ? " (low)" : "",
 			mr);
 
-	if (atmel_spi_is_v2() || spi->chip_select != 0)
+	if (atmel_spi_is_v2(as) || spi->chip_select != 0)
 		gpio_set_value(asd->npcs_pin, !active);
 }
 
@@ -1266,7 +1278,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 	}
 
 	/* see notes above re chipselect */
-	if (!atmel_spi_is_v2()
+	if (atmel_spi_is_v1(as)
 			&& spi->chip_select == 0
 			&& (spi->mode & SPI_CS_HIGH)) {
 		dev_dbg(&spi->dev, "setup: can't be active-high\n");
@@ -1275,7 +1287,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 
 	/* v1 chips start out at half the peripheral bus speed. */
 	bus_hz = clk_get_rate(as->clk);
-	if (!atmel_spi_is_v2())
+	if (atmel_spi_is_v1(as))
 		bus_hz /= 2;
 
 	if (spi->max_speed_hz) {
@@ -1347,7 +1359,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
 		bus_hz / scbr, bits, spi->mode, spi->chip_select, csr);
 
-	if (!atmel_spi_is_v2())
+	if (atmel_spi_is_v1(as))
 		spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
 
 	return 0;
-- 
1.7.9.5
