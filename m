From: gsi@denx.de (Gerhard Sittig)
Date: Tue,  6 Aug 2013 22:44:11 +0200
Subject: [PATCH v4 31/31] clk: mpc512x: remove remaining migration workarounds
In-Reply-To: <1375821851-31609-1-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
Message-ID: <1375821851-31609-32-git-send-email-gsi@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove the last clkdev registration call ("sys_clk" and "ref_clk"
for CAN), as well as the clkdev header inclusion and the "compat
registration" comment

all client lookups for clock items are device tree based now, no
compatibility alias names need to get provided any longer

remove the now obsolete TODO comment on trimming the list of pre-enabled
clock items, after all the respective peripheral drivers were adjusted

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
index fa95814..621a8d9 100644
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/io.h>
@@ -522,8 +521,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	 *   specific and cannot get mapped to componsites (at least not
 	 *   a single one, maybe two of them, but see the comment about
 	 *   "intermediates are referenced from elsewhere, too")
-	 * - trim the list of auto-enabled clocks after drivers acquire
-	 *   them correctly as needed
 	 */
 
 	/* regardless of whether XTAL/OSC exists, have REF created */
@@ -653,10 +650,6 @@ static void mpc512x_clk_setup_clock_tree(int busfreq)
 	/* fixed frequency for AC97, always 24.567MHz */
 	clks[MPC512x_CLK_AC97] = mpc512x_clk_fixed("ac97", 24567000);
 
-	/* clkdev registration for compatibility reasons */
-	clk_register_clkdev(clks[MPC512x_CLK_REF], "ref_clk", NULL);
-	clk_register_clkdev(clks[MPC512x_CLK_SYS], "sys_clk", NULL);
-
 	/* enable some of the clocks here unconditionally because ... */
 	pr_debug("automatically enabling some clocks\n");
 	/* some are essential yet never get claimed by any driver */
-- 
1.7.10.4
