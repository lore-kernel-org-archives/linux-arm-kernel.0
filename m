From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 15:21:50 -0400
Subject: [PATCH] [MTD] [ONENAND] supports custom bbm
Message-ID: <mailman.25.1253880048.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In onenand driver, the default bad block management is embedded. Custom BBM
can't be used. Now make it to support custom BBM.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/onenand/onenand_base.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c
b/drivers/mtd/onenand/onenand_base.c
index 8f7c73a..cc6bccb 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -2136,6 +2136,29 @@ static int onenand_block_isbad_nolock(struct mtd_info
*mtd, loff_t ofs, int allo
 {
     struct onenand_chip *this = mtd->priv;
     struct bbm_info *bbm = this->bbm;
+    struct mtd_oob_ops ops;
+    unsigned char *buf = this->page_buf;
+    int ret;
+
+    if (!bbm) {
+        ops.mode = MTD_OOB_PLACE;
+        ops.ooblen = 2;
+        ops.oobbuf = buf;
+        ops.len = 0;
+        ops.ooboffs = 0;
+        ops.retlen = 0;
+        ops.oobretlen = 0;
+
+        ofs = (ofs >> this->erase_shift) << this->erase_shift;
+        ret = onenand_read_oob_nolock(mtd, ofs, &ops);
+        if (ret == ONENAND_BBT_READ_FATAL_ERROR)
+            return -EIO;
+
+        if ((buf[ONENAND_BADBLOCK_POS] & 0x01) == 0) {
+            return -EIO;
+        }
+        return 0;
+    }

     /* Return info from the table */
     return bbm->isbad_bbt(mtd, ofs, allowbbt);
-- 
1.5.6.5

--0015175ce06877dbdd047465b2b8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
