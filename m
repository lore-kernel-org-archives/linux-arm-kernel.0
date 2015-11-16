From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 16 Nov 2015 14:37:36 +0100
Subject: [PATCH 03/27] mtd: nand: update examples in the documentation to use
 mtd_to_nand()
In-Reply-To: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1447681080-31232-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1447681080-31232-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mtd_to_nand() has been introduced to hide accesses to mtd->priv.
All NAND controller drivers should use it instead of directly accessing
the ->priv field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/DocBook/mtdnand.tmpl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/DocBook/mtdnand.tmpl b/Documentation/DocBook/mtdnand.tmpl
index 7da8f04..403a7ab 100644
--- a/Documentation/DocBook/mtdnand.tmpl
+++ b/Documentation/DocBook/mtdnand.tmpl
@@ -235,7 +235,7 @@ static void board_hwcontrol(struct mtd_info *mtd, int cmd)
 		<programlisting>
 static void board_hwcontrol(struct mtd_info *mtd, int cmd)
 {
-	struct nand_chip *this = (struct nand_chip *) mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	switch(cmd){
 		case NAND_CTL_SETCLE: this->IO_ADDR_W |= CLE_ADRR_BIT;  break;
 		case NAND_CTL_CLRCLE: this->IO_ADDR_W &amp;= ~CLE_ADRR_BIT; break;
@@ -399,7 +399,7 @@ static void board_select_chip (struct mtd_info *mtd, int chip)
 		<programlisting>
 static void board_select_chip (struct mtd_info *mtd, int chip)
 {
-	struct nand_chip *this = (struct nand_chip *) mtd->priv;
+	struct nand_chip *this = mtd_to_nand(mtd);
 	
 	/* Deselect all chips */
 	this->IO_ADDR_R &amp;= ~BOARD_NAND_ADDR_MASK;
-- 
2.1.4
