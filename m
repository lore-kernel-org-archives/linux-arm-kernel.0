From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 08:59:47 +0100
Subject: [PATCH v4 03/58] mtd: nand: nuc900: create and use mtd_to_nuc900()
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create and use mtd_to_nuc900() instead of direct container_of() calls.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/nuc900_nand.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/nuc900_nand.c b/drivers/mtd/nand/nuc900_nand.c
index 8148cd6..65908c0 100644
--- a/drivers/mtd/nand/nuc900_nand.c
+++ b/drivers/mtd/nand/nuc900_nand.c
@@ -62,6 +62,11 @@ struct nuc900_nand {
 	spinlock_t lock;
 };
 
+static inline struct nuc900_nand *mtd_to_nuc900(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct nuc900_nand, mtd);
+}
+
 static const struct mtd_partition partitions[] = {
 	{
 	 .name = "NAND FS 0",
@@ -78,9 +83,7 @@ static const struct mtd_partition partitions[] = {
 static unsigned char nuc900_nand_read_byte(struct mtd_info *mtd)
 {
 	unsigned char ret;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	ret = (unsigned char)read_data_reg(nand);
 
@@ -91,9 +94,7 @@ static void nuc900_nand_read_buf(struct mtd_info *mtd,
 				 unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	for (i = 0; i < len; i++)
 		buf[i] = (unsigned char)read_data_reg(nand);
@@ -103,9 +104,7 @@ static void nuc900_nand_write_buf(struct mtd_info *mtd,
 				  const unsigned char *buf, int len)
 {
 	int i;
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	for (i = 0; i < len; i++)
 		write_data_reg(nand, buf[i]);
@@ -124,11 +123,9 @@ static int nuc900_check_rb(struct nuc900_nand *nand)
 
 static int nuc900_nand_devready(struct mtd_info *mtd)
 {
-	struct nuc900_nand *nand;
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 	int ready;
 
-	nand = container_of(mtd, struct nuc900_nand, mtd);
-
 	ready = (nuc900_check_rb(nand)) ? 1 : 0;
 	return ready;
 }
@@ -137,9 +134,7 @@ static void nuc900_nand_command_lp(struct mtd_info *mtd, unsigned int command,
 				   int column, int page_addr)
 {
 	register struct nand_chip *chip = mtd_to_nand(mtd);
-	struct nuc900_nand *nand;
-
-	nand = container_of(mtd, struct nuc900_nand, mtd);
+	struct nuc900_nand *nand = mtd_to_nuc900(mtd);
 
 	if (command == NAND_CMD_READOOB) {
 		column += mtd->writesize;
-- 
2.1.4
