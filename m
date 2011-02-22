From: olof@lixom.net (Olof Johansson)
Date: Mon, 21 Feb 2011 23:55:17 -0600
Subject: [PATCH 6/6] ARM: tegra: add seaboard, wario and kaen boards
In-Reply-To: <1298354117-19097-1-git-send-email-olof@lixom.net>
References: <1298354117-19097-1-git-send-email-olof@lixom.net>
Message-ID: <1298354117-19097-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds board support for the Seaboard eval platform and some of the
derivatives that are very similar. Since they only differ in some very
minor ways, most of the code is shared.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Kconfig                 |   17 +++
 arch/arm/mach-tegra/Makefile                |    3 +
 arch/arm/mach-tegra/board-seaboard-pinmux.c |  179 ++++++++++++++++++++++++
 arch/arm/mach-tegra/board-seaboard.c        |  195 +++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-seaboard.h        |   38 +++++
 5 files changed, 432 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-seaboard-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-seaboard.c
 create mode 100644 arch/arm/mach-tegra/board-seaboard.h

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index cac8a79..8dd83ff 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -27,12 +27,29 @@ config MACH_HARMONY
        help
          Support for nVidia Harmony development platform
 
+config MACH_KAEN
+       bool "Kaen board"
+       select MACH_SEABOARD
+       help
+         Support for the Kaen version of Seaboard
+
+config MACH_SEABOARD
+       bool "Seaboard board family"
+       help
+         Support for nVidia Seaboard development platform
+
 config MACH_TRIMSLICE
        bool "TrimSlice board"
        select TEGRA_PCI
        help
          Support for CompuLab TrimSlice platform
 
+config MACH_WARIO
+       bool "Wario board"
+       select MACH_SEABOARD
+       help
+         Support for the Wario version of Seaboard
+
 choice
         prompt "Low-level debug console UART"
         default TEGRA_DEBUG_UART_NONE
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index c530dba..9bf39fa 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -22,5 +22,8 @@ obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
 obj-${CONFIG_MACH_HARMONY}              += board-harmony-pcie.o
 
+obj-${CONFIG_MACH_SEABOARD}             += board-seaboard.o
+obj-${CONFIG_MACH_SEABOARD}             += board-seaboard-pinmux.o
+
 obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice.o
 obj-${CONFIG_MACH_TRIMSLICE}            += board-trimslice-pinmux.o
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
new file mode 100644
index 0000000..57898ba
--- /dev/null
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (C) 2010 NVIDIA Corporation
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
+
+#include <mach/pinmux.h>
+#include <mach/pinmux-t2.h>
+#include <mach/gpio.h>
+
+#include "gpio-names.h"
+#include "board-seaboard.h"
+
+#define DEFAULT_DRIVE(_name)					\
+	{							\
+		.pingroup = TEGRA_DRIVE_PINGROUP_##_name,	\
+		.hsm = TEGRA_HSM_DISABLE,			\
+		.schmitt = TEGRA_SCHMITT_ENABLE,		\
+		.drive = TEGRA_DRIVE_DIV_1,			\
+		.pull_down = TEGRA_PULL_31,			\
+		.pull_up = TEGRA_PULL_31,			\
+		.slew_rising = TEGRA_SLEW_SLOWEST,		\
+		.slew_falling = TEGRA_SLEW_SLOWEST,		\
+	}
+
+static __initdata struct tegra_drive_pingroup_config seaboard_drive_pinmux[] = {
+	DEFAULT_DRIVE(SDIO1),
+};
+
+static __initdata struct tegra_pingroup_config seaboard_pinmux[] = {
+	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_UARTD,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
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
+
+
+
+static struct tegra_gpio_table gpio_table[] = {
+	{ .gpio = TEGRA_GPIO_PI5,	.enable = true	}, /* mmc2 cd	 */
+	{ .gpio = TEGRA_GPIO_PH1,	.enable = true	}, /* mmc2 wp	 */
+	{ .gpio = TEGRA_GPIO_PI6,	.enable = true	}, /* mmc2 pwr	 */
+	{ .gpio = TEGRA_GPIO_LIDSWITCH,	.enable = true	}, /* lid switch */
+	{ .gpio = TEGRA_GPIO_POWERKEY,	.enable = true	}, /* power key	 */
+};
+
+void __init seaboard_pinmux_init(void)
+{
+	tegra_pinmux_config_table(seaboard_pinmux, ARRAY_SIZE(seaboard_pinmux));
+
+	tegra_drive_pinmux_config_table(seaboard_drive_pinmux,
+					ARRAY_SIZE(seaboard_drive_pinmux));
+
+	tegra_gpio_config(gpio_table, ARRAY_SIZE(gpio_table));
+}
diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-tegra/board-seaboard.c
new file mode 100644
index 0000000..1c269d0
--- /dev/null
+++ b/arch/arm/mach-tegra/board-seaboard.c
@@ -0,0 +1,195 @@
+/*
+ * Copyright (c) 2010, 2011 NVIDIA Corporation.
+ * Copyright (C) 2010, 2011 Google, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
+#include <mach/io.h>
+#include <mach/iomap.h>
+#include <mach/irqs.h>
+#include <mach/sdhci.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include "board.h"
+#include "board-seaboard.h"
+#include "clock.h"
+#include "devices.h"
+#include "gpio-names.h"
+
+static struct plat_serial8250_port debug_uart_platform_data[] = {
+	{
+		/* Memory and IRQ filled in before registration */
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 216000000,
+	}, {
+		.flags		= 0,
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
+static __initdata struct tegra_clk_init_table seaboard_clk_init_table[] = {
+	/* name		parent		rate		enabled */
+	{ "uartb",	"pll_p",	216000000,	true},
+	{ "uartd",	"pll_p",	216000000,	true},
+	{ NULL,		NULL,		0,		0},
+};
+
+static struct gpio_keys_button seaboard_gpio_keys_buttons[] = {
+	{
+		.code		= SW_LID,
+		.gpio		= TEGRA_GPIO_LIDSWITCH,
+		.active_low	= 0,
+		.desc		= "Lid",
+		.type		= EV_SW,
+		.wakeup		= 1,
+		.debounce_interval = 1,
+	},
+	{
+		.code		= KEY_POWER,
+		.gpio		= TEGRA_GPIO_POWERKEY,
+		.active_low	= 1,
+		.desc		= "Power",
+		.type		= EV_KEY,
+		.wakeup		= 1,
+	},
+};
+
+static struct gpio_keys_platform_data seaboard_gpio_keys = {
+	.buttons	= seaboard_gpio_keys_buttons,
+	.nbuttons	= ARRAY_SIZE(seaboard_gpio_keys_buttons),
+};
+
+static struct platform_device seaboard_gpio_keys_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &seaboard_gpio_keys,
+	}
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata1 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata3 = {
+	.cd_gpio	= TEGRA_GPIO_PI5,
+	.wp_gpio	= TEGRA_GPIO_PH1,
+	.power_gpio	= TEGRA_GPIO_PI6,
+};
+
+static struct tegra_sdhci_platform_data sdhci_pdata4 = {
+	.cd_gpio	= -1,
+	.wp_gpio	= -1,
+	.power_gpio	= -1,
+	.is_8bit	= 1,
+};
+
+static struct platform_device *seaboard_devices[] __initdata = {
+	&debug_uart,
+	&tegra_pmu_device,
+	&tegra_sdhci_device1,
+	&tegra_sdhci_device3,
+	&tegra_sdhci_device4,
+	&seaboard_gpio_keys_device,
+};
+
+static void __init __tegra_seaboard_init(void)
+{
+	seaboard_pinmux_init();
+
+	tegra_common_init();
+
+	tegra_clk_init_from_table(seaboard_clk_init_table);
+
+	tegra_sdhci_device1.dev.platform_data = &sdhci_pdata1;
+	tegra_sdhci_device3.dev.platform_data = &sdhci_pdata3;
+	tegra_sdhci_device4.dev.platform_data = &sdhci_pdata4;
+
+	platform_add_devices(seaboard_devices, ARRAY_SIZE(seaboard_devices));
+}
+
+static void __init tegra_seaboard_init(void)
+{
+	/* Seaboard uses UARTD for the debug port. */
+	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTD_BASE);
+	debug_uart_platform_data[0].mapbase = TEGRA_UARTD_BASE;
+	debug_uart_platform_data[0].irq = INT_UARTD;
+
+	__tegra_seaboard_init();
+}
+
+static void __init tegra_kaen_init(void)
+{
+	/* Kaen uses UARTB for the debug port. */
+	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTB_BASE);
+	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
+	debug_uart_platform_data[0].irq = INT_UARTB;
+
+	__tegra_seaboard_init();
+}
+
+static void __init tegra_wario_init(void)
+{
+	/* Wario uses UARTB for the debug port. */
+	debug_uart_platform_data[0].membase = IO_ADDRESS(TEGRA_UARTB_BASE);
+	debug_uart_platform_data[0].mapbase = TEGRA_UARTB_BASE;
+	debug_uart_platform_data[0].irq = INT_UARTB;
+
+	__tegra_seaboard_init();
+}
+
+
+MACHINE_START(SEABOARD, "seaboard")
+	.boot_params    = 0x00000100,
+	.map_io         = tegra_map_common_io,
+	.init_irq       = tegra_init_irq,
+	.timer          = &tegra_timer,
+	.init_machine   = tegra_seaboard_init,
+MACHINE_END
+
+MACHINE_START(KAEN, "kaen")
+	.boot_params    = 0x00000100,
+	.map_io         = tegra_map_common_io,
+	.init_irq       = tegra_init_irq,
+	.timer          = &tegra_timer,
+	.init_machine   = tegra_kaen_init,
+MACHINE_END
+
+MACHINE_START(WARIO, "wario")
+	.boot_params    = 0x00000100,
+	.map_io         = tegra_map_common_io,
+	.init_irq       = tegra_init_irq,
+	.timer          = &tegra_timer,
+	.init_machine   = tegra_wario_init,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/board-seaboard.h b/arch/arm/mach-tegra/board-seaboard.h
new file mode 100644
index 0000000..a098e35
--- /dev/null
+++ b/arch/arm/mach-tegra/board-seaboard.h
@@ -0,0 +1,38 @@
+/*
+ * arch/arm/mach-tegra/board-seaboard.h
+ *
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
+#ifndef _MACH_TEGRA_BOARD_SEABOARD_H
+#define _MACH_TEGRA_BOARD_SEABOARD_H
+
+#define TEGRA_GPIO_LIDSWITCH		TEGRA_GPIO_PC7
+#define TEGRA_GPIO_USB1			TEGRA_GPIO_PD0
+#define TEGRA_GPIO_POWERKEY		TEGRA_GPIO_PV2
+#define TEGRA_GPIO_BACKLIGHT		TEGRA_GPIO_PD4
+#define TEGRA_GPIO_LVDS_SHUTDOWN	TEGRA_GPIO_PB2
+#define TEGRA_GPIO_BACKLIGHT_PWM	TEGRA_GPIO_PU5
+#define TEGRA_GPIO_BACKLIGHT_VDD	TEGRA_GPIO_PW0
+#define TEGRA_GPIO_EN_VDD_PNL		TEGRA_GPIO_PC6
+#define TEGRA_GPIO_MAGNETOMETER		TEGRA_GPIO_PN5
+#define TEGRA_GPIO_ISL29018_IRQ		TEGRA_GPIO_PZ2
+#define TEGRA_GPIO_AC_ONLINE		TEGRA_GPIO_PV3
+
+#define TPS_GPIO_BASE			TEGRA_NR_GPIOS
+
+#define TPS_GPIO_WWAN_PWR		(TPS_GPIO_BASE + 2)
+
+void seaboard_pinmux_init(void);
+
+#endif
-- 
1.7.0.4
