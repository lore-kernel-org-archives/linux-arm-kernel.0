From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon,  3 Mar 2014 17:02:13 +0100
Subject: [PATCH v2 08/11] ARM: s3c64xx: dt: Enable SoC-level power management
In-Reply-To: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
References: <1393862536-9842-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1393862536-9842-9-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds call to s3c64xx_pm_init() from init_machine() callback
of mach-s3c64xx-dt to enable SoC-level power management features, such
as power domain management and sleep support.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
index 2fddf38..45a4ddc 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
@@ -15,6 +15,7 @@
 #include <asm/system_misc.h>
 
 #include <plat/cpu.h>
+#include <plat/pm.h>
 #include <plat/watchdog-reset.h>
 
 #include <mach/map.h>
@@ -49,9 +50,15 @@ static void __init s3c64xx_dt_map_io(void)
 static void __init s3c64xx_dt_init_machine(void)
 {
 	samsung_wdt_reset_of_init();
+	s3c64xx_pm_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+static void __init s3c64xx_dt_init_late(void)
+{
+	s3c64xx_pm_late_initcall();
+}
+
 static void s3c64xx_dt_restart(enum reboot_mode mode, const char *cmd)
 {
 	if (mode != REBOOT_SOFT)
@@ -72,5 +79,6 @@ DT_MACHINE_START(S3C6400_DT, "Samsung S3C64xx (Flattened Device Tree)")
 	.dt_compat	= s3c64xx_dt_compat,
 	.map_io		= s3c64xx_dt_map_io,
 	.init_machine	= s3c64xx_dt_init_machine,
+	.init_late	= s3c64xx_dt_init_late,
 	.restart        = s3c64xx_dt_restart,
 MACHINE_END
-- 
1.9.0
