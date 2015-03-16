From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 16 Mar 2015 06:55:10 +0100
Subject: [PATCH 4/5] clk: mediatek: Add basic clocks for Mediatek MT8173.
In-Reply-To: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
References: <1426485311-31428-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1426485311-31428-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: James Liao <jamesjj.liao@mediatek.com>

This patch adds basic clocks for MT8173, including TOPCKGEN, PLLs,
INFRA and PERI clocks.

Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/mediatek/Makefile                      |   1 +
 drivers/clk/mediatek/clk-mt8173.c                  | 826 +++++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h             | 231 ++++++
 .../dt-bindings/reset-controller/mt8173-resets.h   |  63 ++
 4 files changed, 1121 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8173.c
 create mode 100644 include/dt-bindings/clock/mt8173-clk.h
 create mode 100644 include/dt-bindings/reset-controller/mt8173-resets.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 12ce576..8e4b2a4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,3 +1,4 @@
 obj-y += clk-mtk.o clk-pll.o clk-gate.o
 obj-$(CONFIG_RESET_CONTROLLER) += reset.o
 obj-y += clk-mt8135.o
+obj-y += clk-mt8173.o
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
new file mode 100644
index 0000000..e674b18
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -0,0 +1,826 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8173-clk.h>
+
+static DEFINE_SPINLOCK(lock);
+
+static const struct mtk_fixed_factor root_clk_alias[] __initdata = {
+	FACTOR(TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
+	FACTOR(TOP_DPI_CK, "dpi_ck", "clk_null", 1, 1),
+	FACTOR(TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
+	FACTOR(TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),
+};
+
+static const struct mtk_fixed_factor top_divs[] __initdata = {
+	FACTOR(TOP_ARMCA7PLL_754M, "armca7pll_754m", "armca7pll", 1, 2),
+	FACTOR(TOP_ARMCA7PLL_502M, "armca7pll_502m", "armca7pll", 1, 3),
+
+	FACTOR(TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2),
+	FACTOR(TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3),
+	FACTOR(TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5),
+	FACTOR(TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7),
+
+	FACTOR(TOP_TVDPLL_445P5M, "tvdpll_445p5m", "tvdpll", 1, 4),
+	FACTOR(TOP_TVDPLL_594M, "tvdpll_594m", "tvdpll", 1, 3),
+
+	FACTOR(TOP_UNIV_624M, "univ_624m", "univpll", 1, 2),
+	FACTOR(TOP_UNIV_416M, "univ_416m", "univpll", 1, 3),
+	FACTOR(TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5),
+	FACTOR(TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7),
+	FACTOR(TOP_UNIV_48M, "univ_48m", "univpll", 1, 26),
+
+	FACTOR(TOP_CLKRTC_EXT, "clkrtc_ext", "clk32k", 1, 1),
+	FACTOR(TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
+	FACTOR(TOP_FPC_CK, "fpc_ck", "clk26m", 1, 1),
+
+	FACTOR(TOP_HDMITXPLL_D2, "hdmitxpll_d2", "hdmitx_dig_cts", 1, 2),
+	FACTOR(TOP_HDMITXPLL_D3, "hdmitxpll_d3", "hdmitx_dig_cts", 1, 3),
+
+	FACTOR(TOP_ARMCA7PLL_D2, "armca7pll_d2", "armca7pll_754m", 1, 1),
+	FACTOR(TOP_ARMCA7PLL_D3, "armca7pll_d3", "armca7pll_502m", 1, 1),
+
+	FACTOR(TOP_APLL1_CK, "apll1_ck", "apll1", 1, 1),
+	FACTOR(TOP_APLL2_CK, "apll2_ck", "apll2", 1, 1),
+
+	FACTOR(TOP_DMPLL_CK, "dmpll_ck", "clkph_mck_o", 1, 1),
+	FACTOR(TOP_DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
+	FACTOR(TOP_DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
+	FACTOR(TOP_DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
+	FACTOR(TOP_DMPLL_D16, "dmpll_d16", "clkph_mck_o", 1, 16),
+
+	FACTOR(TOP_LVDSPLL_D2, "lvdspll_d2", "lvdspll", 1, 2),
+	FACTOR(TOP_LVDSPLL_D4, "lvdspll_d4", "lvdspll", 1, 4),
+	FACTOR(TOP_LVDSPLL_D8, "lvdspll_d8", "lvdspll", 1, 8),
+
+	FACTOR(TOP_MMPLL_CK, "mmpll_ck", "mmpll", 1, 1),
+	FACTOR(TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
+
+	FACTOR(TOP_MSDCPLL_CK, "msdcpll_ck", "msdcpll", 1, 1),
+	FACTOR(TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(TOP_MSDCPLL2_CK, "msdcpll2_ck", "msdcpll2", 1, 1),
+	FACTOR(TOP_MSDCPLL2_D2, "msdcpll2_d2", "msdcpll2", 1, 2),
+	FACTOR(TOP_MSDCPLL2_D4, "msdcpll2_d4", "msdcpll2", 1, 4),
+
+	FACTOR(TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1),
+	FACTOR(TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2),
+	FACTOR(TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4),
+	FACTOR(TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8),
+	FACTOR(TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16),
+	FACTOR(TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1),
+	FACTOR(TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2),
+	FACTOR(TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4),
+	FACTOR(TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1),
+	FACTOR(TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2),
+	FACTOR(TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4),
+	FACTOR(TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1),
+	FACTOR(TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2),
+	FACTOR(TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4),
+
+	FACTOR(TOP_TVDPLL_CK, "tvdpll_ck", "tvdpll_594m", 1, 1),
+	FACTOR(TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_594m", 1, 2),
+	FACTOR(TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll_594m", 1, 4),
+	FACTOR(TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_594m", 1, 8),
+	FACTOR(TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll_594m", 1, 16),
+
+	FACTOR(TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1),
+	FACTOR(TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2),
+	FACTOR(TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4),
+	FACTOR(TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8),
+	FACTOR(TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1),
+	FACTOR(TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2),
+	FACTOR(TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4),
+	FACTOR(TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8),
+	FACTOR(TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1),
+	FACTOR(TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2),
+	FACTOR(TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4),
+	FACTOR(TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8),
+	FACTOR(TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1),
+	FACTOR(TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1),
+	FACTOR(TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2),
+
+	FACTOR(TOP_VCODECPLL_CK, "vcodecpll_ck", "vcodecpll", 1, 3),
+	FACTOR(TOP_VCODECPLL_370P5, "vcodecpll_370p5", "vcodecpll", 1, 4),
+
+	FACTOR(TOP_VENCPLL_CK, "vencpll_ck", "vencpll", 1, 1),
+	FACTOR(TOP_VENCPLL_D2, "vencpll_d2", "vencpll", 1, 2),
+	FACTOR(TOP_VENCPLL_D4, "vencpll_d4", "vencpll", 1, 4),
+};
+
+static const char *axi_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char *mem_parents[] __initconst = {
+	"clk26m",
+	"dmpll_ck"
+};
+
+static const char *ddrphycfg_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d8"
+};
+
+static const char *mm_parents[] __initconst = {
+	"clk26m",
+	"vencpll_d2",
+	"main_h364m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll1_d2",
+	"univpll2_d2",
+	"dmpll_d2"
+};
+
+static const char *pwm_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d4",
+	"univpll3_d2",
+	"univpll1_d4"
+};
+
+static const char *vdec_parents[] __initconst = {
+	"clk26m",
+	"vcodecpll_ck",
+	"tvdpll_445p5m",
+	"univpll_d3",
+	"vencpll_d2",
+	"syspll_d3",
+	"univpll1_d2",
+	"mmpll_d2",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char *venc_parents[] __initconst = {
+	"clk26m",
+	"vcodecpll_ck",
+	"tvdpll_445p5m",
+	"univpll_d3",
+	"vencpll_d2",
+	"syspll_d3",
+	"univpll1_d2",
+	"univpll2_d2",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char *mfg_parents[] __initconst = {
+	"clk26m",
+	"mmpll_ck",
+	"dmpll_ck",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"syspll_d3",
+	"syspll1_d2",
+	"syspll_d5",
+	"univpll_d3",
+	"univpll1_d2",
+	"univpll_d5",
+	"univpll2_d2"
+};
+
+static const char *camtg_parents[] __initconst = {
+	"clk26m",
+	"univpll_d26",
+	"univpll2_d2",
+	"syspll3_d2",
+	"syspll3_d4",
+	"univpll1_d4"
+};
+
+static const char *uart_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d8"
+};
+
+static const char *spi_parents[] __initconst = {
+	"clk26m",
+	"syspll3_d2",
+	"syspll1_d4",
+	"syspll4_d2",
+	"univpll3_d2",
+	"univpll2_d4",
+	"univpll1_d8"
+};
+
+static const char *usb20_parents[] __initconst = {
+	"clk26m",
+	"univpll1_d8",
+	"univpll3_d4"
+};
+
+static const char *usb30_parents[] __initconst = {
+	"clk26m",
+	"univpll3_d2",
+	"usb_syspll_125m",
+	"univpll2_d4"
+};
+
+static const char *msdc50_0_h_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll2_d2",
+	"syspll4_d2",
+	"univpll_d5",
+	"univpll1_d4"
+};
+
+static const char *msdc50_0_parents[] __initconst = {
+	"clk26m",
+	"msdcpll_ck",
+	"msdcpll_d2",
+	"univpll1_d4",
+	"syspll2_d2",
+	"syspll_d7",
+	"msdcpll_d4",
+	"vencpll_d4",
+	"tvdpll_ck",
+	"univpll_d2",
+	"univpll1_d2",
+	"mmpll_ck",
+	"msdcpll2_ck",
+	"msdcpll2_d2",
+	"msdcpll2_d4"
+};
+
+static const char *msdc30_1_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"univpll1_d4",
+	"syspll2_d2",
+	"syspll_d7",
+	"univpll_d7",
+	"vencpll_d4"
+};
+
+static const char *msdc30_2_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"univpll1_d4",
+	"syspll2_d2",
+	"syspll_d7",
+	"univpll_d7",
+	"vencpll_d2"
+};
+
+static const char *msdc30_3_parents[] __initconst = {
+	"clk26m",
+	"msdcpll2_ck",
+	"msdcpll2_d2",
+	"univpll2_d2",
+	"msdcpll2_d4",
+	"msdcpll_d4",
+	"univpll1_d4",
+	"syspll2_d2",
+	"syspll_d7",
+	"univpll_d7",
+	"vencpll_d4",
+	"msdcpll_ck",
+	"msdcpll_d2",
+	"msdcpll_d4"
+};
+
+static const char *audio_parents[] __initconst = {
+	"clk26m",
+	"syspll3_d4",
+	"syspll4_d4",
+	"syspll1_d16"
+};
+
+static const char *aud_intbus_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d4",
+	"syspll4_d2",
+	"univpll3_d2",
+	"univpll2_d8",
+	"dmpll_d4",
+	"dmpll_d8"
+};
+
+static const char *pmicspi_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d8",
+	"syspll3_d4",
+	"syspll1_d16",
+	"univpll3_d4",
+	"univpll_d26",
+	"dmpll_d8",
+	"dmpll_d16"
+};
+
+static const char *scp_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d2",
+	"univpll_d5",
+	"syspll_d5",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char *atb_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d2",
+	"univpll_d5",
+	"dmpll_d2"
+};
+
+static const char *venc_lt_parents[] __initconst = {
+	"clk26m",
+	"univpll_d3",
+	"vcodecpll_ck",
+	"tvdpll_445p5m",
+	"vencpll_d2",
+	"syspll_d3",
+	"univpll1_d2",
+	"univpll2_d2",
+	"syspll1_d2",
+	"univpll_d5",
+	"vcodecpll_370p5",
+	"dmpll_ck"
+};
+
+static const char *dpi0_parents[] __initconst = {
+	"clk26m",
+	"tvdpll_d2",
+	"tvdpll_d4",
+	"clk26m",
+	"clk26m",
+	"tvdpll_d8",
+	"tvdpll_d16"
+};
+
+static const char *irda_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d4",
+	"syspll2_d4"
+};
+
+static const char *cci400_parents[] __initconst = {
+	"clk26m",
+	"vencpll_ck",
+	"armca7pll_754m",
+	"armca7pll_502m",
+	"univpll_d2",
+	"syspll_d2",
+	"msdcpll_ck",
+	"dmpll_ck"
+};
+
+static const char *aud_1_parents[] __initconst = {
+	"clk26m",
+	"apll1_ck",
+	"univpll2_d4",
+	"univpll2_d8"
+};
+
+static const char *aud_2_parents[] __initconst = {
+	"clk26m",
+	"apll2_ck",
+	"univpll2_d4",
+	"univpll2_d8"
+};
+
+static const char *mem_mfg_in_parents[] __initconst = {
+	"clk26m",
+	"mmpll_ck",
+	"dmpll_ck",
+	"clk26m"
+};
+
+static const char *axi_mfg_in_parents[] __initconst = {
+	"clk26m",
+	"axi_sel",
+	"dmpll_d2"
+};
+
+static const char *scam_parents[] __initconst = {
+	"clk26m",
+	"syspll3_d2",
+	"univpll2_d4",
+	"dmpll_d4"
+};
+
+static const char *spinfi_ifr_parents[] __initconst = {
+	"clk26m",
+	"univpll2_d8",
+	"univpll3_d4",
+	"syspll4_d2",
+	"univpll2_d4",
+	"univpll3_d2",
+	"syspll1_d4",
+	"univpll1_d4"
+};
+
+static const char *hdmi_parents[] __initconst = {
+	"clk26m",
+	"hdmitx_dig_cts",
+	"hdmitxpll_d2",
+	"hdmitxpll_d3"
+};
+
+static const char *dpilvds_parents[] __initconst = {
+	"clk26m",
+	"lvdspll",
+	"lvdspll_d2",
+	"lvdspll_d4",
+	"lvdspll_d8",
+	"fpc_ck"
+};
+
+static const char *msdc50_2_h_parents[] __initconst = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll2_d2",
+	"syspll4_d2",
+	"univpll_d5",
+	"univpll1_d4"
+};
+
+static const char *hdcp_parents[] __initconst = {
+	"clk26m",
+	"syspll4_d2",
+	"syspll3_d4",
+	"univpll2_d4"
+};
+
+static const char *hdcp_24m_parents[] __initconst = {
+	"clk26m",
+	"univpll_d26",
+	"univpll_d52",
+	"univpll2_d8"
+};
+
+static const char *rtc_parents[] __initconst = {
+	"clkrtc_int",
+	"clkrtc_ext",
+	"clk26m",
+	"univpll3_d8"
+};
+
+static const char *i2s0_m_ck_parents[] __initconst = {
+	"apll1_div1",
+	"apll2_div1"
+};
+
+static const char *i2s1_m_ck_parents[] __initconst = {
+	"apll1_div2",
+	"apll2_div2"
+};
+
+static const char *i2s2_m_ck_parents[] __initconst = {
+	"apll1_div3",
+	"apll2_div3"
+};
+
+static const char *i2s3_m_ck_parents[] __initconst = {
+	"apll1_div4",
+	"apll2_div4"
+};
+
+static const char *i2s3_b_ck_parents[] __initconst = {
+	"apll1_div5",
+	"apll2_div5"
+};
+
+static const struct mtk_composite top_muxes[] __initdata = {
+	/* CLK_CFG_0 */
+	MUX(TOP_AXI_SEL, "axi_sel", axi_parents, 0x0040, 0, 3),
+	MUX(TOP_MEM_SEL, "mem_sel", mem_parents, 0x0040, 8, 1),
+	MUX_GATE(TOP_DDRPHYCFG_SEL, "ddrphycfg_sel", ddrphycfg_parents, 0x0040, 16, 1, 23),
+	MUX_GATE(TOP_MM_SEL, "mm_sel", mm_parents, 0x0040, 24, 4, 31),
+	/* CLK_CFG_1 */
+	MUX_GATE(TOP_PWM_SEL, "pwm_sel", pwm_parents, 0x0050, 0, 2, 7),
+	MUX_GATE(TOP_VDEC_SEL, "vdec_sel", vdec_parents, 0x0050, 8, 4, 15),
+	MUX_GATE(TOP_VENC_SEL, "venc_sel", venc_parents, 0x0050, 16, 4, 23),
+	MUX_GATE(TOP_MFG_SEL, "mfg_sel", mfg_parents, 0x0050, 24, 4, 31),
+	/* CLK_CFG_2 */
+	MUX_GATE(TOP_CAMTG_SEL, "camtg_sel", camtg_parents, 0x0060, 0, 3, 7),
+	MUX_GATE(TOP_UART_SEL, "uart_sel", uart_parents, 0x0060, 8, 1, 15),
+	MUX_GATE(TOP_SPI_SEL, "spi_sel", spi_parents, 0x0060, 16, 3, 23),
+	MUX_GATE(TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x0060, 24, 2, 31),
+	/* CLK_CFG_3 */
+	MUX_GATE(TOP_USB30_SEL, "usb30_sel", usb30_parents, 0x0070, 0, 2, 7),
+	MUX_GATE(TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents, 0x0070, 8, 3, 15),
+	MUX_GATE(TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents, 0x0070, 16, 4, 23),
+	MUX_GATE(TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents, 0x0070, 24, 3, 31),
+	/* CLK_CFG_4 */
+	MUX_GATE(TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents, 0x0080, 0, 3, 7),
+	MUX_GATE(TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents, 0x0080, 8, 4, 15),
+	MUX_GATE(TOP_AUDIO_SEL, "audio_sel", audio_parents, 0x0080, 16, 2, 23),
+	MUX_GATE(TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents, 0x0080, 24, 3, 31),
+	/* CLK_CFG_5 */
+	MUX_GATE(TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_parents, 0x0090, 0, 3, 7 /* 7:5 */),
+	MUX_GATE(TOP_SCP_SEL, "scp_sel", scp_parents, 0x0090, 8, 3, 15),
+	MUX_GATE(TOP_ATB_SEL, "atb_sel", atb_parents, 0x0090, 16, 2, 23),
+	MUX_GATE(TOP_VENC_LT_SEL, "venclt_sel", venc_lt_parents, 0x0090, 24, 4, 31),
+	/* CLK_CFG_6 */
+	MUX_GATE(TOP_DPI0_SEL, "dpi0_sel", dpi0_parents, 0x00a0, 0, 3, 7),
+	MUX_GATE(TOP_IRDA_SEL, "irda_sel", irda_parents, 0x00a0, 8, 2, 15),
+	MUX_GATE(TOP_CCI400_SEL, "cci400_sel", cci400_parents, 0x00a0, 16, 3, 23),
+	MUX_GATE(TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents, 0x00a0, 24, 2, 31),
+	/* CLK_CFG_7 */
+	MUX_GATE(TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents, 0x00b0, 0, 2, 7),
+	MUX_GATE(TOP_MEM_MFG_IN_SEL, "mem_mfg_in_sel", mem_mfg_in_parents, 0x00b0, 8, 2, 15),
+	MUX_GATE(TOP_AXI_MFG_IN_SEL, "axi_mfg_in_sel", axi_mfg_in_parents, 0x00b0, 16, 2, 23),
+	MUX_GATE(TOP_SCAM_SEL, "scam_sel", scam_parents, 0x00b0, 24, 2, 31),
+	/* CLK_CFG_12 */
+	MUX_GATE(TOP_SPINFI_IFR_SEL, "spinfi_ifr_sel", spinfi_ifr_parents, 0x00c0, 0, 3, 7),
+	MUX_GATE(TOP_HDMI_SEL, "hdmi_sel", hdmi_parents, 0x00c0, 8, 2, 15),
+	MUX_GATE(TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents, 0x00c0, 24, 3, 31),
+	/* CLK_CFG_13 */
+	MUX_GATE(TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents, 0x00d0, 0, 3, 7),
+	MUX_GATE(TOP_HDCP_SEL, "hdcp_sel", hdcp_parents, 0x00d0, 8, 2, 15),
+	MUX_GATE(TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents, 0x00d0, 16, 2, 23),
+	MUX(TOP_RTC_SEL, "rtc_sel", rtc_parents, 0x00d0, 24, 2),
+
+	DIV_GATE(TOP_APLL1_DIV0, "apll1_div0", "aud_1_sel", 0x12c, 8, 0x120, 4, 24),
+	DIV_GATE(TOP_APLL1_DIV1, "apll1_div1", "aud_1_sel", 0x12c, 9, 0x124, 8, 0),
+	DIV_GATE(TOP_APLL1_DIV2, "apll1_div2", "aud_1_sel", 0x12c, 10, 0x124, 8, 8),
+	DIV_GATE(TOP_APLL1_DIV3, "apll1_div3", "aud_1_sel", 0x12c, 11, 0x124, 8, 16),
+	DIV_GATE(TOP_APLL1_DIV4, "apll1_div4", "aud_1_sel", 0x12c, 12, 0x124, 8, 24),
+	DIV_GATE(TOP_APLL1_DIV5, "apll1_div5", "aud_1_sel", 0x12c, 13, 0x12c, 4, 0),
+
+	DIV_GATE(TOP_APLL2_DIV0, "apll2_div0", "aud_2_sel", 0x12c, 16, 0x120, 4, 28),
+	DIV_GATE(TOP_APLL2_DIV1, "apll2_div1", "aud_2_sel", 0x12c, 17, 0x128, 8, 0),
+	DIV_GATE(TOP_APLL2_DIV2, "apll2_div2", "aud_2_sel", 0x12c, 18, 0x128, 8, 8),
+	DIV_GATE(TOP_APLL2_DIV3, "apll2_div3", "aud_2_sel", 0x12c, 19, 0x128, 8, 16),
+	DIV_GATE(TOP_APLL2_DIV4, "apll2_div4", "aud_2_sel", 0x12c, 20, 0x128, 8, 24),
+	DIV_GATE(TOP_APLL2_DIV5, "apll2_div5", "aud_2_sel", 0x12c, 21, 0x12c, 4, 4),
+
+	MUX(TOP_I2S0_M_CK_SEL, "i2s0_m_ck_sel", i2s0_m_ck_parents, 0x120, 4, 1),
+	MUX(TOP_I2S1_M_CK_SEL, "i2s1_m_ck_sel", i2s1_m_ck_parents, 0x120, 5, 1),
+	MUX(TOP_I2S2_M_CK_SEL, "i2s2_m_ck_sel", i2s2_m_ck_parents, 0x120, 6, 1),
+	MUX(TOP_I2S3_M_CK_SEL, "i2s3_m_ck_sel", i2s3_m_ck_parents, 0x120, 7, 1),
+	MUX(TOP_I2S3_B_CK_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
+};
+
+static void __init mtk_init_clk_topckgen(void __iomem *top_base,
+		struct clk_onecell_data *clk_data)
+{
+	int i;
+	struct clk *clk;
+
+	for (i = 0; i < ARRAY_SIZE(top_muxes); i++) {
+		const struct mtk_composite *mux = &top_muxes[i];
+
+		clk = mtk_clk_register_composite(mux, top_base, &lock);
+
+		if (IS_ERR(clk)) {
+			pr_err("Failed to register clk %s: %ld\n",
+					mux->name, PTR_ERR(clk));
+			continue;
+		}
+
+		if (clk_data)
+			clk_data->clks[mux->id] = clk;
+	}
+}
+
+static const struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = 0x0040,
+	.clr_ofs = 0x0044,
+	.sta_ofs = 0x0048,
+};
+
+#define GATE_ICG(_id, _name, _parent, _shift) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &infra_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+static const struct mtk_gate infra_clks[] __initdata = {
+	GATE_ICG(INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
+	GATE_ICG(INFRA_SMI, "infra_smi", "mm_sel", 1),
+	GATE_ICG(INFRA_AUDIO, "infra_audio", "aud_intbus_sel", 5),
+	GATE_ICG(INFRA_GCE, "infra_gce", "axi_sel", 6),
+	GATE_ICG(INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
+	GATE_ICG(INFRA_M4U, "infra_m4u", "mem_sel", 8),
+	GATE_ICG(INFRA_CPUM, "infra_cpum", "clk_null", 15),
+	GATE_ICG(INFRA_KP, "infra_kp", "axi_sel", 16),
+	GATE_ICG(INFRA_CEC, "infra_cec", "clk26m", 18),
+	GATE_ICG(INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel", 22),
+	GATE_ICG(INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
+};
+
+static const struct mtk_gate_regs peri0_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x0010,
+	.sta_ofs = 0x0018,
+};
+
+static const struct mtk_gate_regs peri1_cg_regs = {
+	.set_ofs = 0x000c,
+	.clr_ofs = 0x0014,
+	.sta_ofs = 0x001c,
+};
+
+#define GATE_PERI0(_id, _name, _parent, _shift) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &peri0_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+#define GATE_PERI1(_id, _name, _parent, _shift) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.regs = &peri1_cg_regs,				\
+		.shift = _shift,				\
+		.ops = &mtk_clk_gate_ops_setclr,		\
+	}
+
+static const struct mtk_gate peri_clks[] __initdata = {
+	/* PERI0 */
+	GATE_PERI0(PERI_NFI, "peri_nfi", "axi_sel", 0),
+	GATE_PERI0(PERI_THERM, "peri_therm", "axi_sel", 1),
+	GATE_PERI0(PERI_PWM1, "peri_pwm1", "axi_sel", 2),
+	GATE_PERI0(PERI_PWM2, "peri_pwm2", "axi_sel", 3),
+	GATE_PERI0(PERI_PWM3, "peri_pwm3", "axi_sel", 4),
+	GATE_PERI0(PERI_PWM4, "peri_pwm4", "axi_sel", 5),
+	GATE_PERI0(PERI_PWM5, "peri_pwm5", "axi_sel", 6),
+	GATE_PERI0(PERI_PWM6, "peri_pwm6", "axi_sel", 7),
+	GATE_PERI0(PERI_PWM7, "peri_pwm7", "axi_sel", 8),
+	GATE_PERI0(PERI_PWM, "peri_pwm", "axi_sel", 9),
+	GATE_PERI0(PERI_USB0, "peri_usb0", "usb20_sel", 10),
+	GATE_PERI0(PERI_USB1, "peri_usb1", "usb20_sel", 11),
+	GATE_PERI0(PERI_AP_DMA, "peri_ap_dma", "axi_sel", 12),
+	GATE_PERI0(PERI_MSDC30_0, "peri_msdc30_0", "msdc50_0_sel", 13),
+	GATE_PERI0(PERI_MSDC30_1, "peri_msdc30_1", "msdc30_1_sel", 14),
+	GATE_PERI0(PERI_MSDC30_2, "peri_msdc30_2", "msdc30_2_sel", 15),
+	GATE_PERI0(PERI_MSDC30_3, "peri_msdc30_3", "msdc30_3_sel", 16),
+	GATE_PERI0(PERI_NLI_ARB, "peri_nli_arb", "axi_sel", 17),
+	GATE_PERI0(PERI_IRDA, "peri_irda", "irda_sel", 18),
+	GATE_PERI0(PERI_UART0, "peri_uart0", "uart_sel", 19),
+	GATE_PERI0(PERI_UART1, "peri_uart1", "uart_sel", 20),
+	GATE_PERI0(PERI_UART2, "peri_uart2", "uart_sel", 21),
+	GATE_PERI0(PERI_UART3, "peri_uart3", "uart_sel", 22),
+	GATE_PERI0(PERI_I2C0, "peri_i2c0", "axi_sel", 23),
+	GATE_PERI0(PERI_I2C1, "peri_i2c1", "axi_sel", 24),
+	GATE_PERI0(PERI_I2C2, "peri_i2c2", "axi_sel", 25),
+	GATE_PERI0(PERI_I2C3, "peri_i2c3", "axi_sel", 26),
+	GATE_PERI0(PERI_I2C4, "peri_i2c4", "axi_sel", 27),
+	GATE_PERI0(PERI_AUXADC, "peri_auxadc", "clk26m", 28),
+	GATE_PERI0(PERI_SPI0, "peri_spi0", "spi_sel", 29),
+	GATE_PERI0(PERI_I2C5, "peri_i2c5", "axi_sel", 30),
+	GATE_PERI0(PERI_NFIECC, "peri_nfiecc", "axi_sel", 31),
+	/* PERI1 */
+	GATE_PERI1(PERI_SPI, "peri_spi", "spi_sel", 0),
+	GATE_PERI1(PERI_IRRX, "peri_irrx", "spi_sel", 1),
+	GATE_PERI1(PERI_I2C6, "peri_i2c6", "axi_sel", 2),
+};
+
+static void __init mtk_topckgen_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	void __iomem *base;
+	int r;
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return;
+	}
+
+	clk_data = mtk_alloc_clk_data(TOP_NR_CLK);
+
+	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_init_clk_topckgen(base, clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+}
+CLK_OF_DECLARE(mtk_topckgen, "mediatek,mt8173-topckgen", mtk_topckgen_init);
+
+static void __init mtk_infrasys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(INFRA_NR_CLK);
+
+	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0x30);
+}
+CLK_OF_DECLARE(mtk_infrasys, "mediatek,mt8173-infracfg", mtk_infrasys_init);
+
+static void __init mtk_pericfg_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(PERI_NR_CLK);
+
+	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
+						clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+	mtk_register_reset_controller(node, 2, 0);
+}
+CLK_OF_DECLARE(mtk_pericfg, "mediatek,mt8173-pericfg", mtk_pericfg_init);
+
+#define MT8173_PLL_FMAX		(3000UL * MHZ)
+
+#define CON0_MT8173_RST_BAR	BIT(24)
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, _pd_reg, _pd_shift, \
+			_tuner_reg, _pcw_reg, _pcw_shift) { \
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = CON0_MT8173_RST_BAR,			\
+		.fmax = MT8173_PLL_FMAX,				\
+		.pcwbits = _pcwbits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+	}
+
+static const struct mtk_pll_data plls[] = {
+	PLL(APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0x00000001, 0, 21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0x00000001, 0, 21, 0x214, 24, 0x0, 0x214, 0),
+	PLL(APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000101, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
+	PLL(APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000001, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
+	PLL(APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0x00000001, 0, 21, 0x244, 24, 0x0, 0x244, 0),
+	PLL(APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0x00000001, 0, 21, 0x250, 4, 0x0, 0x254, 0),
+	PLL(APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0x00000001, 0, 21, 0x260, 4, 0x0, 0x264, 0),
+	PLL(APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0x00000001, 0, 21, 0x270, 4, 0x0, 0x274, 0),
+	PLL(APMIXED_MPLL, "mpll", 0x280, 0x28c, 0x00000001, 0, 21, 0x280, 4, 0x0, 0x284, 0),
+	PLL(APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0x00000001, 0, 21, 0x290, 4, 0x0, 0x294, 0),
+	PLL(APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0x00000001, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
+	PLL(APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0x00000001, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
+	PLL(APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0x00000001, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
+	PLL(APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0x00000001, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
+};
+
+static void __init mtk_apmixedsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
+	if (!clk_data)
+		return;
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+}
+CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8173-apmixedsys",
+		mtk_apmixedsys_init);
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
new file mode 100644
index 0000000..e648b28
--- /dev/null
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -0,0 +1,231 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MT8173_H
+#define _DT_BINDINGS_CLK_MT8173_H
+
+/* TOPCKGEN */
+
+#define TOP_CLKPH_MCK_O		1
+#define TOP_DPI_CK		2
+#define TOP_USB_SYSPLL_125M	3
+#define TOP_HDMITX_DIG_CTS	4
+#define TOP_ARMCA7PLL_754M	5
+#define TOP_ARMCA7PLL_502M	6
+#define TOP_MAIN_H546M		7
+#define TOP_MAIN_H364M		8
+#define TOP_MAIN_H218P4M	9
+#define TOP_MAIN_H156M		10
+#define TOP_TVDPLL_445P5M	11
+#define TOP_TVDPLL_594M		12
+#define TOP_UNIV_624M		13
+#define TOP_UNIV_416M		14
+#define TOP_UNIV_249P6M		15
+#define TOP_UNIV_178P3M		16
+#define TOP_UNIV_48M		17
+#define TOP_CLKRTC_EXT		18
+#define TOP_CLKRTC_INT		19
+#define TOP_FPC_CK		20
+#define TOP_HDMITXPLL_D2	21
+#define TOP_HDMITXPLL_D3	22
+#define TOP_ARMCA7PLL_D2	23
+#define TOP_ARMCA7PLL_D3	24
+#define TOP_APLL1_CK		25
+#define TOP_APLL2_CK		26
+#define TOP_DMPLL_CK		27
+#define TOP_DMPLL_D2		28
+#define TOP_DMPLL_D4		29
+#define TOP_DMPLL_D8		30
+#define TOP_DMPLL_D16		31
+#define TOP_LVDSPLL_D2		32
+#define TOP_LVDSPLL_D4		33
+#define TOP_LVDSPLL_D8		34
+#define TOP_MMPLL_CK		35
+#define TOP_MMPLL_D2		36
+#define TOP_MSDCPLL_CK		37
+#define TOP_MSDCPLL_D2		38
+#define TOP_MSDCPLL_D4		39
+#define TOP_MSDCPLL2_CK		40
+#define TOP_MSDCPLL2_D2		41
+#define TOP_MSDCPLL2_D4		42
+#define TOP_SYSPLL_D2		43
+#define TOP_SYSPLL1_D2		44
+#define TOP_SYSPLL1_D4		45
+#define TOP_SYSPLL1_D8		46
+#define TOP_SYSPLL1_D16		47
+#define TOP_SYSPLL_D3		48
+#define TOP_SYSPLL2_D2		49
+#define TOP_SYSPLL2_D4		50
+#define TOP_SYSPLL_D5		51
+#define TOP_SYSPLL3_D2		52
+#define TOP_SYSPLL3_D4		53
+#define TOP_SYSPLL_D7		54
+#define TOP_SYSPLL4_D2		55
+#define TOP_SYSPLL4_D4		56
+#define TOP_TVDPLL_CK		57
+#define TOP_TVDPLL_D2		58
+#define TOP_TVDPLL_D4		59
+#define TOP_TVDPLL_D8		60
+#define TOP_TVDPLL_D16		61
+#define TOP_UNIVPLL_D2		62
+#define TOP_UNIVPLL1_D2		63
+#define TOP_UNIVPLL1_D4		64
+#define TOP_UNIVPLL1_D8		65
+#define TOP_UNIVPLL_D3		66
+#define TOP_UNIVPLL2_D2		67
+#define TOP_UNIVPLL2_D4		68
+#define TOP_UNIVPLL2_D8		69
+#define TOP_UNIVPLL_D5		70
+#define TOP_UNIVPLL3_D2		71
+#define TOP_UNIVPLL3_D4		72
+#define TOP_UNIVPLL3_D8		73
+#define TOP_UNIVPLL_D7		74
+#define TOP_UNIVPLL_D26		75
+#define TOP_UNIVPLL_D52		76
+#define TOP_VCODECPLL_CK	77
+#define TOP_VCODECPLL_370P5	78
+#define TOP_VENCPLL_CK		79
+#define TOP_VENCPLL_D2		80
+#define TOP_VENCPLL_D4		81
+#define TOP_AXI_SEL		82
+#define TOP_MEM_SEL		83
+#define TOP_DDRPHYCFG_SEL	84
+#define TOP_MM_SEL		85
+#define TOP_PWM_SEL		86
+#define TOP_VDEC_SEL		87
+#define TOP_VENC_SEL		88
+#define TOP_MFG_SEL		89
+#define TOP_CAMTG_SEL		90
+#define TOP_UART_SEL		91
+#define TOP_SPI_SEL		92
+#define TOP_USB20_SEL		93
+#define TOP_USB30_SEL		94
+#define TOP_MSDC50_0_H_SEL	95
+#define TOP_MSDC50_0_SEL	96
+#define TOP_MSDC30_1_SEL	97
+#define TOP_MSDC30_2_SEL	98
+#define TOP_MSDC30_3_SEL	99
+#define TOP_AUDIO_SEL		100
+#define TOP_AUD_INTBUS_SEL	101
+#define TOP_PMICSPI_SEL		102
+#define TOP_SCP_SEL		103
+#define TOP_ATB_SEL		104
+#define TOP_VENC_LT_SEL		105
+#define TOP_DPI0_SEL		106
+#define TOP_IRDA_SEL		107
+#define TOP_CCI400_SEL		108
+#define TOP_AUD_1_SEL		109
+#define TOP_AUD_2_SEL		110
+#define TOP_MEM_MFG_IN_SEL	111
+#define TOP_AXI_MFG_IN_SEL	112
+#define TOP_SCAM_SEL		113
+#define TOP_SPINFI_IFR_SEL	114
+#define TOP_HDMI_SEL		115
+#define TOP_DPILVDS_SEL		116
+#define TOP_MSDC50_2_H_SEL	117
+#define TOP_HDCP_SEL		118
+#define TOP_HDCP_24M_SEL	119
+#define TOP_RTC_SEL		120
+#define TOP_APLL1_DIV0		121
+#define TOP_APLL1_DIV1		122
+#define TOP_APLL1_DIV2		123
+#define TOP_APLL1_DIV3		124
+#define TOP_APLL1_DIV4		125
+#define TOP_APLL1_DIV5		126
+#define TOP_APLL2_DIV0		127
+#define TOP_APLL2_DIV1		128
+#define TOP_APLL2_DIV2		129
+#define TOP_APLL2_DIV3		130
+#define TOP_APLL2_DIV4		131
+#define TOP_APLL2_DIV5		132
+#define TOP_I2S0_M_CK_SEL	133
+#define TOP_I2S1_M_CK_SEL	134
+#define TOP_I2S2_M_CK_SEL	135
+#define TOP_I2S3_M_CK_SEL	136
+#define TOP_I2S3_B_CK_SEL	137
+#define TOP_NR_CLK		138
+
+/* APMIXED_SYS */
+
+#define APMIXED_ARMCA15PLL	1
+#define APMIXED_ARMCA7PLL	2
+#define APMIXED_MAINPLL		3
+#define APMIXED_UNIVPLL		4
+#define APMIXED_MMPLL		5
+#define APMIXED_MSDCPLL		6
+#define APMIXED_VENCPLL		7
+#define APMIXED_TVDPLL		8
+#define APMIXED_MPLL		9
+#define APMIXED_VCODECPLL	10
+#define APMIXED_APLL1		11
+#define APMIXED_APLL2		12
+#define APMIXED_LVDSPLL		13
+#define APMIXED_MSDCPLL2	14
+#define APMIXED_NR_CLK		15
+
+/* INFRA_SYS */
+
+#define INFRA_DBGCLK		1
+#define INFRA_SMI		2
+#define INFRA_AUDIO		3
+#define INFRA_GCE		4
+#define INFRA_L2C_SRAM		5
+#define INFRA_M4U		6
+#define INFRA_CPUM		7
+#define INFRA_KP		8
+#define INFRA_CEC		9
+#define INFRA_PMICSPI		10
+#define INFRA_PMICWRAP		11
+#define INFRA_NR_CLK		12
+
+/* PERI_SYS */
+
+#define PERI_NFI		1
+#define PERI_THERM		2
+#define PERI_PWM1		3
+#define PERI_PWM2		4
+#define PERI_PWM3		5
+#define PERI_PWM4		6
+#define PERI_PWM5		7
+#define PERI_PWM6		8
+#define PERI_PWM7		9
+#define PERI_PWM		10
+#define PERI_USB0		11
+#define PERI_USB1		12
+#define PERI_AP_DMA		13
+#define PERI_MSDC30_0		14
+#define PERI_MSDC30_1		15
+#define PERI_MSDC30_2		16
+#define PERI_MSDC30_3		17
+#define PERI_NLI_ARB		18
+#define PERI_IRDA		19
+#define PERI_UART0		20
+#define PERI_UART1		21
+#define PERI_UART2		22
+#define PERI_UART3		23
+#define PERI_I2C0		24
+#define PERI_I2C1		25
+#define PERI_I2C2		26
+#define PERI_I2C3		27
+#define PERI_I2C4		28
+#define PERI_AUXADC		29
+#define PERI_SPI0		30
+#define PERI_I2C5		31
+#define PERI_NFIECC		32
+#define PERI_SPI		33
+#define PERI_IRRX		34
+#define PERI_I2C6		35
+#define PERI_NR_CLK		36
+
+#endif /* _DT_BINDINGS_CLK_MT8173_H */
diff --git a/include/dt-bindings/reset-controller/mt8173-resets.h b/include/dt-bindings/reset-controller/mt8173-resets.h
new file mode 100644
index 0000000..9464b37
--- /dev/null
+++ b/include/dt-bindings/reset-controller/mt8173-resets.h
@@ -0,0 +1,63 @@
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: Flora Fu, MediaTek
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8173
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8173
+
+/* INFRACFG resets */
+#define MT8173_INFRA_EMI_REG_RST        0
+#define MT8173_INFRA_DRAMC0_A0_RST      1
+#define MT8173_INFRA_APCIRQ_EINT_RST    3
+#define MT8173_INFRA_APXGPT_RST         4
+#define MT8173_INFRA_SCPSYS_RST         5
+#define MT8173_INFRA_KP_RST             6
+#define MT8173_INFRA_PMIC_WRAP_RST      7
+#define MT8173_INFRA_MPIP_RST           8
+#define MT8173_INFRA_CEC_RST            9
+#define MT8173_INFRA_EMI_RST            32
+#define MT8173_INFRA_DRAMC0_RST         34
+#define MT8173_INFRA_APMIXEDSYS_RST     35
+#define MT8173_INFRA_MIPI_DSI_RST       36
+#define MT8173_INFRA_TRNG_RST           37
+#define MT8173_INFRA_SYSIRQ_RST         38
+#define MT8173_INFRA_MIPI_CSI_RST       39
+#define MT8173_INFRA_GCE_FAXI_RST       40
+#define MT8173_INFRA_MMIOMMURST         47
+
+
+/*  PERICFG resets */
+#define MT8173_PERI_UART0_SW_RST        0
+#define MT8173_PERI_UART1_SW_RST        1
+#define MT8173_PERI_UART2_SW_RST        2
+#define MT8173_PERI_UART3_SW_RST        3
+#define MT8173_PERI_IRRX_SW_RST         4
+#define MT8173_PERI_PWM_SW_RST          8
+#define MT8173_PERI_AUXADC_SW_RST       10
+#define MT8173_PERI_DMA_SW_RST          11
+#define MT8173_PERI_I2C6_SW_RST         13
+#define MT8173_PERI_NFI_SW_RST          14
+#define MT8173_PERI_THERM_SW_RST        16
+#define MT8173_PERI_MSDC2_SW_RST        17
+#define MT8173_PERI_MSDC3_SW_RST        18
+#define MT8173_PERI_MSDC0_SW_RST        19
+#define MT8173_PERI_MSDC1_SW_RST        20
+#define MT8173_PERI_I2C0_SW_RST         22
+#define MT8173_PERI_I2C1_SW_RST         23
+#define MT8173_PERI_I2C2_SW_RST         24
+#define MT8173_PERI_I2C3_SW_RST         25
+#define MT8173_PERI_I2C4_SW_RST         26
+#define MT8173_PERI_HDMI_SW_RST         29
+#define MT8173_PERI_SPI0_SW_RST         33
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8173 */
-- 
2.1.4
