From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 May 2012 17:00:14 -0600
Subject: [PATCH 2/3] ARM: tegra: harmony: init regulators,
 PCIe when booting from DT
In-Reply-To: <1335999615-6119-1-git-send-email-swarren@wwwdotorg.org>
References: <1335999615-6119-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335999615-6119-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

There currently aren't bindings for the Tegra PCIe controller. Work on
this is in progress, but not yet complete. Manually initialize PCIe when
booting from device tree, in order to bring DT support to the same
feature level as board files, which will in turn allow board files to be
deprecated.

PCIe on Harmony requires various regulators to be registered and enabled
before initializing the PCIe controller. Note that since the I2C
controllers are instantiated from DT, we must use i2c_new_device() to
register the PMU rather than i2c_register_board_info().

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This patch depends on the I2C for-next tree, in particular the addition
of of_find_i2c_adapter_by_node(). I'll need to ask Wolfram for a stable
tag/branch to use as a dependency in arm-soc for this.
---
 arch/arm/mach-tegra/board-dt-tegra20.c    |   20 ++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony-pcie.c  |   15 ++++++++++-----
 arch/arm/mach-tegra/board-harmony-power.c |   25 ++++++++++++++++++++++++-
 arch/arm/mach-tegra/board.h               |    7 +++++++
 4 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 8fd6f31..fd83050 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -109,6 +109,23 @@ static void __init trimslice_init(void)
 }
 #endif
 
+#ifdef CONFIG_MACH_HARMONY
+static void __init harmony_init(void)
+{
+	int ret;
+
+	ret = harmony_regulator_init();
+	if (ret) {
+		pr_err("harmony_regulator_init() failed: %d\n", ret);
+		return;
+	}
+
+	ret = harmony_pcie_init();
+	if (ret)
+		pr_err("harmony_pcie_init() failed: %d\n", ret);
+}
+#endif
+
 static struct {
 	char *machine;
 	void (*init)(void);
@@ -116,6 +133,9 @@ static struct {
 #ifdef CONFIG_MACH_TRIMSLICE
 	{ "compulab,trimslice", trimslice_init },
 #endif
+#ifdef CONFIG_MACH_HARMONY
+	{ "nvidia,harmony", harmony_init },
+#endif
 };
 
 static int __init tegra_dt_init_board_specific(void)
diff --git a/arch/arm/mach-tegra/board-harmony-pcie.c b/arch/arm/mach-tegra/board-harmony-pcie.c
index 33c4fed..e8c3fda 100644
--- a/arch/arm/mach-tegra/board-harmony-pcie.c
+++ b/arch/arm/mach-tegra/board-harmony-pcie.c
@@ -27,14 +27,11 @@
 
 #ifdef CONFIG_TEGRA_PCI
 
-static int __init harmony_pcie_init(void)
+int __init harmony_pcie_init(void)
 {
 	struct regulator *regulator = NULL;
 	int err;
 
-	if (!machine_is_harmony())
-		return 0;
-
 	err = gpio_request(TEGRA_GPIO_EN_VDD_1V05_GPIO, "EN_VDD_1V05");
 	if (err)
 		return err;
@@ -62,7 +59,15 @@ err_reg:
 	return err;
 }
 
+static int __init harmony_pcie_initcall(void)
+{
+	if (!machine_is_harmony())
+		return 0;
+
+	return harmony_pcie_init();
+}
+
 /* PCI should be initialized after I2C, mfd and regulators */
-subsys_initcall_sync(harmony_pcie_init);
+subsys_initcall_sync(harmony_pcie_initcall);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-harmony-power.c b/arch/arm/mach-tegra/board-harmony-power.c
index 82f3230..44dcb2e 100644
--- a/arch/arm/mach-tegra/board-harmony-power.c
+++ b/arch/arm/mach-tegra/board-harmony-power.c
@@ -20,6 +20,10 @@
 #include <linux/gpio.h>
 #include <linux/regulator/machine.h>
 #include <linux/mfd/tps6586x.h>
+#include <linux/of.h>
+#include <linux/of_i2c.h>
+
+#include <asm/mach-types.h>
 
 #include <mach/irqs.h>
 
@@ -110,7 +114,26 @@ static struct i2c_board_info __initdata harmony_regulators[] = {
 
 int __init harmony_regulator_init(void)
 {
-	i2c_register_board_info(3, harmony_regulators, 1);
+	if (machine_is_harmony()) {
+		i2c_register_board_info(3, harmony_regulators, 1);
+	} else { /* Harmony, booted using device tree */
+		struct device_node *np;
+		struct i2c_adapter *adapter;
+
+		np = of_find_node_by_path("/i2c at 7000d000");
+		if (np == NULL) {
+			pr_err("Could not find device_node for DVC I2C\n");
+			return -ENODEV;
+		}
+
+		adapter = of_find_i2c_adapter_by_node(np);
+		if (!adapter) {
+			pr_err("Could not find i2c_adapter for DVC I2C\n");
+			return -ENODEV;
+		}
+
+		i2c_new_device(adapter, harmony_regulators);
+	}
 
 	return 0;
 }
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index 75d1543..a91ce5b 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -32,5 +32,12 @@ void __init tegra_init_irq(void);
 void __init tegra_dt_init_irq(void);
 int __init tegra_pcie_init(bool init_port0, bool init_port1);
 
+int __init harmony_regulator_init(void);
+#ifdef CONFIG_TEGRA_PCI
+int __init harmony_pcie_init(void);
+#else
+static inline int harmony_pcie_init(void) { return 0; }
+#endif
+
 extern struct sys_timer tegra_timer;
 #endif
-- 
1.7.0.4
