From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 2 Feb 2018 15:03:40 +0100
Subject: [PATCH 12/14] clk: stm32mp1: add RTC clock
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1517580222-23301-13-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch adds the RTC clock.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 5a1142c..1cb06b0 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1179,6 +1179,15 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
 }
 
+#define _GATEMUX(_gate_offset,\
+		 _bit_idx,\
+		 _mux_offset, _mux_bit, _mux_width)\
+{\
+	_NO_DIV,\
+	_GATE(_gate_offset, _bit_idx, 0),\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define _MP1_GATE(_gate_offset, _bit_idx, _flags)\
 		  _GATE_OPS(_gate_offset, _bit_idx, _flags, &mp1_gate_clk_ops)
 
@@ -1526,6 +1535,14 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 		 RCC_APB4ENSETR, 0, 0),
 
 	MP1_GATE(GPU_K, "gpu_k", "pll2_q", 0, RCC_AHB6ENSETR, 5, 0),
+
+	/* RTC clock */
+	DIV(NO_ID, "ck_hse_rtc", "ck_hse", 0, RCC_RTCDIVR, 0, 7,
+	    CLK_DIVIDER_ALLOW_ZERO),
+
+	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_PARENT,
+		  _GATEMUX(RCC_BDCR, 20, RCC_BDCR, 16, 2)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
