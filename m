From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 28 Jun 2016 11:41:12 +0900
Subject: [PATCH v2 2/5] spi: s3c64xx: consider the case when the CS line is not
 connected
In-Reply-To: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
References: <1467081676-8442-1-git-send-email-andi.shyti@samsung.com>
Message-ID: <1467081676-8442-3-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the CS line is not connected, it is not needed to enable or
disable the chip selection functionality from the s3c64xx
devices in order to perform a transfer.
Set the CS controller logically always enabled already during
initialization (by writing '0' in the S3C64XX_SPI_SLAVE_SEL
register) and never disable it.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 Documentation/devicetree/bindings/spi/spi-samsung.txt | 3 +++
 drivers/spi/spi-s3c64xx.c                             | 9 ++++++++-
 include/linux/platform_data/spi-s3c64xx.h             | 1 +
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-samsung.txt b/Documentation/devicetree/bindings/spi/spi-samsung.txt
index 6dbdeb3..930bc73 100644
--- a/Documentation/devicetree/bindings/spi/spi-samsung.txt
+++ b/Documentation/devicetree/bindings/spi/spi-samsung.txt
@@ -40,6 +40,9 @@ Optional Board Specific Properties:
 
 - cs-gpios: should specify GPIOs used for chipselects (see spi-bus.txt)
 
+- no-cs-readback: the CS line is disconnected, therefore the device should not
+  operate based on CS signalling.
+
 SPI Controller specific data in SPI slave nodes:
 
 - The spi slave nodes should provide the following information which is required
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 972367d..14269b0 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -315,6 +315,9 @@ static void s3c64xx_spi_set_cs(struct spi_device *spi, bool enable)
 	struct s3c64xx_spi_driver_data *sdd =
 					spi_master_get_devdata(spi->master);
 
+	if (sdd->cntrlr_info->no_cs)
+		return;
+
 	if (enable) {
 		if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO)) {
 			writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
@@ -960,7 +963,9 @@ static void s3c64xx_spi_hwinit(struct s3c64xx_spi_driver_data *sdd, int channel)
 
 	sdd->cur_speed = 0;
 
-	if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
+	if (sci->no_cs)
+		writel(0, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
+	else if (!(sdd->port_conf->quirks & S3C64XX_SPI_QUIRK_CS_AUTO))
 		writel(S3C64XX_SPI_SLAVE_SIG_INACT, sdd->regs + S3C64XX_SPI_SLAVE_SEL);
 
 	/* Disable Interrupts - we use Polling if not DMA mode */
@@ -1015,6 +1020,8 @@ static struct s3c64xx_spi_info *s3c64xx_spi_parse_dt(struct device *dev)
 		sci->num_cs = temp;
 	}
 
+	sci->no_cs = of_property_read_bool(dev->of_node, "broken-cs");
+
 	return sci;
 }
 #else
diff --git a/include/linux/platform_data/spi-s3c64xx.h b/include/linux/platform_data/spi-s3c64xx.h
index fb5625b..5c1e21c 100644
--- a/include/linux/platform_data/spi-s3c64xx.h
+++ b/include/linux/platform_data/spi-s3c64xx.h
@@ -38,6 +38,7 @@ struct s3c64xx_spi_csinfo {
 struct s3c64xx_spi_info {
 	int src_clk_nr;
 	int num_cs;
+	bool no_cs;
 	int (*cfg_gpio)(void);
 	dma_filter_fn filter;
 	void *dma_tx;
-- 
2.8.1
