From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:44:54 +0900
Subject: [PATCH 05/14] ARM: shmobile: koelsch-reference: Work around core
 clock issues
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <53cf0cf7ba2ef785b339826a0765bb6b1756adeb.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Due to issues with runtime PM clock management, clocks not explicitly
managed by their drivers may not be enabled at all, or be inadvertently
disabled by the clk_disable_unused() late initcall.

Until this is fixed, add a temporary workaround, calling
shmobile_clk_workaround() with enable == true.

For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
thermal. More clocks can be added if needed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-koelsch-reference.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 1e6a436..a39114a 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -107,9 +107,21 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
 };
 
+/*
+ * This is a really crude hack to work around core platform clock issues
+ */
+static const struct clk_name clk_enables[] = {
+	{ "ether", NULL, "ee700000.ethernet" },
+	{ "i2c2", NULL, "e6530000.i2c" },
+	{ "msiof0", NULL, "e6e20000.spi" },
+	{ "qspi_mod", NULL, "e6b10000.spi" },
+	{ "thermal", NULL, "e61f0000.thermal" },
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7791_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.8.4
