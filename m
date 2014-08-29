From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 29 Aug 2014 12:49:26 -0700
Subject: [PATCH] clk: qcom: Fix sdc 144kHz frequency entry
Message-ID: <1409341766-24366-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pre-divider for the sdc clocks only has 2 bits in it, so we
can't possibly divide by anything larger than 4 here.
Furthermore, we program the value of ~(n - m) and the n value is
larger than 8 bits (max of 256). Replace this entry with 200kHz
which is close enough to 144kHz to be usable.

Cc: Kumar Gala <galak@codeaurora.org>
Cc: Andy Gross <agross@codeaurora.org>
Fixes: 24d8fba44af3 "clk: qcom: Add support for IPQ8064's global clock controller (GCC)"
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/gcc-ipq806x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 4032e510d9aa..3b83b7dd78c7 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -1095,7 +1095,7 @@ static struct clk_branch prng_clk = {
 };
 
 static const struct freq_tbl clk_tbl_sdc[] = {
-	{    144000, P_PXO,   5, 18,625 },
+	{    200000, P_PXO,   2, 2, 125 },
 	{    400000, P_PLL8,  4, 1, 240 },
 	{  16000000, P_PLL8,  4, 1,   6 },
 	{  17070000, P_PLL8,  1, 2,  45 },
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
