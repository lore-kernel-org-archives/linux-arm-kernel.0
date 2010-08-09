From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  9 Aug 2010 07:20:23 +0300
Subject: [PATCH] nand: fix .correct callback return value check
In-Reply-To: <20100808204341.GA20065@pengutronix.de>
References: <20100808204341.GA20065@pengutronix.de>
Message-ID: <ca767a0d6cafbea862c307e944c2b800dafb6660.1281327492.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers may (and do) return negative errno values other than -1 from the
.correct callback.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mtd/nand/nand_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 4a7b864..080f551 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -1210,7 +1210,7 @@ static int nand_read_subpage(struct mtd_info *mtd, struct nand_chip *chip, uint3
 		int stat;
 
 		stat = chip->ecc.correct(mtd, p, &chip->buffers->ecccode[i], &chip->buffers->ecccalc[i]);
-		if (stat == -1)
+		if (stat < 0)
 			mtd->ecc_stats.failed++;
 		else
 			mtd->ecc_stats.corrected += stat;
-- 
1.7.1
