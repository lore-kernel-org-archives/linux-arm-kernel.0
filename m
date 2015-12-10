From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:42 +0100
Subject: [PATCH v4 58/58] staging: mt29f_spinand: make use of
 nand_set/get_controller_data() helpers
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-59-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New helpers have been added to avoid directly accessing chip->field. Use
them where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index b7d429d..197d112 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -32,7 +32,7 @@
 static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct spinand_info *info = (struct spinand_info *)chip->priv;
+	struct spinand_info *info = nand_get_controller_data(chip);
 	struct spinand_state *state = (struct spinand_state *)info->priv;
 
 	return state;
@@ -633,7 +633,7 @@ static int spinand_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	u8 *p = buf;
 	int eccsize = chip->ecc.size;
 	int eccsteps = chip->ecc.steps;
-	struct spinand_info *info = (struct spinand_info *)chip->priv;
+	struct spinand_info *info = nand_get_controller_data(chip);
 
 	enable_read_hw_ecc = 1;
 
@@ -679,7 +679,7 @@ static u8 spinand_read_byte(struct mtd_info *mtd)
 
 static int spinand_wait(struct mtd_info *mtd, struct nand_chip *chip)
 {
-	struct spinand_info *info = (struct spinand_info *)chip->priv;
+	struct spinand_info *info = nand_get_controller_data(chip);
 
 	unsigned long timeo = jiffies;
 	int retval, state = chip->state;
@@ -745,7 +745,7 @@ static void spinand_cmdfunc(struct mtd_info *mtd, unsigned int command,
 			    int column, int page)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
-	struct spinand_info *info = (struct spinand_info *)chip->priv;
+	struct spinand_info *info = nand_get_controller_data(chip);
 	struct spinand_state *state = (struct spinand_state *)info->priv;
 
 	switch (command) {
@@ -894,7 +894,7 @@ static int spinand_probe(struct spi_device *spi_nand)
 #endif
 
 	nand_set_flash_node(chip, spi_nand->dev.of_node);
-	chip->priv	= info;
+	nand_set_controller_data(chip, info);
 	chip->read_buf	= spinand_read_buf;
 	chip->write_buf	= spinand_write_buf;
 	chip->read_byte	= spinand_read_byte;
-- 
2.1.4
