From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 11 Apr 2018 17:03:29 +0300
Subject: [PATCH v2] clk: imx: Set CLK_SET_RATE_GATE for gate and divider clocks
In-Reply-To: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <1523455409-7771-1-git-send-email-abel.vesa@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawnguo@kernel.org>

Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
client drivers usually make clk_set_rate() call, so that the call will fail
when clock is still on instead of standing the risk of running into glitch
issue. Rate cannot be changed when the clock is enabled due to the glitchy
multiplexers.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
[initial patch from imx internal repo]
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
[carried over from 3.14 and also applied the flag to newer functions]
---

Changes since v1:
 - changed ownership as per initial patch

 drivers/clk/imx/clk.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8076ec0..753ebc4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -96,7 +96,8 @@ static inline struct clk *imx_clk_fixed_factor(const char *name,
 static inline struct clk *imx_clk_divider(const char *name, const char *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
+	return clk_register_divider(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
 
@@ -140,7 +141,8 @@ static inline struct clk *imx_clk_gate_dis(const char *name, const char *parent,
 static inline struct clk *imx_clk_gate2(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
@@ -155,7 +157,8 @@ static inline struct clk *imx_clk_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_register_gate2(NULL, name, parent,
+			CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE, reg,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
@@ -164,8 +167,8 @@ static inline struct clk *imx_clk_gate2_shared2(const char *name,
 		unsigned int *share_count)
 {
 	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
-				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
-				  &imx_ccm_lock, share_count);
+			CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
 
 static inline struct clk *imx_clk_gate2_cgr(const char *name,
@@ -187,7 +190,7 @@ static inline struct clk *imx_clk_gate4(const char *name, const char *parent,
 		void __iomem *reg, u8 shift)
 {
 	return clk_register_gate2(NULL, name, parent,
-			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
 
-- 
2.7.4
