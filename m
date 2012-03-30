From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 17:00:01 -0600
Subject: [PATCH 08/11] ARM: tegra: Switch to new pinctrl driver
In-Reply-To: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
References: <1333148404-17691-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1333148404-17691-9-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

* Rename old pinmux and new pinctrl platform driver and DT match table
  entries, so the new driver gets instantiated.
* Re-write board-pinmux.c, so that it uses pinctrl APIs to configura the
  pinmux.
* Re-write board-*-pinmux.c so that the pinmux configuration tables are
  in pinctrl format.

Ventana's pin mux table needed some edits on top of the basic format
conversion, since some mux options that were previously marked as
reserved are now valid in the new pinctrl driver. Attempting to use the
old reserved names will result in a failure. Specifically, groups lpw0,
lpw2, lsc1, lsck, and lsda were changed from function rsvd4 to displaya,
and group pta was changed from function rsvd2 to hdmi.

All boards' pin mux tables needed some edits on top of the based format
conversion, since function i2c was split into i2c1 (first general I2C
controller) and i2cp (power I2C controller) to better align function
definitions with HW blocks.

Due to the split of mux tables into pure mux and pull/tristate tables,
many entries in the separate Seaboard/Ventana tables could be merged
into the common table, since the entries differed only in the portion
in one of the tables, not both.

Most pin groups allow configuration of mux, tri-state, and pull. However,
some don't allow pull configuration, which is instead configured by new
groups that only allow pull configuration. This is a reflection of the
true HW capabilities, which weren't fully represented by the old pinmux
driver. This required adding new pull table entries for those new groups,
and setting many other entries' pull configuration to
TEGRA_PINCONFIG_DONT_SET.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3: Remove GPIO-related code, use mapping table instead of pinctrl APIs
    for all pinconfig setup. Don't tristate PCIe pingroups on Harmony.
    Note: Before this version, this patch had the following acks, but I've
    removed them due to the rework:
    Linus Walleij <linus.walleij@linaro.org>
    Olof Johansson <olof@lixom.net>
v2: No change?
---
 arch/arm/mach-tegra/board-harmony-pinmux.c   |  249 ++++++++++----------
 arch/arm/mach-tegra/board-paz00-pinmux.c     |  249 ++++++++++----------
 arch/arm/mach-tegra/board-pinmux.c           |   76 ++++---
 arch/arm/mach-tegra/board-pinmux.h           |   35 +++-
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |  314 +++++++++++++-------------
 arch/arm/mach-tegra/board-trimslice-pinmux.c |  252 +++++++++++----------
 arch/arm/mach-tegra/pinmux.c                 |    6 +-
 drivers/pinctrl/pinctrl-tegra.c              |    6 +-
 8 files changed, 609 insertions(+), 578 deletions(-)

diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
index 3ebe2c8..83d420f 100644
--- a/arch/arm/mach-tegra/board-harmony-pinmux.c
+++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/board-harmony-pinmux.c
  *
  * Copyright (C) 2010 Google, Inc.
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -15,136 +16,138 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/of.h>
-
-#include <mach/pinmux.h>
-#include <mach/pinmux-tegra20.h>
 
 #include "board-harmony.h"
 #include "board-pinmux.h"
 
-static struct tegra_pingroup_config harmony_pinmux[] = {
-	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_UARTD,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+static struct pinctrl_map harmony_map[] = {
+	TEGRA_MAP_MUXCONF("ata",   "ide",           none, driven),
+	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("atc",   "nand",          none, driven),
+	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
+	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, tristate),
+	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
+	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", down, tristate),
+	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
+	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
+	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
+	TEGRA_MAP_MUXCONF("dta",   "sdio2",         up,   driven),
+	TEGRA_MAP_MUXCONF("dtb",   "rsvd1",         none, driven),
+	TEGRA_MAP_MUXCONF("dtc",   "rsvd1",         none, tristate),
+	TEGRA_MAP_MUXCONF("dtd",   "sdio2",         up,   driven),
+	TEGRA_MAP_MUXCONF("dte",   "rsvd1",         none, tristate),
+	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, tristate),
+	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gmb",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("gmc",   "uartd",         none, driven),
+	TEGRA_MAP_MUXCONF("gmd",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gpu",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
+	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
+	TEGRA_MAP_MUXCONF("irrx",  "uarta",         up,   tristate),
+	TEGRA_MAP_MUXCONF("irtx",  "uarta",         up,   tristate),
+	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("lcsn",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("ld0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld1",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld10",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld11",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld12",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld13",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld14",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld15",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld16",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld17",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld2",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld3",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld4",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld5",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld6",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld7",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld8",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld9",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ldc",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm1",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsdi",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvp0",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         na,   tristate),
+	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
+	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
+	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
+	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   tristate),
+	TEGRA_MAP_MUXCONF("sdc",   "pwm",           up,   driven),
+	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   tristate),
+	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, tristate),
+	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("slxc",  "spdif",         none, tristate),
+	TEGRA_MAP_MUXCONF("slxd",  "spdif",         none, tristate),
+	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("spia",  "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("spib",  "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   tristate),
+	TEGRA_MAP_MUXCONF("spid",  "spi1",          down, tristate),
+	TEGRA_MAP_MUXCONF("spie",  "spi1",          up,   tristate),
+	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
+	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      none, tristate),
+	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
+	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("uad",   "irda",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uca",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("ucb",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, tristate),
+	TEGRA_MAP_CONF("ck32",    none, na),
+	TEGRA_MAP_CONF("ddrc",    none, na),
+	TEGRA_MAP_CONF("pmca",    none, na),
+	TEGRA_MAP_CONF("pmcb",    none, na),
+	TEGRA_MAP_CONF("pmcc",    none, na),
+	TEGRA_MAP_CONF("pmcd",    none, na),
+	TEGRA_MAP_CONF("pmce",    none, na),
+	TEGRA_MAP_CONF("xm2c",    none, na),
+	TEGRA_MAP_CONF("xm2d",    none, na),
+	TEGRA_MAP_CONF("ls",      up,   na),
+	TEGRA_MAP_CONF("lc",      up,   na),
+	TEGRA_MAP_CONF("ld17_0",  down, na),
+	TEGRA_MAP_CONF("ld19_18", down, na),
+	TEGRA_MAP_CONF("ld21_20", down, na),
+	TEGRA_MAP_CONF("ld23_22", down, na),
 };
 
 static struct tegra_board_pinmux_conf conf = {
-	.pgs = harmony_pinmux,
-	.pg_count = ARRAY_SIZE(harmony_pinmux),
+	.maps = harmony_map,
+	.map_count = ARRAY_SIZE(harmony_map),
 };
 
 void harmony_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-paz00-pinmux.c b/arch/arm/mach-tegra/board-paz00-pinmux.c
index f0ec466..6f1111b 100644
--- a/arch/arm/mach-tegra/board-paz00-pinmux.c
+++ b/arch/arm/mach-tegra/board-paz00-pinmux.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/board-paz00-pinmux.c
  *
  * Copyright (C) 2010 Marc Dietrich <marvin24@gmx.de>
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -15,136 +16,138 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/of.h>
-
-#include <mach/pinmux.h>
-#include <mach/pinmux-tegra20.h>
 
 #include "board-paz00.h"
 #include "board-pinmux.h"
 
-static struct tegra_pingroup_config paz00_pinmux[] = {
-	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_PLLC_OUT1,     TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_RSVD1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTA,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_SDIO2,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_OWR,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_TWC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPI4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPI4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_SPDIF,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+static struct pinctrl_map paz00_map[] = {
+	TEGRA_MAP_MUXCONF("ata",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("atc",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
+	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, driven),
+	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
+	TEGRA_MAP_MUXCONF("csus",  "pllc_out1",     down, tristate),
+	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
+	TEGRA_MAP_MUXCONF("dap2",  "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
+	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
+	TEGRA_MAP_MUXCONF("dta",   "rsvd1",         up,   tristate),
+	TEGRA_MAP_MUXCONF("dtb",   "rsvd1",         none, tristate),
+	TEGRA_MAP_MUXCONF("dtc",   "rsvd1",         none, tristate),
+	TEGRA_MAP_MUXCONF("dtd",   "rsvd1",         up,   tristate),
+	TEGRA_MAP_MUXCONF("dte",   "rsvd1",         none, tristate),
+	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, driven),
+	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gmb",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("gmc",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("gmd",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gpu",   "pwm",           none, driven),
+	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
+	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   driven),
+	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
+	TEGRA_MAP_MUXCONF("irrx",  "uarta",         up,   driven),
+	TEGRA_MAP_MUXCONF("irtx",  "uarta",         up,   driven),
+	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcb",  "sdio2",         up,   driven),
+	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcd",  "sdio2",         up,   driven),
+	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("lcsn",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("ld0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld1",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld10",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld11",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld12",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld13",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld14",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld15",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld16",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld17",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld2",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld3",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld4",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld5",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld6",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld7",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld8",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld9",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ldc",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm0",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lm1",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpw1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsdi",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvp0",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("owc",   "owr",           up,   tristate),
+	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
+	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
+	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
+	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   tristate),
+	TEGRA_MAP_MUXCONF("sdc",   "twc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   tristate),
+	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, driven),
+	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, tristate),
+	TEGRA_MAP_MUXCONF("slxc",  "spi4",          none, tristate),
+	TEGRA_MAP_MUXCONF("slxd",  "spi4",          none, tristate),
+	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("spia",  "gmi",           down, tristate),
+	TEGRA_MAP_MUXCONF("spib",  "gmi",           down, tristate),
+	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   driven),
+	TEGRA_MAP_MUXCONF("spid",  "gmi",           down, tristate),
+	TEGRA_MAP_MUXCONF("spie",  "gmi",           up,   tristate),
+	TEGRA_MAP_MUXCONF("spif",  "rsvd4",         down, tristate),
+	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   driven),
+	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
+	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   driven),
+	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   driven),
+	TEGRA_MAP_MUXCONF("uac",   "rsvd4",         none, driven),
+	TEGRA_MAP_MUXCONF("uad",   "spdif",         up,   tristate),
+	TEGRA_MAP_MUXCONF("uca",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("ucb",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, driven),
+	TEGRA_MAP_CONF("ck32",    none, na),
+	TEGRA_MAP_CONF("ddrc",    none, na),
+	TEGRA_MAP_CONF("pmca",    none, na),
+	TEGRA_MAP_CONF("pmcb",    none, na),
+	TEGRA_MAP_CONF("pmcc",    none, na),
+	TEGRA_MAP_CONF("pmcd",    none, na),
+	TEGRA_MAP_CONF("pmce",    none, na),
+	TEGRA_MAP_CONF("xm2c",    none, na),
+	TEGRA_MAP_CONF("xm2d",    none, na),
+	TEGRA_MAP_CONF("ls",      up,   na),
+	TEGRA_MAP_CONF("lc",      up,   na),
+	TEGRA_MAP_CONF("ld17_0",  down, na),
+	TEGRA_MAP_CONF("ld19_18", down, na),
+	TEGRA_MAP_CONF("ld21_20", down, na),
+	TEGRA_MAP_CONF("ld23_22", down, na),
 };
 
 static struct tegra_board_pinmux_conf conf = {
-	.pgs = paz00_pinmux,
-	.pg_count = ARRAY_SIZE(paz00_pinmux),
+	.maps = paz00_map,
+	.map_count = ARRAY_SIZE(paz00_map),
 };
 
 void paz00_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-pinmux.c b/arch/arm/mach-tegra/board-pinmux.c
index 3015b5a..3b7ad07 100644
--- a/arch/arm/mach-tegra/board-pinmux.c
+++ b/arch/arm/mach-tegra/board-pinmux.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -18,47 +18,57 @@
 #include <linux/of.h>
 #include <linux/string.h>
 
-#include <mach/pinmux.h>
-
 #include "board-pinmux.h"
 #include "devices.h"
 
-struct tegra_board_pinmux_conf *confs[2];
+unsigned long tegra_pincfg_pullnone_driven[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
+};
 
-static void tegra_board_pinmux_setup_pinmux(void)
-{
-	int i;
+unsigned long tegra_pincfg_pullnone_tristate[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
+};
 
-	for (i = 0; i < ARRAY_SIZE(confs); i++) {
-		if (!confs[i])
-			continue;
+unsigned long tegra_pincfg_pullnone_na[1] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_NONE),
+};
 
-		tegra_pinmux_config_table(confs[i]->pgs, confs[i]->pg_count);
+unsigned long tegra_pincfg_pullup_driven[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
+};
 
-		if (confs[i]->drives)
-			tegra_drive_pinmux_config_table(confs[i]->drives,
-							confs[i]->drive_count);
-	}
-}
+unsigned long tegra_pincfg_pullup_tristate[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
+};
 
-static int tegra_board_pinmux_bus_notify(struct notifier_block *nb,
-					 unsigned long event, void *vdev)
-{
-	struct device *dev = vdev;
+unsigned long tegra_pincfg_pullup_na[1] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_UP),
+};
 
-	if (event != BUS_NOTIFY_BOUND_DRIVER)
-		return NOTIFY_DONE;
+unsigned long tegra_pincfg_pulldown_driven[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
+};
 
-	if (strcmp(dev_name(dev), PINMUX_DEV))
-		return NOTIFY_DONE;
+unsigned long tegra_pincfg_pulldown_tristate[2] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
+};
 
-	tegra_board_pinmux_setup_pinmux();
+unsigned long tegra_pincfg_pulldown_na[1] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_PULL, TEGRA_PINCONFIG_PULL_DOWN),
+};
 
-	return NOTIFY_STOP_MASK;
-}
+unsigned long tegra_pincfg_pullna_driven[1] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_DRIVEN),
+};
 
-static struct notifier_block nb = {
-	.notifier_call = tegra_board_pinmux_bus_notify,
+unsigned long tegra_pincfg_pullna_tristate[1] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_TRISTATE, TEGRA_PINCONFIG_TRISTATE),
 };
 
 static struct platform_device *devices[] = {
@@ -69,10 +79,10 @@ static struct platform_device *devices[] = {
 void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
 			     struct tegra_board_pinmux_conf *conf_b)
 {
-	confs[0] = conf_a;
-	confs[1] = conf_b;
-
-	bus_register_notifier(&platform_bus_type, &nb);
+	if (conf_a)
+		pinctrl_register_mappings(conf_a->maps, conf_a->map_count);
+	if (conf_b)
+		pinctrl_register_mappings(conf_b->maps, conf_b->map_count);
 
 	if (!of_machine_is_compatible("nvidia,tegra20"))
 		platform_add_devices(devices, ARRAY_SIZE(devices));
diff --git a/arch/arm/mach-tegra/board-pinmux.h b/arch/arm/mach-tegra/board-pinmux.h
index e08214d..45b5ad8 100644
--- a/arch/arm/mach-tegra/board-pinmux.h
+++ b/arch/arm/mach-tegra/board-pinmux.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2011, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2011,2012, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -15,16 +15,37 @@
 #ifndef __MACH_TEGRA_BOARD_PINMUX_H
 #define __MACH_TEGRA_BOARD_PINMUX_H
 
+#include <linux/pinctrl/machine.h>
+
+#include <mach/pinconf-tegra.h>
+
 #define PINMUX_DEV "tegra-pinmux"
 
-struct tegra_pingroup_config;
+#define TEGRA_MAP_MUX(_group_, _function_) \
+	PIN_MAP_MUX_GROUP_HOG_DEFAULT(PINMUX_DEV, _group_, _function_)
 
-struct tegra_board_pinmux_conf {
-	struct tegra_pingroup_config *pgs;
-	int pg_count;
+#define TEGRA_MAP_CONF(_group_, _pull_, _drive_) \
+	PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(PINMUX_DEV, _group_, tegra_pincfg_pull##_pull_##_##_drive_)
 
-	struct tegra_drive_pingroup_config *drives;
-	int drive_count;
+#define TEGRA_MAP_MUXCONF(_group_, _function_, _pull_, _drive_) \
+	TEGRA_MAP_MUX(_group_, _function_), \
+	TEGRA_MAP_CONF(_group_, _pull_, _drive_)
+
+extern unsigned long tegra_pincfg_pullnone_driven[2];
+extern unsigned long tegra_pincfg_pullnone_tristate[2];
+extern unsigned long tegra_pincfg_pullnone_na[1];
+extern unsigned long tegra_pincfg_pullup_driven[2];
+extern unsigned long tegra_pincfg_pullup_tristate[2];
+extern unsigned long tegra_pincfg_pullup_na[1];
+extern unsigned long tegra_pincfg_pulldown_driven[2];
+extern unsigned long tegra_pincfg_pulldown_tristate[2];
+extern unsigned long tegra_pincfg_pulldown_na[1];
+extern unsigned long tegra_pincfg_pullna_driven[1];
+extern unsigned long tegra_pincfg_pullna_tristate[1];
+
+struct tegra_board_pinmux_conf {
+	struct pinctrl_map *maps;
+	int map_count;
 };
 
 void tegra_board_pinmux_init(struct tegra_board_pinmux_conf *conf_a,
diff --git a/arch/arm/mach-tegra/board-seaboard-pinmux.c b/arch/arm/mach-tegra/board-seaboard-pinmux.c
index 3bf7e97..11fc8a5 100644
--- a/arch/arm/mach-tegra/board-seaboard-pinmux.c
+++ b/arch/arm/mach-tegra/board-seaboard-pinmux.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2010,2011 NVIDIA Corporation
+ * Copyright (C) 2010-2012 NVIDIA Corporation
  * Copyright (C) 2011 Google, Inc.
  *
  * This software is licensed under the terms of the GNU General Public
@@ -14,184 +14,176 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of.h>
 
-#include <mach/pinmux.h>
-#include <mach/pinmux-tegra20.h>
-
-#include "board-pinmux.h"
 #include "board-seaboard.h"
+#include "board-pinmux.h"
 
-#define DEFAULT_DRIVE(_name)					\
-	{							\
-		.pingroup = TEGRA_DRIVE_PINGROUP_##_name,	\
-		.hsm = TEGRA_HSM_DISABLE,			\
-		.schmitt = TEGRA_SCHMITT_ENABLE,		\
-		.drive = TEGRA_DRIVE_DIV_1,			\
-		.pull_down = TEGRA_PULL_31,			\
-		.pull_up = TEGRA_PULL_31,			\
-		.slew_rising = TEGRA_SLEW_SLOWEST,		\
-		.slew_falling = TEGRA_SLEW_SLOWEST,		\
-	}
-
-static struct tegra_drive_pingroup_config seaboard_drive_pinmux[] = {
-	DEFAULT_DRIVE(SDIO1),
+static unsigned long seaboard_pincfg_drive_sdio1[] = {
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_HIGH_SPEED_MODE, 0),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SCHMITT, 0),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_LOW_POWER_MODE, 3),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_DRIVE_DOWN_STRENGTH, 31),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_DRIVE_UP_STRENGTH, 31),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SLEW_RATE_FALLING, 3),
+	TEGRA_PINCONF_PACK(TEGRA_PINCONF_PARAM_SLEW_RATE_RISING, 3),
 };
 
-static struct tegra_pingroup_config common_pinmux[] = {
-	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_VI,            TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_UARTD,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GME,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_RSVD4,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN, TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
+static struct pinctrl_map common_map[] = {
+	TEGRA_MAP_MUXCONF("ata",   "ide",           none, driven),
+	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("atc",   "nand",          none, driven),
+	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, driven),
+	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
+	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     none, driven),
+	TEGRA_MAP_MUXCONF("crtp",  "crt",           up,   tristate),
+	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", none, tristate),
+	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
+	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, driven),
+	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, driven),
+	TEGRA_MAP_MUXCONF("dta",   "vi",            down, driven),
+	TEGRA_MAP_MUXCONF("dtb",   "vi",            down, driven),
+	TEGRA_MAP_MUXCONF("dtc",   "vi",            down, driven),
+	TEGRA_MAP_MUXCONF("dtd",   "vi",            down, driven),
+	TEGRA_MAP_MUXCONF("dte",   "vi",            down, tristate),
+	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          none, driven),
+	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gmb",   "gmi",           up,   tristate),
+	TEGRA_MAP_MUXCONF("gmc",   "uartd",         none, driven),
+	TEGRA_MAP_MUXCONF("gme",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gpu",   "pwm",           none, driven),
+	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
+	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, tristate),
+	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, driven),
+	TEGRA_MAP_MUXCONF("irrx",  "uartb",         none, driven),
+	TEGRA_MAP_MUXCONF("irtx",  "uartb",         none, driven),
+	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   driven),
+	TEGRA_MAP_MUXCONF("lcsn",  "rsvd4",         na,   tristate),
+	TEGRA_MAP_MUXCONF("ld0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld1",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld10",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld11",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld12",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld13",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld14",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld15",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld16",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld17",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld2",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld3",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld4",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld5",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld6",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld7",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld8",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld9",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ldc",   "rsvd4",         na,   tristate),
+	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm0",   "rsvd4",         na,   driven),
+	TEGRA_MAP_MUXCONF("lm1",   "crt",           na,   tristate),
+	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw1",  "rsvd4",         na,   tristate),
+	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsdi",  "rsvd4",         na,   tristate),
+	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvp0",  "rsvd4",         na,   tristate),
+	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   driven),
+	TEGRA_MAP_MUXCONF("pta",   "hdmi",          none, driven),
+	TEGRA_MAP_MUXCONF("rm",    "i2c1",          none, driven),
+	TEGRA_MAP_MUXCONF("sdb",   "sdio3",         na,   driven),
+	TEGRA_MAP_MUXCONF("sdc",   "sdio3",         none, driven),
+	TEGRA_MAP_MUXCONF("sdd",   "sdio3",         none, driven),
+	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         up,   driven),
+	TEGRA_MAP_MUXCONF("slxa",  "pcie",          up,   tristate),
+	TEGRA_MAP_MUXCONF("slxd",  "spdif",         none, driven),
+	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("spdi",  "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("spdo",  "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("spib",  "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("spid",  "spi1",          none, tristate),
+	TEGRA_MAP_MUXCONF("spie",  "spi1",          none, tristate),
+	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
+	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
+	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   driven),
+	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   driven),
+	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("uad",   "irda",          none, driven),
+	TEGRA_MAP_MUXCONF("uca",   "uartc",         none, driven),
+	TEGRA_MAP_MUXCONF("ucb",   "uartc",         none, driven),
+	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, driven),
+	TEGRA_MAP_CONF("ck32",    none, na),
+	TEGRA_MAP_CONF("ddrc",    none, na),
+	TEGRA_MAP_CONF("pmca",    none, na),
+	TEGRA_MAP_CONF("pmcb",    none, na),
+	TEGRA_MAP_CONF("pmcc",    none, na),
+	TEGRA_MAP_CONF("pmcd",    none, na),
+	TEGRA_MAP_CONF("pmce",    none, na),
+	TEGRA_MAP_CONF("xm2c",    none, na),
+	TEGRA_MAP_CONF("xm2d",    none, na),
+	TEGRA_MAP_CONF("ls",      up,   na),
+	TEGRA_MAP_CONF("lc",      up,   na),
+	TEGRA_MAP_CONF("ld17_0",  down, na),
+	TEGRA_MAP_CONF("ld19_18", down, na),
+	TEGRA_MAP_CONF("ld21_20", down, na),
+	TEGRA_MAP_CONF("ld23_22", down, na),
 };
 
-static struct tegra_pingroup_config seaboard_pinmux[] = {
-	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_HDMI,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_GMI,           TEGRA_PUPD_PULL_UP,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,   TEGRA_TRI_TRISTATE},
+static struct pinctrl_map seaboard_map[] = {
+	TEGRA_MAP_MUXCONF("ddc",   "rsvd2",         none, tristate),
+	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, driven),
+	TEGRA_MAP_MUXCONF("lpw0",  "hdmi",          na,   driven),
+	TEGRA_MAP_MUXCONF("lpw2",  "hdmi",          na,   driven),
+	TEGRA_MAP_MUXCONF("lsc1",  "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("lsck",  "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("lsda",  "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("slxc",  "spdif",         none, tristate),
+	TEGRA_MAP_MUXCONF("spia",  "gmi",           up,   tristate),
+	TEGRA_MAP_MUXCONF("spic",  "gmi",           up,   driven),
+	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   tristate),
+	PIN_MAP_CONFIGS_GROUP_HOG_DEFAULT(PINMUX_DEV, "drive_sdio1", seaboard_pincfg_drive_sdio1),
 };
 
-static struct tegra_pingroup_config ventana_pinmux[] = {
-	{TEGRA_PINGROUP_DDC,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMD,  TEGRA_MUX_SFLASH,   TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW0, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW2, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC1, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSCK, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDA, TEGRA_MUX_RSVD4,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PTA,  TEGRA_MUX_RSVD2,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXC, TEGRA_MUX_SDIO3,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXK, TEGRA_MUX_SDIO3,    TEGRA_PUPD_NORMAL,    TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPIA, TEGRA_MUX_GMI,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIC, TEGRA_MUX_GMI,      TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIG, TEGRA_MUX_SPI2_ALT, TEGRA_PUPD_NORMAL,    TEGRA_TRI_TRISTATE},
+static struct pinctrl_map ventana_map[] = {
+	TEGRA_MAP_MUXCONF("ddc",   "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, tristate),
+	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("slxc",  "sdio3",         none, driven),
+	TEGRA_MAP_MUXCONF("spia",  "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("spic",  "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      none, tristate),
 };
 
 static struct tegra_board_pinmux_conf common_conf = {
-	.pgs = common_pinmux,
-	.pg_count = ARRAY_SIZE(common_pinmux),
+	.maps = common_map,
+	.map_count = ARRAY_SIZE(common_map),
 };
 
 static struct tegra_board_pinmux_conf seaboard_conf = {
-	.pgs = seaboard_pinmux,
-	.pg_count = ARRAY_SIZE(seaboard_pinmux),
-	.drives = seaboard_drive_pinmux,
-	.drive_count = ARRAY_SIZE(seaboard_drive_pinmux),
+	.maps = seaboard_map,
+	.map_count = ARRAY_SIZE(seaboard_map),
 };
 
 static struct tegra_board_pinmux_conf ventana_conf = {
-	.pgs = ventana_pinmux,
-	.pg_count = ARRAY_SIZE(ventana_pinmux),
+	.maps = ventana_map,
+	.map_count = ARRAY_SIZE(ventana_map),
 };
 
 void seaboard_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/board-trimslice-pinmux.c b/arch/arm/mach-tegra/board-trimslice-pinmux.c
index a1902d4..7b39511 100644
--- a/arch/arm/mach-tegra/board-trimslice-pinmux.c
+++ b/arch/arm/mach-tegra/board-trimslice-pinmux.c
@@ -2,6 +2,7 @@
  * arch/arm/mach-tegra/board-trimslice-pinmux.c
  *
  * Copyright (C) 2011 CompuLab, Ltd.
+ * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -14,137 +15,138 @@
  *
  */
 #include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/of.h>
 
-#include <mach/pinmux.h>
-#include <mach/pinmux-tegra20.h>
-
-#include "board-pinmux.h"
 #include "board-trimslice.h"
+#include "board-pinmux.h"
 
-static struct tegra_pingroup_config trimslice_pinmux[] = {
-	{TEGRA_PINGROUP_ATA,   TEGRA_MUX_IDE,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_ATB,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,	TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_ATC,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_ATD,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_ATE,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,	TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_CDEV2, TEGRA_MUX_PLLP_OUT4,     TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CRTP,  TEGRA_MUX_CRT,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CSUS,  TEGRA_MUX_VI_SENSOR_CLK, TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP1,  TEGRA_MUX_DAP1,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DAP2,  TEGRA_MUX_DAP2,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP3,  TEGRA_MUX_DAP3,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DAP4,  TEGRA_MUX_DAP4,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DDC,   TEGRA_MUX_I2C2,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DTA,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTB,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTC,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTD,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTE,   TEGRA_MUX_VI,            TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_DTF,   TEGRA_MUX_I2C3,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMA,   TEGRA_MUX_SDIO4,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMB,   TEGRA_MUX_NAND,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GMC,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GMD,   TEGRA_MUX_SFLASH,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GME,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_GPU,   TEGRA_MUX_UARTA,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPU7,  TEGRA_MUX_RTCK,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_GPV,   TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_HDINT, TEGRA_MUX_HDMI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_I2CP,  TEGRA_MUX_I2C,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_IRRX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_IRTX,  TEGRA_MUX_UARTB,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCA,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCB,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCC,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCD,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCE,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_KBCF,  TEGRA_MUX_KBC,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LCSN,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LD0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD2,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD3,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD4,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD5,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD6,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD7,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD8,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD9,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD10,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD11,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD12,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD13,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD14,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD15,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD16,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LD17,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LDC,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LDI,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHP2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LHS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM0,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LM1,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPP,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LPW1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LPW2,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LSC1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSCK,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDA,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSDI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LSPI,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVP0,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_LVP1,  TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_LVS,   TEGRA_MUX_DISPLAYA,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_OWC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PMC,   TEGRA_MUX_PWR_ON,        TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_PTA,   TEGRA_MUX_GMI,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_RM,    TEGRA_MUX_I2C,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDB,   TEGRA_MUX_PWM,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDC,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDD,   TEGRA_MUX_PWM,           TEGRA_PUPD_PULL_UP,     TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SDIO1, TEGRA_MUX_SDIO1,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXA,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SLXC,  TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXD,  TEGRA_MUX_SDIO3,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SLXK,  TEGRA_MUX_PCIE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_SPDI,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPDO,  TEGRA_MUX_SPDIF,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIA,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIB,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIC,  TEGRA_MUX_SPI2,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPID,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIE,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIF,  TEGRA_MUX_SPI1,          TEGRA_PUPD_PULL_DOWN,   TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIG,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_SPIH,  TEGRA_MUX_SPI2_ALT,      TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAB,   TEGRA_MUX_ULPI,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UAC,   TEGRA_MUX_RSVD2,         TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_UAD,   TEGRA_MUX_IRDA,          TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCA,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UCB,   TEGRA_MUX_UARTC,         TEGRA_PUPD_PULL_UP,     TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_UDA,   TEGRA_MUX_ULPI,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_TRISTATE},
-	{TEGRA_PINGROUP_CK32,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_DDRC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCA,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCB,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCC,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCD,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_PMCE,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2C,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
-	{TEGRA_PINGROUP_XM2D,  TEGRA_MUX_NONE,          TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
+static struct pinctrl_map trimslice_map[] = {
+	TEGRA_MAP_MUXCONF("ata",   "ide",           none, tristate),
+	TEGRA_MAP_MUXCONF("atb",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("atc",   "nand",          none, tristate),
+	TEGRA_MAP_MUXCONF("atd",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("ate",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("cdev1", "plla_out",      none, driven),
+	TEGRA_MAP_MUXCONF("cdev2", "pllp_out4",     down, tristate),
+	TEGRA_MAP_MUXCONF("crtp",  "crt",           none, tristate),
+	TEGRA_MAP_MUXCONF("csus",  "vi_sensor_clk", down, tristate),
+	TEGRA_MAP_MUXCONF("dap1",  "dap1",          none, driven),
+	TEGRA_MAP_MUXCONF("dap2",  "dap2",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap3",  "dap3",          none, tristate),
+	TEGRA_MAP_MUXCONF("dap4",  "dap4",          none, tristate),
+	TEGRA_MAP_MUXCONF("ddc",   "i2c2",          up,   driven),
+	TEGRA_MAP_MUXCONF("dta",   "vi",            none, tristate),
+	TEGRA_MAP_MUXCONF("dtb",   "vi",            none, tristate),
+	TEGRA_MAP_MUXCONF("dtc",   "vi",            none, tristate),
+	TEGRA_MAP_MUXCONF("dtd",   "vi",            none, tristate),
+	TEGRA_MAP_MUXCONF("dte",   "vi",            none, tristate),
+	TEGRA_MAP_MUXCONF("dtf",   "i2c3",          up,   driven),
+	TEGRA_MAP_MUXCONF("gma",   "sdio4",         none, driven),
+	TEGRA_MAP_MUXCONF("gmb",   "nand",          none, tristate),
+	TEGRA_MAP_MUXCONF("gmc",   "sflash",        none, driven),
+	TEGRA_MAP_MUXCONF("gmd",   "sflash",        none, driven),
+	TEGRA_MAP_MUXCONF("gme",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("gpu",   "uarta",         none, driven),
+	TEGRA_MAP_MUXCONF("gpu7",  "rtck",          none, driven),
+	TEGRA_MAP_MUXCONF("gpv",   "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("hdint", "hdmi",          na,   tristate),
+	TEGRA_MAP_MUXCONF("i2cp",  "i2cp",          none, tristate),
+	TEGRA_MAP_MUXCONF("irrx",  "uartb",         up,   tristate),
+	TEGRA_MAP_MUXCONF("irtx",  "uartb",         up,   tristate),
+	TEGRA_MAP_MUXCONF("kbca",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("kbcb",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("kbcc",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("kbcd",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("kbce",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("kbcf",  "kbc",           up,   tristate),
+	TEGRA_MAP_MUXCONF("lcsn",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("ld0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld1",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld10",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld11",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld12",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld13",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld14",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld15",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld16",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld17",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld2",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld3",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld4",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld5",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld6",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld7",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld8",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ld9",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("ldc",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("ldi",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhp2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lhs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm0",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lm1",   "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpp",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lpw1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lpw2",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc0",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lsc1",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsck",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsda",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lsdi",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lspi",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvp0",  "displaya",      na,   tristate),
+	TEGRA_MAP_MUXCONF("lvp1",  "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("lvs",   "displaya",      na,   driven),
+	TEGRA_MAP_MUXCONF("owc",   "rsvd2",         up,   tristate),
+	TEGRA_MAP_MUXCONF("pmc",   "pwr_on",        na,   tristate),
+	TEGRA_MAP_MUXCONF("pta",   "gmi",           none, tristate),
+	TEGRA_MAP_MUXCONF("rm",    "i2c1",          up,   driven),
+	TEGRA_MAP_MUXCONF("sdb",   "pwm",           na,   driven),
+	TEGRA_MAP_MUXCONF("sdc",   "pwm",           up,   driven),
+	TEGRA_MAP_MUXCONF("sdd",   "pwm",           up,   driven),
+	TEGRA_MAP_MUXCONF("sdio1", "sdio1",         none, driven),
+	TEGRA_MAP_MUXCONF("slxa",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("slxc",  "sdio3",         none, tristate),
+	TEGRA_MAP_MUXCONF("slxd",  "sdio3",         none, tristate),
+	TEGRA_MAP_MUXCONF("slxk",  "pcie",          none, driven),
+	TEGRA_MAP_MUXCONF("spdi",  "spdif",         none, tristate),
+	TEGRA_MAP_MUXCONF("spdo",  "spdif",         none, tristate),
+	TEGRA_MAP_MUXCONF("spia",  "spi2",          down, tristate),
+	TEGRA_MAP_MUXCONF("spib",  "spi2",          down, tristate),
+	TEGRA_MAP_MUXCONF("spic",  "spi2",          up,   tristate),
+	TEGRA_MAP_MUXCONF("spid",  "spi1",          down, tristate),
+	TEGRA_MAP_MUXCONF("spie",  "spi1",          up,   tristate),
+	TEGRA_MAP_MUXCONF("spif",  "spi1",          down, tristate),
+	TEGRA_MAP_MUXCONF("spig",  "spi2_alt",      up,   tristate),
+	TEGRA_MAP_MUXCONF("spih",  "spi2_alt",      up,   tristate),
+	TEGRA_MAP_MUXCONF("uaa",   "ulpi",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uab",   "ulpi",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uac",   "rsvd2",         none, driven),
+	TEGRA_MAP_MUXCONF("uad",   "irda",          up,   tristate),
+	TEGRA_MAP_MUXCONF("uca",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("ucb",   "uartc",         up,   tristate),
+	TEGRA_MAP_MUXCONF("uda",   "ulpi",          none, tristate),
+	TEGRA_MAP_CONF("ck32",    none, na),
+	TEGRA_MAP_CONF("ddrc",    none, na),
+	TEGRA_MAP_CONF("pmca",    none, na),
+	TEGRA_MAP_CONF("pmcb",    none, na),
+	TEGRA_MAP_CONF("pmcc",    none, na),
+	TEGRA_MAP_CONF("pmcd",    none, na),
+	TEGRA_MAP_CONF("pmce",    none, na),
+	TEGRA_MAP_CONF("xm2c",    none, na),
+	TEGRA_MAP_CONF("xm2d",    none, na),
+	TEGRA_MAP_CONF("ls",      up,   na),
+	TEGRA_MAP_CONF("lc",      up,   na),
+	TEGRA_MAP_CONF("ld17_0",  down, na),
+	TEGRA_MAP_CONF("ld19_18", down, na),
+	TEGRA_MAP_CONF("ld21_20", down, na),
+	TEGRA_MAP_CONF("ld23_22", down, na),
 };
 
 static struct tegra_board_pinmux_conf conf = {
-	.pgs = trimslice_pinmux,
-	.pg_count = ARRAY_SIZE(trimslice_pinmux),
+	.maps = trimslice_map,
+	.map_count = ARRAY_SIZE(trimslice_map),
 };
 
 void trimslice_pinmux_init(void)
diff --git a/arch/arm/mach-tegra/pinmux.c b/arch/arm/mach-tegra/pinmux.c
index ac35d2b..7867a12 100644
--- a/arch/arm/mach-tegra/pinmux.c
+++ b/arch/arm/mach-tegra/pinmux.c
@@ -711,10 +711,10 @@ void tegra_pinmux_config_pullupdown_table(const struct tegra_pingroup_config *co
 
 static struct of_device_id tegra_pinmux_of_match[] __devinitdata = {
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
-	{ .compatible = "nvidia,tegra20-pinmux", tegra20_pinmux_init },
+	{ .compatible = "nvidia,tegra20-pinmux-disabled", tegra20_pinmux_init },
 #endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
-	{ .compatible = "nvidia,tegra30-pinmux", tegra30_pinmux_init },
+	{ .compatible = "nvidia,tegra30-pinmux-disabled", tegra30_pinmux_init },
 #endif
 	{ },
 };
@@ -809,7 +809,7 @@ static int __devinit tegra_pinmux_probe(struct platform_device *pdev)
 
 static struct platform_driver tegra_pinmux_driver = {
 	.driver		= {
-		.name	= "tegra-pinmux",
+		.name	= "tegra-pinmux-disabled",
 		.owner	= THIS_MODULE,
 		.of_match_table = tegra_pinmux_of_match,
 	},
diff --git a/drivers/pinctrl/pinctrl-tegra.c b/drivers/pinctrl/pinctrl-tegra.c
index 80e97c9..ef2d495 100644
--- a/drivers/pinctrl/pinctrl-tegra.c
+++ b/drivers/pinctrl/pinctrl-tegra.c
@@ -33,7 +33,7 @@
 
 #include "pinctrl-tegra.h"
 
-#define DRIVER_NAME "tegra-pinmux-disabled"
+#define DRIVER_NAME "tegra-pinmux"
 
 struct tegra_pmx {
 	struct device *dev;
@@ -627,13 +627,13 @@ static struct pinctrl_desc tegra_pinctrl_desc = {
 static struct of_device_id tegra_pinctrl_of_match[] __devinitdata = {
 #ifdef CONFIG_PINCTRL_TEGRA20
 	{
-		.compatible = "nvidia,tegra20-pinmux-disabled",
+		.compatible = "nvidia,tegra20-pinmux",
 		.data = tegra20_pinctrl_init,
 	},
 #endif
 #ifdef CONFIG_PINCTRL_TEGRA30
 	{
-		.compatible = "nvidia,tegra30-pinmux-disabled",
+		.compatible = "nvidia,tegra30-pinmux",
 		.data = tegra30_pinctrl_init,
 	},
 #endif
-- 
1.7.0.4
