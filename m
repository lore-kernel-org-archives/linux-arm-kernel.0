From: khilman@ti.com (Kevin Hilman)
Date: Thu, 26 Apr 2012 16:29:48 -0700
Subject: [PATCH/RFT 3/8] ARM: OMAP3: clock data: treat all AM35x devices the
 same
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Message-ID: <1335482993-14035-4-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init for 3505/3517 specific clocks depends on the ordering of
cpu_is checks, is error prone and confusing (there are 2 separate
checks for cpu_is_omap3505()).

Remove the 3505-specific checking since CK_3505 flag is not used, and
treat all AM35x clocks the same.

This means that the SGX clock (the only AM35x clkdev not currently
flagged for 3505) will now be registered on 3505, but that is
harmless.  That can be cleaned up when the clkdev nodes are removed in
favor of them being registered by hwmod.

Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index dac076a..23b1e78 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3513,21 +3513,9 @@ int __init omap3xxx_clk_init(void)
 	struct omap_clk *c;
 	u32 cpu_clkflg = 0;
 
-	/*
-	 * 3505 must be tested before 3517, since 3517 returns true
-	 * for both AM3517 chips and AM3517 family chips, which
-	 * includes 3505.  Unfortunately there's no obvious family
-	 * test for 3517/3505 :-(
-	 */
-	if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3505;
-	} else if (cpu_is_omap3517()) {
+	if (cpu_is_omap3517()) {
 		cpu_mask = RATE_IN_34XX;
 		cpu_clkflg = CK_3517;
-	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_3505;
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
 		cpu_clkflg = CK_36XX;
-- 
1.7.9.2
