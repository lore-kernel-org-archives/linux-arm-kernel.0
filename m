From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 16 May 2011 20:10:56 +0200
Subject: [PATCH 2/4] ARM: tegra: paz00: register i2c busses
In-Reply-To: <1305569458-4821-1-git-send-email-marvin24@gmx.de>
References: <1305569458-4821-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305569458-4821-3-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 57e50a8..5f1c110 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -25,6 +25,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/pda_power.h>
 #include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/i2c-tegra.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -70,6 +72,29 @@ static struct platform_device *paz00_devices[] __initdata = {
 	&tegra_sdhci_device4,
 };
 
+static struct tegra_i2c_platform_data paz00_i2c1_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static struct tegra_i2c_platform_data paz00_i2c2_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static struct tegra_i2c_platform_data paz00_dvc_platform_data = {
+	.bus_clk_rate   = 400000,
+};
+
+static void paz00_i2c_init(void)
+{
+	tegra_i2c_device1.dev.platform_data = &paz00_i2c1_platform_data;
+	tegra_i2c_device2.dev.platform_data = &paz00_i2c2_platform_data;
+	tegra_i2c_device4.dev.platform_data = &paz00_dvc_platform_data;
+
+	platform_device_register(&tegra_i2c_device1);
+	platform_device_register(&tegra_i2c_device2);
+	platform_device_register(&tegra_i2c_device4);
+}
+
 static void __init tegra_paz00_fixup(struct machine_desc *desc,
 	struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -115,6 +140,8 @@ static void __init tegra_paz00_init(void)
 	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
 
 	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
+
+	paz00_i2c_init();
 }
 
 MACHINE_START(PAZ00, "paz00")
-- 
1.7.4.2
