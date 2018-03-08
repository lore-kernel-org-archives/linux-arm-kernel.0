From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 8 Mar 2018 17:54:03 +0100
Subject: [PATCH v2 10/12] clk: stm32mp1: add RTC clock
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1520528045-18330-11-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the RTC clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index b5379a2..51e3e76 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -248,6 +248,10 @@
 	"ck_dsi_phy", "pll4_p"
 };
 
+static const char * const rtc_src[] = {
+	"off", "ck_lse", "ck_lsi", "ck_hse_rtc"
+};
+
 static const struct clk_div_table axi_div_table[] = {
 	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
 	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
@@ -1945,6 +1949,17 @@ enum {
 		  _NO_GATE,
 		  _MMUX(M_ETHCK),
 		  _DIV(RCC_ETHCKSELR, 4, 4, CLK_DIVIDER_ALLOW_ZERO, NULL)),
+
+	/* RTC clock */
+	DIV(NO_ID, "ck_hse_rtc", "ck_hse", 0, RCC_RTCDIVR, 0, 7,
+	    CLK_DIVIDER_ALLOW_ZERO),
+
+	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
+		   CLK_SET_RATE_PARENT,
+		  _GATE(RCC_BDCR, 20, 0),
+		  _MUX(RCC_BDCR, 16, 2, 0),
+		  _NO_DIV),
+
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
