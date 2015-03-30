From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 16:04:35 +0200
Subject: [PATCH 2/5] ARM: mvebu: Add standby support
In-Reply-To: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1427724278-12379-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Until now only one Armada XP based board supported suspend to
ram. However most of the recent mvebu SoCs can support the standby
mode. Unlike for the suspend to ram, nothing special have to be done
for this SoC. This patch allow the system to use the standby mode on
Armada 370, 38x, 39x and XP SoCs. There is issues with the the Armada
375, and the support would be added (if possible) in a future patch.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/common.h   |  5 ++--
 arch/arm/mach-mvebu/pm-board.c | 13 ++++++----
 arch/arm/mach-mvebu/pm.c       | 56 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 3e0aca1f288a..341d35d7185a 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -25,6 +25,7 @@ int mvebu_system_controller_get_soc_id(u32 *dev, u32 *rev);
 
 void __iomem *mvebu_get_scu_base(void);
 
-int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd));
-
+int mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+							u32 srcmd));
+void mvebu_pm_register_init(int (*board_pm_init)(void));
 #endif
diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index e56782ac9fbe..f5aa9dfcc19d 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -79,9 +79,6 @@ static int __init mvebu_armada_xp_gp_pm_init(void)
 	struct device_node *gpio_ctrl_np;
 	int ret = 0, i;
 
-	if (!of_machine_is_compatible("marvell,axp-gp"))
-		return -ENODEV;
-
 	np = of_find_node_by_name(NULL, "pm_pic");
 	if (!np)
 		return -ENODEV;
@@ -131,11 +128,17 @@ static int __init mvebu_armada_xp_gp_pm_init(void)
 	if (!gpio_ctrl)
 		return -ENOMEM;
 
-	mvebu_pm_init(mvebu_armada_xp_gp_pm_enter);
+	mvebu_pm_suspend_init(mvebu_armada_xp_gp_pm_enter);
 
 out:
 	of_node_put(np);
 	return ret;
 }
 
-late_initcall(mvebu_armada_xp_gp_pm_init);
+int __init mvebu_armada_xp_gp_pm_register(void)
+{
+	if (of_machine_is_compatible("marvell,axp-gp"))
+		mvebu_pm_register_init(mvebu_armada_xp_gp_pm_init);
+	return 0;
+}
+arch_initcall(mvebu_armada_xp_gp_pm_register);
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 36f28db6e3a1..547310230edd 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -34,6 +34,8 @@
 
 static void (*mvebu_board_pm_enter)(void __iomem *sdram_reg, u32 srcmd);
 static void __iomem *sdram_ctrl;
+static bool is_suspend_mem_available;
+static int (*mvebu_board_pm_init)(void);
 
 static int mvebu_pm_powerdown(unsigned long data)
 {
@@ -151,11 +153,8 @@ static void mvebu_pm_store_bootinfo(void)
 	writel(BOOT_MAGIC_LIST_END, store_addr);
 }
 
-static int mvebu_pm_enter(suspend_state_t state)
+static void mvebu_enter_suspend(void)
 {
-	if (state != PM_SUSPEND_MEM)
-		return -EINVAL;
-
 	cpu_pm_enter();
 
 	mvebu_pm_store_bootinfo();
@@ -168,16 +167,57 @@ static int mvebu_pm_enter(suspend_state_t state)
 	set_cpu_coherent();
 
 	cpu_pm_exit();
+}
 
+static int mvebu_pm_enter(suspend_state_t state)
+{
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+		cpu_do_idle();
+		break;
+	case PM_SUSPEND_MEM:
+		mvebu_enter_suspend();
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
+static int mvebu_pm_valid(suspend_state_t state)
+{
+	return ((state == PM_SUSPEND_STANDBY) ||
+		(is_suspend_mem_available && (state == PM_SUSPEND_MEM)));
+}
+
 static const struct platform_suspend_ops mvebu_pm_ops = {
 	.enter = mvebu_pm_enter,
-	.valid = suspend_valid_only_mem,
+	.valid = mvebu_pm_valid,
 };
 
-int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
+void __init mvebu_pm_register_init(int (*board_pm_init)(void))
+{
+	mvebu_board_pm_init = board_pm_init;
+}
+
+static int __init mvebu_pm_init(void)
+{
+
+	if (!of_machine_is_compatible("marvell,armadaxp") &&
+			!of_machine_is_compatible("marvell,armada370") &&
+			!of_machine_is_compatible("marvell,armada380") &&
+			!of_machine_is_compatible("marvell,armada390"))
+		return -ENODEV;
+
+	if (mvebu_board_pm_init)
+		if (mvebu_board_pm_init())
+			pr_warn("Registering suspend init for this board failed\n");
+	suspend_set_ops(&mvebu_pm_ops);
+
+	return 0;
+}
+
+int __init mvebu_pm_suspend_init(void (*board_pm_enter)(void __iomem *sdram_reg,
+								u32 srcmd))
 {
 	struct device_node *np;
 	struct resource res;
@@ -212,7 +252,9 @@ int __init mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 src
 
 	mvebu_board_pm_enter = board_pm_enter;
 
-	suspend_set_ops(&mvebu_pm_ops);
+	is_suspend_mem_available = true;
 
 	return 0;
 }
+
+late_initcall(mvebu_pm_init);
-- 
2.1.0
