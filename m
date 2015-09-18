From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Fri, 18 Sep 2015 17:49:25 +0200
Subject: [PATCH linux-next 1/4] mtd: spi-nor: remove unused
 read_xfer/write_xfer hooks
In-Reply-To: <cover.1442590224.git.cyrille.pitchen@atmel.com>
References: <cover.1442590224.git.cyrille.pitchen@atmel.com>
Message-ID: <719ad7cc8bf6df151dd799cd4f13292fd9471079.1442590224.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct spi_nor_xfer_cfg and read_xfer/write_xfer hooks were never used by
any driver. Do some cleanup by removing them.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 include/linux/mtd/spi-nor.h | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e9c912d73141..672595a381c5 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -87,33 +87,6 @@ enum read_mode {
 	SPI_NOR_QUAD,
 };
 
-/**
- * struct spi_nor_xfer_cfg - Structure for defining a Serial Flash transfer
- * @wren:		command for "Write Enable", or 0x00 for not required
- * @cmd:		command for operation
- * @cmd_pins:		number of pins to send @cmd (1, 2, 4)
- * @addr:		address for operation
- * @addr_pins:		number of pins to send @addr (1, 2, 4)
- * @addr_width:		number of address bytes
- *			(3,4, or 0 for address not required)
- * @mode:		mode data
- * @mode_pins:		number of pins to send @mode (1, 2, 4)
- * @mode_cycles:	number of mode cycles (0 for mode not required)
- * @dummy_cycles:	number of dummy cycles (0 for dummy not required)
- */
-struct spi_nor_xfer_cfg {
-	u8		wren;
-	u8		cmd;
-	u8		cmd_pins;
-	u32		addr;
-	u8		addr_pins;
-	u8		addr_width;
-	u8		mode;
-	u8		mode_pins;
-	u8		mode_cycles;
-	u8		dummy_cycles;
-};
-
 #define SPI_NOR_MAX_CMD_SIZE	8
 enum spi_nor_ops {
 	SPI_NOR_OPS_READ = 0,
@@ -144,14 +117,11 @@ struct mtd_info;
  * @flash_read:		the mode of the read
  * @sst_write_second:	used by the SST write operation
  * @flags:		flag options for the current SPI-NOR (SNOR_F_*)
- * @cfg:		used by the read_xfer/write_xfer
  * @cmd_buf:		used by the write_reg
  * @prepare:		[OPTIONAL] do some preparations for the
  *			read/write/erase/lock/unlock operations
  * @unprepare:		[OPTIONAL] do some post work after the
  *			read/write/erase/lock/unlock operations
- * @read_xfer:		[OPTIONAL] the read fundamental primitive
- * @write_xfer:		[OPTIONAL] the writefundamental primitive
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
@@ -176,15 +146,10 @@ struct spi_nor {
 	enum read_mode		flash_read;
 	bool			sst_write_second;
 	u32			flags;
-	struct spi_nor_xfer_cfg	cfg;
 	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
 
 	int (*prepare)(struct spi_nor *nor, enum spi_nor_ops ops);
 	void (*unprepare)(struct spi_nor *nor, enum spi_nor_ops ops);
-	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
-			 u8 *buf, size_t len);
-	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
-			  u8 *buf, size_t len);
 	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 
-- 
1.8.2.2
