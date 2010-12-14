From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 13 Dec 2010 23:34:44 -0700
Subject: [PATCH 01/12] OMAP4: clock data: Add control for pad_clks_ck and
	slimbus_clk
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Message-ID: <20101214063443.21555.55086.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

The gating of pad_clks and slimbus_ck is controlled by the PRCM, but
since the clock source is external, this is the SW responsability
to gate / un-gate it when the mcpdm or slimbus module need to be used.
There is no autogating possible with such external clock.

Add SW control to enable / disable this SW gating in the pad_clks_ck
and slimbus_clk clock node.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index bfcd19f..828d7f4 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -47,7 +47,9 @@ static struct clk extalt_clkin_ck = {
 static struct clk pad_clks_ck = {
 	.name		= "pad_clks_ck",
 	.rate		= 12000000,
-	.ops		= &clkops_null,
+	.ops            = &clkops_omap2_dflt,
+	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit     = OMAP4430_PAD_CLKS_GATE_SHIFT,
 };
 
 static struct clk pad_slimbus_core_clks_ck = {
@@ -65,7 +67,9 @@ static struct clk secure_32k_clk_src_ck = {
 static struct clk slimbus_clk = {
 	.name		= "slimbus_clk",
 	.rate		= 12000000,
-	.ops		= &clkops_null,
+	.ops            = &clkops_omap2_dflt,
+	.enable_reg     = OMAP4430_CM_CLKSEL_ABE,
+	.enable_bit     = OMAP4430_SLIMBUS_CLK_GATE_SHIFT,
 };
 
 static struct clk sys_32k_ck = {
