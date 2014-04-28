From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 28 Apr 2014 20:31:28 +0100
Subject: [PATCH 62/97] ARM: l2c: nomadik: convert to generic l2c initialisation
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Message-ID: <E1WerGy-0001Xw-OT@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This also allows us to eliminate the .init_machine function.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/cpu-8815.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 0f245bcc6b7e..9116ca476d7c 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -143,23 +143,16 @@ static int __init cpu8815_mmcsd_init(void)
 }
 device_initcall(cpu8815_mmcsd_init);
 
-static void __init cpu8815_init_of(void)
-{
-#ifdef CONFIG_CACHE_L2X0
-	/* At full speed latency must be >=2, so 0x249 in low bits */
-	l2x0_of_init(0x00700249, 0xfe0fefff);
-#endif
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * cpu8815_board_compat[] = {
 	"calaosystems,usb-s8815",
 	NULL,
 };
 
 DT_MACHINE_START(NOMADIK_DT, "Nomadik STn8815")
+	/* At full speed latency must be >=2, so 0x249 in low bits */
+	.l2c_aux_val	= 0x00700249,
+	.l2c_aux_mask	= 0xfe0fefff,
 	.map_io		= cpu8815_map_io,
-	.init_machine	= cpu8815_init_of,
 	.restart	= cpu8815_restart,
 	.dt_compat      = cpu8815_board_compat,
 MACHINE_END
-- 
1.8.3.1
