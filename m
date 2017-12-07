From: vigneshr@ti.com (Vignesh R)
Date: Thu, 7 Dec 2017 12:08:04 +0530
Subject: [PATCH 2/2] mtd: spi-nor: cadence-quadspi: Add support for direct
 access mode
In-Reply-To: <20171207063804.29436-1-vigneshr@ti.com>
References: <20171207063804.29436-1-vigneshr@ti.com>
Message-ID: <20171207063804.29436-3-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cadence QSPI controller provides direct access mode through which flash
can be accessed in a memory-mapped IO mode. This enables read/write to
flash using memcpy*() functions. This mode provides higher throughput
for both read/write operations when compared to current indirect mode of
operation.

This patch therefore adds support to use QSPI in direct mode. If the
window reserved in SoC's memory map for MMIO access is less that of
flash size(like on most SoCFPGA variants), then the driver falls back
to indirect mode of operation.

On TI's 66AK2G SoC, with ARM running at 600MHz and QSPI at 96MHz
switching to direct mode improves read throughput from 3MB/s to 8MB/s.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 52 +++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index becc7d714ab8..f8721ed68bc6 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -58,6 +58,7 @@ struct cqspi_flash_pdata {
 	u8		data_width;
 	u8		cs;
 	bool		registered;
+	bool		use_direct_mode;
 };
 
 struct cqspi_st {
@@ -68,6 +69,7 @@ struct cqspi_st {
 
 	void __iomem		*iobase;
 	void __iomem		*ahb_base;
+	resource_size_t		ahb_size;
 	struct completion	transfer_complete;
 	struct mutex		bus_mutex;
 
@@ -103,6 +105,7 @@ struct cqspi_st {
 /* Register map */
 #define CQSPI_REG_CONFIG			0x00
 #define CQSPI_REG_CONFIG_ENABLE_MASK		BIT(0)
+#define CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL	BIT(7)
 #define CQSPI_REG_CONFIG_DECODE_MASK		BIT(9)
 #define CQSPI_REG_CONFIG_CHIPSELECT_LSB		10
 #define CQSPI_REG_CONFIG_DMA_MASK		BIT(15)
@@ -569,6 +572,21 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
 	return ret;
 }
 
+static int cqspi_direct_read_execute(struct spi_nor *nor, u8 *rxbuf,
+				     loff_t from_addr, const size_t len)
+{
+	struct cqspi_flash_pdata *f_pdata = nor->priv;
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	u32 reg;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	memcpy_fromio(rxbuf, cqspi->ahb_base + from_addr, len);
+
+	return 0;
+}
+
 static int cqspi_write_setup(struct spi_nor *nor)
 {
 	unsigned int reg;
@@ -671,6 +689,21 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
 	return ret;
 }
 
+static int cqspi_direct_write_execute(struct spi_nor *nor, loff_t to_addr,
+				      const u8 *txbuf, const size_t len)
+{
+	struct cqspi_flash_pdata *f_pdata = nor->priv;
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	u32 reg;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_ENB_DIR_ACC_CTRL;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	memcpy_toio(cqspi->ahb_base + to_addr, txbuf, len);
+
+	return 0;
+}
+
 static void cqspi_chipselect(struct spi_nor *nor)
 {
 	struct cqspi_flash_pdata *f_pdata = nor->priv;
@@ -891,6 +924,7 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
 static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
 			   size_t len, const u_char *buf)
 {
+	struct cqspi_flash_pdata *f_pdata = nor->priv;
 	int ret;
 
 	ret = cqspi_set_protocol(nor, 0);
@@ -901,7 +935,10 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_write_execute(nor, to, buf, len);
+	if (f_pdata->use_direct_mode)
+		ret = cqspi_direct_write_execute(nor, to, buf, len);
+	else
+		ret = cqspi_indirect_write_execute(nor, to, buf, len);
 	if (ret)
 		return ret;
 
@@ -911,6 +948,7 @@ static ssize_t cqspi_write(struct spi_nor *nor, loff_t to,
 static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
 			  size_t len, u_char *buf)
 {
+	struct cqspi_flash_pdata *f_pdata = nor->priv;
 	int ret;
 
 	ret = cqspi_set_protocol(nor, 1);
@@ -921,7 +959,10 @@ static ssize_t cqspi_read(struct spi_nor *nor, loff_t from,
 	if (ret)
 		return ret;
 
-	ret = cqspi_indirect_read_execute(nor, buf, from, len);
+	if (f_pdata->use_direct_mode)
+		ret = cqspi_direct_read_execute(nor, buf, from, len);
+	else
+		ret = cqspi_indirect_read_execute(nor, buf, from, len);
 	if (ret)
 		return ret;
 
@@ -1153,6 +1194,12 @@ static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
 			goto err;
 
 		f_pdata->registered = true;
+
+		if (mtd->size <= cqspi->ahb_size) {
+			f_pdata->use_direct_mode = true;
+			dev_info(nor->dev, "using direct mode for %s\n",
+				 mtd->name);
+		}
 	}
 
 	return 0;
@@ -1212,6 +1259,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		dev_err(dev, "Cannot remap AHB address.\n");
 		return PTR_ERR(cqspi->ahb_base);
 	}
+	cqspi->ahb_size = resource_size(res_ahb);
 
 	init_completion(&cqspi->transfer_complete);
 
-- 
2.15.1
