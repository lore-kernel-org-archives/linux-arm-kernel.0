From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Jun 2010 02:10:40 -0500
Subject: [PATCH 08/10] [ARM] tegra: harmony: Add harmony board file
In-Reply-To: <1275635441-17378-8-git-send-email-olof@lixom.net>
References: <3478yvr76gerav> <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
	<1275635441-17378-4-git-send-email-olof@lixom.net>
	<1275635441-17378-5-git-send-email-olof@lixom.net>
	<1275635441-17378-6-git-send-email-olof@lixom.net>
	<1275635441-17378-7-git-send-email-olof@lixom.net>
	<1275635441-17378-8-git-send-email-olof@lixom.net>
Message-ID: <1275635441-17378-9-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

v2: fixes from Russell King
	- include linux/io.h instead of mach/io.h

Olof:
	- Removed board-harmony-panel, will be merged with the FB driver.
	- Minor cleanups

Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Erik Gilling <konkers@android.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

remove panel file
---
 arch/arm/mach-tegra/Makefile               |    3 +
 arch/arm/mach-tegra/board-harmony-pinmux.c |  144 ++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c        |  129 +++++++++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.h        |   22 ++++
 4 files changed, 298 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-harmony.c
 create mode 100644 arch/arm/mach-tegra/board-harmony.h

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 5e47a71..51e9370 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -9,3 +9,6 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
+
+obj-${CONFIG_MACH_HARMONY}              += board-harmony.o
+obj-${CONFIG_MACH_HARMONY}              += board-harmony-pinmux.o
diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
new file mode 100644
index 0000000..50b15d5
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -0,0 +1,144 @@
+/*
+ * arch/arm/mach-tegra/board-harmony-pinmux.c
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
+#include <linux/kernel.h>
+#include <mach/pinmux.h>
+
+#include "board-harmony.h"
+
+static struct tegra_pingroup_config harmony_pinmux[] = {
+	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_OSC,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_UARTD,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
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
+	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
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
+void harmony_pinmux_init(void)
+{
+	tegra_pinmux_config_table(harmony_pinmux, ARRAY_SIZE(harmony_pinmux));
+}
diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegra/board-harmony.c
new file mode 100644
index 0000000..5e3bb7d
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony.c
@@ -0,0 +1,129 @@
+/*
+ * arch/arm/mach-tegra/board-harmony.c
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
+
+#include "board.h"
+#include "board-harmony.h"
+
+/* NVidia bootloader tags */
+#define ATAG_NVIDIA		0x41000801
+
+#define ATAG_NVIDIA_RM			0x1
+#define ATAG_NVIDIA_DISPLAY		0x2
+#define ATAG_NVIDIA_FRAMEBUFFER		0x3
+#define ATAG_NVIDIA_CHIPSHMOO		0x4
+#define ATAG_NVIDIA_CHIPSHMOOPHYS	0x5
+#define ATAG_NVIDIA_PRESERVED_MEM_0	0x10000
+#define ATAG_NVIDIA_PRESERVED_MEM_N	2
+#define ATAG_NVIDIA_FORCE_32		0x7fffffff
+
+struct tag_tegra {
+	__u32 bootarg_key;
+	__u32 bootarg_len;
+	char bootarg[1];
+};
+
+static int __init parse_tag_nvidia(const struct tag *tag)
+{
+
+	return 0;
+}
+__tagtable(ATAG_NVIDIA, parse_tag_nvidia);
+
+static struct plat_serial8250_port debug_uart_platform_data[] = {
+	{
+		.membase	= IO_ADDRESS(TEGRA_UARTD_BASE),
+		.mapbase	= TEGRA_UARTD_BASE,
+		.irq		= INT_UARTD,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= 216000000/16 * 16,
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
+static struct platform_device *harmony_devices[] __initdata = {
+	&debug_uart,
+};
+
+static void __init tegra_harmony_fixup(struct machine_desc *desc,
+				       struct tag *tags,
+				       char **cmdline, struct meminfo *mi)
+{
+	mi->nr_banks = 2;
+	mi->bank[0].start = PHYS_OFFSET;
+	mi->bank[0].node = PHYS_TO_NID(PHYS_OFFSET);
+	mi->bank[0].size = 448 * SZ_1M;
+	mi->bank[1].start = SZ_512M;
+	mi->bank[1].node = PHYS_TO_NID(SZ_512M);
+	mi->bank[1].size = SZ_512M;
+}
+
+static void __init tegra_harmony_init(void)
+{
+	struct clk *clk;
+
+	tegra_common_init();
+
+	clk = clk_get_sys(NULL, "pll_p");
+	clk_enable(clk);
+	clk_set_rate(clk, 216000000);
+
+	clk = clk_get_sys("uart.3", NULL);
+	clk_set_rate(clk, 216000000);
+	clk_enable(clk);
+
+	harmony_pinmux_init();
+
+	platform_add_devices(harmony_devices, ARRAY_SIZE(harmony_devices));
+}
+
+MACHINE_START(TEGRA_HARMONY, "tegra_harmony")
+	.boot_params  = 0x00000100,
+	.phys_io        = IO_APB_PHYS,
+	.io_pg_offst    = ((IO_APB_VIRT) >> 18) & 0xfffc,
+	.fixup		= tegra_harmony_fixup,
+	.init_irq       = tegra_init_irq,
+	.init_machine   = tegra_harmony_init,
+	.map_io         = tegra_map_common_io,
+	.timer          = &tegra_timer,
+MACHINE_END
diff --git a/arch/arm/mach-tegra/board-harmony.h b/arch/arm/mach-tegra/board-harmony.h
new file mode 100644
index 0000000..09ca775
--- /dev/null
+++ b/arch/arm/mach-tegra/board-harmony.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-tegra/board-harmony.h
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
+#ifndef _MACH_TEGRA_BOARD_HARMONY_H
+#define _MACH_TEGRA_BOARD_HARMONY_H
+
+void harmony_pinmux_init(void);
+
+#endif
-- 
1.5.6.5
