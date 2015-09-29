From: martink@posteo.de (Martin Kepplinger)
Date: Tue, 29 Sep 2015 13:32:27 +0200
Subject: [PATCH] clk: imx: use sign_extend32() and abs()
Message-ID: <1443526347-15501-1-git-send-email-martink@posteo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This simplifies the given function by getting rid of the manual
sign extension as well as saving an absolute value in an extra
variable.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---
built and run, but please review.

                     martin


 drivers/clk/imx/clk-pllv2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv2.c b/drivers/clk/imx/clk-pllv2.c
index 20889d5..b18f875 100644
--- a/drivers/clk/imx/clk-pllv2.c
+++ b/drivers/clk/imx/clk-pllv2.c
@@ -77,7 +77,7 @@ struct clk_pllv2 {
 static unsigned long __clk_pllv2_recalc_rate(unsigned long parent_rate,
 		u32 dp_ctl, u32 dp_op, u32 dp_mfd, u32 dp_mfn)
 {
-	long mfi, mfn, mfd, pdf, ref_clk, mfn_abs;
+	long mfi, mfn, mfd, pdf, ref_clk;
 	unsigned long dbl;
 	s64 temp;
 
@@ -87,19 +87,15 @@ static unsigned long __clk_pllv2_recalc_rate(unsigned long parent_rate,
 	mfi = (dp_op & MXC_PLL_DP_OP_MFI_MASK) >> MXC_PLL_DP_OP_MFI_OFFSET;
 	mfi = (mfi <= 5) ? 5 : mfi;
 	mfd = dp_mfd & MXC_PLL_DP_MFD_MASK;
-	mfn = mfn_abs = dp_mfn & MXC_PLL_DP_MFN_MASK;
-	/* Sign extend to 32-bits */
-	if (mfn >= 0x04000000) {
-		mfn |= 0xFC000000;
-		mfn_abs = -mfn;
-	}
+	mfn = dp_mfn & MXC_PLL_DP_MFN_MASK;
+	mfn = sign_extend32(mfn, 26);
 
 	ref_clk = 2 * parent_rate;
 	if (dbl != 0)
 		ref_clk *= 2;
 
 	ref_clk /= (pdf + 1);
-	temp = (u64) ref_clk * mfn_abs;
+	temp = (u64) ref_clk * abs(mfn);
 	do_div(temp, mfd + 1);
 	if (mfn < 0)
 		temp = -temp;
-- 
2.1.4
