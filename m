From: ben@decadent.org.uk (Ben Hutchings)
Date: Tue, 30 Sep 2014 03:15:04 +0100
Subject: [PATCH v2 2/5] spi-nor: Remove spi_nor::read_id operation
In-Reply-To: <1412043222.9388.81.camel@decadent.org.uk>
References: <1412043222.9388.81.camel@decadent.org.uk>
Message-ID: <1412043304.9388.83.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is currently no useful way to override the default
implementation of this operation.  The returned struct spi_device_id
must have a pointer to struct flash_info in its private data, but this
structure is defined inside spi-nor.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/spi-nor/spi-nor.c | 4 +---
 include/linux/mtd/spi-nor.h   | 3 ---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 53783ed..c2f0573 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -902,8 +902,6 @@ static int spi_nor_check(struct spi_nor *nor)
 		return -EINVAL;
 	}
 
-	if (!nor->read_id)
-		nor->read_id = spi_nor_read_id;
 	if (!nor->wait_till_ready)
 		nor->wait_till_ready = spi_nor_wait_till_ready;
 
@@ -929,7 +927,7 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
 	if (info->jedec_id) {
 		const struct spi_device_id *jid;
 
-		jid = nor->read_id(nor);
+		jid = spi_nor_read_id(nor);
 		if (IS_ERR(jid)) {
 			return PTR_ERR(jid);
 		} else if (jid != id) {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 5ec84cc..66af67a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -139,8 +139,6 @@ enum spi_nor_ops {
  * @write_xfer:		[OPTIONAL] the writefundamental primitive
  * @read_reg:		[DRIVER-SPECIFIC] read out the register
  * @write_reg:		[DRIVER-SPECIFIC] write data to the register
- * @read_id:		[REPLACEABLE] read out the ID data, and find
- *			the proper spi_device_id
  * @wait_till_ready:	[REPLACEABLE] wait till the NOR becomes ready
  * @read:		[DRIVER-SPECIFIC] read data from the SPI NOR
  * @write:		[DRIVER-SPECIFIC] write data to the SPI NOR
@@ -172,7 +170,6 @@ struct spi_nor {
 	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
 	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
 			int write_enable);
-	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
 	int (*wait_till_ready)(struct spi_nor *nor);
 
 	int (*read)(struct spi_nor *nor, loff_t from,


-- 
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/595a9e05/attachment-0001.sig>
