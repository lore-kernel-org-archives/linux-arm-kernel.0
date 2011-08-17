From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 17 Aug 2011 12:47:28 +0100
Subject: [RFC PATCH 2/2] arm/tegra: Add device tree support to pinmux driver
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1313581648-22303-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

[ j.iles: converted to generic of_pinmux_parse() ]

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-tegra/pinmux.c |  240 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 240 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index ed316f9..cd540eb 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -20,6 +20,8 @@
 #include <linux/errno.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_pinmux.h>
 #include <linux/platform_device.h>
 
 #include <mach/iomap.h>
@@ -124,6 +126,21 @@ static const char *pingroup_name(enum tegra_pingroup pg)
 	return pingroups[pg].name;
 }
 
+#ifdef CONFIG_OF
+static int pingroup_enum(const char *name, enum tegra_pingroup *pg_out)
+{
+	int pg;
+
+	for (pg = 0; pg < TEGRA_MAX_PINGROUP; pg++)
+		if (!strcasecmp(name, tegra_soc_pingroups[pg].name)) {
+			*pg_out = pg;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+#endif
+
 static const char *func_name(enum tegra_mux_func func)
 {
 	if (func == TEGRA_MUX_RSVD1)
@@ -147,6 +164,41 @@ static const char *func_name(enum tegra_mux_func func)
 	return tegra_mux_names[func];
 }
 
+#ifdef CONFIG_OF
+static int func_enum(const char *name, enum tegra_mux_func *func_out)
+{
+	int func;
+
+	if (!strcasecmp(name, "RSVD1")) {
+		*func_out = TEGRA_MUX_RSVD1;
+		return 0;
+	}
+	if (!strcasecmp(name, "RSVD2")) {
+		*func_out = TEGRA_MUX_RSVD2;
+		return 0;
+	}
+	if (!strcasecmp(name, "RSVD3")) {
+		*func_out = TEGRA_MUX_RSVD3;
+		return 0;
+	}
+	if (!strcasecmp(name, "RSVD4")) {
+		*func_out = TEGRA_MUX_RSVD4;
+		return 0;
+	}
+	if (!strcasecmp(name, "NONE")) {
+		*func_out = TEGRA_MUX_NONE;
+		return 0;
+	}
+
+	for (func = 0; func < TEGRA_MAX_MUX; func++)
+		if (!strcasecmp(name, tegra_mux_names[func])) {
+			*func_out = func;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+#endif
 
 static const char *tri_name(unsigned long val)
 {
@@ -329,6 +381,22 @@ static const char *drive_pinmux_name(enum tegra_drive_pingroup pg)
 	return drive_pingroups[pg].name;
 }
 
+#ifdef CONFIG_OF
+static int drive_pinmux_enum(const char *name,
+			     enum tegra_drive_pingroup *pg_out)
+{
+	int pg;
+
+	for (pg = 0; pg < TEGRA_MAX_DRIVE_PINGROUP; pg++)
+		if (!strcasecmp(name, drive_pingroups[pg].name)) {
+			*pg_out = pg;
+			return 0;
+		}
+
+	return -EINVAL;
+}
+#endif
+
 static const char *enable_name(unsigned long val)
 {
 	return val ? "ENABLE" : "DISABLE";
@@ -666,15 +734,187 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
 	}
 }
 
+#ifdef CONFIG_OF
+static int __init tegra_pinmux_dt_configure(const struct of_pinmux_ctrl *ctrl,
+					    const struct of_pinmux_cfg *config)
+{
+	struct tegra_pingroup_config tegra_config;
+	int ret;
+
+	ret = pingroup_enum(config->pin->name, &tegra_config.pingroup);
+	if (ret < 0) {
+		pr_err("invalid pingroup name (%s)\n", config->pin->name);
+		return ret;
+	}
+
+	ret = func_enum(config->function, &tegra_config.func);
+	if (ret < 0) {
+		pr_err("invalid function (%s)\n", config->function);
+		return ret;
+	}
+
+	if (config->flags & OF_PINMUX_PULL_UP)
+		tegra_config.pupd = TEGRA_PUPD_PULL_UP;
+	else if (config->flags & OF_PINMUX_PULL_DOWN)
+		tegra_config.pupd = TEGRA_PUPD_PULL_DOWN;
+	else
+		tegra_config.pupd = TEGRA_PUPD_NORMAL;
+
+	tegra_config.tristate = (config->flags & OF_PINMUX_TRISTATE) ?
+		TEGRA_TRI_TRISTATE : TEGRA_TRI_NORMAL;
+
+	tegra_pinmux_config_pingroup(&tegra_config);
+
+	return 0;
+}
+static void __init tegra_pinmux_parse_mux_groups(
+			struct platform_device *pdev,
+			struct device_node *mux_node)
+{
+	struct of_pinmux_ctrl tegra_pinmux_ctrl = {
+		.pinmux = mux_node,
+		.configure = tegra_pinmux_dt_configure,
+	};
+
+	if (of_pinmux_parse(&tegra_pinmux_ctrl))
+		pr_err("failed to parse pinmux configuration\n");
+}
+
+static void __init tegra_pinmux_parse_drive_groups(
+			struct platform_device *pdev,
+			struct device_node *drive_node)
+{
+	struct device_node *node;
+
+	for_each_child_of_node(drive_node, node) {
+		enum tegra_drive_pingroup pg;
+		enum tegra_hsm hsm;
+		enum tegra_schmitt schmitt;
+		enum tegra_drive drive;
+		enum tegra_pull_strength pull_down;
+		enum tegra_pull_strength pull_up;
+		enum tegra_slew slew_rising;
+		enum tegra_slew slew_falling;
+		int ret;
+
+		ret = drive_pinmux_enum(node->name, &pg);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Invalid pingroup name\n",
+				node->name);
+			continue;
+		}
+
+		if (of_find_property(node, "nvidia,high-speed-mode", NULL))
+			hsm = TEGRA_HSM_ENABLE;
+		else
+			hsm = TEGRA_HSM_DISABLE;
+
+		if (of_find_property(node, "nvidia,schmitt", NULL))
+			schmitt = TEGRA_SCHMITT_ENABLE;
+		else
+			schmitt = TEGRA_SCHMITT_DISABLE;
+
+		ret = of_property_read_u32(node, "nvidia,drive-power", &drive);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Missing property "
+				"nvidia,drive-power\n",
+				node->name);
+			continue;
+		}
+
+		ret = of_property_read_u32(node, "nvidia,pull-down-strength",
+					   &pull_down);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Missing property "
+				"nvidia,pull-down-strength\n",
+				node->name);
+			continue;
+		}
+
+		ret = of_property_read_u32(node, "nvidia,pull-up-strength",
+					   &pull_up);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Missing property "
+				"nvidia,pull-up-strength\n",
+				node->name);
+			continue;
+		}
+
+		ret = of_property_read_u32(node, "nvidia,slew-rate-rising",
+					   &slew_rising);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Missing property "
+				"nvidia,slew_rate-rising\n",
+				node->name);
+			continue;
+		}
+
+		ret = of_property_read_u32(node, "nvidia,slew-rate-falling",
+					   &slew_rising);
+		if (ret < 0) {
+			dev_err(&pdev->dev,
+				"(drive) %s: Missing property "
+				"nvidia,slew_rate-falling\n",
+				node->name);
+			continue;
+		}
+
+		dev_dbg(&pdev->dev,
+			"(drive) %s: hsm %d schmitt %d drive %d "
+			"pull_down %d pull_up %d slew_r %d slew_f %d\n",
+			node->name,
+			hsm, schmitt, drive,
+			pull_down, pull_up,
+			slew_rising, slew_falling);
+
+		tegra_drive_pinmux_config_pingroup(pg, hsm, schmitt, drive,
+						   pull_down, pull_up,
+						   slew_rising, slew_falling);
+	}
+}
+
+static void __init tegra_pinmux_probe_dt(struct platform_device *pdev)
+{
+	struct device_node *node;
+
+	for_each_child_of_node(pdev->dev.of_node, node) {
+		if (!strcmp(node->name, "nvidia,mux-groups"))
+			tegra_pinmux_parse_mux_groups(pdev, node);
+		else if (!strcmp(node->name, "nvidia,drive-groups"))
+			tegra_pinmux_parse_drive_groups(pdev, node);
+		else
+			dev_err(&pdev->dev, "%s: Unknown child node\n",
+				node->name);
+	}
+}
+#else
+static inline void __init tegra_pinmux_probe_dt(struct platform_device *pdev)
+{
+}
+#endif
+
 static int __init tegra_pinmux_probe(struct platform_device *pdev)
 {
+	tegra_pinmux_probe_dt(pdev);
+
 	return 0;
 }
 
+static struct of_device_id tegra_pinmux_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-pinmux", },
+	{ },
+};
+
 static struct platform_driver tegra_pinmux_driver = {
 	.driver		= {
 		.name	= "tegra-pinmux",
 		.owner	= THIS_MODULE,
+		.of_match_table = tegra_pinmux_of_match,
 	},
 	.probe		= tegra_pinmux_probe,
 };
-- 
1.7.4.1
