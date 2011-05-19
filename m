From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 19 May 2011 14:08:30 +0200
Subject: [PATCH 6/6] ARM: tegra: paz00: enable wifi card
In-Reply-To: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
References: <1305806910-3903-1-git-send-email-marvin24@gmx.de>
Message-ID: <1305806910-3903-7-git-send-email-marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Wifi card attached to one usb port needs to be unkilled. The
corresponding gpio and also the gpio for the LED are exported to be
controlled by userspace later on.

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/board-paz00-pinmux.c |    2 ++
 arch/arm/mach-tegra/board-paz00.c        |   22 ++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |    7 +++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index bdd2627..41a6304 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -145,6 +145,8 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true },
 	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true },
 	{ .gpio = TEGRA_ULPI_RST,	.enable = true },
+	{ .gpio = TEGRA_WIFI_PWRN,	.enable = true },
+	{ .gpio = TEGRA_WIFI_LED,	.enable = true },
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
index 1b076f6..c78ef4c 100644
--- a/arch/arm/mach-tegra/board-paz00.c
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -135,6 +135,27 @@ static void __init tegra_paz00_fixup(struct machine_desc *desc,
 	mi->bank[0].size = 448 * SZ_1M;
 }
 
+static void __init paz00_wifi_init(void)
+{
+	int ret;
+
+	/* unlock hw rfkill */
+	ret = gpio_request_one(TEGRA_WIFI_PWRN, GPIOF_OUT_INIT_HIGH,
+			"wifi_pwrn");
+	if(ret) {
+		pr_warning("WIFI: could not request PWRN gpio!\n");
+		return;
+	}
+	gpio_export(TEGRA_WIFI_PWRN, 0);
+
+	/* export wifi led */
+	ret = gpio_request_one(TEGRA_WIFI_LED, GPIOF_OUT_INIT_HIGH,
+			"wifi_led");
+	if(ret)
+		pr_warning("WIFI: could not request LED gpio!\n");
+	gpio_export(TEGRA_WIFI_LED, 0);
+}
+
 static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "uartd",	"pll_p",	216000000,	true },
@@ -167,6 +188,7 @@ static void __init tegra_paz00_init(void)
 
 	paz00_i2c_init();
 	paz00_usb_init();
+	paz00_wifi_init();
 }
 
 MACHINE_START(PAZ00, "Toshiba AC100 / Dynabook AZ")
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
index d4ff39d..a49543a 100644
--- a/arch/arm/mach-tegra/board-paz00.h
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -17,11 +17,18 @@
 #ifndef _MACH_TEGRA_BOARD_PAZ00_H
 #define _MACH_TEGRA_BOARD_PAZ00_H
 
+/* SDMMC */
 #define TEGRA_GPIO_SD1_CD		TEGRA_GPIO_PV5
 #define TEGRA_GPIO_SD1_WP		TEGRA_GPIO_PH1
 #define TEGRA_GPIO_SD1_POWER		TEGRA_GPIO_PT3
+
+/* ULPI */
 #define TEGRA_ULPI_RST			TEGRA_GPIO_PV0
 
+/* Wifi */
+#define TEGRA_WIFI_LED			TEGRA_GPIO_PD0
+#define TEGRA_WIFI_PWRN			TEGRA_GPIO_PK5
+
 void paz00_pinmux_init(void);
 
 #endif
-- 
1.7.4.2
