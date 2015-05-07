From: b20788@freescale.com (Anson Huang)
Date: Fri, 8 May 2015 00:14:24 +0800
Subject: [PATCH V3] ARM: imx: correct Audio/Video PLL rate calculation formula
Message-ID: <1431015264-8320-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The audio/video PLL's rate calculation formula is as below in RM:

Fref * (DIV_SELECT + NUM / DENOM),

in original clk-pllv3's code, below code is used:

(parent_rate * div) + ((parent_rate / mfd) * mfn)

as it does NOT consider the float data using div, so below
calculation formula should be used as a decent method:

(parent_rate * div) + ((parent_rate * mfn) / mfd)

and we also need to consider parent_rate * mfd may exceed
a 32 bit value, 64 bit value should be used.

Below is one example of old/new formula's difference:

On i.MX7D, DRAM PLL is a Audio/Video type PLL, the target freq
is 1066MHz, the register settings are as below:

PLL_DDRn: 8060202C   -> div = 0x2C
DDR_NUM: 06AAAC4D    -> mfn = 0x6AAAC4D
DDR_DENOM: 100003EC  -> mfd = 0x100003EC

parent_rate = 24MHz.

with old formula, the (parent_rate / mfd) * mfn = 0, with new formula,
the (parent_rate * mfn) / mfd = 10MHz, so old formula gets
PLL_DDR = 1056MHz, while the updated formuls gets PLL_DDR = 1066MHz
which exactly matches the real rate.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
changes since V2:
	improve commit message;
	replace s64 with u64 to match do_div.
 drivers/clk/imx/clk-pllv3.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 641ebc5..e34a925 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -203,8 +203,13 @@ static unsigned long clk_pllv3_av_recalc_rate(struct clk_hw *hw,
 	u32 mfn = readl_relaxed(pll->base + PLL_NUM_OFFSET);
 	u32 mfd = readl_relaxed(pll->base + PLL_DENOM_OFFSET);
 	u32 div = readl_relaxed(pll->base) & pll->div_mask;
+	u64 temp64 = parent_rate;
+
+	temp64 *= mfn;
+	do_div(temp64, mfd);
+
+	return (parent_rate * div) + temp64;
 
-	return (parent_rate * div) + ((parent_rate / mfd) * mfn);
 }
 
 static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
-- 
1.9.1
