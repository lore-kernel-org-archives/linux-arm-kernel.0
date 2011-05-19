From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:26 +0200
Subject: [PATCH 2/6] ARM: tegra: paz00: register i2c busses
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305806910-3903-3-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the i2c busses on paz00. The 3rd bus is
reserved for the nvec, which acts as master and i2c-tegra has
not yet support for this kind of operation.
The sound codec (alc5632) is connected to the first bus and will
be added once the codec and glue driver is upstream.
The thermal sensor (atd7461) is connected to dvc as usual, but will
not be added now because i2c-tegra still misses probe support
(needs I2C_FUNC_SMBUS_EMUL).

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
