From: swarren@nvidia.com (Stephen Warren)
Date: Fri,  4 Mar 2011 22:44:29 -0700
Subject: [PATCH 3/3] ARM: tegra: Harmony: Beginnings of audio support
In-Reply-To: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
References: <1299303869-7827-1-git-send-email-swarren@nvidia.com>
Message-ID: <1299303869-7827-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change includes everything required to enable audio on Harmony, except
those parts which rely on code not currently in Tegra's for-next branch, i.e.
except those parts which rely on merges of the Tegra I2C driver or latest
ASoC subsystem.

* Define GPIO names for audio-related GPIOs
* Set up platform data and platform device for ASoC machine driver
* Register audio-related platform devices
* Initialize audio-related clocks
* Correctly configure pinmux and GPIO enables for audio-related pins

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/board-harmony-pinmux.c |   16 ++++++++++------
 arch/arm/mach-tegra/board-harmony.c        |   26 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.h        |    7 +++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 3ada474..4d63e2e 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -27,11 +27,11 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_OSC,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
 	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
@@ -114,13 +114,13 @@ static struct tegra_pingroup_config harmony_pinmux[] = {
 	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
 	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
@@ -147,6 +147,10 @@ static struct tegra_gpio_table gpio_table[] = {
 	{ .gpio = TEGRA_GPIO_SD4_CD,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD4_WP,		.enable = true	},
 	{ .gpio = TEGRA_GPIO_SD4_POWER,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_CDC_IRQ,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_HP_DET,		.enable = true	},
+	{ .gpio = TEGRA_GPIO_INT_MIC_EN,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_EXT_MIC_EN,	.enable = true	},
 };
 
 void harmony_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
index 2c4a234..38c2ab8 100644
--- a/arch/arm/mach-tegra/board-harmony.c
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/board-harmony.c
  *
  * Copyright (C) 2010 Google, Inc.
+ * Copyright (C) 2011 NVIDIA, Inc.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -22,12 +23,14 @@
 #include <linux/dma-mapping.h>
 #include <linux/pda_power.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <asm/setup.h>
 
+#include <mach/harmony_audio.h>
 #include <mach/iomap.h>
 #include <mach/irqs.h>
 #include <mach/sdhci.h>
@@ -60,11 +63,30 @@ static struct platform_device debug_uart = {
 	},
 };
 
+static struct harmony_audio_platform_data harmony_audio_pdata = {
+	.gpio_spkr_en		= TEGRA_GPIO_SPKR_EN,
+	.gpio_hp_det		= TEGRA_GPIO_HP_DET,
+	.gpio_int_mic_en	= TEGRA_GPIO_INT_MIC_EN,
+	.gpio_ext_mic_en	= TEGRA_GPIO_EXT_MIC_EN,
+};
+
+static struct platform_device harmony_audio_device = {
+	.name	= "tegra-snd-harmony",
+	.id	= 0,
+	.dev	= {
+		.platform_data  = &harmony_audio_pdata,
+	},
+};
+
 static struct platform_device *harmony_devices[] __initdata = {
 	&debug_uart,
 	&tegra_sdhci_device1,
 	&tegra_sdhci_device2,
 	&tegra_sdhci_device4,
+	&tegra_i2s_device1,
+	&tegra_das_device,
+	&tegra_pcm_device,
+	&harmony_audio_device,
 };
 
 static void __init tegra_harmony_fixup(struct machine_desc *desc,
@@ -80,6 +102,10 @@ static void __init tegra_harmony_fixup(struct machine_desc *desc,
 static __initdata struct tegra_clk_init_table harmony_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "uartd",	"pll_p",	216000000,	true },
+	{ "pll_a",	"pll_p_out1",	56448000,	true },
+	{ "pll_a_out0",	"pll_a",	11289600,	true },
+	{ "cdev1",	NULL,		0,		true },
+	{ "i2s1",	"pll_a_out0",	11289600,	false},
 	{ NULL,		NULL,		0,		0},
 };
 
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
index 4fe33b8..9243521 100644
--- a/arch/arm/mach-tegra/board-harmony.h
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -17,12 +17,19 @@
 #ifndef _MACH_TEGRA_BOARD_HARMONY_H
 #define _MACH_TEGRA_BOARD_HARMONY_H
 
+#define HARMONY_GPIO_WM8903(_x_)	(TEGRA_NR_GPIOS + (_x_))
+
 #define TEGRA_GPIO_SD2_CD		TEGRA_GPIO_PI5
 #define TEGRA_GPIO_SD2_WP		TEGRA_GPIO_PH1
 #define TEGRA_GPIO_SD2_POWER		TEGRA_GPIO_PT3
 #define TEGRA_GPIO_SD4_CD		TEGRA_GPIO_PH2
 #define TEGRA_GPIO_SD4_WP		TEGRA_GPIO_PH3
 #define TEGRA_GPIO_SD4_POWER		TEGRA_GPIO_PI6
+#define TEGRA_GPIO_CDC_IRQ		TEGRA_GPIO_PX3
+#define TEGRA_GPIO_SPKR_EN		HARMONY_GPIO_WM8903(2)
+#define TEGRA_GPIO_HP_DET		TEGRA_GPIO_PW2
+#define TEGRA_GPIO_INT_MIC_EN		TEGRA_GPIO_PX0
+#define TEGRA_GPIO_EXT_MIC_EN		TEGRA_GPIO_PX1
 
 void harmony_pinmux_init(void);
 
-- 
1.7.1
