From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:33 +0000
Subject: [RFC 16/47] mtd: nand: stm_nand_bch: derive some working variables
 for latter use
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A few of the working variables can either be taken or derived from
existing knowledge about the connected chip. Rather than attempt to
provide each specification manually, here we make assumptions based
on information already obtained.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 93fe835..f5a3e80 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -783,6 +783,15 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	/* Derive some working variables */
+	nandi->sectors_per_page = mtd->writesize / NANDI_BCH_SECTOR_SIZE;
+	nandi->blocks_per_device = mtd->size >> chip->phys_erase_shift;
+	nandi->page_shift = chip->page_shift;
+	nandi->block_shift = chip->phys_erase_shift;
+	nandi->extra_addr = ((chip->chipsize >> nandi->page_shift) >
+			     0x10000) ? true : false;
+	mtd->writebufsize = mtd->writesize;
+
 	return 0;
 }
 
-- 
1.8.3.2
