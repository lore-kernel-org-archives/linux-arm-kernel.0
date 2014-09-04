From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:49 +0900
Subject: [PATCH 4/6] ARM: shmobile: r8a7740: Add restart callback
In-Reply-To: <cover.1409792648.git.horms+renesas@verge.net.au>
References: <cover.1409792648.git.horms+renesas@verge.net.au>
Message-ID: <1174c712afa2779fad54b86b3569f40fab78c0c2.1409792648.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Port the r8a7740 restart handling from the Armadillo code
to the r8a7740 generic multiplatform case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 1e55c50..daea3a3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -823,6 +823,13 @@ static void __init r8a7740_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void r8a7740_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel(1 << 31, RESCNT2);
+}
+
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -835,6 +842,7 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_machine	= r8a7740_generic_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
+	.restart	= r8a7740_restart,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
2.0.1
