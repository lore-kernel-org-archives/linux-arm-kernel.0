From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Apr 2013 14:07:08 +0900
Subject: [PATCH 12/30] ARM: shmobile: sh73a0: add a TWD clock
In-Reply-To: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
References: <1364879246-9470-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1364879246-9470-13-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add a TWD clock on sh73a0 for the smp_twd driver to properly update the
clock's frequency upon cpufreq events.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 34b5c5a..a57ec15 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -288,6 +288,20 @@ static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_HP] = DIV4(FRQCRB, 4, 0xdff, 0),
 };
 
+static unsigned long twd_recalc(struct clk *clk)
+{
+	return clk_get_rate(clk->parent) / 4;
+}
+
+static struct sh_clk_ops twd_clk_ops = {
+	.recalc = twd_recalc,
+};
+
+static struct clk twd_clk = {
+	.parent = &div4_clks[DIV4_Z],
+	.ops = &twd_clk_ops,
+};
+
 enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
 	DIV6_FLCTL, DIV6_SDHI0, DIV6_SDHI1, DIV6_SDHI2,
 	DIV6_FSIA, DIV6_FSIB, DIV6_SUB,
@@ -482,6 +496,7 @@ static struct clk dsi1phy_clk = {
 static struct clk *late_main_clks[] = {
 	&dsi0phy_clk,
 	&dsi1phy_clk,
+	&twd_clk,
 };
 
 enum { MSTP001,
@@ -546,6 +561,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
+	CLKDEV_DEV_ID("smp_twd", &twd_clk), /* smp_twd */
 
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("vck1_clk", &div6_clks[DIV6_VCK1]),
-- 
1.7.10.4
