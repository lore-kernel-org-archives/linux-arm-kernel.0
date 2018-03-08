From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Thu, 8 Mar 2018 17:54:00 +0100
Subject: [PATCH v2 07/12] clk: stm32mp1: add Sub System clocks
In-Reply-To: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1520528045-18330-8-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

The RCC handles three sub-system clocks: ck_mpuss, ck_axiss
and ck_mcuss.
This patch adds also some MUX system and several prescalers.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 3a99ad7..77d96d9 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -116,6 +116,42 @@
 	"ck_hsi", "ck_hse", "ck_csi"
 };
 
+static const char * const cpu_src[] = {
+	"ck_hsi", "ck_hse", "pll1_p"
+};
+
+static const char * const axi_src[] = {
+	"ck_hsi", "ck_hse", "pll2_p", "pll3_p"
+};
+
+static const char * const per_src[] = {
+	"ck_hsi", "ck_csi", "ck_hse"
+};
+
+static const char * const mcu_src[] = {
+	"ck_hsi", "ck_hse", "ck_csi", "pll3_p"
+};
+
+static const struct clk_div_table axi_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
+	{ 4, 4 }, { 5, 4 }, { 6, 4 }, { 7, 4 },
+	{ 0 },
+};
+
+static const struct clk_div_table mcu_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 32 }, { 6, 64 }, { 7, 128 },
+	{ 8, 512 }, { 9, 512 }, { 10, 512}, { 11, 512 },
+	{ 12, 512 }, { 13, 512 }, { 14, 512}, { 15, 512 },
+	{ 0 },
+};
+
+static const struct clk_div_table apb_div_table[] = {
+	{ 0, 1 }, { 1, 2 }, { 2, 4 }, { 3, 8 },
+	{ 4, 16 }, { 5, 16 }, { 6, 16 }, { 7, 16 },
+	{ 0 },
+};
+
 struct clock_config {
 	u32 id;
 	const char *name;
@@ -781,6 +817,21 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 	_STM32_DIV(_div_offset, _div_shift, _div_width,\
 		   _div_flags, _div_table, NULL)\
 
+#define _STM32_MUX(_offset, _shift, _width, _mux_flags, _ops)\
+	.mux = &(struct stm32_mux_cfg) {\
+		&(struct mux_cfg) {\
+			.reg_off	= _offset,\
+			.shift		= _shift,\
+			.width		= _width,\
+			.mux_flags	= _mux_flags,\
+			.table		= NULL,\
+		},\
+		.ops		= _ops,\
+	}
+
+#define _MUX(_offset, _shift, _width, _mux_flags)\
+	_STM32_MUX(_offset, _shift, _width, _mux_flags, NULL)\
+
 #define PARENT(_parent) ((const char *[]) { _parent})
 
 #define _NO_MUX .mux = NULL
@@ -882,6 +933,40 @@ struct clk_hw *_clk_register_pll(struct device *dev,
 		  _GATE(RCC_PLL4CR, 6, 0),
 		  _NO_MUX,
 		  _DIV(RCC_PLL4CFGR2, 16, 7, 0, NULL)),
+
+	/* MUX system clocks */
+	MUX(CK_PER, "ck_per", per_src, CLK_OPS_PARENT_ENABLE,
+	    RCC_CPERCKSELR, 0, 2, 0),
+
+	MUX(CK_MPU, "ck_mpu", cpu_src, CLK_OPS_PARENT_ENABLE |
+	     CLK_IS_CRITICAL, RCC_MPCKSELR, 0, 2, 0),
+
+	COMPOSITE(CK_AXI, "ck_axi", axi_src, CLK_IS_CRITICAL |
+		   CLK_OPS_PARENT_ENABLE,
+		   _NO_GATE,
+		   _MUX(RCC_ASSCKSELR, 0, 2, 0),
+		   _DIV(RCC_AXIDIVR, 0, 3, 0, axi_div_table)),
+
+	COMPOSITE(CK_MCU, "ck_mcu", mcu_src, CLK_IS_CRITICAL |
+		   CLK_OPS_PARENT_ENABLE,
+		   _NO_GATE,
+		   _MUX(RCC_MSSCKSELR, 0, 2, 0),
+		   _DIV(RCC_MCUDIVR, 0, 4, 0, mcu_div_table)),
+
+	DIV_TABLE(NO_ID, "pclk1", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB1DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk2", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB2DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk3", "ck_mcu", CLK_IGNORE_UNUSED, RCC_APB3DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk4", "ck_axi", CLK_IGNORE_UNUSED, RCC_APB4DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
+
+	DIV_TABLE(NO_ID, "pclk5", "ck_axi", CLK_IGNORE_UNUSED, RCC_APB5DIVR, 0,
+		  3, CLK_DIVIDER_READ_ONLY, apb_div_table),
 };
 
 struct stm32_clock_match_data {
-- 
1.9.1
