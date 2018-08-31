From: yogeshnarayan.gaur@nxp.com (Yogesh Gaur)
Date: Fri, 31 Aug 2018 15:59:58 +0530
Subject: [PATCH 1/7] spi: add slave device size in spi_device struct
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1535711404-29528-2-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 'size' data variable in spi_device struct.
This is to save the size of the connected slave device.

After slave device scan, spi_nor_scan, size being assigned to this
from MTD layer.

SFDP read is being requested before completion of spi_nor_scan()
routine, thus populate device size before making read request
to the SPI controller.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 drivers/mtd/devices/m25p80.c  | 6 ++++++
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 include/linux/spi/spi.h       | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index fe260cc..6c7ad86 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -124,6 +124,10 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
+	/* for case of SFDP header read commands, populate spi device size */
+	if (flash->spimem->spi->size == 0)
+		flash->spimem->spi->size = nor->mtd.size;
+
 	while (remaining) {
 		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
 		ret = spi_mem_adjust_op_size(flash->spimem, &op);
@@ -215,6 +219,8 @@ static int m25p_probe(struct spi_mem *spimem)
 	if (ret)
 		return ret;
 
+	spi->size = nor->mtd.size;
+
 	return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
 				   data ? data->nr_parts : 0);
 }
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 6042df8..b066bed 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2864,6 +2864,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (info->flags & SPI_S3AN)
 		nor->flags |=  SNOR_F_READY_XSR_RDY;
 
+	mtd->size = info->sector_size * info->n_sectors;
+
 	/* Parse the Serial Flash Discoverable Parameters table. */
 	ret = spi_nor_init_params(nor, info, &params);
 	if (ret)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..558aeed 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -127,6 +127,7 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
  *	for driver coldplugging, and in uevents used for hotplugging
  * @cs_gpio: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line)
+ * @size: size of the connected slave device
  *
  * @statistics: statistics for the spi_device
  *
@@ -168,6 +169,7 @@ struct spi_device {
 	void			*controller_data;
 	char			modalias[SPI_NAME_SIZE];
 	int			cs_gpio;	/* chip select gpio */
+	u32			size;		/* size of slave device */
 
 	/* the statistics */
 	struct spi_statistics	statistics;
-- 
2.7.4
