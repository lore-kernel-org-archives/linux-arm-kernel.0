From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 16 Jul 2015 17:27:49 +0200
Subject: [PATCH 2/7] mtd: spi-nor: notify (Q)SPI controller about protocol
 change
In-Reply-To: <cover.1437059658.git.cyrille.pitchen@atmel.com>
References: <cover.1437059658.git.cyrille.pitchen@atmel.com>
Message-ID: <e70498c0193b04e2ea82eaabda0cddae0edfffb3.1437059658.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the Quad SPI mode has been enabled on a Micron flash memory, this
device expects ALL the following commands to use the SPI 4-4-4 protocol.
The (Q)SPI controller needs to be notified about the protocol change so it
can adapt and keep on dialoging with the Micron memory.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 17 +++++++++++++++++
 include/linux/mtd/spi-nor.h   | 13 +++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d78831b4422b..93627d4e6be8 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -163,6 +163,18 @@ static inline int write_disable(struct spi_nor *nor)
 	return nor->write_reg(nor, SPINOR_OP_WRDI, NULL, 0, 0);
 }
 
+/*
+ * Notify the (Q)SPI controller about the new protocol to be used.
+ */
+static inline int spi_nor_set_protocol(struct spi_nor *nor,
+				       enum spi_protocol proto)
+{
+	if (nor->set_protocol)
+		return nor->set_protocol(nor, proto);
+
+	return 0;
+}
+
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return mtd->priv;
@@ -943,6 +955,11 @@ static int micron_quad_enable(struct spi_nor *nor)
 		return ret;
 	}
 
+	/* switch protocol to Quad CMD 4-4-4 */
+	ret = spi_nor_set_protocol(nor, SPI_PROTO_4_4_4);
+	if (ret)
+		return ret;
+
 	ret = spi_nor_wait_till_ready(nor);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e5409524bb0a..1bf6f11310ef 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -87,6 +87,16 @@ enum read_mode {
 	SPI_NOR_QUAD,
 };
 
+enum spi_protocol {
+	SPI_PROTO_1_1_1,	/* SPI */
+	SPI_PROTO_1_1_2,	/* Dual Output */
+	SPI_PROTO_1_1_4,	/* Quad Output */
+	SPI_PROTO_1_2_2,	/* Dual IO */
+	SPI_PROTO_1_4_4,	/* Quad IO */
+	SPI_PROTO_2_2_2,	/* Dual Command */
+	SPI_PROTO_4_4_4,	/* Quad Command */
+};
+
 /**
  * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash transfer
  * @wren:		command for "Write Enable", or 0x00 for not required
@@ -149,6 +159,7 @@ enum spi_nor_option_flags {
  *			read/write/erase/lock/unlock operations
  * @read_xfer:		[OPTIONAL] the read fundamental primitive
  * @write_xfer:		[OPTIONAL] the writefundamental primitive
+ * @set_protocol:	[OPTIONAL] notify about protocol change
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
@@ -185,6 +196,8 @@ struct spi_nor {
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 			int write_enable);
 
+	int (*set_protocol)(struct spi_nor *nor, enum spi_protocol proto);
+
 	int (*read)(struct spi_nor *nor, loff_t from,
 			size_t len, size_t *retlen, u_char *read_buf);
 	void (*write)(struct spi_nor *nor, loff_t to,
-- 
1.8.2.2
