From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 13:46:47 +0300
Subject: [PATCH v7] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1339064536-20553-1-git-send-email-stigge@antcom.de>
References: <1339064536-20553-1-git-send-email-stigge@antcom.de>
Message-ID: <1340794007.29342.50.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 12:22 +0200, Roland Stigge wrote:
> This patch adds support for the SLC NAND controller inside the LPC32xx SoC.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Now the write_page and write_page_raw functions return an error code,
see this commit in the l2 tree:

http://git.infradead.org/users/dedekind/l2-mtd.git/commit/49c8d9ab3b70732665249f2d993f734378ebbba9

I've amended your SLC driver, see below the diff. But I think it could
return the real return code becuse it can fail - could you please take a
look and send an incremental patch?

Please, base your work on top of the l2-mtd tree:
git://git.infradead.org/users/dedekind/l2-mtd.git

Thanks!

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 796e37b..7e2e78d 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -673,9 +673,9 @@ static int lpc32xx_nand_read_page_raw_syndrome(struct mtd_info *mtd,
  * Write the data and OOB data to the device, use ECC with the data,
  * disable ECC for the OOB data
  */
-static void lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
-                                            struct nand_chip *chip,
-                                            const u8 *buf, int oob_required)
+static int lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
+                                           struct nand_chip *chip,
+                                           const u8 *buf, int oob_required)
 {
        struct lpc32xx_nand_host *host = chip->priv;
        u8 *pb = chip->oob_poi + chip->ecc.layout->eccpos[0];
@@ -691,20 +691,22 @@ static void lpc32xx_nand_write_page_syndrome(struct mtd_info *mtd,
 
        /* Write ECC data to device */
        chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+       return 0;
 }
 
 /*
  * Write the data and OOB data to the device, no ECC correction with the
  * data or OOB data
  */
-static void lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
-                                                struct nand_chip *chip,
-                                                const u8 *buf,
-                                                int oob_required)
+static int lpc32xx_nand_write_page_raw_syndrome(struct mtd_info *mtd,
+                                               struct nand_chip *chip,
+                                               const u8 *buf,
+                                               int oob_required)
 {
        /* Raw writes can just use the FIFO interface */
        chip->write_buf(mtd, buf, chip->ecc.size * chip->ecc.steps);
        chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+       return 0;
 }
 
 static bool lpc32xx_dma_filter(struct dma_chan *chan, void *param)


-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/e4c91679/attachment.sig>
