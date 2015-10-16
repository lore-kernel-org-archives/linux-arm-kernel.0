From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 16 Oct 2015 14:38:54 +0530
Subject: [PATCH v2 1/4] mtd: brcmnand: Fix pointer type-cast in
 brcmnand_write()
In-Reply-To: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
References: <1444986537-28387-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1444986537-28387-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should always type-cast pointer to "long" or "unsigned long"
because size of pointer is same as machine word size. This will
avoid pointer type-cast issues on both 32bit and 64bit systems.

This patch fixes pointer type-cast issue in brcmnand_write()
as-per above info.

Signed-off-by: Anup Patel <anup.patel@broadcom.com>
Reviewed-by: Vikram Prakash <vikramp@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 drivers/mtd/nand/brcmnand/brcmnand.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/brcmnand/brcmnand.c b/drivers/mtd/nand/brcmnand/brcmnand.c
index fddb795..4cba03d 100644
--- a/drivers/mtd/nand/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/brcmnand/brcmnand.c
@@ -1544,9 +1544,9 @@ static int brcmnand_write(struct mtd_info *mtd, struct nand_chip *chip,
 
 	dev_dbg(ctrl->dev, "write %llx <- %p\n", (unsigned long long)addr, buf);
 
-	if (unlikely((u32)buf & 0x03)) {
+	if (unlikely((unsigned long)buf & 0x03)) {
 		dev_warn(ctrl->dev, "unaligned buffer: %p\n", buf);
-		buf = (u32 *)((u32)buf & ~0x03);
+		buf = (u32 *)((unsigned long)buf & ~0x03);
 	}
 
 	brcmnand_wp(mtd, 0);
-- 
1.9.1
