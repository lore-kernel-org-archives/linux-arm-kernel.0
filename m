From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:14 +0900
Subject: [PATCH 18/30] ARM: shmobile: r8a7740: tidyup comment/implementation
 mismatch
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-19-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current clock-r8a7740's DIV4/DIV6/MSTP implemented area and
its comment are mismatching.
This patch tidyup its comment/implementation area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   60 +++++++++++++++++---------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 1feb9a2..161e128 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -323,6 +323,7 @@ struct clk *main_clks[] = {
 	&fsibck_clk,
 };
 
+/* DIV4 clocks */
 static void div4_kick(struct clk *clk)
 {
 	unsigned long value;
@@ -346,6 +347,26 @@ static struct clk_div4_table div4_table = {
 	.kick = div4_kick,
 };
 
+enum {
+	DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_HP,
+	DIV4_HPP, DIV4_USBP, DIV4_S, DIV4_ZB, DIV4_M3, DIV4_CP,
+	DIV4_NR
+};
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_ZG]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_M1]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT),
+	[DIV4_HP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRB,  4, 0x6fff, 0),
+	[DIV4_HPP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 20, 0x6fff, 0),
+	[DIV4_USBP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 16, 0x6fff, 0),
+	[DIV4_S]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 12, 0x6fff, 0),
+	[DIV4_ZB]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  8, 0x6fff, 0),
+	[DIV4_M3]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  4, 0x6fff, 0),
+	[DIV4_CP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  0, 0x6fff, 0),
+};
+
 /* DIV6 reparent */
 enum {
 	DIV6_HDMI,
@@ -391,6 +412,16 @@ static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
 				      fsib_parents, ARRAY_SIZE(fsib_parents), 6, 2),
 };
 
+/* DIV6 clocks */
+enum {
+	DIV6_SUB,
+	DIV6_NR
+};
+
+static struct clk div6_clks[DIV6_NR] = {
+	[DIV6_SUB]	= SH_CLK_DIV6(&pllc1_div2_clk, SUBCKCR, 0),
+};
+
 /* HDMI1/2 clock */
 static unsigned long hdmi12_recalc(struct clk *clk)
 {
@@ -456,35 +487,6 @@ static struct clk fsidivs[] = {
 
 /* MSTP */
 enum {
-	DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1, DIV4_HP,
-	DIV4_HPP, DIV4_USBP, DIV4_S, DIV4_ZB, DIV4_M3, DIV4_CP,
-	DIV4_NR
-};
-
-struct clk div4_clks[DIV4_NR] = {
-	[DIV4_I]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
-	[DIV4_ZG]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
-	[DIV4_B]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  8, 0x6fff, CLK_ENABLE_ON_INIT),
-	[DIV4_M1]	= SH_CLK_DIV4(&pllc1_clk, FRQCRA,  4, 0x6fff, CLK_ENABLE_ON_INIT),
-	[DIV4_HP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRB,  4, 0x6fff, 0),
-	[DIV4_HPP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 20, 0x6fff, 0),
-	[DIV4_USBP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 16, 0x6fff, 0),
-	[DIV4_S]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC, 12, 0x6fff, 0),
-	[DIV4_ZB]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  8, 0x6fff, 0),
-	[DIV4_M3]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  4, 0x6fff, 0),
-	[DIV4_CP]	= SH_CLK_DIV4(&pllc1_clk, FRQCRC,  0, 0x6fff, 0),
-};
-
-enum {
-	DIV6_SUB,
-	DIV6_NR
-};
-
-static struct clk div6_clks[DIV6_NR] = {
-	[DIV6_SUB]	= SH_CLK_DIV6(&pllc1_div2_clk, SUBCKCR, 0),
-};
-
-enum {
 	MSTP128, MSTP127, MSTP125,
 	MSTP116, MSTP111, MSTP100, MSTP117,
 
-- 
1.7.10.4
