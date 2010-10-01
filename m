From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:49 +0530
Subject: [PATCH V2 29/69] Newly erased page read workaround
In-Reply-To: <cover.1285933331.git.viresh.kumar@st.com>
References: <cover.1285933331.git.viresh.kumar@st.com>
Message-ID: <0420ee3d85bb74f000c7c5f35e0c615f4779d9ad.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipin Kumar <vipin.kumar@st.com>

A newly erased page contains ff in data as well as spare area. While reading an
erased page, the read out ecc from spare area does not match the ecc generated
by fsmc ecc hardware accelarator. This is because ecc of data ff ff is not ff
ff. This leads to errors when jffs2 fs erases and reads back the pages to
ensure consistency.

This patch adds a software workaround to ensure that the ecc check is not
performed for erased pages. An erased page is checked by checking data as ff ff.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c |   28 ++++++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index 2ca48fc..5d659df 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -382,7 +382,7 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 	struct fsmc_nand_data *host = container_of(mtd,
 					struct fsmc_nand_data, mtd);
 	struct fsmc_eccplace *ecc_place = host->ecc_place;
-	int i, j, s, stat, eccsize = chip->ecc.size;
+	int i, j, k, s, stat, eccsize = chip->ecc.size;
 	int eccbytes = chip->ecc.bytes;
 	int eccsteps = chip->ecc.steps;
 	u8 *p = buf;
@@ -422,11 +422,27 @@ static int fsmc_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
 		memcpy(&ecc_code[i], oob, 13);
 		chip->ecc.calculate(mtd, p, &ecc_calc[i]);
 
-		stat = chip->ecc.correct(mtd, p, &ecc_code[i], &ecc_calc[i]);
-		if (stat < 0)
-			mtd->ecc_stats.failed++;
-		else
-			mtd->ecc_stats.corrected += stat;
+		/*
+		 * This is a temporary erase check. A newly erased page read
+		 * would result in an ecc error because the oob data is also
+		 * erased to FF and the calculated ecc for an FF data is not
+		 * FF..FF.
+		 * This is a workaround to skip performing correction in case
+		 * data is FF..FF
+		 */
+		for (k = 0; k < eccsize; k++) {
+			if (*(p + k) != 0xff)
+				break;
+		}
+
+		if (k < eccsize) {
+			stat = chip->ecc.correct(mtd, p, &ecc_code[i],
+					&ecc_calc[i]);
+			if (stat < 0)
+				mtd->ecc_stats.failed++;
+			else
+				mtd->ecc_stats.corrected += stat;
+		}
 	}
 
 	return 0;
-- 
1.7.2.2
