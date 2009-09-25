From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 25 Sep 2009 15:15:56 -0400
Subject: [PATCH] [MTD] [ONENAND] export onenand_command
Message-ID: <mailman.21.1253879983.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell PXA3xx bad block management will replaces the bad block with good
one.
The driver have to implement custom command function. Export
onenand_command()
in order to reuse the command function in onenand_base.c.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/mtd/onenand/onenand_base.c |    3 ++-
 include/linux/mtd/onenand.h        |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/onenand/onenand_base.c
b/drivers/mtd/onenand/onenand_base.c
index 6e82909..8f7c73a 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -317,7 +317,7 @@ EXPORT_SYMBOL(flexonenand_region);
  * Send command to OneNAND device. This function is used for middle/large
page
  * devices (1KB/2KB Bytes per page)
  */
-static int onenand_command(struct mtd_info *mtd, int cmd, loff_t addr,
size_t len)
+int onenand_command(struct mtd_info *mtd, int cmd, loff_t addr, size_t len)
 {
     struct onenand_chip *this = mtd->priv;
     int value, block, page;
@@ -433,6 +433,7 @@ static int onenand_command(struct mtd_info *mtd, int
cmd, loff_t addr, size_t le

     return 0;
 }
+EXPORT_SYMBOL(onenand_command);

 /**
  * onenand_read_ecc - return ecc status
diff --git a/include/linux/mtd/onenand.h b/include/linux/mtd/onenand.h
index 8ed8733..c99737f 100644
--- a/include/linux/mtd/onenand.h
+++ b/include/linux/mtd/onenand.h
@@ -24,6 +24,8 @@
 extern int onenand_scan(struct mtd_info *mtd, int max_chips);
 /* Free resources held by the OneNAND device */
 extern void onenand_release(struct mtd_info *mtd);
+extern int onenand_command(struct mtd_info *mtd, int cmd,
+               loff_t addr, size_t len);

 /*
  * onenand_state_t - chip states
-- 
1.5.6.5

--0016e645b8ca818e73047465ae8e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
