From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 2 Feb 2018 15:03:41 +0100
Subject: [PATCH 13/14] clk: stm32mp1: add MCO clocks
In-Reply-To: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
References: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1517580222-23301-14-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Two micro-controller clock output (MCO) pins are available: MCO1 and MCO2.
For each output, it is possible to select a clock source.
The selected clock can be divided thanks to configurable prescaler.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 1cb06b0..0402a0e 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1188,6 +1188,16 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
 }
 
+#define _GATEMUXDIV(_gate_offset, _bit_idx,\
+		    _mux_offset, _mux_bit, _mux_width,\
+		    _div_offset, _div_bit, _div_width\
+		)\
+{\
+	_DIV(_div_offset, _div_bit, _div_width, 0),\
+	_GATE(_gate_offset, _bit_idx, 0),\
+	_MUX(_mux_offset, _mux_bit, _mux_width, 0),\
+}
+
 #define _MP1_GATE(_gate_offset, _bit_idx, _flags)\
 		  _GATE_OPS(_gate_offset, _bit_idx, _flags, &mp1_gate_clk_ops)
 
@@ -1543,6 +1553,19 @@ static struct clk_hw *_clk_register_cktim(struct device *dev,
 	COMPOSITE(RTC, "ck_rtc", rtc_src, CLK_OPS_PARENT_ENABLE |
 		  CLK_SET_RATE_PARENT,
 		  _GATEMUX(RCC_BDCR, 20, RCC_BDCR, 16, 2)),
+
+	/* MCO clocks */
+	COMPOSITE(CK_MCO1, "ck_mco1", mco1_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATEMUXDIV(RCC_MCO1CFGR, 12,
+			      RCC_MCO1CFGR, 0, 3,
+			      RCC_MCO1CFGR, 4, 4)),
+
+	COMPOSITE(CK_MCO2, "ck_mco2", mco2_src, CLK_OPS_PARENT_ENABLE |
+		  CLK_SET_RATE_NO_REPARENT,
+		  _GATEMUXDIV(RCC_MCO2CFGR, 12,
+			      RCC_MCO2CFGR, 0, 3,
+			      RCC_MCO2CFGR, 4, 4)),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
