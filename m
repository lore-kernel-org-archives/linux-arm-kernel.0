From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 21 Oct 2011 11:35:50 -0600
Subject: [PATCH] arm/tegra: Don't create duplicate gpio and pinmux devices
Message-ID: <1319218550-26002-1-git-send-email-swarren@nvidia.com>
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

To avoid this duplicate registration, pass a parameter into *_pinmux_init()
indicating whether they should register the device or not. Set this true
for non-DT boards, and false otherwise.

Finally, modify board-dt.c to call the *_pinmux_init() after all devices have
been instantiated from device-tree. This allows the GPIO and pinmux devices
to be instantiated and initialized before calling functions to configure the
hardware.

This has one disadvantage: The pinmux and GPIO initialization now happens
after /all/ devices are instantiated, rather than after just gpio and
pinmux, but before anything else. So the correct HW configuration is not
in place when e.g. the SD/MMC device is probed. Long-term, this should be
solved by doing both:

a) Initializing the HW state from DT nodes during GPIO and pinmux device
   probe.
b) Using the deferred driver probe mechanism, so that drivers can defer
   their probe until after the gpio and pinmux drivers have probed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Grant, Olof, Colin,

What are your thoughts here? Both with and without the patch there are
disadvantages. I'm not sure which one is better...

 arch/arm/mach-tegra/board-dt.c               |   23 ++++++++++++-----------
 arch/arm/mach-tegra/board-harmony-pinmux.c   |    6 ++++--
 arch/arm/mach-tegra/board-harmony.c          |    2 +-
 arch/arm/mach-tegra/board-harmony.h          |    2 +-
 arch/arm/mach-tegra/board-paz00-pinmux.c     |    6 ++++--
 arch/arm/mach-tegra/board-paz00.c            |    2 +-
 arch/arm/mach-tegra/board-paz00.h            |    2 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |   14 ++++++++------
 arch/arm/mach-tegra/board-seaboard.c         |    2 +-
 arch/arm/mach-tegra/board-seaboard.h         |    2 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    6 ++++--
 arch/arm/mach-tegra/board-trimslice.c        |    2 +-
 arch/arm/mach-tegra/board-trimslice.h        |    2 +-
 13 files changed, 40 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index d368f8d..0d22212 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -45,9 +45,9 @@
 #include "clock.h"
 #include "devices.h"
 
-void harmony_pinmux_init(void);
-void seaboard_pinmux_init(void);
-void ventana_pinmux_init(void);
+void harmony_pinmux_init(int is_dt);
+void seaboard_pinmux_init(int is_dt);
+void ventana_pinmux_init(int is_dt);
 
 struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-sdhci", TEGRA_SDMMC1_BASE, "sdhci-tegra.0", NULL),
@@ -82,7 +82,7 @@ static struct of_device_id tegra_dt_gic_match[] __initdata = {
 
 static struct {
 	char *machine;
-	void (*init)(void);
+	void (*init)(int is_dt);
 } pinmux_configs[] = {
 	{ "nvidia,harmony", harmony_pinmux_init },
 	{ "nvidia,seaboard", seaboard_pinmux_init },
@@ -101,21 +101,22 @@ static void __init tegra_dt_init(void)
 
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
-			pinmux_configs[i].init();
+			pinmux_configs[i].init(1);
 			break;
 		}
 	}
 
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
index e99b456..c1f58dd 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -159,9 +159,11 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_EXT_MIC_EN,	.enable = true	},
 };
 
-void harmony_pinmux_init(void)
+void harmony_pinmux_init(int is_dt)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!is_dt)
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index f0bdc5e..e595901 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -170,7 +170,7 @@ static void __init tegra_harmony_init(void)
 {
 	tegra_clk_init_from_table(harmony_clk_init_table);
 
-	harmony_pinmux_init();
+	harmony_pinmux_init(0);
 
 	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
 	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 139d96c..c194ec5 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -35,7 +35,7 @@
 #define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
 #define TEGRA_GPIO_EN_VDD_1V05_GPIO	HARMONY_GPIO_TPS6586X(2)
 
-void harmony_pinmux_init(void);
+void harmony_pinmux_init(int is_dt);
 int harmony_regulator_init(void);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index fb20894..c8301fd 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -156,9 +156,11 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
-void paz00_pinmux_init(void)
+void paz00_pinmux_init(int is_dt)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!is_dt)
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(paz00_pinmux, ARRAY_SIZE(paz00_pinmux));
 
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 602f8dd..1709e5e 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -173,7 +173,7 @@ static void __init tegra_paz00_init(void)
 {
 	tegra_clk_init_from_table(paz00_clk_init_table);
 
-	paz00_pinmux_init();
+	paz00_pinmux_init(0);
 
 	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index 2dc1899..8695518 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -32,6 +32,6 @@
 #define TEGRA_WIFI_RST		TEGRA_GPIO_PD1
 #define TEGRA_WIFI_LED		TEGRA_GPIO_PD0
 
-void paz00_pinmux_init(void);
+void paz00_pinmux_init(int is_dt);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index fbce31d..a63bc0e 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -216,9 +216,11 @@ static void __init update_pinmux(struct tegra_pingroup_config *newtbl, int size)
 	}
 }
 
-void __init seaboard_common_pinmux_init(void)
+void __init seaboard_common_pinmux_init(int is_dt)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!is_dt)
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 
 	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
 
@@ -228,14 +230,14 @@ void __init seaboard_common_pinmux_init(void)
 	tegra_gpio_config(common_gpio_table, ARRAY_SIZE(common_gpio_table));
 }
 
-void __init seaboard_pinmux_init(void)
+void __init seaboard_pinmux_init(int is_dt)
 {
-	seaboard_common_pinmux_init();
+	seaboard_common_pinmux_init(is_dt);
 }
 
-void __init ventana_pinmux_init(void)
+void __init ventana_pinmux_init(int is_dt)
 {
 	update_pinmux(ventana_pinmux, ARRAY_SIZE(ventana_pinmux));
-	seaboard_common_pinmux_init();
+	seaboard_common_pinmux_init(is_dt);
 }
 
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
index bf13ea3..c41e01a 100644
--- a/arch/arm/mach-tegra/board-seaboard.c
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -226,7 +226,7 @@ static void __init seaboard_i2c_init(void)
 
 static void __init seaboard_common_init(void)
 {
-	seaboard_pinmux_init();
+	seaboard_pinmux_init(0);
 
 	tegra_clk_init_from_table(seaboard_clk_init_table);
 
diff --git a/arch/arm/mach-tegra/board-seaboard.h b/arch/arm/mach-tegra/board-seaboard.h
index 4c45d4c..d4460c3 100644
--- a/arch/arm/mach-tegra/board-seaboard.h
+++ b/arch/arm/mach-tegra/board-seaboard.h
@@ -42,6 +42,6 @@
 #define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PX1
 #define TEGRA_GPIO_KAEN_HP_MUTE		TEGRA_GPIO_PA5
 
-void seaboard_pinmux_init(void);
+void seaboard_pinmux_init(int is_dt);
 
 #endif
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index 4969dd2..3aa05f9 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -155,9 +155,11 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TRIMSLICE_GPIO_USB2_RST,  .enable = true }, /* USB2 PHY rst */
 };
 
-void __init trimslice_pinmux_init(void)
+void __init trimslice_pinmux_init(int is_dt)
 {
-	platform_add_devices(pinmux_devices, ARRAY_SIZE(pinmux_devices));
+	if (!is_dt)
+		platform_add_devices(pinmux_devices,
+					ARRAY_SIZE(pinmux_devices));
 	tegra_pinmux_config_table(trimslice_pinmux, ARRAY_SIZE(trimslice_pinmux));
 	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
 }
diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-tegra/board-trimslice.c
index e008c0e..2b2f262 100644
--- a/arch/arm/mach-tegra/board-trimslice.c
+++ b/arch/arm/mach-tegra/board-trimslice.c
@@ -160,7 +160,7 @@ static void __init tegra_trimslice_init(void)
 {
 	tegra_clk_init_from_table(trimslice_clk_init_table);
 
-	trimslice_pinmux_init();
+	trimslice_pinmux_init(0);
 
 	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
diff --git a/arch/arm/mach-tegra/board-trimslice.h b/arch/arm/mach-tegra/board-trimslice.h
index 50f128d..4d19a11 100644
--- a/arch/arm/mach-tegra/board-trimslice.h
+++ b/arch/arm/mach-tegra/board-trimslice.h
@@ -25,6 +25,6 @@
 #define TRIMSLICE_GPIO_USB1_MODE	TEGRA_GPIO_PV2 /* USB1 mode */
 #define TRIMSLICE_GPIO_USB2_RST		TEGRA_GPIO_PV0 /* USB2 PHY reset */
 
-void trimslice_pinmux_init(void);
+void trimslice_pinmux_init(int is_dt);
 
 #endif
-- 
1.7.0.4
