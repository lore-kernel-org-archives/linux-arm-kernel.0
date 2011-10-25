From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 25 Oct 2011 14:01:27 +0200
Subject: [PATCH v3 2/3] arm/tegra: Don't create duplicate gpio and pinmux
	devices
In-Reply-To: <1319544088-25946-1-git-send-email-swarren@nvidia.com>
References: <1319544088-25946-1-git-send-email-swarren@nvidia.com>
Message-ID: <1319544088-25946-2-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

*_pinmux_init() register the GPIO and pinmux devices so that they're ready
before any other device needs them.

*_pinmux_init() are also called by board-dt.c in order to set up the GPIO
and pinmux configurations. In this case, if we register the devices, they
end up being probed once due to this registration, and a second time due
to a device-tree node (or vice-versa). The second probe fails since the
memory regions are already requested. Besides, we don't actually want the
duplicated devices.

To avoid this duplicate registration, modify *_pinmux_init() to check
whether it's running on a DT machine. If not, register the pinmux devices.
If so, don't register them.

Finally, modify board-dt.c to call the *_pinmux_init() after all devices have
been instantiated from device-tree. This allows the GPIO and pinmux devices
to be instantiated and initialized before calling functions to configure the
hardware.

This has one disadvantage: The pinmux and GPIO initialization now happens
after /all/ devices are instantiated, rather than after just gpio and
pinmux but before anything else. So the correct HW configuration is not
in place when e.g. the SD/MMC device is probed. Long-term, this should be
solved by doing both:

a) Initializing the HW state from DT nodes during GPIO and pinmux device
   probe.
b) Using the deferred driver probe mechanism, so that drivers can defer
   their probe until after the gpio and pinmux drivers have probed.

v2: s/int is_dt/bool is_dt/
v3: Use of_machine_is_compatible inside *_pinmux_init() rather than passing
an explicit parameter into the function from outside.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-dt.c               |   13 +++++++------
 arch/arm/mach-tegra/board-harmony-pinmux.c   |    6 +++++-
 arch/arm/mach-tegra/board-paz00-pinmux.c     |    6 +++++-
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |    5 ++++-
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    5 ++++-
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index d368f8d..74743ad 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -101,6 +101,13 @@ static void __init tegra_dt_init(void)
 
 	tegra_clk_init_from_table(tegra_dt_clk_init_table);
 
+	/*
+	 * Finished with the static registrations now; fill in the missing
+	 * devices
+	 */
+	of_platform_populate(NULL, tegra_dt_match_table,
+				tegra20_auxdata_lookup, NULL);
+
 	for (i = 0; i < ARRAY_SIZE(pinmux_configs); i++) {
 		if (of_machine_is_compatible(pinmux_configs[i].machine)) {
 			pinmux_configs[i].init();
@@ -110,12 +117,6 @@ static void __init tegra_dt_init(void)
 
 	WARN(i == ARRAY_SIZE(pinmux_configs),
 		"Unknown platform! Pinmuxing not initialized\n");
-
-	/*
-	 * Finished with the static registrations now; fill in the missing
-	 * devices
-	 */
-	of_platform_populate(NULL, tegra_dt_match_table, tegra20_auxdata_lookup, NULL);
 }
 
 static const char * tegra_dt_board_compat[] = {
diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index e99b456..7a4a26d 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -16,6 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+
 #include <mach/pinmux.h>
 
 #include "gpio-names.h"
@@ -161,7 +163,9 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void harmony_pinmux_init(void)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index fb20894..be30e21 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -16,6 +16,8 @@
 
 #include <linux/kernel.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
+
 #include <mach/pinmux.h>
 
 #include "gpio-names.h"
@@ -158,7 +160,9 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void paz00_pinmux_init(void)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(paz00_pinmux, ARRAY_SIZE(paz00_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index fbce31d..eb5991d 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 
 #include <mach/pinmux.h>
 #include <mach/pinmux-t2.h>
@@ -218,7 +219,9 @@ static void __init update_pinmux(struct tegra_pingroup_config *newtbl, int size)
 
 void __init seaboard_common_pinmux_init(void)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 4969dd2..7ab719d 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -16,6 +16,7 @@
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/of.h>
 
 #include <mach/pinmux.h>
 
@@ -157,7 +158,9 @@ static struct tegra_gpio_table gpio_table[] = {
 
 void __init trimslice_pinmux_init(void)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 	tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
 	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
 }
-- 
1.7.4.1
