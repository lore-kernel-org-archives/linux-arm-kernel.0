From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 29 Oct 2017 19:19:00 +0530
Subject: [PATCH V4 12/12] boot_constraint: Add Qualcomm display controller
 constraints
In-Reply-To: <cover.1509284255.git.viresh.kumar@linaro.org>
References: <cover.1509284255.git.viresh.kumar@linaro.org>
Message-ID: <b9b813b6ee18134c6b729fe4ecbe764e0dd365df.1509284255.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@codeaurora.org>

This sets boot constraints for the display controller used on Qualcomm
dragonboard 410c.

The display controlled is enabled by the bootloader to show a flash
screen during kernel boot. The handover to kernel should be without any
glitches on the screen.The resources of the display controller (like
regulators) are shared with other peripherals, which may reconfigure
those resources before the display driver comes up. The same problem can
happen if the display driver probes first, as the constraints of the
other devices (sharing same resources with display controller) may not
be honored anymore by the kernel.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/Kconfig.platforms      |   1 +
 drivers/boot_constraints/Makefile |   1 +
 drivers/boot_constraints/qcom.c   | 123 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/boot_constraints/qcom.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 265df4a088ab..6343627cf105 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -134,6 +134,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
+	select DEV_BOOT_CONSTRAINTS
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
diff --git a/drivers/boot_constraints/Makefile b/drivers/boot_constraints/Makefile
index 3b5a87fcf099..e32751b70957 100644
--- a/drivers/boot_constraints/Makefile
+++ b/drivers/boot_constraints/Makefile
@@ -4,3 +4,4 @@ obj-y := clk.o deferrable_dev.o core.o pm.o serial.o supply.o
 
 obj-$(CONFIG_ARCH_HISI)			+= hikey.o
 obj-$(CONFIG_ARCH_MXC)			+= imx.o
+obj-$(CONFIG_ARCH_QCOM)			+= qcom.o
diff --git a/drivers/boot_constraints/qcom.c b/drivers/boot_constraints/qcom.c
new file mode 100644
index 000000000000..e89357670906
--- /dev/null
+++ b/drivers/boot_constraints/qcom.c
@@ -0,0 +1,123 @@
+/*
+ * This sets up Dragonboard 410c constraints on behalf of the bootloader, which
+ * uses display controller to display a flash screen during system boot.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ * Rajendra Nayak <rnayak@codeaurora.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/boot_constraint.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+static struct dev_boot_constraint_clk_info iface_clk_info = {
+	.name = "iface_clk",
+};
+
+static struct dev_boot_constraint_clk_info bus_clk_info = {
+	.name = "bus_clk",
+};
+
+static struct dev_boot_constraint_clk_info core_clk_info = {
+	.name = "core_clk",
+};
+
+static struct dev_boot_constraint_clk_info vsync_clk_info = {
+	.name = "vsync_clk",
+};
+
+static struct dev_boot_constraint_clk_info esc0_clk_info = {
+	.name = "core_clk",
+};
+
+static struct dev_boot_constraint_clk_info byte_clk_info = {
+	.name = "byte_clk",
+};
+
+static struct dev_boot_constraint_clk_info pixel_clk_info = {
+	.name = "pixel_clk",
+};
+
+static struct dev_boot_constraint_supply_info vdda_info = {
+	.name = "vdda"
+};
+
+static struct dev_boot_constraint_supply_info vddio_info = {
+	.name = "vddio"
+};
+
+static struct dev_boot_constraint constraints_mdss[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_PM,
+		.data = NULL,
+	},
+};
+
+static struct dev_boot_constraint constraints_mdp[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &iface_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &bus_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &core_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &vsync_clk_info,
+	},
+};
+
+static struct dev_boot_constraint constraints_dsi[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &esc0_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &byte_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &pixel_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vdda_info,
+
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_SUPPLY,
+		.data = &vddio_info,
+	},
+};
+
+static struct dev_boot_constraint_of constraints[] = {
+	{
+		.compat = "qcom,mdss",
+		.constraints = constraints_mdss,
+		.count = ARRAY_SIZE(constraints_mdss),
+	}, {
+		.compat = "qcom,mdp5",
+		.constraints = constraints_mdp,
+		.count = ARRAY_SIZE(constraints_mdp),
+	}, {
+		.compat = "qcom,mdss-dsi-ctrl",
+		.constraints = constraints_dsi,
+		.count = ARRAY_SIZE(constraints_dsi),
+	},
+};
+
+static int __init qcom_constraints_init(void)
+{
+	/* Only Dragonboard 410c is supported for now */
+	if (!of_machine_is_compatible("qcom,apq8016-sbc"))
+		return 0;
+
+	dev_boot_constraint_add_deferrable_of(constraints,
+					      ARRAY_SIZE(constraints));
+
+	return 0;
+}
+subsys_initcall(qcom_constraints_init);
-- 
2.15.0.rc1.236.g92ea95045093
