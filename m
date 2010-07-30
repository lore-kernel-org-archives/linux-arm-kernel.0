From: ccross@google.com (Colin Cross)
Date: Thu, 29 Jul 2010 17:29:25 -0700
Subject: [PATCH 4/9] [ARM] tegra: pinmux: add safe values, move tegra2,
	add suspend
In-Reply-To: <1280449771-24043-1-git-send-email-ccross@google.com>
References: <1280449771-24043-1-git-send-email-ccross@google.com>
Message-ID: <1280449771-24043-5-git-send-email-ccross@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

- the reset values for some pin groups in the tegra pin mux can result in
functional errors due to conflicting with actively-configured pin groups
muxing from the same controller. this change adds a known safe, non-
conflicting mux for every pin group, which can be used on platforms
where the pin group is not routed to any peripheral

- also add each pin group's I/O voltage rail, to enable platform code to
map from the pin groups used by each interface to the regulators used
for dynamic voltage control

- add routines to individually configure the tristate, pin mux and pull-
ups for a pingroup_config array, so that it is possible to program
individual values at run-time without modifying other values.
this allows driver power-management code to reprogram individual
interfaces into lower power states during idle / suspend, or to
reprogram the pin mux to support multiple physical busses per
internal controller (e.g., sharing a single I2C or SPI controller
across multiple pin groups)

- move chip-specific data like pingroups and drive-pingroups
out of the common code and into chip-specific code

- fix debug output for group with no pullups

- add a TEGRA_MUX_SAFE function.  Setting a pingroup to TEGRA_MUX_SAFE
will automatically select a mux setting that is guaranteed not to
conflict with any of the hardware blocks.

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/mach-tegra/Makefile                 |    1 +
 arch/arm/mach-tegra/include/mach/pinmux-t2.h |  174 +++++++++++++
 arch/arm/mach-tegra/include/mach/pinmux.h    |  210 ++++------------
 arch/arm/mach-tegra/pinmux-t2-tables.c       |  260 +++++++++++++++++++
 arch/arm/mach-tegra/pinmux.c                 |  354 +++++++++-----------------
 5 files changed, 603 insertions(+), 396 deletions(-)
 create mode 100644 arch/arm/mach-tegra/include/mach/pinmux-t2.h
 create mode 100644 arch/arm/mach-tegra/pinmux-t2-tables.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 0a975b5..87d065e 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -7,6 +7,7 @@ obj-y                                   += gpio.o
 obj-y                                   += pinmux.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
+obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
 obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 
diff --git a/arch/arm/mach-tegra/include/mach/pinmux-t2.h b/arch/arm/mach-tegra/include/mach/pinmux-t2.h
new file mode 100644
index 0000000..e5b9d74
--- /dev/null
+++ b/arch/arm/mach-tegra/include/mach/pinmux-t2.h
@@ -0,0 +1,174 @@
+/*
+ * linux/arch/arm/mach-tegra/include/mach/pinmux-t2.h
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
+#ifndef __MACH_TEGRA_PINMUX_T2_H
+#define __MACH_TEGRA_PINMUX_T2_H
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
+enum tegra_drive_pingroup {
+	TEGRA_DRIVE_PINGROUP_AO1 = 0,
+	TEGRA_DRIVE_PINGROUP_AO2,
+	TEGRA_DRIVE_PINGROUP_AT1,
+	TEGRA_DRIVE_PINGROUP_AT2,
+	TEGRA_DRIVE_PINGROUP_CDEV1,
+	TEGRA_DRIVE_PINGROUP_CDEV2,
+	TEGRA_DRIVE_PINGROUP_CSUS,
+	TEGRA_DRIVE_PINGROUP_DAP1,
+	TEGRA_DRIVE_PINGROUP_DAP2,
+	TEGRA_DRIVE_PINGROUP_DAP3,
+	TEGRA_DRIVE_PINGROUP_DAP4,
+	TEGRA_DRIVE_PINGROUP_DBG,
+	TEGRA_DRIVE_PINGROUP_LCD1,
+	TEGRA_DRIVE_PINGROUP_LCD2,
+	TEGRA_DRIVE_PINGROUP_SDMMC2,
+	TEGRA_DRIVE_PINGROUP_SDMMC3,
+	TEGRA_DRIVE_PINGROUP_SPI,
+	TEGRA_DRIVE_PINGROUP_UAA,
+	TEGRA_DRIVE_PINGROUP_UAB,
+	TEGRA_DRIVE_PINGROUP_UART2,
+	TEGRA_DRIVE_PINGROUP_UART3,
+	TEGRA_DRIVE_PINGROUP_VI1,
+	TEGRA_DRIVE_PINGROUP_VI2,
+	TEGRA_DRIVE_PINGROUP_XM2A,
+	TEGRA_DRIVE_PINGROUP_XM2C,
+	TEGRA_DRIVE_PINGROUP_XM2D,
+	TEGRA_DRIVE_PINGROUP_XM2CLK,
+	TEGRA_DRIVE_PINGROUP_MEMCOMP,
+	TEGRA_MAX_DRIVE_PINGROUP,
+};
+
+#endif
+
diff --git a/arch/arm/mach-tegra/include/mach/pinmux.h b/arch/arm/mach-tegra/include/mach/pinmux.h
index 41c8ce5..defd877 100644
--- a/arch/arm/mach-tegra/include/mach/pinmux.h
+++ b/arch/arm/mach-tegra/include/mach/pinmux.h
@@ -17,126 +17,11 @@
 #ifndef __MACH_TEGRA_PINMUX_H
 #define __MACH_TEGRA_PINMUX_H
 
-enum tegra_pingroup {
-	TEGRA_PINGROUP_ATA = 0,
-	TEGRA_PINGROUP_ATB,
-	TEGRA_PINGROUP_ATC,
-	TEGRA_PINGROUP_ATD,
-	TEGRA_PINGROUP_ATE,
-	TEGRA_PINGROUP_CDEV1,
-	TEGRA_PINGROUP_CDEV2,
-	TEGRA_PINGROUP_CRTP,
-	TEGRA_PINGROUP_CSUS,
-	TEGRA_PINGROUP_DAP1,
-	TEGRA_PINGROUP_DAP2,
-	TEGRA_PINGROUP_DAP3,
-	TEGRA_PINGROUP_DAP4,
-	TEGRA_PINGROUP_DDC,
-	TEGRA_PINGROUP_DTA,
-	TEGRA_PINGROUP_DTB,
-	TEGRA_PINGROUP_DTC,
-	TEGRA_PINGROUP_DTD,
-	TEGRA_PINGROUP_DTE,
-	TEGRA_PINGROUP_DTF,
-	TEGRA_PINGROUP_GMA,
-	TEGRA_PINGROUP_GMB,
-	TEGRA_PINGROUP_GMC,
-	TEGRA_PINGROUP_GMD,
-	TEGRA_PINGROUP_GME,
-	TEGRA_PINGROUP_GPU,
-	TEGRA_PINGROUP_GPU7,
-	TEGRA_PINGROUP_GPV,
-	TEGRA_PINGROUP_HDINT,
-	TEGRA_PINGROUP_I2CP,
-	TEGRA_PINGROUP_IRRX,
-	TEGRA_PINGROUP_IRTX,
-	TEGRA_PINGROUP_KBCA,
-	TEGRA_PINGROUP_KBCB,
-	TEGRA_PINGROUP_KBCC,
-	TEGRA_PINGROUP_KBCD,
-	TEGRA_PINGROUP_KBCE,
-	TEGRA_PINGROUP_KBCF,
-	TEGRA_PINGROUP_LCSN,
-	TEGRA_PINGROUP_LD0,
-	TEGRA_PINGROUP_LD1,
-	TEGRA_PINGROUP_LD10,
-	TEGRA_PINGROUP_LD11,
-	TEGRA_PINGROUP_LD12,
-	TEGRA_PINGROUP_LD13,
-	TEGRA_PINGROUP_LD14,
-	TEGRA_PINGROUP_LD15,
-	TEGRA_PINGROUP_LD16,
-	TEGRA_PINGROUP_LD17,
-	TEGRA_PINGROUP_LD2,
-	TEGRA_PINGROUP_LD3,
-	TEGRA_PINGROUP_LD4,
-	TEGRA_PINGROUP_LD5,
-	TEGRA_PINGROUP_LD6,
-	TEGRA_PINGROUP_LD7,
-	TEGRA_PINGROUP_LD8,
-	TEGRA_PINGROUP_LD9,
-	TEGRA_PINGROUP_LDC,
-	TEGRA_PINGROUP_LDI,
-	TEGRA_PINGROUP_LHP0,
-	TEGRA_PINGROUP_LHP1,
-	TEGRA_PINGROUP_LHP2,
-	TEGRA_PINGROUP_LHS,
-	TEGRA_PINGROUP_LM0,
-	TEGRA_PINGROUP_LM1,
-	TEGRA_PINGROUP_LPP,
-	TEGRA_PINGROUP_LPW0,
-	TEGRA_PINGROUP_LPW1,
-	TEGRA_PINGROUP_LPW2,
-	TEGRA_PINGROUP_LSC0,
-	TEGRA_PINGROUP_LSC1,
-	TEGRA_PINGROUP_LSCK,
-	TEGRA_PINGROUP_LSDA,
-	TEGRA_PINGROUP_LSDI,
-	TEGRA_PINGROUP_LSPI,
-	TEGRA_PINGROUP_LVP0,
-	TEGRA_PINGROUP_LVP1,
-	TEGRA_PINGROUP_LVS,
-	TEGRA_PINGROUP_OWC,
-	TEGRA_PINGROUP_PMC,
-	TEGRA_PINGROUP_PTA,
-	TEGRA_PINGROUP_RM,
-	TEGRA_PINGROUP_SDB,
-	TEGRA_PINGROUP_SDC,
-	TEGRA_PINGROUP_SDD,
-	TEGRA_PINGROUP_SDIO1,
-	TEGRA_PINGROUP_SLXA,
-	TEGRA_PINGROUP_SLXC,
-	TEGRA_PINGROUP_SLXD,
-	TEGRA_PINGROUP_SLXK,
-	TEGRA_PINGROUP_SPDI,
-	TEGRA_PINGROUP_SPDO,
-	TEGRA_PINGROUP_SPIA,
-	TEGRA_PINGROUP_SPIB,
-	TEGRA_PINGROUP_SPIC,
-	TEGRA_PINGROUP_SPID,
-	TEGRA_PINGROUP_SPIE,
-	TEGRA_PINGROUP_SPIF,
-	TEGRA_PINGROUP_SPIG,
-	TEGRA_PINGROUP_SPIH,
-	TEGRA_PINGROUP_UAA,
-	TEGRA_PINGROUP_UAB,
-	TEGRA_PINGROUP_UAC,
-	TEGRA_PINGROUP_UAD,
-	TEGRA_PINGROUP_UCA,
-	TEGRA_PINGROUP_UCB,
-	TEGRA_PINGROUP_UDA,
-	/* these pin groups only have pullup and pull down control */
-	TEGRA_PINGROUP_CK32,
-	TEGRA_PINGROUP_DDRC,
-	TEGRA_PINGROUP_PMCA,
-	TEGRA_PINGROUP_PMCB,
-	TEGRA_PINGROUP_PMCC,
-	TEGRA_PINGROUP_PMCD,
-	TEGRA_PINGROUP_PMCE,
-	TEGRA_PINGROUP_XM2C,
-	TEGRA_PINGROUP_XM2D,
-	TEGRA_MAX_PINGROUP,
-};
+#if defined(CONFIG_ARCH_TEGRA_2x_SOC)
+#include "pinmux-t2.h"
+#else
+#error "Undefined Tegra architecture"
+#endif
 
 enum tegra_mux_func {
 	TEGRA_MUX_RSVD = 0x8000,
@@ -205,6 +90,7 @@ enum tegra_mux_func {
 	TEGRA_MUX_VI,
 	TEGRA_MUX_VI_SENSOR_CLK,
 	TEGRA_MUX_XIO,
+	TEGRA_MUX_SAFE,
 	TEGRA_MAX_MUX,
 };
 
@@ -219,6 +105,18 @@ enum tegra_tristate {
 	TEGRA_TRI_TRISTATE = 1,
 };
 
+enum tegra_vddio {
+	TEGRA_VDDIO_BB = 0,
+	TEGRA_VDDIO_LCD,
+	TEGRA_VDDIO_VI,
+	TEGRA_VDDIO_UART,
+	TEGRA_VDDIO_DDR,
+	TEGRA_VDDIO_NAND,
+	TEGRA_VDDIO_SYS,
+	TEGRA_VDDIO_AUDIO,
+	TEGRA_VDDIO_SD,
+};
+
 struct tegra_pingroup_config {
 	enum tegra_pingroup	pingroup;
 	enum tegra_mux_func	func;
@@ -270,38 +168,6 @@ enum tegra_pull_strength {
 	TEGRA_MAX_PULL,
 };
 
-enum tegra_drive_pingroup {
-	TEGRA_DRIVE_PINGROUP_AO1 = 0,
-	TEGRA_DRIVE_PINGROUP_AO2,
-	TEGRA_DRIVE_PINGROUP_AT1,
-	TEGRA_DRIVE_PINGROUP_AT2,
-	TEGRA_DRIVE_PINGROUP_CDEV1,
-	TEGRA_DRIVE_PINGROUP_CDEV2,
-	TEGRA_DRIVE_PINGROUP_CSUS,
-	TEGRA_DRIVE_PINGROUP_DAP1,
-	TEGRA_DRIVE_PINGROUP_DAP2,
-	TEGRA_DRIVE_PINGROUP_DAP3,
-	TEGRA_DRIVE_PINGROUP_DAP4,
-	TEGRA_DRIVE_PINGROUP_DBG,
-	TEGRA_DRIVE_PINGROUP_LCD1,
-	TEGRA_DRIVE_PINGROUP_LCD2,
-	TEGRA_DRIVE_PINGROUP_SDMMC2,
-	TEGRA_DRIVE_PINGROUP_SDMMC3,
-	TEGRA_DRIVE_PINGROUP_SPI,
-	TEGRA_DRIVE_PINGROUP_UAA,
-	TEGRA_DRIVE_PINGROUP_UAB,
-	TEGRA_DRIVE_PINGROUP_UART2,
-	TEGRA_DRIVE_PINGROUP_UART3,
-	TEGRA_DRIVE_PINGROUP_VI1,
-	TEGRA_DRIVE_PINGROUP_VI2,
-	TEGRA_DRIVE_PINGROUP_XM2A,
-	TEGRA_DRIVE_PINGROUP_XM2C,
-	TEGRA_DRIVE_PINGROUP_XM2D,
-	TEGRA_DRIVE_PINGROUP_XM2CLK,
-	TEGRA_DRIVE_PINGROUP_MEMCOMP,
-	TEGRA_MAX_DRIVE_PINGROUP,
-};
-
 enum tegra_drive {
 	TEGRA_DRIVE_DIV_8 = 0,
 	TEGRA_DRIVE_DIV_4,
@@ -331,18 +197,44 @@ struct tegra_drive_pingroup_config {
 	enum tegra_slew slew_falling;
 };
 
-int tegra_pinmux_set_func(enum tegra_pingroup pg, enum tegra_mux_func func);
-int tegra_pinmux_set_tristate(enum tegra_pingroup pg, enum tegra_tristate tristate);
-int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg, enum tegra_pullupdown pupd);
+struct tegra_drive_pingroup_desc {
+	const char *name;
+	s16 reg;
+};
+
+struct tegra_pingroup_desc {
+	const char *name;
+	int funcs[4];
+	int func_safe;
+	int vddio;
+	s16 tri_reg; 	/* offset into the TRISTATE_REG_* register bank */
+	s16 mux_reg;	/* offset into the PIN_MUX_CTL_* register bank */
+	s16 pupd_reg;	/* offset into the PULL_UPDOWN_REG_* register bank */
+	s8 tri_bit; 	/* offset into the TRISTATE_REG_* register bit */
+	s8 mux_bit;	/* offset into the PIN_MUX_CTL_* register bit */
+	s8 pupd_bit;	/* offset into the PULL_UPDOWN_REG_* register bit */
+};
+
+extern const struct tegra_pingroup_desc tegra_soc_pingroups[];
+extern const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[];
 
-void tegra_pinmux_config_pingroup(enum tegra_pingroup pingroup,
-	enum tegra_mux_func func, enum tegra_pullupdown pupd,
+int tegra_pinmux_set_tristate(enum tegra_pingroup pg,
 	enum tegra_tristate tristate);
+int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
+	enum tegra_pullupdown pupd);
 
-void tegra_pinmux_config_table(struct tegra_pingroup_config *config, int len);
+void tegra_pinmux_config_table(const struct tegra_pingroup_config *config,
+	int len);
 
 void tegra_drive_pinmux_config_table(struct tegra_drive_pingroup_config *config,
 	int len);
-
+void tegra_pinmux_set_safe_pinmux_table(const struct tegra_pingroup_config *config,
+	int len);
+void tegra_pinmux_config_pinmux_table(const struct tegra_pingroup_config *config,
+	int len);
+void tegra_pinmux_config_tristate_table(const struct tegra_pingroup_config *config,
+	int len, enum tegra_tristate tristate);
+void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *config,
+	int len, enum tegra_pullupdown pupd);
 #endif
 
diff --git a/arch/arm/mach-tegra/pinmux-t2-tables.c b/arch/arm/mach-tegra/pinmux-t2-tables.c
new file mode 100644
index 0000000..a6ea34e
--- /dev/null
+++ b/arch/arm/mach-tegra/pinmux-t2-tables.c
@@ -0,0 +1,260 @@
+/*
+ * linux/arch/arm/mach-tegra/pinmux-t2-tables.c
+ *
+ * Common pinmux configurations for Tegra 2 SoCs
+ *
+ * Copyright (C) 2010 NVIDIA Corporation
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
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/string.h>
+
+#include <mach/iomap.h>
+#include <mach/pinmux.h>
+
+#define DRIVE_PINGROUP(pg_name, r)				\
+	[TEGRA_DRIVE_PINGROUP_ ## pg_name] = {			\
+		.name = #pg_name,				\
+		.reg = r					\
+	}
+
+const struct tegra_drive_pingroup_desc tegra_soc_drive_pingroups[TEGRA_MAX_DRIVE_PINGROUP] = {
+	DRIVE_PINGROUP(AO1,		0x868),
+	DRIVE_PINGROUP(AO2,		0x86c),
+	DRIVE_PINGROUP(AT1,		0x870),
+	DRIVE_PINGROUP(AT2,		0x874),
+	DRIVE_PINGROUP(CDEV1,		0x878),
+	DRIVE_PINGROUP(CDEV2,		0x87c),
+	DRIVE_PINGROUP(CSUS,		0x880),
+	DRIVE_PINGROUP(DAP1,		0x884),
+	DRIVE_PINGROUP(DAP2,		0x888),
+	DRIVE_PINGROUP(DAP3,		0x88c),
+	DRIVE_PINGROUP(DAP4,		0x890),
+	DRIVE_PINGROUP(DBG,		0x894),
+	DRIVE_PINGROUP(LCD1,		0x898),
+	DRIVE_PINGROUP(LCD2,		0x89c),
+	DRIVE_PINGROUP(SDMMC2,		0x8a0),
+	DRIVE_PINGROUP(SDMMC3,		0x8a4),
+	DRIVE_PINGROUP(SPI,		0x8a8),
+	DRIVE_PINGROUP(UAA,		0x8ac),
+	DRIVE_PINGROUP(UAB,		0x8b0),
+	DRIVE_PINGROUP(UART2,		0x8b4),
+	DRIVE_PINGROUP(UART3,		0x8b8),
+	DRIVE_PINGROUP(VI1,		0x8bc),
+	DRIVE_PINGROUP(VI2,		0x8c0),
+	DRIVE_PINGROUP(XM2A,		0x8c4),
+	DRIVE_PINGROUP(XM2C,		0x8c8),
+	DRIVE_PINGROUP(XM2D,		0x8cc),
+	DRIVE_PINGROUP(XM2CLK,		0x8d0),
+	DRIVE_PINGROUP(MEMCOMP,		0x8d4),
+};
+
+#define PINGROUP(pg_name, vdd, f0, f1, f2, f3, f_safe,		\
+		 tri_r, tri_b, mux_r, mux_b, pupd_r, pupd_b)	\
+	[TEGRA_PINGROUP_ ## pg_name] = {			\
+		.name = #pg_name,				\
+		.vddio = TEGRA_VDDIO_ ## vdd,			\
+		.funcs = {					\
+			TEGRA_MUX_ ## f0,			\
+			TEGRA_MUX_ ## f1,			\
+			TEGRA_MUX_ ## f2,			\
+			TEGRA_MUX_ ## f3,			\
+		},						\
+		.func_safe = TEGRA_MUX_ ## f_safe,		\
+		.tri_reg = tri_r,				\
+		.tri_bit = tri_b,				\
+		.mux_reg = mux_r,				\
+		.mux_bit = mux_b,				\
+		.pupd_reg = pupd_r,				\
+		.pupd_bit = pupd_b,				\
+	}
+
+const struct tegra_pingroup_desc tegra_soc_pingroups[TEGRA_MAX_PINGROUP] = {
+	PINGROUP(ATA,   NAND,  IDE,       NAND,      GMI,       RSVD,          IDE,       0x14, 0,  0x80, 24, 0xA0, 0),
+	PINGROUP(ATB,   NAND,  IDE,       NAND,      GMI,       SDIO4,         IDE,       0x14, 1,  0x80, 16, 0xA0, 2),
+	PINGROUP(ATC,   NAND,  IDE,       NAND,      GMI,       SDIO4,         IDE,       0x14, 2,  0x80, 22, 0xA0, 4),
+	PINGROUP(ATD,   NAND,  IDE,       NAND,      GMI,       SDIO4,         IDE,       0x14, 3,  0x80, 20, 0xA0, 6),
+	PINGROUP(ATE,   NAND,  IDE,       NAND,      GMI,       RSVD,          IDE,       0x18, 25, 0x80, 12, 0xA0, 8),
+	PINGROUP(CDEV1, AUDIO, OSC,       PLLA_OUT,  PLLM_OUT1, AUDIO_SYNC,    OSC,       0x14, 4,  0x88, 2,  0xA8, 0),
+	PINGROUP(CDEV2, AUDIO, OSC,       AHB_CLK,   APB_CLK,   PLLP_OUT4,     OSC,       0x14, 5,  0x88, 4,  0xA8, 2),
+	PINGROUP(CRTP,  LCD,   CRT,       RSVD,      RSVD,      RSVD,          RSVD,      0x20, 14, 0x98, 20, 0xA4, 24),
+	PINGROUP(CSUS,  VI,    PLLC_OUT1, PLLP_OUT2, PLLP_OUT3, VI_SENSOR_CLK, PLLC_OUT1, 0x14, 6,  0x88, 6,  0xAC, 24),
+	PINGROUP(DAP1,  AUDIO, DAP1,      RSVD,      GMI,       SDIO2,         DAP1,      0x14, 7,  0x88, 20, 0xA0, 10),
+	PINGROUP(DAP2,  AUDIO, DAP2,      TWC,       RSVD,      GMI,           DAP2,      0x14, 8,  0x88, 22, 0xA0, 12),
+	PINGROUP(DAP3,  BB,    DAP3,      RSVD,      RSVD,      RSVD,          DAP3,      0x14, 9,  0x88, 24, 0xA0, 14),
+	PINGROUP(DAP4,  UART,  DAP4,      RSVD,      GMI,       RSVD,          DAP4,      0x14, 10, 0x88, 26, 0xA0, 16),
+	PINGROUP(DDC,   LCD,   I2C2,      RSVD,      RSVD,      RSVD,          RSVD4,     0x18, 31, 0x88, 0,  0xB0, 28),
+	PINGROUP(DTA,   VI,    RSVD,      SDIO2,     VI,        RSVD,          RSVD4,     0x14, 11, 0x84, 20, 0xA0, 18),
+	PINGROUP(DTB,   VI,    RSVD,      RSVD,      VI,        SPI1,          RSVD1,     0x14, 12, 0x84, 22, 0xA0, 20),
+	PINGROUP(DTC,   VI,    RSVD,      RSVD,      VI,        RSVD,          RSVD1,     0x14, 13, 0x84, 26, 0xA0, 22),
+	PINGROUP(DTD,   VI,    RSVD,      SDIO2,     VI,        RSVD,          RSVD1,     0x14, 14, 0x84, 28, 0xA0, 24),
+	PINGROUP(DTE,   VI,    RSVD,      RSVD,      VI,        SPI1,          RSVD1,     0x14, 15, 0x84, 30, 0xA0, 26),
+	PINGROUP(DTF,   VI,    I2C3,      RSVD,      VI,        RSVD,          RSVD4,     0x20, 12, 0x98, 30, 0xA0, 28),
+	PINGROUP(GMA,   NAND,  UARTE,     SPI3,      GMI,       SDIO4,         SPI3,      0x14, 28, 0x84, 0,  0xB0, 20),
+	PINGROUP(GMB,   NAND,  IDE,       NAND,      GMI,       GMI_INT,       GMI,       0x18, 29, 0x88, 28, 0xB0, 22),
+	PINGROUP(GMC,   NAND,  UARTD,     SPI4,      GMI,       SFLASH,        SPI4,      0x14, 29, 0x84, 2,  0xB0, 24),
+	PINGROUP(GMD,   NAND,  RSVD,      NAND,      GMI,       SFLASH,        GMI,       0x18, 30, 0x88, 30, 0xB0, 26),
+	PINGROUP(GME,   NAND,  RSVD,      DAP5,      GMI,       SDIO4,         GMI,       0x18, 0,  0x8C, 0,  0xA8, 24),
+	PINGROUP(GPU,   UART,  PWM,       UARTA,     GMI,       RSVD,          RSVD4,     0x14, 16, 0x8C, 4,  0xA4, 20),
+	PINGROUP(GPU7,  SYS,   RTCK,      RSVD,      RSVD,      RSVD,          RTCK,      0x20, 11, 0x98, 28, 0xA4, 6),
+	PINGROUP(GPV,   SD,    PCIE,      RSVD,      RSVD,      RSVD,          PCIE,      0x14, 17, 0x8C, 2,  0xA0, 30),
+	PINGROUP(HDINT, LCD,   HDMI,      RSVD,      RSVD,      RSVD,          HDMI,      0x1C, 23, 0x84, 4,  0xAC, 22),
+	PINGROUP(I2CP,  SYS,   I2C,       RSVD,      RSVD,      RSVD,          RSVD4,     0x14, 18, 0x88, 8,  0xA4, 2),
+	PINGROUP(IRRX,  UART,  UARTA,     UARTB,     GMI,       SPI4,          UARTB,     0x14, 20, 0x88, 18, 0xA8, 22),
+	PINGROUP(IRTX,  UART,  UARTA,     UARTB,     GMI,       SPI4,          UARTB,     0x14, 19, 0x88, 16, 0xA8, 20),
+	PINGROUP(KBCA,  SYS,   KBC,       NAND,      SDIO2,     EMC_TEST0_DLL, KBC,       0x14, 22, 0x88, 10, 0xA4, 8),
+	PINGROUP(KBCB,  SYS,   KBC,       NAND,      SDIO2,     MIO,           KBC,       0x14, 21, 0x88, 12, 0xA4, 10),
+	PINGROUP(KBCC,  SYS,   KBC,       NAND,      TRACE,     EMC_TEST1_DLL, KBC,       0x18, 26, 0x88, 14, 0xA4, 12),
+	PINGROUP(KBCD,  SYS,   KBC,       NAND,      SDIO2,     MIO,           KBC,       0x20, 10, 0x98, 26, 0xA4, 14),
+	PINGROUP(KBCE,  SYS,   KBC,       NAND,      OWR,       RSVD,          KBC,       0x14, 26, 0x80, 28, 0xB0, 2),
+	PINGROUP(KBCF,  SYS,   KBC,       NAND,      TRACE,     MIO,           KBC,       0x14, 27, 0x80, 26, 0xB0, 0),
+	PINGROUP(LCSN,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          RSVD4,     0x1C, 31, 0x90, 12, 0xAC, 20),
+	PINGROUP(LD0,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 0,  0x94, 0,  0xAC, 12),
+	PINGROUP(LD1,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 1,  0x94, 2,  0xAC, 12),
+	PINGROUP(LD10,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 10, 0x94, 20, 0xAC, 12),
+	PINGROUP(LD11,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 11, 0x94, 22, 0xAC, 12),
+	PINGROUP(LD12,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 12, 0x94, 24, 0xAC, 12),
+	PINGROUP(LD13,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 13, 0x94, 26, 0xAC, 12),
+	PINGROUP(LD14,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 14, 0x94, 28, 0xAC, 12),
+	PINGROUP(LD15,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 15, 0x94, 30, 0xAC, 12),
+	PINGROUP(LD16,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 16, 0x98, 0,  0xAC, 12),
+	PINGROUP(LD17,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 17, 0x98, 2,  0xAC, 12),
+	PINGROUP(LD2,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 2,  0x94, 4,  0xAC, 12),
+	PINGROUP(LD3,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 3,  0x94, 6,  0xAC, 12),
+	PINGROUP(LD4,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 4,  0x94, 8,  0xAC, 12),
+	PINGROUP(LD5,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 5,  0x94, 10, 0xAC, 12),
+	PINGROUP(LD6,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 6,  0x94, 12, 0xAC, 12),
+	PINGROUP(LD7,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 7,  0x94, 14, 0xAC, 12),
+	PINGROUP(LD8,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 8,  0x94, 16, 0xAC, 12),
+	PINGROUP(LD9,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 9,  0x94, 18, 0xAC, 12),
+	PINGROUP(LDC,   LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 30, 0x90, 14, 0xAC, 20),
+	PINGROUP(LDI,   LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x20, 6,  0x98, 16, 0xAC, 18),
+	PINGROUP(LHP0,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 18, 0x98, 10, 0xAC, 16),
+	PINGROUP(LHP1,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 19, 0x98, 4,  0xAC, 14),
+	PINGROUP(LHP2,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 20, 0x98, 6,  0xAC, 14),
+	PINGROUP(LHS,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x20, 7,  0x90, 22, 0xAC, 22),
+	PINGROUP(LM0,   LCD,   DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          RSVD4,     0x1C, 24, 0x90, 26, 0xAC, 22),
+	PINGROUP(LM1,   LCD,   DISPLAYA,  DISPLAYB,  RSVD,      CRT,           RSVD3,     0x1C, 25, 0x90, 28, 0xAC, 22),
+	PINGROUP(LPP,   LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x20, 8,  0x98, 14, 0xAC, 18),
+	PINGROUP(LPW0,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          DISPLAYA,  0x20, 3,  0x90, 0,  0xAC, 20),
+	PINGROUP(LPW1,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x20, 4,  0x90, 2,  0xAC, 20),
+	PINGROUP(LPW2,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          DISPLAYA,  0x20, 5,  0x90, 4,  0xAC, 20),
+	PINGROUP(LSC0,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 27, 0x90, 18, 0xAC, 22),
+	PINGROUP(LSC1,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          DISPLAYA,  0x1C, 28, 0x90, 20, 0xAC, 20),
+	PINGROUP(LSCK,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          DISPLAYA,  0x1C, 29, 0x90, 16, 0xAC, 20),
+	PINGROUP(LSDA,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          DISPLAYA,  0x20, 1,  0x90, 8,  0xAC, 20),
+	PINGROUP(LSDI,  LCD,   DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          DISPLAYA,  0x20, 2,  0x90, 6,  0xAC, 20),
+	PINGROUP(LSPI,  LCD,   DISPLAYA,  DISPLAYB,  XIO,       HDMI,          DISPLAYA,  0x20, 0,  0x90, 10, 0xAC, 22),
+	PINGROUP(LVP0,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 21, 0x90, 30, 0xAC, 22),
+	PINGROUP(LVP1,  LCD,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          RSVD4,     0x1C, 22, 0x98, 8,  0xAC, 16),
+	PINGROUP(LVS,   LCD,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          RSVD4,     0x1C, 26, 0x90, 24, 0xAC, 22),
+	PINGROUP(OWC,   SYS,   OWR,       RSVD,      RSVD,      RSVD,          OWR,       0x14, 31, 0x84, 8,  0xB0, 30),
+	PINGROUP(PMC,   SYS,   PWR_ON,    PWR_INTR,  RSVD,      RSVD,          PWR_ON,    0x14, 23, 0x98, 18, -1,   -1),
+	PINGROUP(PTA,   NAND,  I2C2,      HDMI,      GMI,       RSVD,          RSVD4,     0x14, 24, 0x98, 22, 0xA4, 4),
+	PINGROUP(RM,    UART,  I2C,       RSVD,      RSVD,      RSVD,          RSVD4,     0x14, 25, 0x80, 14, 0xA4, 0),
+	PINGROUP(SDB,   SD,    UARTA,     PWM,       SDIO3,     SPI2,          PWM,       0x20, 15, 0x8C, 10, -1,   -1),
+	PINGROUP(SDC,   SD,    PWM,       TWC,       SDIO3,     SPI3,          TWC,       0x18, 1,  0x8C, 12, 0xAC, 28),
+	PINGROUP(SDD,   SD,    UARTA,     PWM,       SDIO3,     SPI3,          PWM,       0x18, 2,  0x8C, 14, 0xAC, 30),
+	PINGROUP(SDIO1, BB,    SDIO1,     RSVD,      UARTE,     UARTA,         RSVD2,     0x14, 30, 0x80, 30, 0xB0, 18),
+	PINGROUP(SLXA,  SD,    PCIE,      SPI4,      SDIO3,     SPI2,          PCIE,      0x18, 3,  0x84, 6,  0xA4, 22),
+	PINGROUP(SLXC,  SD,    SPDIF,     SPI4,      SDIO3,     SPI2,          SPI4,      0x18, 5,  0x84, 10, 0xA4, 26),
+	PINGROUP(SLXD,  SD,    SPDIF,     SPI4,      SDIO3,     SPI2,          SPI4,      0x18, 6,  0x84, 12, 0xA4, 28),
+	PINGROUP(SLXK,  SD,    PCIE,      SPI4,      SDIO3,     SPI2,          PCIE,      0x18, 7,  0x84, 14, 0xA4, 30),
+	PINGROUP(SPDI,  AUDIO, SPDIF,     RSVD,      I2C,       SDIO2,         RSVD2,     0x18, 8,  0x8C, 8,  0xA4, 16),
+	PINGROUP(SPDO,  AUDIO, SPDIF,     RSVD,      I2C,       SDIO2,         RSVD2,     0x18, 9,  0x8C, 6,  0xA4, 18),
+	PINGROUP(SPIA,  AUDIO, SPI1,      SPI2,      SPI3,      GMI,           GMI,       0x18, 10, 0x8C, 30, 0xA8, 4),
+	PINGROUP(SPIB,  AUDIO, SPI1,      SPI2,      SPI3,      GMI,           GMI,       0x18, 11, 0x8C, 28, 0xA8, 6),
+	PINGROUP(SPIC,  AUDIO, SPI1,      SPI2,      SPI3,      GMI,           GMI,       0x18, 12, 0x8C, 26, 0xA8, 8),
+	PINGROUP(SPID,  AUDIO, SPI2,      SPI1,      SPI2_ALT,  GMI,           GMI,       0x18, 13, 0x8C, 24, 0xA8, 10),
+	PINGROUP(SPIE,  AUDIO, SPI2,      SPI1,      SPI2_ALT,  GMI,           GMI,       0x18, 14, 0x8C, 22, 0xA8, 12),
+	PINGROUP(SPIF,  AUDIO, SPI3,      SPI1,      SPI2,      RSVD,          RSVD4,     0x18, 15, 0x8C, 20, 0xA8, 14),
+	PINGROUP(SPIG,  AUDIO, SPI3,      SPI2,      SPI2_ALT,  I2C,           SPI2_ALT,  0x18, 16, 0x8C, 18, 0xA8, 16),
+	PINGROUP(SPIH,  AUDIO, SPI3,      SPI2,      SPI2_ALT,  I2C,           SPI2_ALT,  0x18, 17, 0x8C, 16, 0xA8, 18),
+	PINGROUP(UAA,   BB,    SPI3,      MIPI_HS,   UARTA,     ULPI,          MIPI_HS,   0x18, 18, 0x80, 0,  0xAC, 0),
+	PINGROUP(UAB,   BB,    SPI2,      MIPI_HS,   UARTA,     ULPI,          MIPI_HS,   0x18, 19, 0x80, 2,  0xAC, 2),
+	PINGROUP(UAC,   BB,    OWR,       RSVD,      RSVD,      RSVD,          RSVD4,     0x18, 20, 0x80, 4,  0xAC, 4),
+	PINGROUP(UAD,   UART,  IRDA,      SPDIF,     UARTA,     SPI4,          SPDIF,     0x18, 21, 0x80, 6,  0xAC, 6),
+	PINGROUP(UCA,   UART,  UARTC,     RSVD,      GMI,       RSVD,          RSVD4,     0x18, 22, 0x84, 16, 0xAC, 8),
+	PINGROUP(UCB,   UART,  UARTC,     PWM,       GMI,       RSVD,          RSVD4,     0x18, 23, 0x84, 18, 0xAC, 10),
+	PINGROUP(UDA,   BB,    SPI1,      RSVD,      UARTD,     ULPI,          RSVD2,     0x20, 13, 0x80, 8,  0xB0, 16),
+	/* these pin groups only have pullup and pull down control */
+	PINGROUP(CK32,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 14),
+	PINGROUP(DDRC,  DDR,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xAC, 26),
+	PINGROUP(PMCA,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 4),
+	PINGROUP(PMCB,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 6),
+	PINGROUP(PMCC,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 8),
+	PINGROUP(PMCD,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 10),
+	PINGROUP(PMCE,  SYS,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xB0, 12),
+	PINGROUP(XM2C,  DDR,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xA8, 30),
+	PINGROUP(XM2D,  DDR,   RSVD,      RSVD,      RSVD,      RSVD,          RSVD,      -1,   -1, -1,   -1, 0xA8, 28),
+};
+
+#ifdef CONFIG_PM
+#define TRISTATE_REG_A         0x14
+#define TRISTATE_REG_NUM       4
+#define PIN_MUX_CTL_REG_A      0x80
+#define PIN_MUX_CTL_REG_NUM    8
+#define PULLUPDOWN_REG_A       0xa0
+#define PULLUPDOWN_REG_NUM     5
+
+static u32 pinmux_reg[TRISTATE_REG_NUM + PIN_MUX_CTL_REG_NUM +
+		     PULLUPDOWN_REG_NUM];
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
+void tegra_pinmux_suspend(void)
+{
+	unsigned int i;
+	u32 *ctx = pinmux_reg;
+
+	for (i = 0; i < TRISTATE_REG_NUM; i++)
+		*ctx++ = pg_readl(TRISTATE_REG_A + i*4);
+
+	for (i = 0; i < PIN_MUX_CTL_REG_NUM; i++)
+		*ctx++ = pg_readl(PIN_MUX_CTL_REG_A + i*4);
+
+	for (i = 0; i < PULLUPDOWN_REG_NUM; i++)
+		*ctx++ = pg_readl(PULLUPDOWN_REG_A + i*4);
+}
+
+void tegra_pinmux_resume(void)
+{
+	unsigned int i;
+	u32 *ctx = pinmux_reg;
+
+	for (i = 0; i < PIN_MUX_CTL_REG_NUM; i++)
+		pg_writel(*ctx++, PIN_MUX_CTL_REG_A + i*4);
+
+	for (i = 0; i < PULLUPDOWN_REG_NUM; i++)
+		pg_writel(*ctx++, PULLUPDOWN_REG_A + i*4);
+
+	for (i = 0; i < TRISTATE_REG_NUM; i++)
+		pg_writel(*ctx++, TRISTATE_REG_A + i*4);
+}
+#endif
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index 13ae102..f80d507 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -14,7 +14,8 @@
  *
  */
 
-
+#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/spinlock.h>
@@ -23,21 +24,6 @@
 #include <mach/iomap.h>
 #include <mach/pinmux.h>
 
-
-#define TEGRA_TRI_STATE(x)	(0x14 + (4 * (x)))
-#define TEGRA_PP_MUX_CTL(x)	(0x80 + (4 * (x)))
-#define TEGRA_PP_PU_PD(x)	(0xa0 + (4 * (x)))
-
-#define REG_A 0
-#define REG_B 1
-#define REG_C 2
-#define REG_D 3
-#define REG_E 4
-#define REG_F 5
-#define REG_G 6
-
-#define REG_N -1
-
 #define HSM_EN(reg)	(((reg) >> 2) & 0x1)
 #define SCHMT_EN(reg)	(((reg) >> 3) & 0x1)
 #define LPMD(reg)	(((reg) >> 4) & 0x3)
@@ -46,154 +32,8 @@
 #define SLWR(reg)	(((reg) >> 28) & 0x3)
 #define SLWF(reg)	(((reg) >> 30) & 0x3)
 
-struct tegra_pingroup_desc {
-	const char *name;
-	int funcs[4];
-	s8 tri_reg; 	/* offset into the TRISTATE_REG_* register bank */
-	s8 tri_bit; 	/* offset into the TRISTATE_REG_* register bit */
-	s8 mux_reg;	/* offset into the PIN_MUX_CTL_* register bank */
-	s8 mux_bit;	/* offset into the PIN_MUX_CTL_* register bit */
-	s8 pupd_reg;	/* offset into the PULL_UPDOWN_REG_* register bank */
-	s8 pupd_bit;	/* offset into the PULL_UPDOWN_REG_* register bit */
-};
-
-#define PINGROUP(pg_name, f0, f1, f2, f3,			\
-		 tri_r, tri_b, mux_r, mux_b, pupd_r, pupd_b)	\
-	[TEGRA_PINGROUP_ ## pg_name] = {			\
-		.name = #pg_name,				\
-		.funcs = {					\
-			TEGRA_MUX_ ## f0,			\
-			TEGRA_MUX_ ## f1,			\
-			TEGRA_MUX_ ## f2,			\
-			TEGRA_MUX_ ## f3,			\
-		},						\
-		.tri_reg = REG_ ## tri_r,			\
-		.tri_bit = tri_b,				\
-		.mux_reg = REG_ ## mux_r,			\
-		.mux_bit = mux_b,				\
-		.pupd_reg = REG_ ## pupd_r,			\
-		.pupd_bit = pupd_b,				\
-	}
-
-static const struct tegra_pingroup_desc pingroups[TEGRA_MAX_PINGROUP] = {
-	PINGROUP(ATA,   IDE,       NAND,      GMI,       RSVD,          A, 0,  A, 24, A, 0),
-	PINGROUP(ATB,   IDE,       NAND,      GMI,       SDIO4,         A, 1,  A, 16, A, 2),
-	PINGROUP(ATC,   IDE,       NAND,      GMI,       SDIO4,         A, 2,  A, 22, A, 4),
-	PINGROUP(ATD,   IDE,       NAND,      GMI,       SDIO4,         A, 3,  A, 20, A, 6),
-	PINGROUP(ATE,   IDE,       NAND,      GMI,       RSVD,          B, 25, A, 12, A, 8),
-	PINGROUP(CDEV1, OSC,       PLLA_OUT,  PLLM_OUT1, AUDIO_SYNC,    A, 4,  C, 2,  C, 0),
-	PINGROUP(CDEV2, OSC,       AHB_CLK,   APB_CLK,   PLLP_OUT4,     A, 5,  C, 4,  C, 2),
-	PINGROUP(CRTP,  CRT,       RSVD,      RSVD,      RSVD,          D, 14, G, 20, B, 24),
-	PINGROUP(CSUS,  PLLC_OUT1, PLLP_OUT2, PLLP_OUT3, VI_SENSOR_CLK, A, 6,  C, 6,  D, 24),
-	PINGROUP(DAP1,  DAP1,      RSVD,      GMI,       SDIO2,         A, 7,  C, 20, A, 10),
-	PINGROUP(DAP2,  DAP2,      TWC,       RSVD,      GMI,           A, 8,  C, 22, A, 12),
-	PINGROUP(DAP3,  DAP3,      RSVD,      RSVD,      RSVD,          A, 9,  C, 24, A, 14),
-	PINGROUP(DAP4,  DAP4,      RSVD,      GMI,       RSVD,          A, 10, C, 26, A, 16),
-	PINGROUP(DDC,   I2C2,      RSVD,      RSVD,      RSVD,          B, 31, C, 0,  E, 28),
-	PINGROUP(DTA,   RSVD,      SDIO2,     VI,        RSVD,          A, 11, B, 20, A, 18),
-	PINGROUP(DTB,   RSVD,      RSVD,      VI,        SPI1,          A, 12, B, 22, A, 20),
-	PINGROUP(DTC,   RSVD,      RSVD,      VI,        RSVD,          A, 13, B, 26, A, 22),
-	PINGROUP(DTD,   RSVD,      SDIO2,     VI,        RSVD,          A, 14, B, 28, A, 24),
-	PINGROUP(DTE,   RSVD,      RSVD,      VI,        SPI1,          A, 15, B, 30, A, 26),
-	PINGROUP(DTF,   I2C3,      RSVD,      VI,        RSVD,          D, 12, G, 30, A, 28),
-	PINGROUP(GMA,   UARTE,     SPI3,      GMI,       SDIO4,         A, 28, B, 0,  E, 20),
-	PINGROUP(GMB,   IDE,       NAND,      GMI,       GMI_INT,       B, 29, C, 28, E, 22),
-	PINGROUP(GMC,   UARTD,     SPI4,      GMI,       SFLASH,        A, 29, B, 2,  E, 24),
-	PINGROUP(GMD,   RSVD,      NAND,      GMI,       SFLASH,        B, 30, C, 30, E, 26),
-	PINGROUP(GME,   RSVD,      DAP5,      GMI,       SDIO4,         B, 0,  D, 0,  C, 24),
-	PINGROUP(GPU,   PWM,       UARTA,     GMI,       RSVD,          A, 16, D, 4,  B, 20),
-	PINGROUP(GPU7,  RTCK,      RSVD,      RSVD,      RSVD,          D, 11, G, 28, B, 6),
-	PINGROUP(GPV,   PCIE,      RSVD,      RSVD,      RSVD,          A, 17, D, 2,  A, 30),
-	PINGROUP(HDINT, HDMI,      RSVD,      RSVD,      RSVD,          C, 23, B, 4,  D, 22),
-	PINGROUP(I2CP,  I2C,       RSVD,      RSVD,      RSVD,          A, 18, C, 8,  B, 2),
-	PINGROUP(IRRX,  UARTA,     UARTB,     GMI,       SPI4,          A, 20, C, 18, C, 22),
-	PINGROUP(IRTX,  UARTA,     UARTB,     GMI,       SPI4,          A, 19, C, 16, C, 20),
-	PINGROUP(KBCA,  KBC,       NAND,      SDIO2,     EMC_TEST0_DLL, A, 22, C, 10, B, 8),
-	PINGROUP(KBCB,  KBC,       NAND,      SDIO2,     MIO,           A, 21, C, 12, B, 10),
-	PINGROUP(KBCC,  KBC,       NAND,      TRACE,     EMC_TEST1_DLL, B, 26, C, 14, B, 12),
-	PINGROUP(KBCD,  KBC,       NAND,      SDIO2,     MIO,           D, 10, G, 26, B, 14),
-	PINGROUP(KBCE,  KBC,       NAND,      OWR,       RSVD,          A, 26, A, 28, E, 2),
-	PINGROUP(KBCF,  KBC,       NAND,      TRACE,     MIO,           A, 27, A, 26, E, 0),
-	PINGROUP(LCSN,  DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          C, 31, E, 12, D, 20),
-	PINGROUP(LD0,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 0,  F, 0,  D, 12),
-	PINGROUP(LD1,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 1,  F, 2,  D, 12),
-	PINGROUP(LD10,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 10, F, 20, D, 12),
-	PINGROUP(LD11,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 11, F, 22, D, 12),
-	PINGROUP(LD12,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 12, F, 24, D, 12),
-	PINGROUP(LD13,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 13, F, 26, D, 12),
-	PINGROUP(LD14,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 14, F, 28, D, 12),
-	PINGROUP(LD15,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 15, F, 30, D, 12),
-	PINGROUP(LD16,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 16, G, 0,  D, 12),
-	PINGROUP(LD17,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 17, G, 2,  D, 12),
-	PINGROUP(LD2,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 2,  F, 4,  D, 12),
-	PINGROUP(LD3,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 3,  F, 6,  D, 12),
-	PINGROUP(LD4,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 4,  F, 8,  D, 12),
-	PINGROUP(LD5,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 5,  F, 10, D, 12),
-	PINGROUP(LD6,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 6,  F, 12, D, 12),
-	PINGROUP(LD7,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 7,  F, 14, D, 12),
-	PINGROUP(LD8,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 8,  F, 16, D, 12),
-	PINGROUP(LD9,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 9,  F, 18, D, 12),
-	PINGROUP(LDC,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 30, E, 14, D, 20),
-	PINGROUP(LDI,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 6,  G, 16, D, 18),
-	PINGROUP(LHP0,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 18, G, 10, D, 16),
-	PINGROUP(LHP1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 19, G, 4,  D, 14),
-	PINGROUP(LHP2,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 20, G, 6,  D, 14),
-	PINGROUP(LHS,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          D, 7,  E, 22, D, 22),
-	PINGROUP(LM0,   DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          C, 24, E, 26, D, 22),
-	PINGROUP(LM1,   DISPLAYA,  DISPLAYB,  RSVD,      CRT,           C, 25, E, 28, D, 22),
-	PINGROUP(LPP,   DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 8,  G, 14, D, 18),
-	PINGROUP(LPW0,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 3,  E, 0,  D, 20),
-	PINGROUP(LPW1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          D, 4,  E, 2,  D, 20),
-	PINGROUP(LPW2,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 5,  E, 4,  D, 20),
-	PINGROUP(LSC0,  DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 27, E, 18, D, 22),
-	PINGROUP(LSC1,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          C, 28, E, 20, D, 20),
-	PINGROUP(LSCK,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          C, 29, E, 16, D, 20),
-	PINGROUP(LSDA,  DISPLAYA,  DISPLAYB,  SPI3,      HDMI,          D, 1,  E, 8,  D, 20),
-	PINGROUP(LSDI,  DISPLAYA,  DISPLAYB,  SPI3,      RSVD,          D, 2,  E, 6,  D, 20),
-	PINGROUP(LSPI,  DISPLAYA,  DISPLAYB,  XIO,       HDMI,          D, 0,  E, 10, D, 22),
-	PINGROUP(LVP0,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 21, E, 30, D, 22),
-	PINGROUP(LVP1,  DISPLAYA,  DISPLAYB,  RSVD,      RSVD,          C, 22, G, 8,  D, 16),
-	PINGROUP(LVS,   DISPLAYA,  DISPLAYB,  XIO,       RSVD,          C, 26, E, 24, D, 22),
-	PINGROUP(OWC,   OWR,       RSVD,      RSVD,      RSVD,          A, 31, B, 8,  E, 30),
-	PINGROUP(PMC,   PWR_ON,    PWR_INTR,  RSVD,      RSVD,          A, 23, G, 18, N, -1),
-	PINGROUP(PTA,   I2C2,      HDMI,      GMI,       RSVD,          A, 24, G, 22, B, 4),
-	PINGROUP(RM,    I2C,       RSVD,      RSVD,      RSVD,          A, 25, A, 14, B, 0),
-	PINGROUP(SDB,   UARTA,     PWM,       SDIO3,     SPI2,          D, 15, D, 10, N, -1),
-	PINGROUP(SDC,   PWM,       TWC,       SDIO3,     SPI3,          B, 1,  D, 12, D, 28),
-	PINGROUP(SDD,   UARTA,     PWM,       SDIO3,     SPI3,          B, 2,  D, 14, D, 30),
-	PINGROUP(SDIO1, SDIO1,     RSVD,      UARTE,     UARTA,         A, 30, A, 30, E, 18),
-	PINGROUP(SLXA,  PCIE,      SPI4,      SDIO3,     SPI2,          B, 3,  B, 6,  B, 22),
-	PINGROUP(SLXC,  SPDIF,     SPI4,      SDIO3,     SPI2,          B, 5,  B, 10, B, 26),
-	PINGROUP(SLXD,  SPDIF,     SPI4,      SDIO3,     SPI2,          B, 6,  B, 12, B, 28),
-	PINGROUP(SLXK,  PCIE,      SPI4,      SDIO3,     SPI2,          B, 7,  B, 14, B, 30),
-	PINGROUP(SPDI,  SPDIF,     RSVD,      I2C,       SDIO2,         B, 8,  D, 8,  B, 16),
-	PINGROUP(SPDO,  SPDIF,     RSVD,      I2C,       SDIO2,         B, 9,  D, 6,  B, 18),
-	PINGROUP(SPIA,  SPI1,      SPI2,      SPI3,      GMI,           B, 10, D, 30, C, 4),
-	PINGROUP(SPIB,  SPI1,      SPI2,      SPI3,      GMI,           B, 11, D, 28, C, 6),
-	PINGROUP(SPIC,  SPI1,      SPI2,      SPI3,      GMI,           B, 12, D, 26, C, 8),
-	PINGROUP(SPID,  SPI2,      SPI1,      SPI2_ALT,  GMI,           B, 13, D, 24, C, 10),
-	PINGROUP(SPIE,  SPI2,      SPI1,      SPI2_ALT,  GMI,           B, 14, D, 22, C, 12),
-	PINGROUP(SPIF,  SPI3,      SPI1,      SPI2,      RSVD,          B, 15, D, 20, C, 14),
-	PINGROUP(SPIG,  SPI3,      SPI2,      SPI2_ALT,  I2C,           B, 16, D, 18, C, 16),
-	PINGROUP(SPIH,  SPI3,      SPI2,      SPI2_ALT,  I2C,           B, 17, D, 16, C, 18),
-	PINGROUP(UAA,   SPI3,      MIPI_HS,   UARTA,     ULPI,          B, 18, A, 0,  D, 0),
-	PINGROUP(UAB,   SPI2,      MIPI_HS,   UARTA,     ULPI,          B, 19, A, 2,  D, 2),
-	PINGROUP(UAC,   OWR,       RSVD,      RSVD,      RSVD,          B, 20, A, 4,  D, 4),
-	PINGROUP(UAD,   IRDA,      SPDIF,     UARTA,     SPI4,          B, 21, A, 6,  D, 6),
-	PINGROUP(UCA,   UARTC,     RSVD,      GMI,       RSVD,          B, 22, B, 16, D, 8),
-	PINGROUP(UCB,   UARTC,     PWM,       GMI,       RSVD,          B, 23, B, 18, D, 10),
-	PINGROUP(UDA,   SPI1,      RSVD,      UARTD,     ULPI,          D, 13, A, 8,  E, 16),
-	/* these pin groups only have pullup and pull down control */
-	PINGROUP(CK32,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 14),
-	PINGROUP(DDRC,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  D, 26),
-	PINGROUP(PMCA,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 4),
-	PINGROUP(PMCB,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 6),
-	PINGROUP(PMCC,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 8),
-	PINGROUP(PMCD,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 10),
-	PINGROUP(PMCE,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  E, 12),
-	PINGROUP(XM2C,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  C, 30),
-	PINGROUP(XM2D,  RSVD,      RSVD,      RSVD,      RSVD,          N, -1,  N, -1,  C, 28),
-};
+static const struct tegra_pingroup_desc *const pingroups = tegra_soc_pingroups;
+static const struct tegra_drive_pingroup_desc *const drive_pingroups = tegra_soc_drive_pingroups;
 
 static char *tegra_mux_names[TEGRA_MAX_MUX] = {
 	[TEGRA_MUX_AHB_CLK] = "AHB_CLK",
@@ -256,48 +96,7 @@ static char *tegra_mux_names[TEGRA_MAX_MUX] = {
 	[TEGRA_MUX_VI] = "VI",
 	[TEGRA_MUX_VI_SENSOR_CLK] = "VI_SENSOR_CLK",
 	[TEGRA_MUX_XIO] = "XIO",
-};
-
-struct tegra_drive_pingroup_desc {
-	const char *name;
-	s16 reg;
-};
-
-#define DRIVE_PINGROUP(pg_name, r)				\
-	[TEGRA_DRIVE_PINGROUP_ ## pg_name] = {			\
-		.name = #pg_name,				\
-		.reg = r					\
-	}
-
-static const struct tegra_drive_pingroup_desc drive_pingroups[TEGRA_MAX_PINGROUP] = {
-	DRIVE_PINGROUP(AO1,		0x868),
-	DRIVE_PINGROUP(AO2,		0x86c),
-	DRIVE_PINGROUP(AT1,		0x870),
-	DRIVE_PINGROUP(AT2,		0x874),
-	DRIVE_PINGROUP(CDEV1,		0x878),
-	DRIVE_PINGROUP(CDEV2,		0x87c),
-	DRIVE_PINGROUP(CSUS,		0x880),
-	DRIVE_PINGROUP(DAP1,		0x884),
-	DRIVE_PINGROUP(DAP2,		0x888),
-	DRIVE_PINGROUP(DAP3,		0x88c),
-	DRIVE_PINGROUP(DAP4,		0x890),
-	DRIVE_PINGROUP(DBG,		0x894),
-	DRIVE_PINGROUP(LCD1,		0x898),
-	DRIVE_PINGROUP(LCD2,		0x89c),
-	DRIVE_PINGROUP(SDMMC2,	0x8a0),
-	DRIVE_PINGROUP(SDMMC3,	0x8a4),
-	DRIVE_PINGROUP(SPI,		0x8a8),
-	DRIVE_PINGROUP(UAA,		0x8ac),
-	DRIVE_PINGROUP(UAB,		0x8b0),
-	DRIVE_PINGROUP(UART2,		0x8b4),
-	DRIVE_PINGROUP(UART3,		0x8b8),
-	DRIVE_PINGROUP(VI1,		0x8bc),
-	DRIVE_PINGROUP(VI2,		0x8c0),
-	DRIVE_PINGROUP(XM2A,		0x8c4),
-	DRIVE_PINGROUP(XM2C,		0x8c8),
-	DRIVE_PINGROUP(XM2D,		0x8cc),
-	DRIVE_PINGROUP(XM2CLK,	0x8d0),
-	DRIVE_PINGROUP(MEMCOMP,	0x8d4),
+	[TEGRA_MUX_SAFE] = "<safe>",
 };
 
 static const char *tegra_drive_names[TEGRA_MAX_DRIVE] = {
@@ -381,22 +180,27 @@ static inline void pg_writel(unsigned long value, unsigned long offset)
 	writel(value, IO_TO_VIRT(TEGRA_APB_MISC_BASE + offset));
 }
 
-int tegra_pinmux_set_func(enum tegra_pingroup pg, enum tegra_mux_func func)
+static int tegra_pinmux_set_func(const struct tegra_pingroup_config *config)
 {
 	int mux = -1;
 	int i;
 	unsigned long reg;
 	unsigned long flags;
+	enum tegra_pingroup pg = config->pingroup;
+	enum tegra_mux_func func = config->func;
 
 	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
 		return -ERANGE;
 
-	if (pingroups[pg].mux_reg == REG_N)
+	if (pingroups[pg].mux_reg < 0)
 		return -EINVAL;
 
 	if (func < 0)
 		return -ERANGE;
 
+	if (func == TEGRA_MUX_SAFE)
+		func = pingroups[pg].func_safe;
+
 	if (func & TEGRA_MUX_RSVD) {
 		mux = func & 0x3;
 	} else {
@@ -413,10 +217,10 @@ int tegra_pinmux_set_func(enum tegra_pingroup pg, enum tegra_mux_func func)
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(TEGRA_PP_MUX_CTL(pingroups[pg].mux_reg));
+	reg = pg_readl(pingroups[pg].mux_reg);
 	reg &= ~(0x3 << pingroups[pg].mux_bit);
 	reg |= mux << pingroups[pg].mux_bit;
-	pg_writel(reg, TEGRA_PP_MUX_CTL(pingroups[pg].mux_reg));
+	pg_writel(reg, pingroups[pg].mux_reg);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -432,16 +236,16 @@ int tegra_pinmux_set_tristate(enum tegra_pingroup pg,
 	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
 		return -ERANGE;
 
-	if (pingroups[pg].tri_reg == REG_N)
+	if (pingroups[pg].tri_reg < 0)
 		return -EINVAL;
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(TEGRA_TRI_STATE(pingroups[pg].tri_reg));
+	reg = pg_readl(pingroups[pg].tri_reg);
 	reg &= ~(0x1 << pingroups[pg].tri_bit);
 	if (tristate)
 		reg |= 1 << pingroups[pg].tri_bit;
-	pg_writel(reg, TEGRA_TRI_STATE(pingroups[pg].tri_reg));
+	pg_writel(reg, pingroups[pg].tri_reg);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
@@ -457,7 +261,7 @@ int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
 	if (pg < 0 || pg >=  TEGRA_MAX_PINGROUP)
 		return -ERANGE;
 
-	if (pingroups[pg].pupd_reg == REG_N)
+	if (pingroups[pg].pupd_reg < 0)
 		return -EINVAL;
 
 	if (pupd != TEGRA_PUPD_NORMAL &&
@@ -468,38 +272,39 @@ int tegra_pinmux_set_pullupdown(enum tegra_pingroup pg,
 
 	spin_lock_irqsave(&mux_lock, flags);
 
-	reg = pg_readl(TEGRA_PP_PU_PD(pingroups[pg].pupd_reg));
+	reg = pg_readl(pingroups[pg].pupd_reg);
 	reg &= ~(0x3 << pingroups[pg].pupd_bit);
 	reg |= pupd << pingroups[pg].pupd_bit;
-	pg_writel(reg, TEGRA_PP_PU_PD(pingroups[pg].pupd_reg));
+	pg_writel(reg, pingroups[pg].pupd_reg);
 
 	spin_unlock_irqrestore(&mux_lock, flags);
 
 	return 0;
 }
 
-void tegra_pinmux_config_pingroup(enum tegra_pingroup pingroup,
-				 enum tegra_mux_func func,
-				 enum tegra_pullupdown pupd,
-				 enum tegra_tristate tristate)
+static void tegra_pinmux_config_pingroup(const struct tegra_pingroup_config *config)
 {
+	enum tegra_pingroup pingroup = config->pingroup;
+	enum tegra_mux_func func     = config->func;
+	enum tegra_pullupdown pupd   = config->pupd;
+	enum tegra_tristate tristate = config->tristate;
 	int err;
 
-	if (pingroups[pingroup].mux_reg != REG_N) {
-		err = tegra_pinmux_set_func(pingroup, func);
+	if (pingroups[pingroup].mux_reg >= 0) {
+		err = tegra_pinmux_set_func(config);
 		if (err < 0)
 			pr_err("pinmux: can't set pingroup %s func to %s: %d\n",
 			       pingroup_name(pingroup), func_name(func), err);
 	}
 
-	if (pingroups[pingroup].pupd_reg != REG_N) {
+	if (pingroups[pingroup].pupd_reg >= 0) {
 		err = tegra_pinmux_set_pullupdown(pingroup, pupd);
 		if (err < 0)
 			pr_err("pinmux: can't set pingroup %s pullupdown to %s: %d\n",
 			       pingroup_name(pingroup), pupd_name(pupd), err);
 	}
 
-	if (pingroups[pingroup].tri_reg != REG_N) {
+	if (pingroups[pingroup].tri_reg >= 0) {
 		err = tegra_pinmux_set_tristate(pingroup, tristate);
 		if (err < 0)
 			pr_err("pinmux: can't set pingroup %s tristate to %s: %d\n",
@@ -507,17 +312,12 @@ void tegra_pinmux_config_pingroup(enum tegra_pingroup pingroup,
 	}
 }
 
-
-
-void tegra_pinmux_config_table(struct tegra_pingroup_config *config, int len)
+void tegra_pinmux_config_table(const struct tegra_pingroup_config *config, int len)
 {
 	int i;
 
 	for (i = 0; i < len; i++)
-		tegra_pinmux_config_pingroup(config[i].pingroup,
-					     config[i].func,
-					     config[i].pupd,
-					     config[i].tristate);
+		tegra_pinmux_config_pingroup(&config[i]);
 }
 
 static const char *drive_pinmux_name(enum tegra_drive_pingroup pg)
@@ -784,6 +584,86 @@ void tegra_drive_pinmux_config_table(struct tegra_drive_pingroup_config *config,
 						     config[i].slew_falling);
 }
 
+void tegra_pinmux_set_safe_pinmux_table(const struct tegra_pingroup_config *config,
+	int len)
+{
+	int i;
+	struct tegra_pingroup_config c;
+
+	for (i = 0; i < len; i++) {
+		int err;
+		c = config[i];
+		if (c.pingroup < 0 || c.pingroup >= TEGRA_MAX_PINGROUP) {
+			WARN_ON(1);
+			continue;
+		}
+		c.func = pingroups[c.pingroup].func_safe;
+		err = tegra_pinmux_set_func(&c);
+		if (err < 0)
+			pr_err("%s: tegra_pinmux_set_func returned %d setting "
+			       "%s to %s\n", __func__, err,
+			       pingroup_name(c.pingroup), func_name(c.func));
+	}
+}
+
+void tegra_pinmux_config_pinmux_table(const struct tegra_pingroup_config *config,
+	int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int err;
+		if (config[i].pingroup < 0 ||
+		    config[i].pingroup >= TEGRA_MAX_PINGROUP) {
+			WARN_ON(1);
+			continue;
+		}
+		err = tegra_pinmux_set_func(&config[i]);
+		if (err < 0)
+			pr_err("%s: tegra_pinmux_set_func returned %d setting "
+			       "%s to %s\n", __func__, err,
+			       pingroup_name(config[i].pingroup),
+			       func_name(config[i].func));
+	}
+}
+
+void tegra_pinmux_config_tristate_table(const struct tegra_pingroup_config *config,
+	int len, enum tegra_tristate tristate)
+{
+	int i;
+	int err;
+	enum tegra_pingroup pingroup;
+
+	for (i = 0; i < len; i++) {
+		pingroup = config[i].pingroup;
+		if (pingroups[pingroup].tri_reg >= 0) {
+			err = tegra_pinmux_set_tristate(pingroup, tristate);
+			if (err < 0)
+				pr_err("pinmux: can't set pingroup %s tristate"
+					" to %s: %d\n",	pingroup_name(pingroup),
+					tri_name(tristate), err);
+		}
+	}
+}
+
+void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *config,
+	int len, enum tegra_pullupdown pupd)
+{
+	int i;
+	int err;
+	enum tegra_pingroup pingroup;
+
+	for (i = 0; i < len; i++) {
+		pingroup = config[i].pingroup;
+		if (pingroups[pingroup].pupd_reg >= 0) {
+			err = tegra_pinmux_set_pullupdown(pingroup, pupd);
+			if (err < 0)
+				pr_err("pinmux: can't set pingroup %s pullupdown"
+					" to %s: %d\n",	pingroup_name(pingroup),
+					pupd_name(pupd), err);
+		}
+	}
+}
 
 #ifdef	CONFIG_DEBUG_FS
 
@@ -812,11 +692,11 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 		len = strlen(pingroups[i].name);
 		dbg_pad_field(s, 5 - len);
 
-		if (pingroups[i].mux_reg == REG_N) {
+		if (pingroups[i].mux_reg < 0) {
 			seq_printf(s, "TEGRA_MUX_NONE");
 			len = strlen("NONE");
 		} else {
-			mux = (pg_readl(TEGRA_PP_MUX_CTL(pingroups[i].mux_reg)) >>
+			mux = (pg_readl(pingroups[i].mux_reg) >>
 			       pingroups[i].mux_bit) & 0x3;
 			if (pingroups[i].funcs[mux] == TEGRA_MUX_RSVD) {
 				seq_printf(s, "TEGRA_MUX_RSVD%1lu", mux+1);
@@ -829,21 +709,21 @@ static int dbg_pinmux_show(struct seq_file *s, void *unused)
 		}
 		dbg_pad_field(s, 13-len);
 
-		if (pingroups[i].mux_reg == REG_N) {
+		if (pingroups[i].pupd_reg < 0) {
 			seq_printf(s, "TEGRA_PUPD_NORMAL");
 			len = strlen("NORMAL");
 		} else {
-			pupd = (pg_readl(TEGRA_PP_PU_PD(pingroups[i].pupd_reg)) >>
+			pupd = (pg_readl(pingroups[i].pupd_reg) >>
 				pingroups[i].pupd_bit) & 0x3;
 			seq_printf(s, "TEGRA_PUPD_%s", pupd_name(pupd));
 			len = strlen(pupd_name(pupd));
 		}
 		dbg_pad_field(s, 9 - len);
 
-		if (pingroups[i].tri_reg == REG_N) {
+		if (pingroups[i].tri_reg < 0) {
 			seq_printf(s, "TEGRA_TRI_NORMAL");
 		} else {
-			tri = (pg_readl(TEGRA_TRI_STATE(pingroups[i].tri_reg)) >>
+			tri = (pg_readl(pingroups[i].tri_reg) >>
 			       pingroups[i].tri_bit) & 0x1;
 
 			seq_printf(s, "TEGRA_TRI_%s", tri_name(tri));
-- 
1.7.1
