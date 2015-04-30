From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 30 Apr 2015 09:53:42 +0800
Subject: [PATCH RESEND 3/3] clk: mmp: add timer clock for pxa168/mmp2/pxa910
In-Reply-To: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
References: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1430358822-4699-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

Timer has external fast clock, and it is a mux clock.
Add the timer clock type for timer driver.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-of-mmp2.c              |  6 ++++++
 drivers/clk/mmp/clk-of-pxa168.c            |  7 +++++++
 drivers/clk/mmp/clk-of-pxa910.c            | 11 +++++++++++
 include/dt-bindings/clock/marvell,mmp2.h   |  1 +
 include/dt-bindings/clock/marvell,pxa168.h |  2 ++
 include/dt-bindings/clock/marvell,pxa910.h |  3 +++
 6 files changed, 30 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index b7e0b89..251533d 100644
--- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -30,6 +30,7 @@
 #define APBC_TWSI4	0x7c
 #define APBC_TWSI5	0x80
 #define APBC_KPC	0x18
+#define APBC_TIMER	0x24
 #define APBC_UART0	0x2c
 #define APBC_UART1	0x30
 #define APBC_UART2	0x34
@@ -132,6 +133,9 @@ static DEFINE_SPINLOCK(ssp2_lock);
 static DEFINE_SPINLOCK(ssp3_lock);
 static const char *ssp_parent_names[] = {"vctcxo_4", "vctcxo_2", "vctcxo", "pll1_16"};
 
+static DEFINE_SPINLOCK(timer_lock);
+static const char *timer_parent_names[] = {"clk32", "vctcxo_2", "vctcxo_4", "vctcxo"};
+
 static DEFINE_SPINLOCK(reset_lock);
 
 static struct mmp_param_mux_clk apbc_mux_clks[] = {
@@ -143,6 +147,7 @@ static struct mmp_param_mux_clk apbc_mux_clks[] = {
 	{0, "ssp1_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP1, 4, 3, 0, &ssp1_lock},
 	{0, "ssp2_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP2, 4, 3, 0, &ssp2_lock},
 	{0, "ssp3_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP3, 4, 3, 0, &ssp3_lock},
+	{0, "timer_mux", timer_parent_names, ARRAY_SIZE(timer_parent_names), CLK_SET_RATE_PARENT, APBC_TIMER, 4, 3, 0, &timer_lock},
 };
 
 static struct mmp_param_gate_clk apbc_gate_clks[] = {
@@ -168,6 +173,7 @@ static struct mmp_param_gate_clk apbc_gate_clks[] = {
 	{MMP2_CLK_SSP1, "ssp1_clk", "ssp1_mux", CLK_SET_RATE_PARENT, APBC_SSP1, 0x7, 0x3, 0x0, 0, &ssp1_lock},
 	{MMP2_CLK_SSP2, "ssp2_clk", "ssp2_mux", CLK_SET_RATE_PARENT, APBC_SSP2, 0x7, 0x3, 0x0, 0, &ssp2_lock},
 	{MMP2_CLK_SSP3, "ssp3_clk", "ssp3_mux", CLK_SET_RATE_PARENT, APBC_SSP3, 0x7, 0x3, 0x0, 0, &ssp3_lock},
+	{MMP2_CLK_TIMER, "timer_clk", "timer_mux", CLK_SET_RATE_PARENT, APBC_TIMER, 0x7, 0x3, 0x0, 0, &timer_lock},
 };
 
 static void mmp2_apb_periph_clk_init(struct mmp2_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index 01a650e..64eaf41 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -32,6 +32,7 @@
 #define APBC_PWM1	0x10
 #define APBC_PWM2	0x14
 #define APBC_PWM3	0x18
+#define APBC_TIMER	0x34
 #define APBC_SSP0	0x81c
 #define APBC_SSP1	0x820
 #define APBC_SSP2	0x84c
@@ -71,6 +72,7 @@ static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
 	{PXA168_CLK_PLL1_24, "pll1_24", "pll1_12", 1, 2, 0},
 	{PXA168_CLK_PLL1_48, "pll1_48", "pll1_24", 1, 2, 0},
 	{PXA168_CLK_PLL1_96, "pll1_96", "pll1_48", 1, 2, 0},
+	{PXA168_CLK_PLL1_192, "pll1_192", "pll1_96", 1, 2, 0},
 	{PXA168_CLK_PLL1_13, "pll1_13", "pll1", 1, 13, 0},
 	{PXA168_CLK_PLL1_13_1_5, "pll1_13_1_5", "pll1_13", 2, 3, 0},
 	{PXA168_CLK_PLL1_2_1_5, "pll1_2_1_5", "pll1_2", 2, 3, 0},
@@ -120,6 +122,9 @@ static DEFINE_SPINLOCK(ssp3_lock);
 static DEFINE_SPINLOCK(ssp4_lock);
 static const char *ssp_parent_names[] = {"pll1_96", "pll1_48", "pll1_24", "pll1_12"};
 
+static DEFINE_SPINLOCK(timer_lock);
+static const char *timer_parent_names[] = {"pll1_48", "clk32", "pll1_96", "pll1_192"};
+
 static DEFINE_SPINLOCK(reset_lock);
 
 static struct mmp_param_mux_clk apbc_mux_clks[] = {
@@ -131,6 +136,7 @@ static struct mmp_param_mux_clk apbc_mux_clks[] = {
 	{0, "ssp2_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP2, 4, 3, 0, &ssp2_lock},
 	{0, "ssp3_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP3, 4, 3, 0, &ssp3_lock},
 	{0, "ssp4_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP4, 4, 3, 0, &ssp4_lock},
+	{0, "timer_mux", timer_parent_names, ARRAY_SIZE(timer_parent_names), CLK_SET_RATE_PARENT, APBC_TIMER, 4, 3, 0, &timer_lock},
 };
 
 static struct mmp_param_gate_clk apbc_gate_clks[] = {
@@ -152,6 +158,7 @@ static struct mmp_param_gate_clk apbc_gate_clks[] = {
 	{PXA168_CLK_SSP2, "ssp2_clk", "ssp2_mux", CLK_SET_RATE_PARENT, APBC_SSP2, 0x3, 0x3, 0x0, 0, &ssp2_lock},
 	{PXA168_CLK_SSP3, "ssp3_clk", "ssp3_mux", CLK_SET_RATE_PARENT, APBC_SSP3, 0x3, 0x3, 0x0, 0, &ssp3_lock},
 	{PXA168_CLK_SSP4, "ssp4_clk", "ssp4_mux", CLK_SET_RATE_PARENT, APBC_SSP4, 0x3, 0x3, 0x0, 0, &ssp4_lock},
+	{PXA168_CLK_TIMER, "timer_clk", "timer_mux", CLK_SET_RATE_PARENT, APBC_TIMER, 0x3, 0x3, 0x0, 0, &timer_lock},
 };
 
 static void pxa168_apb_periph_clk_init(struct pxa168_clk_unit *pxa_unit)
diff --git a/drivers/clk/mmp/clk-of-pxa910.c b/drivers/clk/mmp/clk-of-pxa910.c
index cca98ef..13d6173 100644
--- a/drivers/clk/mmp/clk-of-pxa910.c
+++ b/drivers/clk/mmp/clk-of-pxa910.c
@@ -35,6 +35,8 @@
 #define APBC_SSP0	0x1c
 #define APBC_SSP1	0x20
 #define APBC_SSP2	0x4c
+#define APBC_TIMER0	0x30
+#define APBC_TIMER1	0x44
 #define APBCP_TWSI1	0x28
 #define APBCP_UART2	0x1c
 #define APMU_SDH0	0x54
@@ -70,6 +72,7 @@ static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
 	{PXA910_CLK_PLL1_24, "pll1_24", "pll1_12", 1, 2, 0},
 	{PXA910_CLK_PLL1_48, "pll1_48", "pll1_24", 1, 2, 0},
 	{PXA910_CLK_PLL1_96, "pll1_96", "pll1_48", 1, 2, 0},
+	{PXA910_CLK_PLL1_192, "pll1_192", "pll1_96", 1, 2, 0},
 	{PXA910_CLK_PLL1_13, "pll1_13", "pll1", 1, 13, 0},
 	{PXA910_CLK_PLL1_13_1_5, "pll1_13_1_5", "pll1_13", 2, 3, 0},
 	{PXA910_CLK_PLL1_2_1_5, "pll1_2_1_5", "pll1_2", 2, 3, 0},
@@ -116,6 +119,10 @@ static DEFINE_SPINLOCK(ssp0_lock);
 static DEFINE_SPINLOCK(ssp1_lock);
 static const char *ssp_parent_names[] = {"pll1_96", "pll1_48", "pll1_24", "pll1_12"};
 
+static DEFINE_SPINLOCK(timer0_lock);
+static DEFINE_SPINLOCK(timer1_lock);
+static const char *timer_parent_names[] = {"pll1_48", "clk32", "pll1_96"};
+
 static DEFINE_SPINLOCK(reset_lock);
 
 static struct mmp_param_mux_clk apbc_mux_clks[] = {
@@ -123,6 +130,8 @@ static struct mmp_param_mux_clk apbc_mux_clks[] = {
 	{0, "uart1_mux", uart_parent_names, ARRAY_SIZE(uart_parent_names), CLK_SET_RATE_PARENT, APBC_UART1, 4, 3, 0, &uart1_lock},
 	{0, "ssp0_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP0, 4, 3, 0, &ssp0_lock},
 	{0, "ssp1_mux", ssp_parent_names, ARRAY_SIZE(ssp_parent_names), CLK_SET_RATE_PARENT, APBC_SSP1, 4, 3, 0, &ssp1_lock},
+	{0, "timer0_mux", timer_parent_names, ARRAY_SIZE(timer_parent_names), CLK_SET_RATE_PARENT, APBC_TIMER0, 4, 3, 0, &timer0_lock},
+	{0, "timer1_mux", timer_parent_names, ARRAY_SIZE(timer_parent_names), CLK_SET_RATE_PARENT, APBC_TIMER1, 4, 3, 0, &timer1_lock},
 };
 
 static struct mmp_param_mux_clk apbcp_mux_clks[] = {
@@ -143,6 +152,8 @@ static struct mmp_param_gate_clk apbc_gate_clks[] = {
 	{PXA910_CLK_UART1, "uart1_clk", "uart1_mux", CLK_SET_RATE_PARENT, APBC_UART1, 0x3, 0x3, 0x0, 0, &uart1_lock},
 	{PXA910_CLK_SSP0, "ssp0_clk", "ssp0_mux", CLK_SET_RATE_PARENT, APBC_SSP0, 0x3, 0x3, 0x0, 0, &ssp0_lock},
 	{PXA910_CLK_SSP1, "ssp1_clk", "ssp1_mux", CLK_SET_RATE_PARENT, APBC_SSP1, 0x3, 0x3, 0x0, 0, &ssp1_lock},
+	{PXA910_CLK_TIMER0, "timer0_clk", "timer0_mux", CLK_SET_RATE_PARENT, APBC_TIMER0, 0x3, 0x3, 0x0, 0, &timer0_lock},
+	{PXA910_CLK_TIMER1, "timer1_clk", "timer1_mux", CLK_SET_RATE_PARENT, APBC_TIMER1, 0x3, 0x3, 0x0, 0, &timer1_lock},
 };
 
 static struct mmp_param_gate_clk apbcp_gate_clks[] = {
diff --git a/include/dt-bindings/clock/marvell,mmp2.h b/include/dt-bindings/clock/marvell,mmp2.h
index 591f7fb..7a51038 100644
--- a/include/dt-bindings/clock/marvell,mmp2.h
+++ b/include/dt-bindings/clock/marvell,mmp2.h
@@ -48,6 +48,7 @@
 #define MMP2_CLK_SSP1			78
 #define MMP2_CLK_SSP2			79
 #define MMP2_CLK_SSP3			80
+#define MMP2_CLK_TIMER			81
 
 /* axi periphrals */
 #define MMP2_CLK_SDH0			101
diff --git a/include/dt-bindings/clock/marvell,pxa168.h b/include/dt-bindings/clock/marvell,pxa168.h
index 84ce5de..3e45bdf 100644
--- a/include/dt-bindings/clock/marvell,pxa168.h
+++ b/include/dt-bindings/clock/marvell,pxa168.h
@@ -18,6 +18,7 @@
 #define PXA168_CLK_PLL1_13_1_5		18
 #define PXA168_CLK_PLL1_2_1_5		19
 #define PXA168_CLK_PLL1_3_16		20
+#define PXA168_CLK_PLL1_192		21
 #define PXA168_CLK_UART_PLL		27
 #define PXA168_CLK_USB_PLL		28
 
@@ -41,6 +42,7 @@
 #define PXA168_CLK_SSP2			76
 #define PXA168_CLK_SSP3			77
 #define PXA168_CLK_SSP4			78
+#define PXA168_CLK_TIMER		79
 
 /* axi periphrals */
 #define PXA168_CLK_DFC			100
diff --git a/include/dt-bindings/clock/marvell,pxa910.h b/include/dt-bindings/clock/marvell,pxa910.h
index bea08b6..135082a 100644
--- a/include/dt-bindings/clock/marvell,pxa910.h
+++ b/include/dt-bindings/clock/marvell,pxa910.h
@@ -18,6 +18,7 @@
 #define PXA910_CLK_PLL1_13_1_5		18
 #define PXA910_CLK_PLL1_2_1_5		19
 #define PXA910_CLK_PLL1_3_16		20
+#define PXA910_CLK_PLL1_192		21
 #define PXA910_CLK_UART_PLL		27
 #define PXA910_CLK_USB_PLL		28
 
@@ -38,6 +39,8 @@
 #define PXA910_CLK_UART2		73
 #define PXA910_CLK_SSP0			74
 #define PXA910_CLK_SSP1			75
+#define PXA910_CLK_TIMER0		76
+#define PXA910_CLK_TIMER1		77
 
 /* axi periphrals */
 #define PXA910_CLK_DFC			100
-- 
1.8.3.2
