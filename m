From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Mon, 17 Feb 2014 16:24:51 +0100
Subject: [PATCH v2] clk: at91: optimization of the set_rate callback
In-Reply-To: <52F1FC52.1040205@overkiz.com>
References: <52F1FC52.1040205@overkiz.com>
Message-ID: <1392650691-20215-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---

Hi,
this fixes the commit's log as indicated by Boris.
cheers,
Jean-jacques

 drivers/clk/at91/clk-programmable.c | 38 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index 7bcc725..62e2509 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -139,43 +139,21 @@ static int clk_programmable_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct clk_programmable *prog = to_clk_programmable(hw);
 	struct at91_pmc *pmc = prog->pmc;
 	const struct clk_programmable_layout *layout = prog->layout;
-	unsigned long best_rate = parent_rate;
-	unsigned long best_diff;
-	unsigned long new_diff;
-	unsigned long cur_rate;
+	unsigned long div = parent_rate / rate;
 	int shift = 0;
 	u32 tmp = pmc_read(pmc, AT91_PMC_PCKR(prog->id)) &
 		  ~(PROG_PRES_MASK << layout->pres_shift);
 
-	if (rate > parent_rate)
-		return parent_rate;
-	else
-		best_diff = parent_rate - rate;
+	if (!div)
+		return -EINVAL;
 
-	if (!best_diff) {
-		pmc_write(pmc, AT91_PMC_PCKR(prog->id), tmp | shift);
-		return 0;
-	}
-
-	for (shift = 1; shift < PROG_PRES_MASK; shift++) {
-		cur_rate = parent_rate >> shift;
-
-		if (cur_rate > rate)
-			new_diff = cur_rate - rate;
-		else
-			new_diff = rate - cur_rate;
-
-		if (!new_diff)
-			break;
+	shift = fls(div) - 1;
 
-		if (new_diff < best_diff) {
-			best_diff = new_diff;
-			best_rate = cur_rate;
-		}
+	if (div != (1<<shift))
+		return -EINVAL;
 
-		if (rate > cur_rate)
-			break;
-	}
+	if (shift >= PROG_PRES_MASK)
+		return -EINVAL;
 
 	pmc_write(pmc, AT91_PMC_PCKR(prog->id),
 		  tmp | (shift << layout->pres_shift));
-- 
1.8.5.3
