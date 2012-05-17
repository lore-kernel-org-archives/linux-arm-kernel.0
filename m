From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 May 2012 15:21:12 -0600
Subject: [PATCH V2 1/3] ARM: tegra: trimslice: enable PCIe when booting from
 device tree
Message-ID: <1337289674-18581-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

There currently aren't bindings for the Tegra PCIe controller. Work on
this is in progress, but not yet complete. Manually initialize PCIe when
booting from device tree, in order to bring DT support to the same
feature level as board files, which will in turn allow board files to be
deprecated.

PCIe hosts the wired Ethernet controller on TrimSlice.

To support this, add infra-structure to board-dt-tegra20.c for board-
specific initialization code. Once device tree support for the relevant
features is in place, this code will be removed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Use .init_late hook in DT_MACHINE_START instead of an explicit late
initcall.
---
 arch/arm/mach-tegra/board-dt-tegra20.c |   36 +++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index eb7249d..9537f20 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -98,6 +98,40 @@ static void __init tegra_dt_init(void)
 				tegra20_auxdata_lookup, NULL);
 }
 
+#ifdef CONFIG_MACH_TRIMSLICE
+static void __init trimslice_init(void)
+{
+	int ret;
+
+	ret = tegra_pcie_init(true, true);
+	if (ret)
+		pr_err("tegra_pci_init() failed: %d\n", ret);
+}
+#endif
+
+static struct {
+	char *machine;
+	void (*init)(void);
+} board_init_funcs[] = {
+#ifdef CONFIG_MACH_TRIMSLICE
+	{ "compulab,trimslice", trimslice_init },
+#endif
+};
+
+static void __init tegra_dt_init_late(void)
+{
+	int i;
+
+	tegra_init_late();
+
+	for (i = 0; i < ARRAY_SIZE(board_init_funcs); i++) {
+		if (of_machine_is_compatible(board_init_funcs[i].machine)) {
+			board_init_funcs[i].init();
+			break;
+		}
+	}
+}
+
 static const char *tegra20_dt_board_compat[] = {
 	"nvidia,tegra20",
 	NULL
@@ -110,7 +144,7 @@ DT_MACHINE_START(TEGRA_DT, "nVidia Tegra20 (Flattened Device Tree)")
 	.handle_irq	= gic_handle_irq,
 	.timer		= &tegra_timer,
 	.init_machine	= tegra_dt_init,
-	.init_late	= tegra_init_late,
+	.init_late	= tegra_dt_init_late,
 	.restart	= tegra_assert_system_reset,
 	.dt_compat	= tegra20_dt_board_compat,
 MACHINE_END
-- 
1.7.0.4
