From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Nov 2014 10:20:26 +0900
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: Add restart callback
In-Reply-To: <cover.1415841454.git.horms+renesas@verge.net.au>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
Message-ID: <cad900819fba01760833c6c6ed89f464f9c93690.1415841454.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Port the sh73a0 restart handling from the kzm9g-legacy board code to the
generic sh73a0 code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index b7bd8e5..3447ca7 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -775,6 +775,13 @@ void __init sh73a0_add_standard_devices_dt(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void sh73a0_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *sh73a0_boards_compat_dt[] __initdata = {
 	"renesas,sh73a0",
 	NULL,
@@ -786,6 +793,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= sh73a0_init_delay,
 	.init_machine	= sh73a0_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
+	.restart	= sh73a0_restart,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.1.1
