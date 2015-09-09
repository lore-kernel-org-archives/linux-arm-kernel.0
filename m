From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 9 Sep 2015 15:24:11 +0200
Subject: [PATCH linux-next v6 1/8] mtd: spi-nor: read JEDEC ID with multiple
 I/O protocols
In-Reply-To: <cover.1441803609.git.cyrille.pitchen@atmel.com>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com>
Message-ID: <735e22efa25f6529bf8ed4a709c18a719176714b.1441803609.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When their quad or dual I/O mode is enabled, Micron and Macronix spi-nor
memories don't reply to the regular Read ID (0x9f) command. Instead they
reply to a new dedicated command Read ID Multiple I/O (0xaf).

If the Read ID (0x9f) command fails (the read ID is all 1's or all 0's),
then the Read ID Multiple I/O (0xaf) is used, first with SPI 4-4-4 protocol
(supported by both Micron and Macronix memories), lately with SPI-2-2-2
protocol (supported only by Micron memories).

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 28 +++++++++++++++++++++++++++-
 include/linux/mtd/spi-nor.h   | 23 +++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index f59aedfe1462..80a0db078aaa 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -703,8 +703,9 @@ static const struct flash_info spi_nor_ids[] = {
 
 static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 {
-	int			tmp;
+	int			i, tmp;
 	u8			id[SPI_NOR_MAX_ID_LEN];
+	enum spi_protocol	proto[2] = {SPI_PROTO_4_4_4, SPI_PROTO_2_2_2};
 	const struct flash_info	*info;
 
 	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
@@ -713,6 +714,25 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 		return ERR_PTR(tmp);
 	}
 
+	/* Special case for Micron/Macronix qspi nor. */
+	for (i = 0; i < ARRAY_SIZE(proto); ++i) {
+		if (!((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
+		      (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00)))
+			break;
+
+		nor->erase_proto = proto[i];
+		nor->read_proto = proto[i];
+		nor->write_proto = proto[i];
+		nor->reg_proto = proto[i];
+		tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID,
+				    id, SPI_NOR_MAX_ID_LEN);
+		if (tmp < 0) {
+			dev_dbg(nor->dev,
+				" error %d reading JEDEC ID (MULTI IO)\n", tmp);
+			return ERR_PTR(tmp);
+		}
+	}
+
 	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
 		info = &spi_nor_ids[tmp];
 		if (info->id_len) {
@@ -1013,6 +1033,12 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (ret)
 		return ret;
 
+	/* Reset SPI protocol for all commands */
+	nor->erase_proto = SPI_PROTO_1_1_1;
+	nor->read_proto = SPI_PROTO_1_1_1;
+	nor->write_proto = SPI_PROTO_1_1_1;
+	nor->reg_proto = SPI_PROTO_1_1_1;
+
 	if (name)
 		info = spi_nor_match_id(name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e5409524bb0a..66a5f144728a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -57,8 +57,9 @@
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
 
 /* Used for Micron flashes only. */
-#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
-#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
+#define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
+#define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
+#define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
 
 /* Status Register bits. */
 #define SR_WIP			1	/* Write in progress */
@@ -87,6 +88,16 @@ enum read_mode {
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
@@ -142,6 +153,10 @@ enum spi_nor_option_flags {
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
  * @cfg:		used by the read_xfer/write_xfer
+ * @erase_proto:	the SPI protocol used by erase operations
+ * @read_proto:		the SPI protocol used by read operations
+ * @write_proto:	the SPI protocol used by write operations
+ * @reg_proto		the SPI protocol used by read_reg/write_reg operations
  * @cmd_buf:		used by the write_reg
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
@@ -169,6 +184,10 @@ struct spi_nor {
 	u8			read_opcode;
 	u8			read_dummy;
 	u8			program_opcode;
+	enum spi_protocol	erase_proto;
+	enum spi_protocol	read_proto;
+	enum spi_protocol	write_proto;
+	enum spi_protocol	reg_proto;
 	enum read_mode		flash_read;
 	bool			sst_write_second;
 	u32			flags;
-- 
1.8.2.2
