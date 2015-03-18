From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 18 Mar 2015 10:52:25 +0100
Subject: [PATCH v6 10/12] soc/tegra: pmc: move to using a restart handler
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426672363-30667-11-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Riley <davidriley@chromium.org>

The pmc driver was previously exporting tegra_pmc_restart, which was
assigned to machine_desc.init_machine, taking precedence over the
restart handlers registered through register_restart_handler().

Signed-off-by: David Riley <davidriley@chromium.org>
[tomeu.vizoso at collabora.com: Rebased]
Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/mach-tegra/tegra.c |  1 -
 drivers/soc/tegra/pmc.c     | 31 +++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 914341b..4805ef6 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -164,6 +164,5 @@ DT_MACHINE_START(TEGRA_DT, "NVIDIA Tegra SoC (Flattened Device Tree)")
 	.init_irq	= tegra_dt_init_irq,
 	.init_machine	= tegra_dt_init,
 	.init_late	= tegra_dt_init_late,
-	.restart	= tegra_pmc_restart,
 	.dt_compat	= tegra_dt_board_compat,
 MACHINE_END
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index c956395..0285b74 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -377,26 +377,23 @@ int tegra_pmc_cpu_remove_clamping(int cpuid)
 }
 #endif /* CONFIG_SMP */
 
-/**
- * tegra_pmc_restart() - reboot the system
- * @mode: which mode to reboot in
- * @cmd: reboot command
- */
-void tegra_pmc_restart(enum reboot_mode mode, const char *cmd)
+static int tegra_pmc_restart_notify(struct notifier_block *this,
+				    unsigned long mode, void *cmd)
 {
 	u32 value;
+	const char *cmd_str = (const char *) cmd;
 
 	value = tegra_pmc_readl(PMC_SCRATCH0);
 	value &= ~PMC_SCRATCH0_MODE_MASK;
 
-	if (cmd) {
-		if (strcmp(cmd, "recovery") == 0)
+	if (cmd_str) {
+		if (strcmp(cmd_str, "recovery") == 0)
 			value |= PMC_SCRATCH0_MODE_RECOVERY;
 
-		if (strcmp(cmd, "bootloader") == 0)
+		if (strcmp(cmd_str, "bootloader") == 0)
 			value |= PMC_SCRATCH0_MODE_BOOTLOADER;
 
-		if (strcmp(cmd, "forced-recovery") == 0)
+		if (strcmp(cmd_str, "forced-recovery") == 0)
 			value |= PMC_SCRATCH0_MODE_RCM;
 	}
 
@@ -405,8 +402,15 @@ void tegra_pmc_restart(enum reboot_mode mode, const char *cmd)
 	value = tegra_pmc_readl(0);
 	value |= 0x10;
 	tegra_pmc_writel(value, 0);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block tegra_pmc_restart_handler = {
+	.notifier_call = tegra_pmc_restart_notify,
+	.priority = 128,
+};
+
 static int powergate_show(struct seq_file *s, void *data)
 {
 	unsigned int i;
@@ -837,6 +841,13 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	err = register_restart_handler(&tegra_pmc_restart_handler);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register restart handler, %d\n",
+			err);
+		return err;
+	}
+
 	return 0;
 }
 
-- 
2.1.0
