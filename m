From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  2 May 2012 17:00:15 -0600
Subject: [PATCH 3/3] ARM: tegra: paz00: enable WiFi rfkill when booting from
 device tree
In-Reply-To: <1335999615-6119-1-git-send-email-swarren@wwwdotorg.org>
References: <1335999615-6119-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1335999615-6119-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

There currently aren't bindings for a WiFi rfkill button, and defining
a good binding is non-trivial. Manually register this "device" when
booting from device tree, in order to bring DT support to the same
feature level as board files, which will in turn allow board files to be
deprecated.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-dt-tegra20.c |   10 ++++++++++
 arch/arm/mach-tegra/board-paz00.c      |    7 ++++++-
 arch/arm/mach-tegra/board.h            |    2 ++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index fd83050..9e02f85 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -126,6 +126,13 @@ static void __init harmony_init(void)
 }
 #endif
 
+#ifdef CONFIG_MACH_PAZ00
+static void __init paz00_init(void)
+{
+	tegra_paz00_wifikill_init();
+}
+#endif
+
 static struct {
 	char *machine;
 	void (*init)(void);
@@ -136,6 +143,9 @@ static struct {
 #ifdef CONFIG_MACH_HARMONY
 	{ "nvidia,harmony", harmony_init },
 #endif
+#ifdef CONFIG_MACH_PAZ00
+	{ "compal,paz00", paz00_init },
+#endif
 };
 
 static int __init tegra_dt_init_board_specific(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 55a1e6c..d4353e3 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -148,7 +148,6 @@ static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device4,
 	&tegra_sdhci_device1,
-	&wifi_rfkill_device,
 	&leds_gpio,
 	&gpio_keys_device,
 };
@@ -201,6 +200,11 @@ static struct tegra_sdhci_platform_data sdhci_pdata4 = {
 	.is_8bit	= 1,
 };
 
+void __init tegra_paz00_wifikill_init(void)
+{
+	platform_device_register(&wifi_rfkill_device);
+}
+
 static void __init tegra_paz00_init(void)
 {
 	tegra_clk_init_from_table(paz00_clk_init_table);
@@ -211,6 +215,7 @@ static void __init tegra_paz00_init(void)
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
 
 	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
+	tegra_paz00_wifikill_init();
 
 	paz00_i2c_init();
 	paz00_usb_init();
diff --git a/arch/arm/mach-tegra/board.h b/arch/arm/mach-tegra/board.h
index a91ce5b..fcf15d0 100644
--- a/arch/arm/mach-tegra/board.h
+++ b/arch/arm/mach-tegra/board.h
@@ -39,5 +39,7 @@ int __init harmony_pcie_init(void);
 static inline int harmony_pcie_init(void) { return 0; }
 #endif
 
+void __init tegra_paz00_wifikill_init(void);
+
 extern struct sys_timer tegra_timer;
 #endif
-- 
1.7.0.4
