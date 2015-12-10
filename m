From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 10 Dec 2015 09:00:40 +0100
Subject: [PATCH v4 56/58] ARM: make use of nand_set/get_controller_data()
 helpers
In-Reply-To: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449734442-18672-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449734442-18672-57-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New helpers have been added to avoid directly accessing chip->field. Use
them where appropriate.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-ixp4xx/ixdp425-setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/ixdp425-setup.c b/arch/arm/mach-ixp4xx/ixdp425-setup.c
index 333b0f9..508c2d7 100644
--- a/arch/arm/mach-ixp4xx/ixdp425-setup.c
+++ b/arch/arm/mach-ixp4xx/ixdp425-setup.c
@@ -77,7 +77,7 @@ static void
 ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
-	int offset = (int)this->priv;
+	int offset = (int)nand_get_controller_data(this);
 
 	if (ctrl & NAND_CTRL_CHANGE) {
 		if (ctrl & NAND_NCE) {
@@ -88,7 +88,7 @@ ixdp425_flash_nand_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 
 		offset = (ctrl & NAND_CLE) ? IXDP425_NAND_CMD_BYTE : 0;
 		offset |= (ctrl & NAND_ALE) ? IXDP425_NAND_ADDR_BYTE : 0;
-		this->priv = (void *)offset;
+		nand_set_controller_data(this, (void *)offset);
 	}
 
 	if (cmd != NAND_CMD_NONE)
-- 
2.1.4
