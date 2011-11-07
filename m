From: zonque@gmail.com (Daniel Mack)
Date: Mon,  7 Nov 2011 16:43:31 +0100
Subject: [PATCH 4/4] mtd: pxa3xx_nand: Fix blank page ECC mismatch
In-Reply-To: <1320680611-29448-1-git-send-email-zonque@gmail.com>
References: <1320680611-29448-1-git-send-email-zonque@gmail.com>
Message-ID: <1320680611-29448-5-git-send-email-zonque@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bug was introduced in f8155a40 ("mtd: pxa3xx_nand: rework irq
logic") and causes the PXA3xx NAND controller fail to operate with NAND
flash that has empty pages. According to the comment in this block, the
hardware controller will report a double-bit error for empty pages,
which can and must be ignored.

This patch restores the original behaviour of the driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Acked-by: Lei Wen <leiwen@marvell.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: David Woodhouse <David.Woodhouse@intel.com>
Cc: stable at kernel.org [2.6.38+]
Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 drivers/mtd/nand/pxa3xx_nand.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index f08fae9..063cb19 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -685,6 +685,8 @@ static int pxa3xx_nand_read_page_hwecc(struct mtd_info *mtd,
 		 * OOB, ignore such double bit errors
 		 */
 		if (is_buf_blank(buf, mtd->writesize))
+			info->retcode = ERR_NONE;
+		else
 			mtd->ecc_stats.failed++;
 	}
 
-- 
1.7.6.4
