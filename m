From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue, 12 Oct 2010 09:31:24 +0200
Subject: [PATCH 1/2] clock-mx51: factorize clk_set_parent and clk_get_rate
In-Reply-To: <20101011170405.GC476@pengutronix.de>
References: <20101011170405.GC476@pengutronix.de>
Message-ID: <1286868685-7825-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx5/clock-mx51.c |  142 ++++++++++++++--------------------------
 1 files changed, 48 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
index 21cecc0..7deb683 100644
--- a/arch/arm/mach-mx5/clock-mx51.c
+++ b/arch/arm/mach-mx5/clock-mx51.c
@@ -544,35 +544,6 @@ static int _clk_ipg_per_set_parent(struct clk *clk, struct clk *parent)
 	return 0;
 }
 
-static unsigned long clk_uart_get_rate(struct clk *clk)
-{
-	u32 reg, prediv, podf;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	reg = __raw_readl(MXC_CCM_CSCDR1);
-	prediv = ((reg & MXC_CCM_CSCDR1_UART_CLK_PRED_MASK) >>
-		  MXC_CCM_CSCDR1_UART_CLK_PRED_OFFSET) + 1;
-	podf = ((reg & MXC_CCM_CSCDR1_UART_CLK_PODF_MASK) >>
-		MXC_CCM_CSCDR1_UART_CLK_PODF_OFFSET) + 1;
-
-	return parent_rate / (prediv * podf);
-}
-
-static int _clk_uart_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 reg, mux;
-
-	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
-		       &lp_apm_clk);
-	reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_UART_CLK_SEL_MASK;
-	reg |= mux << MXC_CCM_CSCMR1_UART_CLK_SEL_OFFSET;
-	__raw_writel(reg, MXC_CCM_CSCMR1);
-
-	return 0;
-}
-
 #define clk_nfc_set_parent	NULL
 
 static unsigned long clk_nfc_get_rate(struct clk *clk)
@@ -631,35 +602,6 @@ static int clk_nfc_set_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-static unsigned long clk_usboh3_get_rate(struct clk *clk)
-{
-	u32 reg, prediv, podf;
-	unsigned long parent_rate;
-
-	parent_rate = clk_get_rate(clk->parent);
-
-	reg = __raw_readl(MXC_CCM_CSCDR1);
-	prediv = ((reg & MXC_CCM_CSCDR1_USBOH3_CLK_PRED_MASK) >>
-		  MXC_CCM_CSCDR1_USBOH3_CLK_PRED_OFFSET) + 1;
-	podf = ((reg & MXC_CCM_CSCDR1_USBOH3_CLK_PODF_MASK) >>
-		MXC_CCM_CSCDR1_USBOH3_CLK_PODF_OFFSET) + 1;
-
-	return parent_rate / (prediv * podf);
-}
-
-static int _clk_usboh3_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 reg, mux;
-
-	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
-		       &lp_apm_clk);
-	reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_USBOH3_CLK_SEL_MASK;
-	reg |= mux << MXC_CCM_CSCMR1_USBOH3_CLK_SEL_OFFSET;
-	__raw_writel(reg, MXC_CCM_CSCMR1);
-
-	return 0;
-}
-
 static unsigned long get_high_reference_clock_rate(struct clk *clk)
 {
 	return external_high_reference;
@@ -786,18 +728,6 @@ static struct clk ipg_perclk = {
 	.set_parent = _clk_ipg_per_set_parent,
 };
 
-static struct clk uart_root_clk = {
-	.parent = &pll2_sw_clk,
-	.get_rate = clk_uart_get_rate,
-	.set_parent = _clk_uart_set_parent,
-};
-
-static struct clk usboh3_clk = {
-	.parent = &pll2_sw_clk,
-	.get_rate = clk_usboh3_get_rate,
-	.set_parent = _clk_usboh3_set_parent,
-};
-
 static struct clk ahb_max_clk = {
 	.parent = &ahb_clk,
 	.enable_reg = MXC_CCM_CCGR0,
@@ -857,35 +787,59 @@ static struct clk emi_slow_clk = {
 		.secondary	= s,			\
 	}
 
-/* eCSPI */
-static unsigned long clk_ecspi_get_rate(struct clk *clk)
-{
-	u32 reg, pred, podf;
-
-	reg = __raw_readl(MXC_CCM_CSCDR2);
-
-	pred = (reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
-			MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET;
-	podf = (reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
-			MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET;
-
-	return DIV_ROUND_CLOSEST(clk_get_rate(clk->parent),
-			(pred + 1) * (podf + 1));
+#define CLK_GET_RATE(name, nr, bitsname)				\
+static unsigned long clk_##name##_get_rate(struct clk *clk)		\
+{									\
+	u32 reg, pred, podf;						\
+									\
+	reg = __raw_readl(MXC_CCM_CSCDR##nr);				\
+	pred = (reg & MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_MASK)	\
+		>> MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PRED_OFFSET;	\
+	podf = (reg & MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_MASK)	\
+		>> MXC_CCM_CSCDR##nr##_##bitsname##_CLK_PODF_OFFSET;	\
+									\
+	return DIV_ROUND_CLOSEST(clk_get_rate(clk->parent),		\
+			(pred + 1) * (podf + 1));			\
+}
+
+#define CLK_SET_PARENT(name, nr, bitsname)				\
+static int clk_##name##_set_parent(struct clk *clk, struct clk *parent)	\
+{									\
+	u32 reg, mux;							\
+									\
+	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk,		\
+			&pll3_sw_clk, &lp_apm_clk);			\
+	reg = __raw_readl(MXC_CCM_CSCMR##nr) &				\
+		~MXC_CCM_CSCMR##nr##_##bitsname##_CLK_SEL_MASK;		\
+	reg |= mux << MXC_CCM_CSCMR##nr##_##bitsname##_CLK_SEL_OFFSET;	\
+	__raw_writel(reg, MXC_CCM_CSCMR##nr);				\
+									\
+	return 0;							\
 }
 
-static int clk_ecspi_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 reg, mux;
+/* UART */
+CLK_GET_RATE(uart, 1, UART)
+CLK_SET_PARENT(uart, 1, UART)
 
-	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
-			&lp_apm_clk);
+static struct clk uart_root_clk = {
+	.parent = &pll2_sw_clk,
+	.get_rate = clk_uart_get_rate,
+	.set_parent = clk_uart_set_parent,
+};
 
-	reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_MASK;
-	reg |= mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
-	__raw_writel(reg, MXC_CCM_CSCMR1);
+/* USBOH3 */
+CLK_GET_RATE(usboh3, 1, USBOH3)
+CLK_SET_PARENT(usboh3, 1, USBOH3)
 
-	return 0;
-}
+static struct clk usboh3_clk = {
+	.parent = &pll2_sw_clk,
+	.get_rate = clk_usboh3_get_rate,
+	.set_parent = clk_usboh3_set_parent,
+};
+
+/* eCSPI */
+CLK_GET_RATE(ecspi, 2, CSPI)
+CLK_SET_PARENT(ecspi, 1, CSPI)
 
 static struct clk ecspi_main_clk = {
 	.parent = &pll3_sw_clk,
-- 
1.7.0.4
