From: olof@lixom.net (Olof Johansson)
Date: Fri,  4 Jun 2010 02:10:39 -0500
Subject: [PATCH 07/10] [ARM] tegra: add pinmux support
In-Reply-To: <1275635441-17378-7-git-send-email-olof@lixom.net>
References: <3478yvr76gerav> <1275635441-17378-1-git-send-email-olof@lixom.net>
	<1275635441-17378-2-git-send-email-olof@lixom.net>
	<1275635441-17378-3-git-send-email-olof@lixom.net>
	<1275635441-17378-4-git-send-email-olof@lixom.net>
	<1275635441-17378-5-git-send-email-olof@lixom.net>
	<1275635441-17378-6-git-send-email-olof@lixom.net>
	<1275635441-17378-7-git-send-email-olof@lixom.net>
Message-ID: <1275635441-17378-8-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Erik Gilling <konkers@android.com>

v2: fixes from Russell King
	- include linux/io.h instead of asm/io.h

Olof:
	- checkpatch cleanups
	- switched from typedefs to regular enums

Signed-off-by: Erik Gilling <konkers@android.com>
Signed-off-by: Colin Cross <ccross@android.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Makefile              |    2 +
 arch/arm/mach-tegra/include/mach/pinmux.h |  241 +++++++++++++
 arch/arm/mach-tegra/pinmux.c              |  550 +++++++++++++++++++++++++++++
 3 files changed, 793 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux.h
 create mode 100644 arch/arm/mach-tegra/pinmux.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 122f7dc..5e47a71 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -4,6 +4,8 @@ obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
 obj-y                                   += gpio.o
+obj-y                                   += pinmux.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
new file mode 100644
index 0000000..b52c35c
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/pinmux.h
@@ -0,0 +1,241 @@
+/*
+ * linux/arch/arm/mach-tegra/include/mach/pinmux.h
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
+#ifndef __MACH_TEGRA_PINMUX_H
+#define __MACH_TEGRA_PINMUX_H
+
+enum tegra_pingroup {
+	TEGRA_PINGROUP_ATA = 0,
+	TEGRA_PINGROUP_ATB,
+	TEGRA_PINGROUP_ATC,
+	TEGRA_PINGROUP_ATD,
+	TEGRA_PINGROUP_ATE,
+	TEGRA_PINGROUP_CDEV1,
+	TEGRA_PINGROUP_CDEV2,
+	TEGRA_PINGROUP_CRTP,
+	TEGRA_PINGROUP_CSUS,
+	TEGRA_PINGROUP_DAP1,
+	TEGRA_PINGROUP_DAP2,
+	TEGRA_PINGROUP_DAP3,
+	TEGRA_PINGROUP_DAP4,
+	TEGRA_PINGROUP_DDC,
+	TEGRA_PINGROUP_DTA,
+	TEGRA_PINGROUP_DTB,
+	TEGRA_PINGROUP_DTC,
+	TEGRA_PINGROUP_DTD,
+	TEGRA_PINGROUP_DTE,
+	TEGRA_PINGROUP_DTF,
+	TEGRA_PINGROUP_GMA,
+	TEGRA_PINGROUP_GMB,
+	TEGRA_PINGROUP_GMC,
+	TEGRA_PINGROUP_GMD,
+	TEGRA_PINGROUP_GME,
+	TEGRA_PINGROUP_GPU,
+	TEGRA_PINGROUP_GPU7,
+	TEGRA_PINGROUP_GPV,
+	TEGRA_PINGROUP_HDINT,
+	TEGRA_PINGROUP_I2CP,
+	TEGRA_PINGROUP_IRRX,
+	TEGRA_PINGROUP_IRTX,
+	TEGRA_PINGROUP_KBCA,
+	TEGRA_PINGROUP_KBCB,
+	TEGRA_PINGROUP_KBCC,
+	TEGRA_PINGROUP_KBCD,
+	TEGRA_PINGROUP_KBCE,
+	TEGRA_PINGROUP_KBCF,
+	TEGRA_PINGROUP_LCSN,
+	TEGRA_PINGROUP_LD0,
+	TEGRA_PINGROUP_LD1,
+	TEGRA_PINGROUP_LD10,
+	TEGRA_PINGROUP_LD11,
+	TEGRA_PINGROUP_LD12,
+	TEGRA_PINGROUP_LD13,
+	TEGRA_PINGROUP_LD14,
+	TEGRA_PINGROUP_LD15,
+	TEGRA_PINGROUP_LD16,
+	TEGRA_PINGROUP_LD17,
+	TEGRA_PINGROUP_LD2,
+	TEGRA_PINGROUP_LD3,
+	TEGRA_PINGROUP_LD4,
+	TEGRA_PINGROUP_LD5,
+	TEGRA_PINGROUP_LD6,
+	TEGRA_PINGROUP_LD7,
+	TEGRA_PINGROUP_LD8,
+	TEGRA_PINGROUP_LD9,
+	TEGRA_PINGROUP_LDC,
+	TEGRA_PINGROUP_LDI,
+	TEGRA_PINGROUP_LHP0,
+	TEGRA_PINGROUP_LHP1,
+	TEGRA_PINGROUP_LHP2,
+	TEGRA_PINGROUP_LHS,
+	TEGRA_PINGROUP_LM0,
+	TEGRA_PINGROUP_LM1,
+	TEGRA_PINGROUP_LPP,
+	TEGRA_PINGROUP_LPW0,
+	TEGRA_PINGROUP_LPW1,
+	TEGRA_PINGROUP_LPW2,
+	TEGRA_PINGROUP_LSC0,
+	TEGRA_PINGROUP_LSC1,
+	TEGRA_PINGROUP_LSCK,
+	TEGRA_PINGROUP_LSDA,
+	TEGRA_PINGROUP_LSDI,
+	TEGRA_PINGROUP_LSPI,
+	TEGRA_PINGROUP_LVP0,
+	TEGRA_PINGROUP_LVP1,
+	TEGRA_PINGROUP_LVS,
+	TEGRA_PINGROUP_OWC,
+	TEGRA_PINGROUP_PMC,
+	TEGRA_PINGROUP_PTA,
+	TEGRA_PINGROUP_RM,
+	TEGRA_PINGROUP_SDB,
+	TEGRA_PINGROUP_SDC,
+	TEGRA_PINGROUP_SDD,
+	TEGRA_PINGROUP_SDIO1,
+	TEGRA_PINGROUP_SLXA,
+	TEGRA_PINGROUP_SLXC,
+	TEGRA_PINGROUP_SLXD,
+	TEGRA_PINGROUP_SLXK,
+	TEGRA_PINGROUP_SPDI,
+	TEGRA_PINGROUP_SPDO,
+	TEGRA_PINGROUP_SPIA,
+	TEGRA_PINGROUP_SPIB,
+	TEGRA_PINGROUP_SPIC,
+	TEGRA_PINGROUP_SPID,
+	TEGRA_PINGROUP_SPIE,
+	TEGRA_PINGROUP_SPIF,
+	TEGRA_PINGROUP_SPIG,
+	TEGRA_PINGROUP_SPIH,
+	TEGRA_PINGROUP_UAA,
+	TEGRA_PINGROUP_UAB,
+	TEGRA_PINGROUP_UAC,
+	TEGRA_PINGROUP_UAD,
+	TEGRA_PINGROUP_UCA,
+	TEGRA_PINGROUP_UCB,
+	TEGRA_PINGROUP_UDA,
+	/* these pin groups only have pullup and pull down control */
+	TEGRA_PINGROUP_CK32,
+	TEGRA_PINGROUP_DDRC,
+	TEGRA_PINGROUP_PMCA,
+	TEGRA_PINGROUP_PMCB,
+	TEGRA_PINGROUP_PMCC,
+	TEGRA_PINGROUP_PMCD,
+	TEGRA_PINGROUP_PMCE,
+	TEGRA_PINGROUP_XM2C,
+	TEGRA_PINGROUP_XM2D,
+	TEGRA_MAX_PINGROUP,
+};
+
+enum tegra_mux_func {
+	TEGRA_MUX_RSVD = 0x8000,
+	TEGRA_MUX_RSVD1 = 0x8000,
+	TEGRA_MUX_RSVD2 = 0x8001,
+	TEGRA_MUX_RSVD3 = 0x8002,
+	TEGRA_MUX_RSVD4 = 0x8003,
+	TEGRA_MUX_NONE = -1,
+	TEGRA_MUX_AHB_CLK,
+	TEGRA_MUX_APB_CLK,
+	TEGRA_MUX_AUDIO_SYNC,
+	TEGRA_MUX_CRT,
+	TEGRA_MUX_DAP1,
+	TEGRA_MUX_DAP2,
+	TEGRA_MUX_DAP3,
+	TEGRA_MUX_DAP4,
+	TEGRA_MUX_DAP5,
+	TEGRA_MUX_DISPLAYA,
+	TEGRA_MUX_DISPLAYB,
+	TEGRA_MUX_EMC_TEST0_DLL,
+	TEGRA_MUX_EMC_TEST1_DLL,
+	TEGRA_MUX_GMI,
+	TEGRA_MUX_GMI_INT,
+	TEGRA_MUX_HDMI,
+	TEGRA_MUX_I2C,
+	TEGRA_MUX_I2C2,
+	TEGRA_MUX_I2C3,
+	TEGRA_MUX_IDE,
+	TEGRA_MUX_IRDA,
+	TEGRA_MUX_KBC,
+	TEGRA_MUX_MIO,
+	TEGRA_MUX_MIPI_HS,
+	TEGRA_MUX_NAND,
+	TEGRA_MUX_OSC,
+	TEGRA_MUX_OWR,
+	TEGRA_MUX_PCIE,
+	TEGRA_MUX_PLLA_OUT,
+	TEGRA_MUX_PLLC_OUT1,
+	TEGRA_MUX_PLLM_OUT1,
+	TEGRA_MUX_PLLP_OUT2,
+	TEGRA_MUX_PLLP_OUT3,
+	TEGRA_MUX_PLLP_OUT4,
+	TEGRA_MUX_PWM,
+	TEGRA_MUX_PWR_INTR,
+	TEGRA_MUX_PWR_ON,
+	TEGRA_MUX_RTCK,
+	TEGRA_MUX_SDIO1,
+	TEGRA_MUX_SDIO2,
+	TEGRA_MUX_SDIO3,
+	TEGRA_MUX_SDIO4,
+	TEGRA_MUX_SFLASH,
+	TEGRA_MUX_SPDIF,
+	TEGRA_MUX_SPI1,
+	TEGRA_MUX_SPI2,
+	TEGRA_MUX_SPI2_ALT,
+	TEGRA_MUX_SPI3,
+	TEGRA_MUX_SPI4,
+	TEGRA_MUX_TRACE,
+	TEGRA_MUX_TWC,
+	TEGRA_MUX_UARTA,
+	TEGRA_MUX_UARTB,
+	TEGRA_MUX_UARTC,
+	TEGRA_MUX_UARTD,
+	TEGRA_MUX_UARTE,
+	TEGRA_MUX_ULPI,
+	TEGRA_MUX_VI,
+	TEGRA_MUX_VI_SENSOR_CLK,
+	TEGRA_MUX_XIO,
+	TEGRA_MAX_MUX,
+};
+
+enum tegra_pullupdown {
+	TEGRA_PUPD_NORMAL = 0,
+	TEGRA_PUPD_PULL_DOWN,
+	TEGRA_PUPD_PULL_UP,
+};
+
+enum tegra_tristate {
+	TEGRA_TRI_NORMAL = 0,
+	TEGRA_TRI_TRISTATE = 1,
+};
+
+struct tegra_pingroup_config {
+	enum tegra_pingroup	pingroup;
+	enum tegra_mux_func	func;
+	enum tegra_pullupdown	pupd;
+	enum tegra_tristate	tristate;
+};
+
+int tegra_pinmux_set_func(enum tegra_pingroup pg, enum tegra_mux_func func);
+int tegra_pinmux_set_tristate(enum tegra_pingroup pg, enum tegra_tristate tristate);
+int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg, enum tegra_pullupdown pupd);
+
+void tegra_pinmux_config_pingroup(enum tegra_pingroup pingroup,
+				  enum tegra_mux_func func,
+				  enum tegra_pullupdown pupd,
+				  enum tegra_tristate tristate);
+
+void tegra_pinmux_config_table(struct tegra_pingroup_config *config, int len);
+
+#endif
+
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
new file mode 100644
index 0000000..34a403e
--- /dev/null
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -0,0 +1,550 @@
+/*
+ * linux/arch/arm/mach-tegra/pinmux.c
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
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+
+#include <mach/iomap.h>
+#include <mach/pinmux.h>
+
+
+#define TEGRA_TRI_STATE(x)	(0x14 + (4 * (x)))
+#define TEGRA_PP_MUX_CTL(x)	(0x80 + (4 * (x)))
+#define TEGRA_PP_PU_PD(x)	(0xa0 + (4 * (x)))
+
+#define REG_A 0
+#define REG_B 1
+#define REG_C 2
+#define REG_D 3
+#define REG_E 4
+#define REG_F 5
+#define REG_G 6
+
+#define REG_N -1
+
+struct tegra_pingroup_desc {
+	const char *name;
+	int funcs[4];
+	s8 tri_reg;	/* offset into the TRISTATE_REG_* register bank */
+	s8 tri_bit;	/* offset into the TRISTATE_REG_* register bit */
+	s8 mux_reg;	/* offset into the PIN_MUX_CTL_* register bank */
+	s8 mux_bit;	/* offset into the PIN_MUX_CTL_* register bit */
+	s8 pupd_reg;	/* offset into the PULL_UPDOWN_REG_* register bank */
+	s8 pupd_bit;	/* offset into the PULL_UPDOWN_REG_* register bit */
+};
+
+#define PINGROUP(pg_name, f0, f1, f2, f3,			\
+		 tri_r, tri_b, mux_r, mux_b, pupd_r, pupd_b)	\
+	[TEGRA_PINGROUP_ ## pg_name] = {			\
+		.name = #pg_name,				\
+		.funcs = {					\
+			TEGRA_MUX_ ## f0,			\
+			TEGRA_MUX_ ## f1,			\
+			TEGRA_MUX_ ## f2,			\
+			TEGRA_MUX_ ## f3,			\
+		},						\
+		.tri_reg = REG_ ## tri_r,			\
+		.tri_bit = tri_b,				\
+		.mux_reg = REG_ ## mux_r,			\
+		.mux_bit = mux_b,				\
+		.pupd_reg = REG_ ## pupd_r,			\
+		.pupd_bit = pupd_b,				\
+	}
+
+static const struct tegra_pingroup_desc pingroups[TEGRA_MAX_PINGROUP] = {
+	PINGROUP(ATA,   IDE,       NAND,      GMI,       RSVD,          A, 0,  A, 24, A, 0),
+	PINGROUP(ATB,   IDE,       NAND,      GMI,       SDIO4,         A, 1,  A, 16, A, 2),
+	PINGROUP(ATC,   IDE,       NAND,      GMI,       SDIO4,         A, 2,  A, 22, A, 4),
+	PINGROUP(ATD,   IDE,       NAND,      GMI,       SDIO4,         A, 3,  A, 20, A, 6),
+	PINGROUP(ATE,   IDE,       NAND,      GMI,       RSVD,          B, 25, A, 12, A, 8),
+	PINGROUP(CDEV1, OSC,       PLLA_OUT,  PLLM_OUT1, AUDIO_SYNC,    A, 4,  C, 2,  C, 0),
+	PINGROUP(CDEV2, OSC,       AHB_CLK,   APB_CLK,   PLLP_OUT4,     A, 5,  C, 4,  C, 2),
+	PINGROUP(CRTP,  CRT,       RSVD,      RSVD,      RSVD,          D, 14, G, 20, B, 24),
+	PINGROUP(CSUS,  PLLC_OUT1, PLLP_OUT2, PLLP_OUT3, VI_SENSOR_CLK, A, 6,  C, 6,  D, 24),
+	PINGROUP(DAP1,  DAP1,      RSVD,      GMI,       SDIO2,         A, 7,  C, 20, A, 10),
+	PINGROUP(DAP2,  DAP2,      TWC,       RSVD,      GMI,           A, 8,  C, 22, A, 12),
+	PINGROUP(DAP3,  DAP3,      RSVD,      RSVD,      RSVD,          A, 9,  C, 24, A, 14),
+	PINGROUP(DAP4,  DAP4,      RSVD,      GMI,       RSVD,          A, 10, C, 26, A, 16),
+	PINGROUP(DDC,   I2C2,      RSVD,      RSVD,      RSVD,          B, 31, C, 0,  E, 28),
+	PINGROUP(DTA,   RSVD,      SDIO2,     VI,        RSVD,          A, 11, B, 20, A, 18),
+	PINGROUP(DTB,   RSVD,      RSVD,      VI,        SPI1,          A, 12, B, 22, A, 20),
+	PINGROUP(DTC,   RSVD,      RSVD,      VI,        RSVD,          A, 13, B, 26, A, 22),
+	PINGROUP(DTD,   RSVD,      SDIO2,     VI,        RSVD,          A, 14, B, 28, A, 24),
+	PINGROUP(DTE,   RSVD,      RSVD,      VI,        SPI1,          A, 15, B, 30, A, 26),
+	PINGROUP(DTF,   I2C3,      RSVD,      VI,        RSVD,          D, 12, G, 30, A, 28),
+	PINGROUP(GMA,   UARTE,     SPI3,      GMI,       SDIO4,         A, 28, B, 0,  E, 20),
+	PINGROUP(GMB,   IDE,       NAND,      GMI,       GMI_INT,       B, 29, C, 28, E, 22),
+	PINGROUP(GMC,   UARTD,     SPI4,      GMI,       SFLASH,        A, 29, B, 2,  E, 24),
+	PINGROUP(GMD,   RSVD,      NAND,      GMI,       SFLASH,        B, 30, C, 30, E, 26),
+	PINGROUP(GME,   RSVD,      DAP5,      GMI,       SDIO4,         B, 0,  D, 0,  C, 24),
+	PINGROUP(GPU,   PWM,       UARTA,     GMI,       RSVD,          A, 16, D, 4,  B, 20),
+	PINGROUP(GPU7,  RTCK,      RSVD,      RSVD,      RSVD,          D, 11, G, 28, B, 6),
+	PINGROUP(GPV,   PCIE,      RSVD,      RSVD,      RSVD,          A, 17, D, 2,  A, 30),
+	PINGROUP(HDINT, HDMI,      RSVD,      RSVD,      RSVD,          C, 23, B, 4,  D, 22),
+	PINGROUP(I2CP,  I2C,       RSVD,      RSVD,      RSVD,          A, 18, C, 8,  B, 2),
+	PINGROUP(IRRX,  UARTA,     UARTB,     GMI,       SPI4,          A, 20, C, 18, C, 22),
+	PINGROUP(IRTX,  UARTA,     UARTB,     GMI,       SPI4,          A, 19, C, 16, C, 20),
+	PINGROUP(KBCA,  KBC,       NAND,      SDIO2,     EMC_TEST0_DLL, A, 22, C, 10, B, 8),
+	PINGROUP(KBCB,  KBC,       NAND,      SDIO2,     MIO,           A, 21, C, 12, B, 10),
+	PINGROUP(KBCC,  KBC,       NAND,      TRACE,     EMC_TEST1_DLL, B, 26, C, 14, B, 12),
+	PINGROUP(KBCD,  KBC,       NAND,      SDIO2,     MIO,           D, 10, G, 26, B, 14),
+	PINGROUP(KBCE,  KBC,       NAND,      OWR,       RSVD,          A, 26, A, 28, E, 2),
+	PINGROUP(KBCF,  KBC,       NAND,      TRACE,     MIO,           A, 27, A, 26, E, 0),
+	PINGROUP(LCSN,  DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          C, 31, E, 12, D, 20),
+	PINGROUP(LD0,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 0,  F, 0,  D, 12),
+	PINGROUP(LD1,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 1,  F, 2,  D, 12),
+	PINGROUP(LD10,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 10, F, 20, D, 12),
+	PINGROUP(LD11,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 11, F, 22, D, 12),
+	PINGROUP(LD12,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 12, F, 24, D, 12),
+	PINGROUP(LD13,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 13, F, 26, D, 12),
+	PINGROUP(LD14,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 14, F, 28, D, 12),
+	PINGROUP(LD15,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 15, F, 30, D, 12),
+	PINGROUP(LD16,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 16, G, 0,  D, 12),
+	PINGROUP(LD17,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 17, G, 2,  D, 12),
+	PINGROUP(LD2,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 2,  F, 4,  D, 12),
+	PINGROUP(LD3,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 3,  F, 6,  D, 12),
+	PINGROUP(LD4,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 4,  F, 8,  D, 12),
+	PINGROUP(LD5,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 5,  F, 10, D, 12),
+	PINGROUP(LD6,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 6,  F, 12, D, 12),
+	PINGROUP(LD7,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 7,  F, 14, D, 12),
+	PINGROUP(LD8,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 8,  F, 16, D, 12),
+	PINGROUP(LD9,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 9,  F, 18, D, 12),
+	PINGROUP(LDC,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 30, E, 14, D, 20),
+	PINGROUP(LDI,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 6,  G, 16, D, 18),
+	PINGROUP(LHP0,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 18, G, 10, D, 16),
+	PINGROUP(LHP1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 19, G, 4,  D, 14),
+	PINGROUP(LHP2,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 20, G, 6,  D, 14),
+	PINGROUP(LHS,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          D, 7,  E, 22, D, 22),
+	PINGROUP(LM0,   DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          C, 24, E, 26, D, 22),
+	PINGROUP(LM1,   DISPLAYA,  DISPLAYB,  RSVD,      CRT,           C, 25, E, 28, D, 22),
+	PINGROUP(LPP,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 8,  G, 14, D, 18),
+	PINGROUP(LPW0,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 3,  E, 0,  D, 20),
+	PINGROUP(LPW1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 4,  E, 2,  D, 20),
+	PINGROUP(LPW2,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 5,  E, 4,  D, 20),
+	PINGROUP(LSC0,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 27, E, 18, D, 22),
+	PINGROUP(LSC1,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          C, 28, E, 20, D, 20),
+	PINGROUP(LSCK,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          C, 29, E, 16, D, 20),
+	PINGROUP(LSDA,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 1,  E, 8,  D, 20),
+	PINGROUP(LSDI,  DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          D, 2,  E, 6,  D, 20),
+	PINGROUP(LSPI,  DISPLAYA,  DISPLAYB,  XIO,       HDMI,          D, 0,  E, 10, D, 22),
+	PINGROUP(LVP0,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 21, E, 30, D, 22),
+	PINGROUP(LVP1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 22, G, 8,  D, 16),
+	PINGROUP(LVS,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 26, E, 24, D, 22),
+	PINGROUP(OWC,   OWR,       RSVD,      RSVD,      RSVD,          A, 31, B, 8,  E, 30),
+	PINGROUP(PMC,   PWR_ON,    PWR_INTR,  RSVD,      RSVD,          A, 23, G, 18, N, -1),
+	PINGROUP(PTA,   I2C2,      HDMI,      GMI,       RSVD,          A, 24, G, 22, B, 4),
+	PINGROUP(RM,    I2C,       RSVD,      RSVD,      RSVD,          A, 25, A, 14, B, 0),
+	PINGROUP(SDB,   UARTA,     PWM,       SDIO3,     SPI2,          D, 15, D, 10, N, -1),
+	PINGROUP(SDC,   PWM,       TWC,       SDIO3,     SPI3,          B, 1,  D, 12, D, 28),
+	PINGROUP(SDD,   UARTA,     PWM,       SDIO3,     SPI3,          B, 2,  D, 14, D, 30),
+	PINGROUP(SDIO1, SDIO1,     RSVD,      UARTE,     UARTA,         A, 30, A, 30, E, 18),
+	PINGROUP(SLXA,  PCIE,      SPI4,      SDIO3,     SPI2,          B, 3,  B, 6,  B, 22),
+	PINGROUP(SLXC,  SPDIF,     SPI4,      SDIO3,     SPI2,          B, 5,  B, 10, B, 26),
+	PINGROUP(SLXD,  SPDIF,     SPI4,      SDIO3,     SPI2,          B, 6,  B, 12, B, 28),
+	PINGROUP(SLXK,  PCIE,      SPI4,      SDIO3,     SPI2,          B, 7,  B, 14, B, 30),
+	PINGROUP(SPDI,  SPDIF,     RSVD,      I2C,       SDIO2,         B, 8,  D, 8,  B, 16),
+	PINGROUP(SPDO,  SPDIF,     RSVD,      I2C,       SDIO2,         B, 9,  D, 6,  B, 18),
+	PINGROUP(SPIA,  SPI1,      SPI2,      SPI3,      GMI,           B, 10, D, 30, C, 4),
+	PINGROUP(SPIB,  SPI1,      SPI2,      SPI3,      GMI,           B, 11, D, 28, C, 6),
+	PINGROUP(SPIC,  SPI1,      SPI2,      SPI3,      GMI,           B, 12, D, 26, C, 8),
+	PINGROUP(SPID,  SPI2,      SPI1,      SPI2_ALT,  GMI,           B, 13, D, 24, C, 10),
+	PINGROUP(SPIE,  SPI2,      SPI1,      SPI2_ALT,  GMI,           B, 14, D, 22, C, 12),
+	PINGROUP(SPIF,  SPI3,      SPI1,      SPI2,      RSVD,          B, 15, D, 20, C, 14),
+	PINGROUP(SPIG,  SPI3,      SPI2,      SPI2_ALT,  I2C,           B, 16, D, 18, C, 16),
+	PINGROUP(SPIH,  SPI3,      SPI2,      SPI2_ALT,  I2C,           B, 17, D, 16, C, 18),
+	PINGROUP(UAA,   SPI3,      MIPI_HS,   UARTA,     ULPI,          B, 18, A, 0,  D, 0),
+	PINGROUP(UAB,   SPI2,      MIPI_HS,   UARTA,     ULPI,          B, 19, A, 2,  D, 2),
+	PINGROUP(UAC,   OWR,       RSVD,      RSVD,      RSVD,          B, 20, A, 4,  D, 4),
+	PINGROUP(UAD,   IRDA,      SPDIF,     UARTA,     SPI4,          B, 21, A, 6,  D, 6),
+	PINGROUP(UCA,   UARTC,     RSVD,      GMI,       RSVD,          B, 22, B, 16, D, 8),
+	PINGROUP(UCB,   UARTC,     PWM,       GMI,       RSVD,          B, 23, B, 18, D, 10),
+	PINGROUP(UDA,   SPI1,      RSVD,      UARTD,     ULPI,          D, 13, A, 8,  E, 16),
+	/* these pin groups only have pullup and pull down control */
+	PINGROUP(CK32,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 14),
+	PINGROUP(DDRC,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  D, 26),
+	PINGROUP(PMCA,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 4),
+	PINGROUP(PMCB,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 6),
+	PINGROUP(PMCC,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 8),
+	PINGROUP(PMCD,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 10),
+	PINGROUP(PMCE,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 12),
+	PINGROUP(XM2C,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  C, 30),
+	PINGROUP(XM2D,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  C, 28),
+};
+
+static char *tegra_mux_names[TEGRA_MAX_MUX] = {
+	[TEGRA_MUX_AHB_CLK] = "AHB_CLK",
+	[TEGRA_MUX_APB_CLK] = "APB_CLK",
+	[TEGRA_MUX_AUDIO_SYNC] = "AUDIO_SYNC",
+	[TEGRA_MUX_CRT] = "CRT",
+	[TEGRA_MUX_DAP1] = "DAP1",
+	[TEGRA_MUX_DAP2] = "DAP2",
+	[TEGRA_MUX_DAP3] = "DAP3",
+	[TEGRA_MUX_DAP4] = "DAP4",
+	[TEGRA_MUX_DAP5] = "DAP5",
+	[TEGRA_MUX_DISPLAYA] = "DISPLAYA",
+	[TEGRA_MUX_DISPLAYB] = "DISPLAYB",
+	[TEGRA_MUX_EMC_TEST0_DLL] = "EMC_TEST0_DLL",
+	[TEGRA_MUX_EMC_TEST1_DLL] = "EMC_TEST1_DLL",
+	[TEGRA_MUX_GMI] = "GMI",
+	[TEGRA_MUX_GMI_INT] = "GMI_INT",
+	[TEGRA_MUX_HDMI] = "HDMI",
+	[TEGRA_MUX_I2C] = "I2C",
+	[TEGRA_MUX_I2C2] = "I2C2",
+	[TEGRA_MUX_I2C3] = "I2C3",
+	[TEGRA_MUX_IDE] = "IDE",
+	[TEGRA_MUX_IRDA] = "IRDA",
+	[TEGRA_MUX_KBC] = "KBC",
+	[TEGRA_MUX_MIO] = "MIO",
+	[TEGRA_MUX_MIPI_HS] = "MIPI_HS",
+	[TEGRA_MUX_NAND] = "NAND",
+	[TEGRA_MUX_OSC] = "OSC",
+	[TEGRA_MUX_OWR] = "OWR",
+	[TEGRA_MUX_PCIE] = "PCIE",
+	[TEGRA_MUX_PLLA_OUT] = "PLLA_OUT",
+	[TEGRA_MUX_PLLC_OUT1] = "PLLC_OUT1",
+	[TEGRA_MUX_PLLM_OUT1] = "PLLM_OUT1",
+	[TEGRA_MUX_PLLP_OUT2] = "PLLP_OUT2",
+	[TEGRA_MUX_PLLP_OUT3] = "PLLP_OUT3",
+	[TEGRA_MUX_PLLP_OUT4] = "PLLP_OUT4",
+	[TEGRA_MUX_PWM] = "PWM",
+	[TEGRA_MUX_PWR_INTR] = "PWR_INTR",
+	[TEGRA_MUX_PWR_ON] = "PWR_ON",
+	[TEGRA_MUX_RTCK] = "RTCK",
+	[TEGRA_MUX_SDIO1] = "SDIO1",
+	[TEGRA_MUX_SDIO2] = "SDIO2",
+	[TEGRA_MUX_SDIO3] = "SDIO3",
+	[TEGRA_MUX_SDIO4] = "SDIO4",
+	[TEGRA_MUX_SFLASH] = "SFLASH",
+	[TEGRA_MUX_SPDIF] = "SPDIF",
+	[TEGRA_MUX_SPI1] = "SPI1",
+	[TEGRA_MUX_SPI2] = "SPI2",
+	[TEGRA_MUX_SPI2_ALT] = "SPI2_ALT",
+	[TEGRA_MUX_SPI3] = "SPI3",
+	[TEGRA_MUX_SPI4] = "SPI4",
+	[TEGRA_MUX_TRACE] = "TRACE",
+	[TEGRA_MUX_TWC] = "TWC",
+	[TEGRA_MUX_UARTA] = "UARTA",
+	[TEGRA_MUX_UARTB] = "UARTB",
+	[TEGRA_MUX_UARTC] = "UARTC",
+	[TEGRA_MUX_UARTD] = "UARTD",
+	[TEGRA_MUX_UARTE] = "UARTE",
+	[TEGRA_MUX_ULPI] = "ULPI",
+	[TEGRA_MUX_VI] = "VI",
+	[TEGRA_MUX_VI_SENSOR_CLK] = "VI_SENSOR_CLK",
+	[TEGRA_MUX_XIO] = "XIO",
+};
+
+static DEFINE_SPINLOCK(mux_lock);
+
+static const char *pingroup_name(enum tegra_pingroup pg)
+{
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return "<UNKNOWN>";
+
+	return pingroups[pg].name;
+}
+
+static const char *func_name(enum tegra_mux_func func)
+{
+	if (func == TEGRA_MUX_RSVD1)
+		return "RSVD1";
+
+	if (func == TEGRA_MUX_RSVD2)
+		return "RSVD2";
+
+	if (func == TEGRA_MUX_RSVD3)
+		return "RSVD3";
+
+	if (func == TEGRA_MUX_RSVD4)
+		return "RSVD4";
+
+	if (func == TEGRA_MUX_NONE)
+		return "NONE";
+
+	if (func < 0 || func >=  TEGRA_MAX_MUX)
+		return "<UNKNOWN>";
+
+	return tegra_mux_names[func];
+}
+
+
+static const char *tri_name(unsigned long val)
+{
+	return val ? "TRISTATE" : "NORMAL";
+}
+
+static const char *pupd_name(unsigned long val)
+{
+	switch (val) {
+	case 0:
+		return "NORMAL";
+
+	case 1:
+		return "PULL_DOWN";
+
+	case 2:
+		return "PULL_UP";
+
+	default:
+		return "RSVD";
+	}
+}
+
+
+static inline unsigned long pg_readl(unsigned long offset)
+{
+	return readl(IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+}
+
+static inline void pg_writel(unsigned long value, unsigned long offset)
+{
+	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
+}
+
+int tegra_pinmux_set_func(enum tegra_pingroup pg, enum tegra_mux_func func)
+{
+	int mux = -1;
+	int i;
+	unsigned long reg;
+	unsigned long flags;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].mux_reg == REG_N)
+		return -EINVAL;
+
+	if (func < 0)
+		return -ERANGE;
+
+	if (func & TEGRA_MUX_RSVD) {
+		mux = func & 0x3;
+	} else {
+		for (i = 0; i < 4; i++) {
+			if (pingroups[pg].funcs[i] == func) {
+				mux = i;
+				break;
+			}
+		}
+	}
+
+	if (mux < 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&mux_lock, flags);
+
+	reg = pg_readl(TEGRA_PP_MUX_CTL(pingroups[pg].mux_reg));
+	reg &= ~(0x3 << pingroups[pg].mux_bit);
+	reg |= mux << pingroups[pg].mux_bit;
+	pg_writel(reg, TEGRA_PP_MUX_CTL(pingroups[pg].mux_reg));
+
+	spin_unlock_irqrestore(&mux_lock, flags);
+
+	return 0;
+}
+
+int tegra_pinmux_set_tristate(enum tegra_pingroup pg,
+			      enum tegra_tristate tristate)
+{
+	unsigned long reg;
+	unsigned long flags;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].tri_reg == REG_N)
+		return -EINVAL;
+
+	spin_lock_irqsave(&mux_lock, flags);
+
+	reg = pg_readl(TEGRA_TRI_STATE(pingroups[pg].tri_reg));
+	reg &= ~(0x1 << pingroups[pg].tri_bit);
+	if (tristate)
+		reg |= 1 << pingroups[pg].tri_bit;
+	pg_writel(reg, TEGRA_TRI_STATE(pingroups[pg].tri_reg));
+
+	spin_unlock_irqrestore(&mux_lock, flags);
+
+	return 0;
+}
+
+int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
+				enum tegra_pullupdown pupd)
+{
+	unsigned long reg;
+	unsigned long flags;
+
+	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
+		return -ERANGE;
+
+	if (pingroups[pg].pupd_reg == REG_N)
+		return -EINVAL;
+
+	if (pupd != TEGRA_PUPD_NORMAL &&
+	    pupd != TEGRA_PUPD_PULL_DOWN &&
+	    pupd != TEGRA_PUPD_PULL_UP)
+		return -EINVAL;
+
+
+	spin_lock_irqsave(&mux_lock, flags);
+
+	reg = pg_readl(TEGRA_PP_PU_PD(pingroups[pg].pupd_reg));
+	reg &= ~(0x3 << pingroups[pg].pupd_bit);
+	reg |= pupd << pingroups[pg].pupd_bit;
+	pg_writel(reg, TEGRA_PP_PU_PD(pingroups[pg].pupd_reg));
+
+	spin_unlock_irqrestore(&mux_lock, flags);
+
+	return 0;
+}
+
+void tegra_pinmux_config_pingroup(enum tegra_pingroup pingroup,
+				 enum tegra_mux_func func,
+				 enum tegra_pullupdown pupd,
+				 enum tegra_tristate tristate)
+{
+	int err;
+
+	if (pingroups[pingroup].mux_reg != REG_N) {
+		err = tegra_pinmux_set_func(pingroup, func);
+		if (err < 0)
+			pr_err("pinmux: can't set pingroup %s func to %s: %d\n",
+			       pingroup_name(pingroup), func_name(func), err);
+	}
+
+	if (pingroups[pingroup].pupd_reg != REG_N) {
+		err = tegra_pinmux_set_pullupdown(pingroup, pupd);
+		if (err < 0)
+			pr_err("pinmux: can't set pingroup %s pullupdown to %s: %d\n",
+			       pingroup_name(pingroup), pupd_name(pupd), err);
+	}
+
+	if (pingroups[pingroup].tri_reg != REG_N) {
+		err = tegra_pinmux_set_tristate(pingroup, tristate);
+		if (err < 0)
+			pr_err("pinmux: can't set pingroup %s tristate to %s: %d\n",
+			       pingroup_name(pingroup), tri_name(func), err);
+	}
+}
+
+
+
+void tegra_pinmux_config_table(struct tegra_pingroup_config *config, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		tegra_pinmux_config_pingroup(config[i].pingroup,
+					     config[i].func,
+					     config[i].pupd,
+					     config[i].tristate);
+}
+
+
+
+
+
+#ifdef	CONFIG_DEBUG_FS
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+static void dbg_pad_field(struct seq_file *s, int len)
+{
+	seq_putc(s, ',');
+
+	while (len-- > -1)
+		seq_putc(s, ' ');
+}
+
+static int dbg_pinmux_show(struct seq_file *s, void *unused)
+{
+	int i;
+	int len;
+
+	for (i = 0; i < TEGRA_MAX_PINGROUP; i++) {
+		unsigned long tri;
+		unsigned long mux;
+		unsigned long pupd;
+
+		seq_printf(s, "\t{TEGRA_PINGROUP_%s", pingroups[i].name);
+		len = strlen(pingroups[i].name);
+		dbg_pad_field(s, 5 - len);
+
+		if (pingroups[i].mux_reg == REG_N) {
+			seq_printf(s, "TEGRA_MUX_NONE");
+			len = strlen("NONE");
+		} else {
+			mux = (pg_readl(TEGRA_PP_MUX_CTL(pingroups[i].mux_reg)) >>
+			       pingroups[i].mux_bit) & 0x3;
+			if (pingroups[i].funcs[mux] == TEGRA_MUX_RSVD) {
+				seq_printf(s, "TEGRA_MUX_RSVD%1lu", mux+1);
+				len = 5;
+			} else {
+				seq_printf(s, "TEGRA_MUX_%s",
+					   tegra_mux_names[pingroups[i].funcs[mux]]);
+				len = strlen(tegra_mux_names[pingroups[i].funcs[mux]]);
+			}
+		}
+		dbg_pad_field(s, 13-len);
+
+		if (pingroups[i].mux_reg == REG_N) {
+			seq_printf(s, "TEGRA_PUPD_NORMAL");
+			len = strlen("NORMAL");
+		} else {
+			pupd = (pg_readl(TEGRA_PP_PU_PD(pingroups[i].pupd_reg)) >>
+				pingroups[i].pupd_bit) & 0x3;
+			seq_printf(s, "TEGRA_PUPD_%s", pupd_name(pupd));
+			len = strlen(pupd_name(pupd));
+		}
+		dbg_pad_field(s, 9 - len);
+
+		if (pingroups[i].tri_reg == REG_N) {
+			seq_printf(s, "TEGRA_TRI_NORMAL");
+		} else {
+			tri = (pg_readl(TEGRA_TRI_STATE(pingroups[i].tri_reg)) >>
+			       pingroups[i].tri_bit) & 0x1;
+
+			seq_printf(s, "TEGRA_TRI_%s", tri_name(tri));
+		}
+		seq_printf(s, "},\n");
+	}
+	return 0;
+}
+
+static int dbg_pinmux_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, dbg_pinmux_show, &inode->i_private);
+}
+
+static const struct file_operations debug_fops = {
+	.open		= dbg_pinmux_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init tegra_pinmux_debuginit(void)
+{
+	(void) debugfs_create_file("tegra_pinmux", S_IRUGO,
+					NULL, NULL, &debug_fops);
+	return 0;
+}
+late_initcall(tegra_pinmux_debuginit);
+#endif
-- 
1.5.6.5
