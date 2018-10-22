From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Mon, 22 Oct 2018 11:33:40 +0300
Subject: [PATCH v3 1/2] mtd: spi-nor: add support to non-uniform SFDP SPI
 NOR flash memories
In-Reply-To: <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <20180911154007.17195-1-tudor.ambarus@microchip.com>
 <20180911154007.17195-2-tudor.ambarus@microchip.com>
 <VI1PR04MB103888BC18F3C5AD0C02DEF699FE0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <31a8f6a9-1459-443a-6ef8-2b2c17769ae4@microchip.com>
 <de0f7245-2557-12be-a306-67b08e55ae7b@wedev4u.fr>
 <VI1PR04MB1038AB25EABDC8507984ADC799FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017090724.12f2cd79@bbrezillon> <20181017091045.124e0266@bbrezillon>
 <20181017092941.3658bd9a@bbrezillon>
 <VI1PR04MB1038EFA1E83AD78EBE84ECC499FF0@VI1PR04MB1038.eurprd04.prod.outlook.com>
 <20181017115237.07310b74@bbrezillon>
 <VI1PR04MB1038BD6103DD8BD6B6DEC2B899F40@VI1PR04MB1038.eurprd04.prod.outlook.com>
Message-ID: <c96cf515-3e9c-b775-38bf-51e85af96e32@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please amend this as well. Thanks!

---
 drivers/mtd/spi-nor/spi-nor.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3a9b69e9ba6d..3019708696cd 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2887,10 +2887,15 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
 static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 {
 	const u32 *ret = NULL;
+	u8 *dma_safe;
 	u32 i, addr;
 	int err;
 	u8 addr_width, read_opcode, read_dummy;
-	u8 read_data_mask, data_byte, map_id;
+	u8 read_data_mask, map_id;
+
+	dma_safe = kmalloc(sizeof(*dma_safe), GFP_KERNEL | GFP_DMA);
+	if (!dma_safe)
+		return ERR_PTR(-ENOMEM);
 
 	addr_width = nor->addr_width;
 	read_dummy = nor->read_dummy;
@@ -2906,7 +2911,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
 		addr = smpt[i + 1];
 
-		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
+		err = spi_nor_read_raw(nor, addr, 1, dma_safe);
 		if (err)
 			goto out;
 
@@ -2914,7 +2919,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 		 * Build an index value that is used to select the Sector Map
 		 * Configuration that is currently in use.
 		 */
-		map_id = map_id << 1 | !!(data_byte & read_data_mask);
+		map_id = map_id << 1 | !!(*dma_safe & read_data_mask);
 		i = i + 2;
 	}
 
@@ -2929,6 +2934,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
 	ret = smpt + i;
 	/* fall through */
 out:
+	kfree(dma_safe);
 	nor->addr_width = addr_width;
 	nor->read_dummy = read_dummy;
 	nor->read_opcode = read_opcode;
-- 
2.9.4
