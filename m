From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 8 Mar 2018 17:54:05 +0100
Subject: [PATCH v2 12/12] clk: stm32mp1: add Debug clocks
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1520528045-18330-13-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

RCC manages clock for debug and trace.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index b3a6ec4..f1d5967 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -260,6 +260,10 @@
 	"ck_mpu", "ck_axi", "ck_mcu", "pll4_p", "ck_hse", "ck_hsi"
 };
 
+static const char * const ck_trace_src[] = {
+	"ck_axi"
+};
+
 static const struct clk_div_table axi_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
@@ -280,6 +284,12 @@
 	{ 0 },
 };
 
+static const struct clk_div_table ck_trace_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 #define MAX_MUX_CLK 2
 
 struct stm32_mmux {
@@ -1980,6 +1990,18 @@ enum {
 		  _GATE(RCC_MCO2CFGR, 12, 0),
 		  _MUX(RCC_MCO2CFGR, 0, 3, 0),
 		  _DIV(RCC_MCO2CFGR, 4, 4, 0, NULL)),
+
+	/* Debug clocks */
+	FIXED_FACTOR(NO_ID, "ck_axi_div2", "ck_axi", 0, 1, 2),
+
+	GATE(DBG, "ck_apb_dbg", "ck_axi_div2", 0, RCC_DBGCFGR, 8, 0),
+
+	GATE(CK_DBG, "ck_sys_dbg", "ck_axi", 0, RCC_DBGCFGR, 8, 0),
+
+	COMPOSITE(CK_TRACE, "ck_trace", ck_trace_src, CLK_OPS_PARENT_ENABLE,
+		  _GATE(RCC_DBGCFGR, 9, 0),
+		  _NO_MUX,
+		  _DIV(RCC_DBGCFGR, 0, 3, 0, ck_trace_div_table)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
