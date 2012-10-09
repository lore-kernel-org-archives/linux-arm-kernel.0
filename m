From: vipin.kumar@st.com (Vipin Kumar)
Date: Tue, 9 Oct 2012 16:14:51 +0530
Subject: [PATCH 09/11] fsmc/nand:FIX: replace change_bit routine
In-Reply-To: <cover.1349778820.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
Message-ID: <ec169eb041e87e66c06108e85ea4a67e5797cecc.1349778821.git.vipin.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

change_bit routine accepts only ulong pointers as buffer, so an unaligned char
pointer passed to change_bit may lead to a crash.

Fix this bug by accessing the buffer as char pointer.

Signed-off-by: Vipin Kumar <vipin.kumar@st.com>
---
 drivers/mtd/nand/fsmc_nand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
index f48ee60..762cf83 100644
--- a/drivers/mtd/nand/fsmc_nand.c
+++ b/drivers/mtd/nand/fsmc_nand.c
@@ -859,7 +859,9 @@ static int fsmc_bch8_correct_data(struct mtd_info *mtd, uint8_t *dat,
 		change_bit(1, (unsigned long *)&err_idx[i]);
 
 		if (err_idx[i] < chip->ecc.size * 8) {
-			change_bit(err_idx[i], (unsigned long *)dat);
+			uint8_t *p = dat + err_idx[i] / 8;
+			*p = *p ^ (1 << (err_idx[i] % 8));
+
 			i++;
 		}
 	}
-- 
1.7.11.4
