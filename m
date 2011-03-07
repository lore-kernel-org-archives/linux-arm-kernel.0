From: marvin24@gmx.de (Marc Dietrich)
Date: Mon,  7 Mar 2011 21:01:31 +0100
Subject: [PATCH v2 1/2] Add initial support for the Toshiba AC100/Dynabook AZ
	netbook
In-Reply-To: <cover.1299526691.git.marvin24@gmx.de>
References: <cover.1299526691.git.marvin24@gmx.de>
Message-ID: <2717b8b15dfde5e2db0eed4c9b89dd8d4fee5e68.1299526691.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the config infrastructure, the pinmux and basic
board setup code for PAZ00 (name of board inside the AC100/AZ).

Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 arch/arm/mach-tegra/Kconfig              |    5 +
 arch/arm/mach-tegra/Makefile             |    3 +
 arch/arm/mach-tegra/board-paz00-pinmux.c |  157 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.c        |  128 ++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |   29 ++++++
 5 files changed, 322 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index b94e52d..8df6499 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -33,6 +33,11 @@ config MACH_KAEN
        help
          Support for the Kaen version of Seaboard
 
+config MACH_PAZ00
+       bool "Paz00 board"
+       help
+         Support for the Toshiba AC100/Dynabook AZ netbook
+
 config MACH_SEABOARD
        bool "Seaboard board"
        help
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9bf39fa..673651f 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -22,6 +22,9 @@ obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
 
+obj-${CONFIG_MACH_PAZ00}		+= board-paz00.o
+obj-${CONFIG_MACH_PAZ00}		+= board-paz00-pinmux.o
+
 obj-${CONFIG_MACH_SEABOARD}             += board-seaboard.o
 obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
 
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
new file mode 100644
index 0000000..2643d1b
--- /dev/null
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -0,0 +1,157 @@
+/*
+ * arch/arm/mach-tegra/board-paz00-pinmux.c
+ *
+ * Copyright (C) 2010 Marc Dietrich <marvin24@gmx.de>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+#include <mach/pinmux.h>
+
+#include "gpio-names.h"
+#include "board-paz00.h"
+
+static struct tegra_pingroup_config paz00_pinmux[] = {
+	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_PLLC_OUT1,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_OWR,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_TWC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPI4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPI4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_SPDIF,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+};
+
+static struct tegra_gpio_table gpio_table[] = {
+	{ .gpio = TEGRA_GPIO_SD1_CD,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD1_WP,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD1_POWER,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_CD,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_WP,	.enable = true	},
+	{ .gpio = TEGRA_GPIO_SD4_POWER,	.enable = true	},
+};
+
+void paz00_pinmux_init(void)
+{
+	tegra_pinmux_config_table(paz00_pinmux, ARRAY_SIZE(paz00_pinmux));
+
+	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
+}
diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/board-paz00.c
new file mode 100644
index 0000000..57e50a8
--- /dev/null
+++ b/arch/arm/mach-tegra/board-paz00.c
@@ -0,0 +1,128 @@
+/*
+ * arch/arm/mach-tegra/board-paz00.c
+ *
+ * Copyright (C) 2011 Marc Dietrich <marvin24@gmx.de>
+ *
+ * Based on board-harmony.c
+ * Copyright (C) 2010 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/pda_power.h>
+#include <linux/io.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <asm/setup.h>
+
+#include <mach/iomap.h>
+#include <mach/irqs.h>
+#include <mach/sdhci.h>
+
+#include "board.h"
+#include "board-paz00.h"
+#include "clock.h"
+#include "devices.h"
+#include "gpio-names.h"
+
+static struct plat_serial8250_port debug_uart_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(TEGRA_UARTD_BASE),
+		.mapbase	= TEGRA_UARTD_BASE,
+		.irq		= INT_UARTD,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 216000000,
+	}, {
+		.flags		= 0
+	}
+};
+
+static struct platform_device debug_uart = {
+	.name = "serial8250",
+	.id = PLAT8250_DEV_PLATFORM,
+	.dev = {
+		.platform_data = debug_uart_platform_data,
+	},
+};
+
+static struct platform_device *paz00_devices[] __initdata = {
+	&debug_uart,
+	&tegra_sdhci_device1,
+	&tegra_sdhci_device2,
+	&tegra_sdhci_device4,
+};
+
+static void __init tegra_paz00_fixup(struct machine_desc *desc,
+	struct tag *tags, char **cmdline, struct meminfo *mi)
+{
+	mi->nr_banks = 1;
+	mi->bank[0].start = PHYS_OFFSET;
+	mi->bank[0].size = 448 * SZ_1M;
+}
+
+static __initdata struct tegra_clk_init_table paz00_clk_init_table[] = {
+	/* name		parent		rate		enabled */
+	{ "uartd",	"pll_p",	216000000,	true },
+	{ NULL,		NULL,		0,		0},
+};
+
+
+static struct tegra_sdhci_platform_data sdhci_pdata1 = {
+	.cd_gpio	= TEGRA_GPIO_SD1_CD,
+	.wp_gpio	= TEGRA_GPIO_SD1_WP,
+	.power_gpio	= TEGRA_GPIO_SD1_POWER,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata2 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata4 = {
+	.cd_gpio	= TEGRA_GPIO_SD4_CD,
+	.wp_gpio	= TEGRA_GPIO_SD4_WP,
+	.power_gpio	= TEGRA_GPIO_SD4_POWER,
+	.is_8bit	= 1,
+};
+
+static void __init tegra_paz00_init(void)
+{
+	tegra_clk_init_from_table(paz00_clk_init_table);
+
+	paz00_pinmux_init();
+
+	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
+	tegra_sdhci_device2.dev.platform_data = &sdhci_pdata2;
+	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
+
+	platform_add_devices(paz00_devices, ARRAY_SIZE(paz00_devices));
+}
+
+MACHINE_START(PAZ00, "paz00")
+	.boot_params	= 0x00000100,
+	.fixup		= tegra_paz00_fixup,
+	.map_io         = tegra_map_common_io,
+	.init_early	= tegra_init_early,
+	.init_irq       = tegra_init_irq,
+	.timer          = &tegra_timer,
+	.init_machine   = tegra_paz00_init,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/board-paz00.h b/arch/arm/mach-tegra/board-paz00.h
new file mode 100644
index 0000000..da193ca
--- /dev/null
+++ b/arch/arm/mach-tegra/board-paz00.h
@@ -0,0 +1,29 @@
+/*
+ * arch/arm/mach-tegra/board-paz00.h
+ *
+ * Copyright (C) 2010 Marc Dietrich <marvin24@gmx.de>
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _MACH_TEGRA_BOARD_PAZ00_H
+#define _MACH_TEGRA_BOARD_PAZ00_H
+
+#define TEGRA_GPIO_SD1_CD               TEGRA_GPIO_PV5
+#define TEGRA_GPIO_SD1_WP               TEGRA_GPIO_PH1
+#define TEGRA_GPIO_SD1_POWER            TEGRA_GPIO_PT3
+#define TEGRA_GPIO_SD4_CD               TEGRA_GPIO_PH2
+#define TEGRA_GPIO_SD4_WP               TEGRA_GPIO_PH3
+#define TEGRA_GPIO_SD4_POWER            TEGRA_GPIO_PI6
+
+void paz00_pinmux_init(void);
+
+#endif
-- 
1.7.1
