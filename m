From: b32955@freescale.com (Huang Shijie)
Date: Tue, 26 Nov 2013 14:32:53 +0800
Subject: [PATCH 2/4] mtd: spi-nor: add a new data structrue spi_nor{}
In-Reply-To: <1385447575-23773-1-git-send-email-b32955@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
Message-ID: <1385447575-23773-3-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spi_nor{} is cloned from the m25p{}.
The spi_nor{} can be used by both the m25p80 and spi-nor controller.

 1) Add four hooks:
    @read_reg: used to read the registers, such as read status register,
             read ID, read configure register.

    @write_reg: used to write the registers, such as write enable,
             erase sector.

    @read: use the proper read opcode to read out the data from the NOR.

    @write: use the proper write opcode to write data to the NOR.

 2) Add a new field sst_write_second for the SST NOR write.

 3) change the @command field from pointer to array which makes the code
    more simple.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/devices/m25p80.c |    6 -----
 include/linux/mtd/spi-nor.h  |   43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 4703aa4..13d9864 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -44,12 +44,6 @@
 
 /****************************************************************************/
 
-enum read_type {
-	M25P80_NORMAL = 0,
-	M25P80_FAST,
-	M25P80_QUAD,
-};
-
 struct m25p {
 	struct spi_device	*spi;
 	struct mutex		lock;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index ab2ea1e..8da1f69 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -50,4 +50,47 @@
 /* Configuration Register bits. */
 #define CR_QUAD_EN_SPAN		0x2     /* Spansion Quad I/O */
 
+#define	MAX_CMD_SIZE		6
+
+enum read_type {
+	M25P80_NORMAL = 0,
+	M25P80_FAST,
+	M25P80_QUAD,
+};
+
+struct spi_nor {
+	struct mutex		lock;
+	struct mtd_info		mtd;
+	struct device		*dev;
+	u16			page_size;
+	u16			addr_width;
+	u8			erase_opcode;
+	u8			read_opcode;
+	u8			program_opcode;
+	u8			command[MAX_CMD_SIZE];
+	enum read_type		flash_read;
+	bool			sst_write_second;
+
+	/*
+	 * Read the register:
+	 *  Read `len` length data from the register specified by the `opcode`,
+	 *  and store the data to the `buf`.
+	 */
+	int (*read_reg)(struct spi_nor *flash, u8 opcode, u8 *buf, int len);
+
+	/*
+	 * Write the register:
+	 *  Write the `cmd_len` length data stored in the @command to the NOR,
+	 *  the command[0] stores the write opcode. `offset` is only used for
+	 *  erase operation, it should set to zero for other NOR commands.
+	 */
+	int (*write_reg)(struct spi_nor *flash, int cmd_len, u32 offset);
+
+	/* write data */
+	void (*write)(struct spi_nor *flash, loff_t to, size_t len,
+			size_t *retlen, const u_char *buf);
+	/* read data */
+	int (*read)(struct spi_nor *flash, loff_t from, size_t len,
+			size_t *retlen, u_char *buf);
+};
 #endif
-- 
1.7.2.rc3
