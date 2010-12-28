From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 28 Dec 2010 22:55:51 +0800
Subject: [PATCH 06/10] ARM: mx28: update clocks for dual fec support
In-Reply-To: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1293548155-16328-7-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Change fec clock registration to use con_id only for looking up,
  so that dual fec driver can find the same clock for both fec0
  and fec1.

* Explicitly call clk_enable for some clocks that have been on to
  reflect the clock status and get usecount updated. Otherwise,
  clocks could be turned off by pair call of clk_enable/clk_disable
  in drivers, because of the incorrect initial usecount.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx28.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index dd6d158..6b77aff 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -603,7 +603,7 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
 
 static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("uart", NULL, uart_clk)
-	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
+	_REGISTER_CLOCK(NULL, "fec_clk", fec_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
 	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
@@ -726,6 +726,11 @@ int __init mx28_clocks_init(void)
 {
 	clk_misc_init();
 
+	clk_enable(&cpu_clk);
+	clk_enable(&hbus_clk);
+	clk_enable(&emi_clk);
+	clk_enable(&uart_clk);
+
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	mxs_timer_init(&clk32k_clk, MX28_INT_TIMER0);
-- 
1.7.1
