From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 16 Dec 2011 15:12:32 -0700
Subject: [PATCH 9/9] arm/tegra: Use bus notifiers to trigger pinmux setup
In-Reply-To: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
References: <1324073552-15542-1-git-send-email-swarren@nvidia.com>
Message-ID: <1324073552-15542-10-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the Tegra pinmux is initialized at different times when booting
with and without device tree:

Without device tree:

1) Pinmux and GPIO drivers are registered.
2) Pinmux is configured.
3) All other drivers are registered.

With device tree:

1) All drivers are registered and probed, including pinmux and GPIO.
2) Pinmux is configured.

This change modifies board-pinmux.c to detect pinmux and GPIO driver
registration using bus notifiers. This allows pinmux configuration to
happen immediately after the pinmux driver is probed, irrespective of
whether the pinmux driver is manually registered by board-pinmux.c, or
if it's instantiated during device tree parsing.

To support this with device tree, the pinmux init functions must be
called prior to instantiating devices from device tree, so that the
notifiers are set up before-hand.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-dt.c     |   14 +++---
 arch/arm/mach-tegra/board-pinmux.c |   72 +++++++++++++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index f062051..b44633b 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -123,13 +123,6 @@ static void __init tegra_dt_init(void)
 
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
-	/*
-	 * Finished with the static registrations now; fill in the missing
-	 * devices
-	 */
-	of_platform_populate(NULL, tegra_dt_match_table,
-				tegra20_auxdata_lookup, NULL);
-
 	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
 		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
 			pinmux_configs[i].init();
@@ -139,6 +132,13 @@ static void __init tegra_dt_init(void)
 
 	WARN(i == ARRAY_SIZE(pinmux_configs),
 		"Unknown platform! Pinmuxing not initialized\n");
+
+	/*
+	 * Finished with the static registrations now; fill in the missing
+	 * devices
+	 */
+	of_platform_populate(NULL, tegra_dt_match_table,
+				tegra20_auxdata_lookup, NULL);
 }
 
 static const char * tegra_dt_board_compat[] = {
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
index 103ef65..adc3efe 100644
--- a/arch/arm/mach-tegra/board-pinmux.c
+++ b/arch/arm/mach-tegra/board-pinmux.c
@@ -12,7 +12,11 @@
  *
  */
 
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/string.h>
 
 #include <mach/gpio-tegra.h>
 #include <mach/pinmux.h>
@@ -20,19 +24,23 @@
 #include "board-pinmux.h"
 #include "devices.h"
 
-static struct platform_device *devices[] = {
-	&tegra_gpio_device,
-	&tegra_pinmux_device,
-};
+struct tegra_board_pinmux_conf *confs[2];
 
-void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
-			     struct tegra_board_pinmux_conf *conf_b)
+static void tegra_board_pinmux_setup_gpios(void)
 {
-	struct tegra_board_pinmux_conf *confs[] = {conf_a, conf_b};
 	int i;
 
-	if (of_machine_is_compatible("nvidia,tegra20"))
-		platform_add_devices(devices, ARRAY_SIZE(devices));
+	for (i = 0; i < ARRAY_SIZE(confs); i++) {
+		if (!confs[i])
+			continue;
+
+		tegra_gpio_config(confs[i]->gpios, confs[i]->gpio_count);
+	}
+}
+
+static void tegra_board_pinmux_setup_pinmux(void)
+{
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(confs); i++) {
 		if (!confs[i])
@@ -43,10 +51,54 @@ void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
 		if (confs[i]->drives)
 			tegra_drive_pinmux_config_table(confs[i]->drives,
 							confs[i]->drive_count);
+	}
+}
 
-		tegra_gpio_config(confs[i]->gpios, confs[i]->gpio_count);
+static int tegra_board_pinmux_bus_notify(struct notifier_block *nb,
+					 unsigned long event, void *vdev)
+{
+	static bool had_gpio;
+	static bool had_pinmux;
+
+	struct device *dev = vdev;
+	const char *devname;
+
+	if (event != BUS_NOTIFY_BOUND_DRIVER)
+		return NOTIFY_DONE;
+
+	devname = dev_name(dev);
+
+	if (!had_gpio && !strcmp(devname, GPIO_DEV)) {
+		tegra_board_pinmux_setup_gpios();
+		had_gpio = true;
+	} else if (!had_pinmux && !strcmp(devname, PINMUX_DEV)) {
+		tegra_board_pinmux_setup_pinmux();
+		had_pinmux = true;
 	}
 
+	if (had_gpio && had_pinmux)
+		return NOTIFY_STOP_MASK;
+	else
+		return NOTIFY_DONE;
+}
+
+static struct notifier_block nb = {
+	.notifier_call = tegra_board_pinmux_bus_notify,
+};
+
+static struct platform_device *devices[] = {
+	&tegra_gpio_device,
+	&tegra_pinmux_device,
+};
+
+void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
+			     struct tegra_board_pinmux_conf *conf_b)
+{
+	confs[0] = conf_a;
+	confs[1] = conf_b;
+
+	bus_register_notifier(&platform_bus_type, &nb);
+
 	if (!of_machine_is_compatible("nvidia,tegra20"))
 		platform_add_devices(devices, ARRAY_SIZE(devices));
 }
-- 
1.7.0.4
