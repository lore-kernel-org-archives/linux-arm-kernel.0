From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 Aug 2013 23:28:06 +0200
Subject: [PATCH RFC v2 12/16] ARM: sti: remove custom .init_time hook
In-Reply-To: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377638890-371-13-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks. To get rid of it, move l2cc init to
.init_machine hook instead.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Cc: Stuart Menefy <stuart.menefy@st.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: kernel at stlinux.com
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-sti/board-dt.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sti/board-dt.c b/arch/arm/mach-sti/board-dt.c
index 8fe6f0c..1217fb5 100644
--- a/arch/arm/mach-sti/board-dt.c
+++ b/arch/arm/mach-sti/board-dt.c
@@ -7,9 +7,8 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 #include <linux/irq.h>
+#include <linux/of_platform.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach/arch.h>
 
@@ -28,11 +27,10 @@ void __init stih41x_l2x0_init(void)
 	l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
 }
 
-static void __init stih41x_timer_init(void)
+static void __init stih41x_machine_init(void)
 {
-	of_clk_init(NULL);
-	clocksource_of_init();
 	stih41x_l2x0_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *stih41x_dt_match[] __initdata = {
@@ -42,7 +40,7 @@ static const char *stih41x_dt_match[] __initdata = {
 };
 
 DT_MACHINE_START(STM, "STiH415/416 SoC with Flattened Device Tree")
-	.init_time	= stih41x_timer_init,
+	.init_machine	= stih41x_machine_init,
 	.smp		= smp_ops(sti_smp_ops),
 	.dt_compat	= stih41x_dt_match,
 MACHINE_END
-- 
1.7.2.5
