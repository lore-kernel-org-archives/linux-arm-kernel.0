From: b20788@freescale.com (Anson Huang)
Date: Thu, 11 Sep 2014 11:29:42 +0800
Subject: [PATCH V3 3/3] ARM: imx: source gpt per clk from OSC for system timer
In-Reply-To: <1410406182-21113-1-git-send-email-b20788@freescale.com>
References: <1410406182-21113-1-git-send-email-b20788@freescale.com>
Message-ID: <1410406182-21113-4-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6Q TO > 1.0, i.MX6DL and i.MX6SX, gpt per clock
can be from OSC instead of ipg_per, as ipg_per's rate
may be scaled when system enter low bus mode, to keep
system timer NOT drift, better to make gpt per clock
at fixed rate, here add support for gpt per clock to
be from OSC which is at fixed rate always.

There are some difference on this implementation of
gpt per clock source, see below for details:

i.MX6Q TO > 1.0: GPT_CR_CLKSRC, b'101 selects fix clock
    of OSC / 8 for gpt per clk;
i.MX6DL and i.MX6SX: GPT_CR_CLKSRC, b'101 selects OSC
    for gpt per clk, and we must enable GPT_CR_24MEM to
    enable OSC clk source for gpt per, GPT_PR_PRESCALER24M
    is for pre-scaling of this OSC clk, here set it to 8
    to make gpt per clk is 3MHz;
i.MX6SL: ipg_per can be from OSC directly, so no need to
    implement this new clk source for gpt per.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
change log from v2->v3:
	1.remove unnecessary definition V2_TCTL_CLK_OSC and
	  variable tprer_val;
	2.optimize the logic of different gpt clk select.

 arch/arm/mach-imx/time.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index bf92e5a..15d18e1 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -60,17 +60,22 @@
 #define MX2_TSTAT_CAPT		(1 << 1)
 #define MX2_TSTAT_COMP		(1 << 0)
 
-/* MX31, MX35, MX25, MX5 */
+/* MX31, MX35, MX25, MX5, MX6 */
 #define V2_TCTL_WAITEN		(1 << 3) /* Wait enable mode */
 #define V2_TCTL_CLK_IPG		(1 << 6)
 #define V2_TCTL_CLK_PER		(2 << 6)
+#define V2_TCTL_CLK_OSC_DIV8	(5 << 6)
 #define V2_TCTL_FRR		(1 << 9)
+#define V2_TCTL_24MEN		(1 << 10)
+#define V2_TPRER_PRE24M		12
 #define V2_IR			0x0c
 #define V2_TSTAT		0x08
 #define V2_TSTAT_OF1		(1 << 0)
 #define V2_TCN			0x24
 #define V2_TCMP			0x10
 
+#define V2_TIMER_RATE_OSC_DIV8	3000000
+
 #define timer_is_v1()	(cpu_is_mx1() || cpu_is_mx21() || cpu_is_mx27())
 #define timer_is_v2()	(!timer_is_v1())
 
@@ -312,10 +317,22 @@ static void __init _mxc_timer_init(int irq,
 	__raw_writel(0, timer_base + MXC_TCTL);
 	__raw_writel(0, timer_base + MXC_TPRER); /* see datasheet note */
 
-	if (timer_is_v2())
-		tctl_val = V2_TCTL_CLK_PER | V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
-	else
+	if (timer_is_v2()) {
+		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
+		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
+			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
+			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
+				/* 24 / 8 = 3 MHz */
+				__raw_writel(7 << V2_TPRER_PRE24M,
+					timer_base + MXC_TPRER);
+				tctl_val |= V2_TCTL_24MEN;
+			}
+		} else {
+			tctl_val |= V2_TCTL_CLK_PER;
+		}
+	} else {
 		tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
+	}
 
 	__raw_writel(tctl_val, timer_base + MXC_TCTL);
 
@@ -349,9 +366,13 @@ static void __init mxc_timer_init_dt(struct device_node *np)
 	WARN_ON(!timer_base);
 	irq = irq_of_parse_and_map(np, 0);
 
-	clk_per = of_clk_get_by_name(np, "per");
 	clk_ipg = of_clk_get_by_name(np, "ipg");
 
+	/* Try osc_per first, and fall back to per otherwise */
+	clk_per = of_clk_get_by_name(np, "osc_per");
+	if (IS_ERR(clk_per))
+		clk_per = of_clk_get_by_name(np, "per");
+
 	_mxc_timer_init(irq, clk_per, clk_ipg);
 }
 CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
-- 
1.7.9.5
