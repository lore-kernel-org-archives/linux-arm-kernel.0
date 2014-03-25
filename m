From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:32 +0000
Subject: [RFC 15/47] mtd: nand: stm_nand_bch: add compatible page size check
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-16-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/stm_nand_bch.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index fbcd1b9..93fe835 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -29,6 +29,9 @@
 #include "stm_nand_regs.h"
 #include "stm_nand_dt.h"
 
+/* NANDi BCH Controller properties */
+#define NANDI_BCH_SECTOR_SIZE			1024
+
 /* Bad Block Table (BBT) */
 struct nandi_bbt_info {
 	uint32_t	bbt_size;		/* Size of bad-block table */
@@ -774,6 +777,12 @@ static int stm_nand_bch_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "No timing data available\n");
 	}
 
+	if (mtd->writesize < NANDI_BCH_SECTOR_SIZE) {
+		dev_err(nandi->dev,
+			"page size incompatible with BCH ECC sector\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.8.3.2
