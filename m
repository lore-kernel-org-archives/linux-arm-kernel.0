From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 17:46:29 -0700
Subject: [PATCH 5/5] OMAP1 clock: convert armwdt_ck to use the fixed divisor
	recalc function
In-Reply-To: <20100112004326.24684.91321.stgit@localhost.localdomain>
References: <20100112004326.24684.91321.stgit@localhost.localdomain>
Message-ID: <20100112004628.24684.49978.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The armwdt_ck clock uses a fixed divisor, so it can use the OMAP clock
fixed divisor recalculation code, rather than a custom function.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c      |    6 ------
 arch/arm/mach-omap1/clock_data.c |    3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 2ba9ab9..5b735b2 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -52,12 +52,6 @@ const struct clkops clkops_dummy = {
 	.disable	= clk_omap1_dummy_disable,
 };
 
-/* XXX can be replaced with a fixed_divisor_recalc */
-unsigned long omap1_watchdog_recalc(struct clk *clk)
-{
-	return clk->parent->rate / 14;
-}
-
 unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 65e7b5b..edefb34 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -149,7 +149,8 @@ static struct arm_idlect1_clk armwdt_ck = {
 		.flags		= CLOCK_IDLE_CONTROL,
 		.enable_reg	= OMAP1_IO_ADDRESS(ARM_IDLECT2),
 		.enable_bit	= EN_WDTCK,
-		.recalc		= &omap1_watchdog_recalc,
+		.fixed_div	= 14,
+		.recalc		= &omap_fixed_divisor_recalc,
 	},
 	.idlect_shift	= 0,
 };
