From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 15 Aug 2012 19:07:30 +0200
Subject: [PATCH v3 1/6] ARM: dove: unify clock setup
In-Reply-To: <1345050455-32643-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344681326-17946-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1345050455-32643-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1345050455-32643-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch synchronizes the clock setup of dove with other orion-based
platforms.

In dove_find_tclk there was a note about DOVE_SAMPLE_HI/LO register to
detect tclk. While it might be possible to set a different tclk frequency
with reset strapping the Dove datasheets don't tell anything about tclk
frequency here. Therefore, I removed that comment.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Ian Molton <ian.molton@codethink.co.uk>
Cc: Maen Suleiman <maen@marvell.com>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-dove/common.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

v2: remove useless clk_prepare_enable for fixed rate tclk

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 4db5de5..b6f092c 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -33,8 +33,6 @@
 #include <plat/addr-map.h>
 #include "common.h"
 
-static int get_tclk(void);
-
 /*****************************************************************************
  * I/O Address Mapping
  ****************************************************************************/
@@ -70,12 +68,13 @@ void __init dove_map_io(void)
 /*****************************************************************************
  * CLK tree
  ****************************************************************************/
+static int dove_tclk;
 static struct clk *tclk;
 
-static void __init clk_init(void)
+static void __init dove_clk_init(void)
 {
 	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       get_tclk());
+				       dove_tclk);
 
 	orion_clkdev_init(tclk);
 }
@@ -187,16 +186,16 @@ void __init dove_init_early(void)
 	orion_time_set_base(TIMER_VIRT_BASE);
 }
 
-static int get_tclk(void)
+static int __init dove_find_tclk(void)
 {
-	/* use DOVE_RESET_SAMPLE_HI/LO to detect tclk */
 	return 166666667;
 }
 
 static void __init dove_timer_init(void)
 {
+	dove_tclk = dove_find_tclk();
 	orion_time_init(BRIDGE_VIRT_BASE, BRIDGE_INT_TIMER1_CLR,
-			IRQ_DOVE_BRIDGE, get_tclk());
+			IRQ_DOVE_BRIDGE, dove_tclk);
 }
 
 struct sys_timer dove_timer = {
@@ -284,8 +283,8 @@ void __init dove_sdio1_init(void)
 
 void __init dove_init(void)
 {
-	printk(KERN_INFO "Dove 88AP510 SoC, ");
-	printk(KERN_INFO "TCLK = %dMHz\n", (get_tclk() + 499999) / 1000000);
+	pr_info("Dove 88AP510 SoC, TCLK = %d MHz.\n",
+		(dove_tclk + 499999) / 1000000);
 
 #ifdef CONFIG_CACHE_TAUROS2
 	tauros2_init();
@@ -293,7 +292,7 @@ void __init dove_init(void)
 	dove_setup_cpu_mbus();
 
 	/* Setup root of clk tree */
-	clk_init();
+	dove_clk_init();
 
 	/* internal devices that every board has */
 	dove_rtc_init();
-- 
1.7.10.4
