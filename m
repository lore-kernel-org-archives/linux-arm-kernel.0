From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 2 Feb 2018 15:03:42 +0100
Subject: [PATCH 14/14] clk: stm32mp1: add Debug clocks
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1517580222-23301-15-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

RCC manages clock for debug and trace.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 0402a0e..eafc95a 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -352,6 +352,12 @@
 	{ 0 },
 };
 
+static const struct clk_div_table ck_trace_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -1566,6 +1572,17 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 		  _GATEMUXDIV(RCC_MCO2CFGR, 12,
 			      RCC_MCO2CFGR, 0, 3,
 			      RCC_MCO2CFGR, 4, 4)),
+
+	/* Debug clocks */
+	FIXED_FACTOR(NO_ID, "ck_axi_div2", "ck_axi", 0, 1, 2),
+
+	GATE(DBG, "ck_apb_dbg", "ck_axi_div2", 0, RCC_DBGCFGR, 8, 0),
+
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+
+	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
+		  _GATEDIV(RCC_DBGCFGR, 9,
+			   RCC_DBGCFGR, 0, 3, ck_trace_div_table)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
