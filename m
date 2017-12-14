From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 14 Dec 2017 21:03:18 +0530
Subject: [PATCH V5 11/13] boot_constraint: Add Qualcomm display controller
 constraints
In-Reply-To: <cover.1513264961.git.viresh.kumar@linaro.org>
References: <cover.1513264961.git.viresh.kumar@linaro.org>
Message-ID: <22b3eec1377cc64242bede04f03bb65b8d2ba00a.1513264961.git.viresh.kumar@linaro.org>
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
 arch/arm64/Kconfig.platforms     |   1 +
 drivers/boot_constraint/Makefile |   1 +
 drivers/boot_constraint/qcom.c   | 122 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 drivers/boot_constraint/qcom.c

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index a586ed728393..b514327290ca 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -136,6 +136,7 @@ config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select GPIOLIB
 	select PINCTRL
+	select DEV_BOOT_CONSTRAINT
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 
diff --git a/drivers/boot_constraint/Makefile b/drivers/boot_constraint/Makefile
index f3e123b5d854..7b6b5966c908 100644
--- a/drivers/boot_constraint/Makefile
+++ b/drivers/boot_constraint/Makefile
@@ -4,3 +4,4 @@ obj-y := clk.o deferrable_dev.o core.o pm.o supply.o
 
 obj-$(CONFIG_ARCH_HISI)			+= hikey.o
 obj-$(CONFIG_ARCH_MXC)			+= imx.o
+obj-$(CONFIG_ARCH_QCOM)			+= qcom.o
diff --git a/drivers/boot_constraint/qcom.c b/drivers/boot_constraint/qcom.c
new file mode 100644
index 000000000000..0498f464da05
--- /dev/null
+++ b/drivers/boot_constraint/qcom.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This sets up Dragonboard 410c constraints on behalf of the bootloader, which
+ * uses display controller to display a flash screen during system boot.
+ *
+ * Copyright (C) 2017 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ * Rajendra Nayak <rnayak@codeaurora.org>
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
2.15.0.194.g9af6a3dea062
