From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 20 Aug 2013 04:04:24 +0200
Subject: [RFC 10/17] ARM: nspire: remove custom .init_time hook
In-Reply-To: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1376964271-22715-11-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-nspire/nspire.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
index 99e2609..4b2ed2e 100644
--- a/arch/arm/mach-nspire/nspire.c
+++ b/arch/arm/mach-nspire/nspire.c
@@ -14,11 +14,9 @@
 #include <linux/of_platform.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-vic.h>
-#include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
-#include <linux/clocksource.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
@@ -65,12 +63,6 @@ static void __init nspire_init(void)
 			nspire_auxdata, NULL);
 }
 
-static void __init nspire_init_time(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void nspire_restart(char mode, const char *cmd)
 {
 	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
@@ -83,7 +75,6 @@ static void nspire_restart(char mode, const char *cmd)
 DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
 	.dt_compat	= nspire_dt_match,
 	.map_io		= nspire_map_io,
-	.init_time	= nspire_init_time,
 	.init_machine	= nspire_init,
 	.restart	= nspire_restart,
 MACHINE_END
-- 
1.7.10.4
