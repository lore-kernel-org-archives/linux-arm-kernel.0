From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Mon,  5 Oct 2015 10:06:30 +0200
Subject: [PATCH v3 1/4] drivers: clk: st: Support for enable/disable in
 Clockgen PLLs
In-Reply-To: <1444032393-13433-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1444032393-13433-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1444032393-13433-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds support for enable/disable of the Clockgen PLLs.
clkgen_pll_enable/clkgen_pll_disable added as generic function for all PLLs.

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/clk/st/clkgen-pll.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index b2a332c..092f82c 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/iopoll.h>
 
 #include "clkgen.h"
 
@@ -43,6 +44,7 @@ static DEFINE_SPINLOCK(clkgena_c32_odf_lock);
 
 struct clkgen_pll_data {
 	struct clkgen_field pdn_status;
+	struct clkgen_field pdn_ctrl;
 	struct clkgen_field locked_status;
 	struct clkgen_field mdiv;
 	struct clkgen_field ndiv;
@@ -62,6 +64,7 @@ static const struct clk_ops st_pll1200c32_ops;
 
 static const struct clkgen_pll_data st_pll1600c65_ax = {
 	.pdn_status	= CLKGEN_FIELD(0x0, 0x1,			19),
+	.pdn_ctrl	= CLKGEN_FIELD(0x10,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x0, 0x1,			31),
 	.mdiv		= CLKGEN_FIELD(0x0, C65_MDIV_PLL1600_MASK,	0),
 	.ndiv		= CLKGEN_FIELD(0x0, C65_NDIV_MASK,		8),
@@ -70,6 +73,7 @@ static const struct clkgen_pll_data st_pll1600c65_ax = {
 
 static const struct clkgen_pll_data st_pll800c65_ax = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			19),
+	.pdn_ctrl	= CLKGEN_FIELD(0xC,	0x1,			1),
 	.locked_status	= CLKGEN_FIELD(0x0,	0x1,			31),
 	.mdiv		= CLKGEN_FIELD(0x0,	C65_MDIV_PLL800_MASK,	0),
 	.ndiv		= CLKGEN_FIELD(0x0,	C65_NDIV_MASK,		8),
@@ -79,6 +83,7 @@ static const struct clkgen_pll_data st_pll800c65_ax = {
 
 static const struct clkgen_pll_data st_pll3200c32_a1x_0 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			31),
+	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x4,	0x1,			31),
 	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		0x0),
 	.idf		= CLKGEN_FIELD(0x4,	C32_IDF_MASK,		0x0),
@@ -96,6 +101,7 @@ static const struct clkgen_pll_data st_pll3200c32_a1x_0 = {
 
 static const struct clkgen_pll_data st_pll3200c32_a1x_1 = {
 	.pdn_status	= CLKGEN_FIELD(0xC,	0x1,			31),
+	.pdn_ctrl	= CLKGEN_FIELD(0x18,	0x1,			1),
 	.locked_status	= CLKGEN_FIELD(0x10,	0x1,			31),
 	.ndiv		= CLKGEN_FIELD(0xC,	C32_NDIV_MASK,		0x0),
 	.idf		= CLKGEN_FIELD(0x10,	C32_IDF_MASK,		0x0),
@@ -114,6 +120,7 @@ static const struct clkgen_pll_data st_pll3200c32_a1x_1 = {
 /* 415 specific */
 static const struct clkgen_pll_data st_pll3200c32_a9_415 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x0,	C32_NDIV_MASK,		9),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		22),
@@ -125,6 +132,7 @@ static const struct clkgen_pll_data st_pll3200c32_a9_415 = {
 
 static const struct clkgen_pll_data st_pll3200c32_ddr_415 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x100,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -137,7 +145,8 @@ static const struct clkgen_pll_data st_pll3200c32_ddr_415 = {
 };
 
 static const struct clkgen_pll_data st_pll1200c32_gpu_415 = {
-	.pdn_status	= CLKGEN_FIELD(0x144,	0x1,			3),
+	.pdn_status	= CLKGEN_FIELD(0x4,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x4,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x168,	0x1,			0),
 	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
@@ -149,6 +158,7 @@ static const struct clkgen_pll_data st_pll1200c32_gpu_415 = {
 /* 416 specific */
 static const struct clkgen_pll_data st_pll3200c32_a9_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x6C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -160,6 +170,7 @@ static const struct clkgen_pll_data st_pll3200c32_a9_416 = {
 
 static const struct clkgen_pll_data st_pll3200c32_ddr_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x0,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x0,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x10C,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x8,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		25),
@@ -173,6 +184,7 @@ static const struct clkgen_pll_data st_pll3200c32_ddr_416 = {
 
 static const struct clkgen_pll_data st_pll1200c32_gpu_416 = {
 	.pdn_status	= CLKGEN_FIELD(0x8E4,	0x1,			3),
+	.pdn_ctrl	= CLKGEN_FIELD(0x8E4,	0x1,			3),
 	.locked_status	= CLKGEN_FIELD(0x90C,	0x1,			0),
 	.ldf		= CLKGEN_FIELD(0x0,	C32_LDF_MASK,		3),
 	.idf		= CLKGEN_FIELD(0x0,	C32_IDF_MASK,		0),
@@ -184,6 +196,7 @@ static const struct clkgen_pll_data st_pll1200c32_gpu_416 = {
 static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 	/* 407 A0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2a0,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2a4,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2a4,	C32_IDF_MASK,		0x0),
@@ -196,6 +209,7 @@ static const struct clkgen_pll_data st_pll3200c32_407_a0 = {
 static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
 	/* 407 C0 PLL0 */
 	.pdn_status	= CLKGEN_FIELD(0x2a0,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2a0,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2a0,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2a4,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2a4,	C32_IDF_MASK,		0x0),
@@ -208,6 +222,7 @@ static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
 static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
 	/* 407 C0 PLL1 */
 	.pdn_status	= CLKGEN_FIELD(0x2c8,	0x1,			8),
+	.pdn_ctrl	= CLKGEN_FIELD(0x2c8,	0x1,			8),
 	.locked_status	= CLKGEN_FIELD(0x2c8,	0x1,			24),
 	.ndiv		= CLKGEN_FIELD(0x2cc,	C32_NDIV_MASK,		16),
 	.idf		= CLKGEN_FIELD(0x2cc,	C32_IDF_MASK,		0x0),
@@ -220,6 +235,7 @@ static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
 static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
 	/* 407 A9 */
 	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
+	.pdn_ctrl	= CLKGEN_FIELD(0x1a8,	0x1,			0),
 	.locked_status	= CLKGEN_FIELD(0x87c,	0x1,			0),
 	.ndiv		= CLKGEN_FIELD(0x1b0,	C32_NDIV_MASK,		0),
 	.idf		= CLKGEN_FIELD(0x1a8,	C32_IDF_MASK,		25),
@@ -271,6 +287,40 @@ static int clkgen_pll_is_enabled(struct clk_hw *hw)
 	return !poweroff;
 }
 
+static int clkgen_pll_enable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+	void __iomem *base =  pll->regs_base;
+	struct clkgen_field *field = &pll->data->locked_status;
+	int ret = 0;
+	u32 reg;
+
+	if (clkgen_pll_is_enabled(hw))
+		return 0;
+
+	CLKGEN_WRITE(pll, pdn_ctrl, 0);
+
+	ret = readl_relaxed_poll_timeout(base + field->offset, reg,
+			!!((reg >> field->shift) & field->mask),  0, 10000);
+
+	if (!ret)
+		pr_debug("%s:%s enabled\n", __clk_get_name(hw->clk), __func__);
+
+	return ret;
+}
+
+static void clkgen_pll_disable(struct clk_hw *hw)
+{
+	struct clkgen_pll *pll = to_clkgen_pll(hw);
+
+	if (!clkgen_pll_is_enabled(hw))
+		return;
+
+	CLKGEN_WRITE(pll, pdn_ctrl, 1);
+
+	pr_debug("%s:%s disabled\n", __clk_get_name(hw->clk), __func__);
+}
+
 static unsigned long recalc_stm_pll800c65(struct clk_hw *hw,
 		unsigned long parent_rate)
 {
@@ -372,21 +422,29 @@ static unsigned long recalc_stm_pll1200c32(struct clk_hw *hw,
 }
 
 static const struct clk_ops st_pll1600c65_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll1600c65,
 };
 
 static const struct clk_ops st_pll800c65_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll800c65,
 };
 
 static const struct clk_ops stm_pll3200c32_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll3200c32,
 };
 
 static const struct clk_ops st_pll1200c32_ops = {
+	.enable		= clkgen_pll_enable,
+	.disable	= clkgen_pll_disable,
 	.is_enabled	= clkgen_pll_is_enabled,
 	.recalc_rate	= recalc_stm_pll1200c32,
 };
-- 
1.9.1
