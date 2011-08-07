From: marvin24@gmx.de (Marc Dietrich)
Date: Sun,  7 Aug 2011 21:00:52 +0200
Subject: [PATCH 2/5] ARM: tegra: paz00: enable rfkill for internal wifi card
In-Reply-To: <cover.1312735430.git.marvin24@gmx.de>
References: <cover.1312735430.git.marvin24@gmx.de>
Message-ID: <089ce540da0a4545b86c52e5247fbbceb65edcb1.1312742856.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for controlling the rfkill gpios for the
internal WIFI card via the rfkill_gpio driver.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    2 ++
 arch/arm/mach-tegra/board-paz00.c        |   17 +++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |   15 +++++++++++----
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index bdd2627..70c5710 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -145,6 +145,8 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
 	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
+	{ .gpio = TEGRA_WIFI_PWRN,	.enable = true },
+	{ .gpio = TEGRA_WIFI_RST,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index f3b7376..6b798e7 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -26,6 +26,7 @@
 #include <linux/pda_power.h>
 #include <linux/io.h>
 #include <linux/i2c.h>
+#include <linux/rfkill-gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -75,10 +76,26 @@ static struct platform_device debug_uart = {
 	},
 };
 
+static struct rfkill_gpio_platform_data wifi_rfkill_platform_data = {
+	.name		= "wifi_rfkill",
+	.reset_gpio	= TEGRA_WIFI_RST,
+	.shutdown_gpio	= TEGRA_WIFI_PWRN,
+	.type	= RFKILL_TYPE_WLAN,
+};
+
+static struct platform_device wifi_rfkill_device = {
+	.name	= "rfkill_gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &wifi_rfkill_platform_data,
+	},
+};
+
 static struct platform_device *paz00_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device4,
+	&wifi_rfkill_device,
 };
 
 static void paz00_i2c_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index d4ff39d..e780f30 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -17,10 +17,17 @@
 #ifndef _MACH_TEGRA_BOARD_PAZ00_H
 #define _MACH_TEGRA_BOARD_PAZ00_H
 
-#define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
-#define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
-#define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PT3
-#define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
+/* SDCARD */
+#define TEGRA_GPIO_SD1_CD	TEGRA_GPIO_PV5
+#define TEGRA_GPIO_SD1_WP	TEGRA_GPIO_PH1
+#define TEGRA_GPIO_SD1_POWER	TEGRA_GPIO_PT3
+
+/* ULPI */
+#define TEGRA_ULPI_RST		TEGRA_GPIO_PV0
+
+/* WIFI */
+#define TEGRA_WIFI_PWRN		TEGRA_GPIO_PK5
+#define TEGRA_WIFI_RST		TEGRA_GPIO_PD1
 
 void paz00_pinmux_init(void);
 
-- 
1.7.4.1
