From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Apr 2014 07:44:56 +0900
Subject: [PATCH 07/14] ARM: shmobile: lager-reference: Work around core clock
 issues
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
Message-ID: <aa5de826afe747c353162bbc116c63ab5335f91c.1397774191.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to issues with runtime PM clock management, clocks not explicitly
managed by their drivers may not be enabled at all, or be inadvertently
disabled by the clk_disable_unused() late initcall.

Until this is fixed, add a temporary workaround, calling
shmobile_clk_workaround() with enable == true.

For now this enables the clocks for: ether, msiof1, qspi_mod, and
thermal. More clocks can be added if needed.

Based on work for the koelsch board by Geert Uytterhoeven.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-lager-reference.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 7ff395e..313118c 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -108,9 +108,20 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 };
 
+/*
+ * This is a really crude hack to work around core platform clock issues
+ */
+static const struct clk_name clk_enables[] __initconst = {
+	{ "ether", NULL, "ee700000.ethernet" },
+	{ "msiof1", NULL, "e6e10000.spi" },
+	{ "qspi_mod", NULL, "e6b10000.spi" },
+	{ "thermal", NULL, "e61f0000.thermal" },
+};
+
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
+	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
-- 
1.8.4
