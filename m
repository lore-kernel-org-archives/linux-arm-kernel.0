From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 Aug 2013 23:28:08 +0200
Subject: [PATCH RFC v2 14/16] ARM: vexpress: remove custom .init_time hook
In-Reply-To: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377638890-371-15-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks. The call to versatile_sched_clock_init
is moved to .init_early instead, we it is also for non-DT boards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-vexpress/v2m.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 95a469e..4f8b8cb 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -1,12 +1,10 @@
 /*
  * Versatile Express V2M Motherboard Support
  */
-#include <linux/clocksource.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/mmci.h>
 #include <linux/io.h>
-#include <linux/clocksource.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/of_address.h>
@@ -22,7 +20,6 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/vexpress.h>
-#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 
 #include <asm/mach-types.h>
@@ -422,16 +419,8 @@ void __init v2m_dt_init_early(void)
 			pr_warning("vexpress: DT HBI (%x) is not matching "
 					"hardware (%x)!\n", dt_hbi, hbi);
 	}
-}
-
-static void __init v2m_dt_timer_init(void)
-{
-	of_clk_init(NULL);
 
-	clocksource_of_init();
-
-	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(),
-				24000000);
+	versatile_sched_clock_init(vexpress_get_24mhz_clock_base(), 24000000);
 }
 
 static const struct of_device_id v2m_dt_bus_match[] __initconst = {
@@ -458,6 +447,5 @@ DT_MACHINE_START(VEXPRESS_DT, "ARM-Versatile Express")
 	.smp_init	= smp_init_ops(vexpress_smp_init_ops),
 	.map_io		= v2m_dt_map_io,
 	.init_early	= v2m_dt_init_early,
-	.init_time	= v2m_dt_timer_init,
 	.init_machine	= v2m_dt_init,
 MACHINE_END
-- 
1.7.2.5
