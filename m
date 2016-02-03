From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Wed, 3 Feb 2016 14:26:47 +0100
Subject: [PATCH v3 02/14] mtd: spi-nor: properly detect the memory when it
 boots in Quad or Dual mode
In-Reply-To: <cover.1454505161.git.cyrille.pitchen@atmel.com>
References: <cover.1454505161.git.cyrille.pitchen@atmel.com>
Message-ID: <0234fe7fc577854b0bf59fcb376ce8260b56fb29.1454505161.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quad (or dual) mode of a spi-nor memory may be enabled at boot time by
non-volatile bits in some setting register. Also such a mode may have
already been enabled at early stage by some boot loader.

Hence, we should not guess the spi-nor memory is always configured for the
regular SPI 1-1-1 protocol.

Micron and Macronix memories, once their Quad (or dual for Micron) mode
enabled, no longer process the regular JEDEC Read ID (0x9f) command but
instead reply to a new command: JEDEC Read ID Multiple I/O (0xaf).
Besides, in Quad mode both memory manufacturers expect ALL commands to
use the SPI 4-4-4 protocol. For Micron memories, enabling their Dual mode
implies to use the SPI 2-2-2 protocol for ALL commands.

Winbond memories, once their Quad mode enabled, expect ALL commands to use
the SPI 4-4-4 protocol. Unlike Micron and Macronix memories, they still
reply to the regular JEDEC Read ID (0x9f) command.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 76 +++++++++++++++++++++++++++++++++++--------
 include/linux/mtd/spi-nor.h   | 50 ++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3028c06547c1..cff2665cea66 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -73,6 +73,13 @@ struct flash_info {
 
 #define JEDEC_MFR(info)	((info)->id[0])
 
+struct read_id_config {
+	enum read_mode		mode;
+	enum spi_nor_protocol	proto;
+	u8			opcode;
+	int			id_len;
+};
+
 static const struct flash_info *spi_nor_match_id(const char *name);
 
 /*
@@ -879,25 +886,60 @@ static const struct flash_info spi_nor_ids[] = {
 	{ },
 };
 
-static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
+static const struct flash_info *spi_nor_read_id(struct spi_nor *nor,
+						enum read_mode mode)
 {
-	int			tmp;
+	int			i, tmp;
 	u8			id[SPI_NOR_MAX_ID_LEN];
 	const struct flash_info	*info;
+	static const struct read_id_config configs[] = {
+		/* Regular JEDEC Read ID (always tested first) */
+		{SPI_NOR_NORMAL, SNOR_PROTO_1_1_1, SPINOR_OP_RDID, sizeof(id)},
 
-	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
-	if (tmp < 0) {
-		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
-		return ERR_PTR(tmp);
-	}
+		/* Winbond QPI mode */
+		{SPI_NOR_QUAD, SNOR_PROTO_4_4_4, SPINOR_OP_RDID, sizeof(id)},
+
+		/* Micron Quad mode & Macronix QPI mode */
+		{SPI_NOR_QUAD, SNOR_PROTO_4_4_4, SPINOR_OP_MIO_RDID, 3},
+
+		/* Micron Dual mode */
+		{SPI_NOR_DUAL, SNOR_PROTO_2_2_2, SPINOR_OP_MIO_RDID, 3}
+	};
+
+	/*
+	 * Check whether the SPI NOR memory has already been configured (at
+	 * reset or by some bootloader) to use a protocol other than SPI 1-1-1.
+	 */
+	for (i = 0; i < ARRAY_SIZE(configs); i++) {
+		/* Only try protocols supported by the user. */
+		if (i && configs[i].mode != mode)
+			continue;
+
+		/* Set this protocol for all commands. */
+		nor->reg_proto = configs[i].proto;
+		nor->read_proto = configs[i].proto;
+		nor->write_proto = configs[i].proto;
+		nor->erase_proto = configs[i].proto;
+
+		/* Read the JEDEC ID. */
+		memset(id, 0, sizeof(id));
+		tmp = nor->read_reg(nor, configs[i].opcode,
+				    id, configs[i].id_len);
+		if (tmp < 0) {
+			dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
+			return ERR_PTR(tmp);
+		}
 
-	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
-		info = &spi_nor_ids[tmp];
-		if (info->id_len) {
-			if (!memcmp(info->id, id, info->id_len))
-				return &spi_nor_ids[tmp];
+		/* Look this ID up. */
+		for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
+			info = &spi_nor_ids[tmp];
+			if (info->id_len) {
+				if (!memcmp(info->id, id, info->id_len))
+					return &spi_nor_ids[tmp];
+			}
 		}
 	}
+
 	dev_err(nor->dev, "unrecognized JEDEC id bytes: %02x, %02x, %02x\n",
 		id[0], id[1], id[2]);
 	return ERR_PTR(-ENODEV);
@@ -1148,11 +1190,17 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (ret)
 		return ret;
 
+	/* Reset SPI protocol for all commands */
+	nor->erase_proto = SNOR_PROTO_1_1_1;
+	nor->read_proto = SNOR_PROTO_1_1_1;
+	nor->write_proto = SNOR_PROTO_1_1_1;
+	nor->reg_proto = SNOR_PROTO_1_1_1;
+
 	if (name)
 		info = spi_nor_match_id(name);
 	/* Try to auto-detect if chip name wasn't specified or not found */
 	if (!info)
-		info = spi_nor_read_id(nor);
+		info = spi_nor_read_id(nor, mode);
 	if (IS_ERR_OR_NULL(info))
 		return -ENOENT;
 
@@ -1163,7 +1211,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (name && info->id_len) {
 		const struct flash_info *jinfo;
 
-		jinfo = spi_nor_read_id(nor);
+		jinfo = spi_nor_read_id(nor, mode);
 		if (IS_ERR(jinfo)) {
 			return PTR_ERR(jinfo);
 		} else if (jinfo != info) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 62356d50815b..53932c87bcf2 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -75,8 +75,9 @@
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
 
 /* Used for Micron flashes only. */
-#define SPINOR_OP_RD_EVCR      0x65    /* Read EVCR register */
-#define SPINOR_OP_WD_EVCR      0x61    /* Write EVCR register */
+#define SPINOR_OP_MIO_RDID	0xaf	/* Multiple I/O Read JEDEC ID */
+#define SPINOR_OP_RD_EVCR	0x65    /* Read EVCR register */
+#define SPINOR_OP_WD_EVCR	0x61    /* Write EVCR register */
 
 /* Status Register bits. */
 #define SR_WIP			BIT(0)	/* Write in progress */
@@ -105,6 +106,43 @@ enum read_mode {
 	SPI_NOR_QUAD,
 };
 
+
+#define SNOR_PROTO_CMD_OFF	8
+#define SNOR_PROTO_CMD_MASK	GENMASK(11, 8)
+#define SNOR_PROTO_CMD_TO_PROTO(cmd) \
+	(((cmd) << SNOR_PROTO_CMD_OFF) & SNOR_PROTO_CMD_MASK)
+#define SNOR_PROTO_CMD_FROM_PROTO(proto) \
+	((((u32)(proto)) & SNOR_PROTO_CMD_MASK) >> SNOR_PROTO_CMD_OFF)
+
+#define SNOR_PROTO_ADDR_OFF	4
+#define SNOR_PROTO_ADDR_MASK	GENMASK(7, 4)
+#define SNOR_PROTO_ADDR_TO_PROTO(addr) \
+	(((addr) << SNOR_PROTO_ADDR_OFF) & SNOR_PROTO_ADDR_MASK)
+#define SNOR_PROTO_ADDR_FROM_PROTO(proto) \
+	((((u32)(proto)) & SNOR_PROTO_ADDR_MASK) >> SNOR_PROTO_ADDR_OFF)
+
+#define SNOR_PROTO_DATA_OFF	0
+#define SNOR_PROTO_DATA_MASK	GENMASK(3, 0)
+#define SNOR_PROTO_DATA_TO_PROTO(data) \
+	(((data) << SNOR_PROTO_DATA_OFF) & SNOR_PROTO_DATA_MASK)
+#define SNOR_PROTO_DATA_FROM_PROTO(proto) \
+	((((u32)(proto)) & SNOR_PROTO_DATA_MASK) >> SNOR_PROTO_DATA_OFF)
+
+#define SNOR_PROTO(cmd, addr, data)	  \
+	(SNOR_PROTO_CMD_TO_PROTO(cmd) |   \
+	 SNOR_PROTO_ADDR_TO_PROTO(addr) | \
+	 SNOR_PROTO_DATA_TO_PROTO(data))
+
+enum spi_nor_protocol {
+	SNOR_PROTO_1_1_1 = SNOR_PROTO(1, 1, 1),	/* SPI */
+	SNOR_PROTO_1_1_2 = SNOR_PROTO(1, 1, 2),	/* Dual Output */
+	SNOR_PROTO_1_1_4 = SNOR_PROTO(1, 1, 4),	/* Quad Output */
+	SNOR_PROTO_1_2_2 = SNOR_PROTO(1, 2, 2),	/* Dual IO */
+	SNOR_PROTO_1_4_4 = SNOR_PROTO(1, 4, 4),	/* Quad IO */
+	SNOR_PROTO_2_2_2 = SNOR_PROTO(2, 2, 2),	/* Dual Command */
+	SNOR_PROTO_4_4_4 = SNOR_PROTO(4, 4, 4),	/* Quad Command */
+};
+
 #define SPI_NOR_MAX_CMD_SIZE	8
 enum spi_nor_ops {
 	SPI_NOR_OPS_READ = 0,
@@ -132,6 +170,10 @@ enum spi_nor_option_flags {
  * @flash_read:		the mode of the read
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
+ * @erase_proto:	the SPI protocol used by erase operations
+ * @read_proto:		the SPI protocol used by read operations
+ * @write_proto:	the SPI protocol used by write operations
+ * @reg_proto		the SPI protocol used by read_reg/write_reg operations
  * @cmd_buf:		used by the write_reg
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
@@ -160,6 +202,10 @@ struct spi_nor {
 	u8			read_opcode;
 	u8			read_dummy;
 	u8			program_opcode;
+	enum spi_nor_protocol	erase_proto;
+	enum spi_nor_protocol	read_proto;
+	enum spi_nor_protocol	write_proto;
+	enum spi_nor_protocol	reg_proto;
 	enum read_mode		flash_read;
 	bool			sst_write_second;
 	u32			flags;
-- 
1.8.2.2
