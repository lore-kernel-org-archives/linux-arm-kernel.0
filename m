From: olof@lixom.net (Olof Johansson)
Date: Mon,  7 Mar 2011 02:26:38 -0600
Subject: [PATCH 2/3] ARM: tegra: harmony: register i2c devices
In-Reply-To: <1299486399-21761-1-git-send-email-olof@lixom.net>
References: <1299486399-21761-1-git-send-email-olof@lixom.net>
Message-ID: <1299486399-21761-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the base i2c busses on harmony. Devices coming at a later date,
but this allows for hand-probing of some of them at least.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/board-harmony.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 38c2ab8..d46268d 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -24,6 +24,8 @@
 #include <linux/pda_power.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/i2c-tegra.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -78,6 +80,35 @@ static struct platform_device harmony_audio_device = {
 	},
 };
 
+static struct tegra_i2c_platform_data harmony_i2c1_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static struct tegra_i2c_platform_data harmony_i2c2_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static struct tegra_i2c_platform_data harmony_i2c3_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static struct tegra_i2c_platform_data harmony_dvc_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static void harmony_i2c_init(void)
+{
+	tegra_i2c_device1.dev.platform_data = &harmony_i2c1_platform_data;
+	tegra_i2c_device2.dev.platform_data = &harmony_i2c2_platform_data;
+	tegra_i2c_device3.dev.platform_data = &harmony_i2c3_platform_data;
+	tegra_i2c_device4.dev.platform_data = &harmony_dvc_platform_data;
+
+	platform_device_register(&tegra_i2c_device1);
+	platform_device_register(&tegra_i2c_device2);
+	platform_device_register(&tegra_i2c_device3);
+	platform_device_register(&tegra_i2c_device4);
+}
+
 static struct platform_device *harmony_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device1,
@@ -140,6 +171,7 @@ static void __init tegra_harmony_init(void)
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
 
 	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
+	harmony_i2c_init();
 }
 
 MACHINE_START(HARMONY, "harmony")
-- 
1.7.0.4
