From: b32955@freescale.com (Huang Shijie)
Date: Fri, 14 Jun 2013 16:06:24 +0800
Subject: [PATCH 3/4] mtd: gpmi: scan two nand chips
In-Reply-To: <1371197185-27491-1-git-send-email-b32955@freescale.com>
References: <1371197185-27491-1-git-send-email-b32955@freescale.com>
Message-ID: <1371197185-27491-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nand chip has two DIEs in a single chip, such as Micron MT29F32G08QAA.
Each die has its own chip select pin, so this chip acts as two nand
chips.

If we only scan one chip, we may find that we only get 2G for this chip,
but in actually, this chip's size is 4G.

So scan two chips by default.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
index 036e5e4..bb8af93 100644
--- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
@@ -1551,7 +1551,7 @@ static int gpmi_nfc_init(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
-	ret = nand_scan(mtd, 1);
+	ret = nand_scan(mtd, 2);
 	if (ret) {
 		pr_err("Chip scan failed\n");
 		goto err_out;
-- 
1.7.1
