From: bintian.wang@huawei.com (Bintian Wang)
Date: Wed, 20 May 2015 18:29:11 +0800
Subject: [PATCH v7 6/7] clk: hi6220: Clock driver support for Hisilicon hi6220
 SoC
In-Reply-To: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
References: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
Message-ID: <1432117752-7074-2-git-send-email-bintian.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock drivers for hi6220 SoC, this driver controls the SoC
registers to supply different clocks to different IPs in the SoC.

We add one divider clock for hi6220 because the divider in hi6220
also has a mask bit but it doesnot obey the rule defined by flag
"CLK_DIVIDER_HIWORD_MASK", we can not get index of the mask bit by
left shift fixed bits (e.g. 16 bits), so we add this divider clock
to handle it.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Will Deacon <will.deacon@arm.com>
Tested-by: Tyler Baker <tyler.baker@linaro.org>
---
 drivers/clk/Kconfig                       |    2 +
 drivers/clk/Makefile                      |    4 +-
 drivers/clk/hisilicon/Kconfig             |    6 +
 drivers/clk/hisilicon/Makefile            |    3 +-
 drivers/clk/hisilicon/clk-hi6220.c        |  291 +++++++++++++++++++++++++++++
 drivers/clk/hisilicon/clk.c               |   29 +++
 drivers/clk/hisilicon/clk.h               |   17 ++
 drivers/clk/hisilicon/clkdivider-hi6220.c |  156 ++++++++++++++++
 include/dt-bindings/clock/hi6220-clock.h  |  173 +++++++++++++++++
 9 files changed, 677 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/hisilicon/Kconfig
 create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
 create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
 create mode 100644 include/dt-bindings/clock/hi6220-clock.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 9897f35..18bb930 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -150,6 +150,8 @@ config COMMON_CLK_CDCE706
 	---help---
 	  This driver supports TI CDCE706 programmable 3-PLL clock synthesizer.
 
+source "drivers/clk/hisilicon/Kconfig"
+
 source "drivers/clk/qcom/Kconfig"
 
 endmenu
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 3d00c25..9719954 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -47,9 +47,7 @@ obj-$(CONFIG_COMMON_CLK_PWM)		+= clk-pwm.o
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_BCM_MOBILE)		+= bcm/
 obj-$(CONFIG_ARCH_BERLIN)		+= berlin/
-obj-$(CONFIG_ARCH_HI3xxx)		+= hisilicon/
-obj-$(CONFIG_ARCH_HIP04)		+= hisilicon/
-obj-$(CONFIG_ARCH_HIX5HD2)		+= hisilicon/
+obj-$(CONFIG_ARCH_HISI)			+= hisilicon/
 obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
diff --git a/drivers/clk/hisilicon/Kconfig b/drivers/clk/hisilicon/Kconfig
new file mode 100644
index 0000000..b4165ba
--- /dev/null
+++ b/drivers/clk/hisilicon/Kconfig
@@ -0,0 +1,6 @@
+config COMMON_CLK_HI6220
+	bool "Hi6220 Clock Driver"
+	depends on ARCH_HISI || COMPILE_TEST
+	default ARCH_HISI
+	help
+	  Build the Hisilicon Hi6220 clock driver based on the common clock framework.
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
index 038c02f..48f0116 100644
--- a/drivers/clk/hisilicon/Makefile
+++ b/drivers/clk/hisilicon/Makefile
@@ -2,8 +2,9 @@
 # Hisilicon Clock specific Makefile
 #
 
-obj-y	+= clk.o clkgate-separated.o
+obj-y	+= clk.o clkgate-separated.o clkdivider-hi6220.o
 
 obj-$(CONFIG_ARCH_HI3xxx)	+= clk-hi3620.o
 obj-$(CONFIG_ARCH_HIP04)	+= clk-hip04.o
 obj-$(CONFIG_ARCH_HIX5HD2)	+= clk-hix5hd2.o
+obj-$(CONFIG_COMMON_CLK_HI6220)	+= clk-hi6220.o
diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
new file mode 100644
index 0000000..438326f
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -0,0 +1,291 @@
+/*
+ * Hisilicon Hi6220 clock driver
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ *
+ * Author: Bintian Wang <bintian.wang@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/hi6220-clock.h>
+
+#include "clk.h"
+
+
+/* clocks in AO (always on) controller */
+static struct hisi_fixed_rate_clock hi6220_fixed_rate_clks[] __initdata = {
+	{ HI6220_REF32K,	"ref32k",	NULL, CLK_IS_ROOT, 32764,     },
+	{ HI6220_CLK_TCXO,	"clk_tcxo",	NULL, CLK_IS_ROOT, 19200000,  },
+	{ HI6220_MMC1_PAD,	"mmc1_pad",	NULL, CLK_IS_ROOT, 100000000, },
+	{ HI6220_MMC2_PAD,	"mmc2_pad",	NULL, CLK_IS_ROOT, 100000000, },
+	{ HI6220_MMC0_PAD,	"mmc0_pad",	NULL, CLK_IS_ROOT, 200000000, },
+	{ HI6220_PLL_BBP,	"bbppll0",	NULL, CLK_IS_ROOT, 245760000, },
+	{ HI6220_PLL_GPU,	"gpupll",	NULL, CLK_IS_ROOT, 1000000000,},
+	{ HI6220_PLL1_DDR,	"ddrpll1",	NULL, CLK_IS_ROOT, 1066000000,},
+	{ HI6220_PLL_SYS,	"syspll",	NULL, CLK_IS_ROOT, 1200000000,},
+	{ HI6220_PLL_SYS_MEDIA,	"media_syspll",	NULL, CLK_IS_ROOT, 1200000000,},
+	{ HI6220_DDR_SRC,	"ddr_sel_src",  NULL, CLK_IS_ROOT, 1200000000,},
+	{ HI6220_PLL_MEDIA,	"media_pll",    NULL, CLK_IS_ROOT, 1440000000,},
+	{ HI6220_PLL_DDR,	"ddrpll0",      NULL, CLK_IS_ROOT, 1600000000,},
+};
+
+static struct hisi_fixed_factor_clock hi6220_fixed_factor_clks[] __initdata = {
+	{ HI6220_300M,         "clk_300m",    "syspll",          1, 4, 0, },
+	{ HI6220_150M,         "clk_150m",    "clk_300m",        1, 2, 0, },
+	{ HI6220_PICOPHY_SRC,  "picophy_src", "clk_150m",        1, 4, 0, },
+	{ HI6220_MMC0_SRC_SEL, "mmc0srcsel",  "mmc0_sel",        1, 8, 0, },
+	{ HI6220_MMC1_SRC_SEL, "mmc1srcsel",  "mmc1_sel",        1, 8, 0, },
+	{ HI6220_MMC2_SRC_SEL, "mmc2srcsel",  "mmc2_sel",        1, 8, 0, },
+	{ HI6220_VPU_CODEC,    "vpucodec",    "codec_jpeg_aclk", 1, 2, 0, },
+	{ HI6220_MMC0_SMP,     "mmc0_sample", "mmc0_sel",        1, 8, 0, },
+	{ HI6220_MMC1_SMP,     "mmc1_sample", "mmc1_sel",        1, 8, 0, },
+	{ HI6220_MMC2_SMP,     "mmc2_sample", "mmc2_sel",        1, 8, 0, },
+};
+
+static struct hisi_gate_clock hi6220_separated_gate_clks_ao[] __initdata = {
+	{ HI6220_WDT0_PCLK,   "wdt0_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 12, 0, },
+	{ HI6220_WDT1_PCLK,   "wdt1_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 13, 0, },
+	{ HI6220_WDT2_PCLK,   "wdt2_pclk",   "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 14, 0, },
+	{ HI6220_TIMER0_PCLK, "timer0_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 15, 0, },
+	{ HI6220_TIMER1_PCLK, "timer1_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 16, 0, },
+	{ HI6220_TIMER2_PCLK, "timer2_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 17, 0, },
+	{ HI6220_TIMER3_PCLK, "timer3_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 18, 0, },
+	{ HI6220_TIMER4_PCLK, "timer4_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 19, 0, },
+	{ HI6220_TIMER5_PCLK, "timer5_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 20, 0, },
+	{ HI6220_TIMER6_PCLK, "timer6_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 21, 0, },
+	{ HI6220_TIMER7_PCLK, "timer7_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 22, 0, },
+	{ HI6220_TIMER8_PCLK, "timer8_pclk", "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 23, 0, },
+	{ HI6220_UART0_PCLK,  "uart0_pclk",  "clk_tcxo", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x630, 24, 0, },
+};
+
+static struct hisi_clock_data *clk_data_ao;
+
+static void __init hi6220_clk_ao_init(struct device_node *np)
+{
+	clk_data_ao = hisi_clk_init(np, HI6220_AO_NR_CLKS);
+	if (!clk_data_ao)
+		return;
+
+	hisi_clk_register_fixed_rate(hi6220_fixed_rate_clks,
+				ARRAY_SIZE(hi6220_fixed_rate_clks), clk_data_ao);
+
+	hisi_clk_register_fixed_factor(hi6220_fixed_factor_clks,
+				ARRAY_SIZE(hi6220_fixed_factor_clks), clk_data_ao);
+
+	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_ao,
+				ARRAY_SIZE(hi6220_separated_gate_clks_ao), clk_data_ao);
+}
+CLK_OF_DECLARE(hi6220_clk_ao, "hisilicon,hi6220-aoctrl", hi6220_clk_ao_init);
+
+
+/* clocks in sysctrl */
+static const char *mmc0_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
+static const char *mmc0_mux1_p[] __initdata = { "mmc0_mux0", "pll_media_gate", };
+static const char *mmc0_src_p[] __initdata = { "mmc0srcsel", "mmc0_div", };
+static const char *mmc1_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
+static const char *mmc1_mux1_p[] __initdata = { "mmc1_mux0", "pll_media_gate", };
+static const char *mmc1_src_p[]  __initdata = { "mmc1srcsel", "mmc1_div", };
+static const char *mmc2_mux0_p[] __initdata = { "pll_ddr_gate", "syspll", };
+static const char *mmc2_mux1_p[] __initdata = { "mmc2_mux0", "pll_media_gate", };
+static const char *mmc2_src_p[]  __initdata = { "mmc2srcsel", "mmc2_div", };
+static const char *mmc0_sample_in[] __initdata = { "mmc0_sample", "mmc0_pad", };
+static const char *mmc1_sample_in[] __initdata = { "mmc1_sample", "mmc1_pad", };
+static const char *mmc2_sample_in[] __initdata = { "mmc2_sample", "mmc2_pad", };
+static const char *uart1_src[] __initdata = { "clk_tcxo", "clk_150m", };
+static const char *uart2_src[] __initdata = { "clk_tcxo", "clk_150m", };
+static const char *uart3_src[] __initdata = { "clk_tcxo", "clk_150m", };
+static const char *uart4_src[] __initdata = { "clk_tcxo", "clk_150m", };
+static const char *hifi_src[] __initdata = { "syspll", "pll_media_gate", };
+
+static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
+	{ HI6220_MMC0_CLK,      "mmc0_clk",      "mmc0_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
+	{ HI6220_MMC0_CIUCLK,   "mmc0_ciuclk",   "mmc0_smp_in",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 0,  0, },
+	{ HI6220_MMC1_CLK,      "mmc1_clk",      "mmc1_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 1,  0, },
+	{ HI6220_MMC1_CIUCLK,   "mmc1_ciuclk",   "mmc1_smp_in",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 1,  0, },
+	{ HI6220_MMC2_CLK,      "mmc2_clk",      "mmc2_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 2,  0, },
+	{ HI6220_MMC2_CIUCLK,   "mmc2_ciuclk",   "mmc2_smp_in",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 2,  0, },
+	{ HI6220_USBOTG_HCLK,   "usbotg_hclk",   "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 4,  0, },
+	{ HI6220_CLK_PICOPHY,   "clk_picophy",   "cs_dapb",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x200, 5,  0, },
+	{ HI6220_HIFI,          "hifi_clk",      "hifi_div",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x210, 0,  0, },
+	{ HI6220_DACODEC_PCLK,  "dacodec_pclk",  "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x210, 5,  0, },
+	{ HI6220_EDMAC_ACLK,    "edmac_aclk",    "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x220, 2,  0, },
+	{ HI6220_CS_ATB,        "cs_atb",        "cs_atb_div",     CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 0,  0, },
+	{ HI6220_I2C0_CLK,      "i2c0_clk",      "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 1,  0, },
+	{ HI6220_I2C1_CLK,      "i2c1_clk",      "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 2,  0, },
+	{ HI6220_I2C2_CLK,      "i2c2_clk",      "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 3,  0, },
+	{ HI6220_I2C3_CLK,      "i2c3_clk",      "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 4,  0, },
+	{ HI6220_UART1_PCLK,    "uart1_pclk",    "uart1_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 5,  0, },
+	{ HI6220_UART2_PCLK,    "uart2_pclk",    "uart2_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 6,  0, },
+	{ HI6220_UART3_PCLK,    "uart3_pclk",    "uart3_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 7,  0, },
+	{ HI6220_UART4_PCLK,    "uart4_pclk",    "uart4_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 8,  0, },
+	{ HI6220_SPI_CLK,       "spi_clk",       "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 9,  0, },
+	{ HI6220_TSENSOR_CLK,   "tsensor_clk",   "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 12, 0, },
+	{ HI6220_MMU_CLK,       "mmu_clk",       "ddrc_axi1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x240, 11, 0, },
+	{ HI6220_HIFI_SEL,      "hifi_sel",      "hifi_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 0,  0, },
+	{ HI6220_MMC0_SYSPLL,   "mmc0_syspll",   "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 1,  0, },
+	{ HI6220_MMC1_SYSPLL,   "mmc1_syspll",   "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 2,  0, },
+	{ HI6220_MMC2_SYSPLL,   "mmc2_syspll",   "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 3,  0, },
+	{ HI6220_MMC0_SEL,      "mmc0_sel",      "mmc0_mux1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 6,  0, },
+	{ HI6220_MMC1_SEL,      "mmc1_sel",      "mmc1_mux1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 7,  0, },
+	{ HI6220_BBPPLL_SEL,    "bbppll_sel",    "pll0_bbp_gate",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 9,  0, },
+	{ HI6220_MEDIA_PLL_SRC, "media_pll_src", "pll_media_gate", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 10, 0, },
+	{ HI6220_MMC2_SEL,      "mmc2_sel",      "mmc2_mux1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 11, 0, },
+	{ HI6220_CS_ATB_SYSPLL, "cs_atb_syspll", "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 12, 0, },
+};
+
+static struct hisi_mux_clock hi6220_mux_clks_sys[] __initdata = {
+	{ HI6220_MMC0_SRC,    "mmc0_src",    mmc0_src_p,     ARRAY_SIZE(mmc0_src_p),     CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
+	{ HI6220_MMC0_SMP_IN, "mmc0_smp_in", mmc0_sample_in, ARRAY_SIZE(mmc0_sample_in), CLK_SET_RATE_PARENT, 0x4,   0,  1, 0, },
+	{ HI6220_MMC1_SRC,    "mmc1_src",    mmc1_src_p,     ARRAY_SIZE(mmc1_src_p),     CLK_SET_RATE_PARENT, 0x4,   2,  1, 0, },
+	{ HI6220_MMC1_SMP_IN, "mmc1_smp_in", mmc1_sample_in, ARRAY_SIZE(mmc1_sample_in), CLK_SET_RATE_PARENT, 0x4,   2,  1, 0, },
+	{ HI6220_MMC2_SRC,    "mmc2_src",    mmc2_src_p,     ARRAY_SIZE(mmc2_src_p),     CLK_SET_RATE_PARENT, 0x4,   4,  1, 0, },
+	{ HI6220_MMC2_SMP_IN, "mmc2_smp_in", mmc2_sample_in, ARRAY_SIZE(mmc2_sample_in), CLK_SET_RATE_PARENT, 0x4,   4,  1, 0, },
+	{ HI6220_HIFI_SRC,    "hifi_src",    hifi_src,       ARRAY_SIZE(hifi_src),       CLK_SET_RATE_PARENT, 0x400, 0,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_UART1_SRC,   "uart1_src",   uart1_src,      ARRAY_SIZE(uart1_src),      CLK_SET_RATE_PARENT, 0x400, 1,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_UART2_SRC,   "uart2_src",   uart2_src,      ARRAY_SIZE(uart2_src),      CLK_SET_RATE_PARENT, 0x400, 2,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_UART3_SRC,   "uart3_src",   uart3_src,      ARRAY_SIZE(uart3_src),      CLK_SET_RATE_PARENT, 0x400, 3,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_UART4_SRC,   "uart4_src",   uart4_src,      ARRAY_SIZE(uart4_src),      CLK_SET_RATE_PARENT, 0x400, 4,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC0_MUX0,   "mmc0_mux0",   mmc0_mux0_p,    ARRAY_SIZE(mmc0_mux0_p),    CLK_SET_RATE_PARENT, 0x400, 5,  1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC1_MUX0,   "mmc1_mux0",   mmc1_mux0_p,    ARRAY_SIZE(mmc1_mux0_p),    CLK_SET_RATE_PARENT, 0x400, 11, 1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC2_MUX0,   "mmc2_mux0",   mmc2_mux0_p,    ARRAY_SIZE(mmc2_mux0_p),    CLK_SET_RATE_PARENT, 0x400, 12, 1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC0_MUX1,   "mmc0_mux1",   mmc0_mux1_p,    ARRAY_SIZE(mmc0_mux1_p),    CLK_SET_RATE_PARENT, 0x400, 13, 1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC1_MUX1,   "mmc1_mux1",   mmc1_mux1_p,    ARRAY_SIZE(mmc1_mux1_p),    CLK_SET_RATE_PARENT, 0x400, 14, 1, CLK_MUX_HIWORD_MASK,},
+	{ HI6220_MMC2_MUX1,   "mmc2_mux1",   mmc2_mux1_p,    ARRAY_SIZE(mmc2_mux1_p),    CLK_SET_RATE_PARENT, 0x400, 15, 1, CLK_MUX_HIWORD_MASK,},
+};
+
+static struct hi6220_divider_clock hi6220_div_clks_sys[] __initdata = {
+	{ HI6220_CLK_BUS,     "clk_bus",     "clk_300m",      CLK_SET_RATE_PARENT, 0x490, 0,  4, 7, },
+	{ HI6220_MMC0_DIV,    "mmc0_div",    "mmc0_syspll",   CLK_SET_RATE_PARENT, 0x494, 0,  6, 7, },
+	{ HI6220_MMC1_DIV,    "mmc1_div",    "mmc1_syspll",   CLK_SET_RATE_PARENT, 0x498, 0,  6, 7, },
+	{ HI6220_MMC2_DIV,    "mmc2_div",    "mmc2_syspll",   CLK_SET_RATE_PARENT, 0x49c, 0,  6, 7, },
+	{ HI6220_HIFI_DIV,    "hifi_div",    "hifi_sel",      CLK_SET_RATE_PARENT, 0x4a0, 0,  4, 7, },
+	{ HI6220_BBPPLL0_DIV, "bbppll0_div", "bbppll_sel",    CLK_SET_RATE_PARENT, 0x4a0, 8,  6, 15,},
+	{ HI6220_CS_DAPB,     "cs_dapb",     "picophy_src",   CLK_SET_RATE_PARENT, 0x4a0, 24, 2, 31,},
+	{ HI6220_CS_ATB_DIV,  "cs_atb_div",  "cs_atb_syspll", CLK_SET_RATE_PARENT, 0x4a4, 0,  4, 7, },
+};
+
+static void __init hi6220_clk_sys_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
+			ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
+
+	hisi_clk_register_mux(hi6220_mux_clks_sys,
+			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
+
+	hi6220_clk_register_divider(hi6220_div_clks_sys,
+			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
+
+	if (!clk_data_ao)
+		return;
+
+	/* enable high speed clock on UART1 mux */
+	clk_set_parent(clk_data->clk_data.clks[HI6220_UART1_SRC],
+			clk_data_ao->clk_data.clks[HI6220_150M]);
+}
+CLK_OF_DECLARE(hi6220_clk_sys, "hisilicon,hi6220-sysctrl", hi6220_clk_sys_init);
+
+
+/* clocks in media controller */
+static const char *clk_1000_1200_src[] __initdata = { "pll_gpu_gate", "media_syspll_src", };
+static const char *clk_1440_1200_src[] __initdata = { "media_syspll_src", "media_pll_src", };
+static const char *clk_1000_1440_src[] __initdata = { "pll_gpu_gate", "media_pll_src", };
+
+static struct hisi_gate_clock hi6220_separated_gate_clks_media[] __initdata = {
+	{ HI6220_DSI_PCLK,       "dsi_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 0,  0, },
+	{ HI6220_G3D_PCLK,       "g3d_pclk",         "vpucodec",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 1,  0, },
+	{ HI6220_ACLK_CODEC_VPU, "aclk_codec_vpu",   "ade_core_src",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 3,  0, },
+	{ HI6220_ISP_SCLK,       "isp_sclk",         "isp_sclk_src",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 5,  0, },
+	{ HI6220_ADE_CORE,	 "ade_core",	     "ade_core_src",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 6,  0, },
+	{ HI6220_MED_MMU,        "media_mmu",        "mmu_clk",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 8,  0, },
+	{ HI6220_CFG_CSI4PHY,    "cfg_csi4phy",      "clk_tcxo",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 9,  0, },
+	{ HI6220_CFG_CSI2PHY,    "cfg_csi2phy",      "clk_tcxo",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 10, 0, },
+	{ HI6220_ISP_SCLK_GATE,  "isp_sclk_gate",    "media_pll_src", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 11, 0, },
+	{ HI6220_ISP_SCLK_GATE1, "isp_sclk_gate1",   "media_pll_src", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 12, 0, },
+	{ HI6220_ADE_CORE_GATE,  "ade_core_gate",    "media_pll_src", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 14, 0, },
+	{ HI6220_CODEC_VPU_GATE, "codec_vpu_gate",   "clk_1000_1440", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 15, 0, },
+	{ HI6220_MED_SYSPLL,     "media_syspll_src", "media_syspll",  CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x520, 17, 0, },
+};
+
+static struct hisi_mux_clock hi6220_mux_clks_media[] __initdata = {
+	{ HI6220_1440_1200, "clk_1440_1200", clk_1440_1200_src, ARRAY_SIZE(clk_1440_1200_src), CLK_SET_RATE_PARENT, 0x51c, 0, 1, 0, },
+	{ HI6220_1000_1200, "clk_1000_1200", clk_1000_1200_src, ARRAY_SIZE(clk_1000_1200_src), CLK_SET_RATE_PARENT, 0x51c, 1, 1, 0, },
+	{ HI6220_1000_1440, "clk_1000_1440", clk_1000_1440_src, ARRAY_SIZE(clk_1000_1440_src), CLK_SET_RATE_PARENT, 0x51c, 6, 1, 0, },
+};
+
+static struct hi6220_divider_clock hi6220_div_clks_media[] __initdata = {
+	{ HI6220_CODEC_JPEG,    "codec_jpeg_aclk", "media_pll_src",  CLK_SET_RATE_PARENT, 0xcbc, 0,  4, 23, },
+	{ HI6220_ISP_SCLK_SRC,  "isp_sclk_src",    "isp_sclk_gate",  CLK_SET_RATE_PARENT, 0xcbc, 8,  4, 15, },
+	{ HI6220_ISP_SCLK1,     "isp_sclk1",       "isp_sclk_gate1", CLK_SET_RATE_PARENT, 0xcbc, 24, 4, 31, },
+	{ HI6220_ADE_CORE_SRC,  "ade_core_src",    "ade_core_gate",  CLK_SET_RATE_PARENT, 0xcc0, 16, 3, 23, },
+	{ HI6220_ADE_PIX_SRC,   "ade_pix_src",     "clk_1440_1200",  CLK_SET_RATE_PARENT, 0xcc0, 24, 6, 31, },
+	{ HI6220_G3D_CLK,       "g3d_clk",         "clk_1000_1200",  CLK_SET_RATE_PARENT, 0xcc4, 8,  4, 15, },
+	{ HI6220_CODEC_VPU_SRC, "codec_vpu_src",   "codec_vpu_gate", CLK_SET_RATE_PARENT, 0xcc4, 24, 6, 31, },
+};
+
+static void __init hi6220_clk_media_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI6220_MEDIA_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_media,
+				ARRAY_SIZE(hi6220_separated_gate_clks_media), clk_data);
+
+	hisi_clk_register_mux(hi6220_mux_clks_media,
+				ARRAY_SIZE(hi6220_mux_clks_media), clk_data);
+
+	hi6220_clk_register_divider(hi6220_div_clks_media,
+				ARRAY_SIZE(hi6220_div_clks_media), clk_data);
+}
+CLK_OF_DECLARE(hi6220_clk_media, "hisilicon,hi6220-mediactrl", hi6220_clk_media_init);
+
+
+/* clocks in pmctrl */
+static struct hisi_gate_clock hi6220_gate_clks_power[] __initdata = {
+	{ HI6220_PLL_GPU_GATE,   "pll_gpu_gate",   "gpupll",    CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x8,  0,  0, },
+	{ HI6220_PLL1_DDR_GATE,  "pll1_ddr_gate",  "ddrpll1",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x10, 0,  0, },
+	{ HI6220_PLL_DDR_GATE,   "pll_ddr_gate",   "ddrpll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x18, 0,  0, },
+	{ HI6220_PLL_MEDIA_GATE, "pll_media_gate", "media_pll", CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x38, 0,  0, },
+	{ HI6220_PLL0_BBP_GATE,  "pll0_bbp_gate",  "bbppll0",   CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x48, 0,  0, },
+};
+
+static struct hi6220_divider_clock hi6220_div_clks_power[] __initdata = {
+	{ HI6220_DDRC_SRC,  "ddrc_src",  "ddr_sel_src", CLK_SET_RATE_PARENT, 0x5a8, 0, 4, 0, },
+	{ HI6220_DDRC_AXI1, "ddrc_axi1", "ddrc_src",    CLK_SET_RATE_PARENT, 0x5a8, 8, 2, 0, },
+};
+
+static void __init hi6220_clk_power_init(struct device_node *np)
+{
+	struct hisi_clock_data *clk_data;
+
+	clk_data = hisi_clk_init(np, HI6220_POWER_NR_CLKS);
+	if (!clk_data)
+		return;
+
+	hisi_clk_register_gate(hi6220_gate_clks_power,
+				ARRAY_SIZE(hi6220_gate_clks_power), clk_data);
+
+	hi6220_clk_register_divider(hi6220_div_clks_power,
+				ARRAY_SIZE(hi6220_div_clks_power), clk_data);
+}
+CLK_OF_DECLARE(hi6220_clk_power, "hisilicon,hi6220-pmctrl", hi6220_clk_power_init);
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
index a078e84..c90a897 100644
--- a/drivers/clk/hisilicon/clk.c
+++ b/drivers/clk/hisilicon/clk.c
@@ -232,3 +232,32 @@ void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
 		data->clk_data.clks[clks[i].id] = clk;
 	}
 }
+
+void __init hi6220_clk_register_divider(struct hi6220_divider_clock *clks,
+					int nums, struct hisi_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = hi6220_register_clkdiv(NULL, clks[i].name,
+						clks[i].parent_name,
+						clks[i].flags,
+						base + clks[i].offset,
+						clks[i].shift,
+						clks[i].width,
+						clks[i].mask_bit,
+						&hisi_clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+}
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
index 6b6f994..21b403b 100644
--- a/drivers/clk/hisilicon/clk.h
+++ b/drivers/clk/hisilicon/clk.h
@@ -79,6 +79,18 @@ struct hisi_divider_clock {
 	const char		*alias;
 };
 
+struct hi6220_divider_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u32			mask_bit;
+	const char		*alias;
+};
+
 struct hisi_gate_clock {
 	unsigned int		id;
 	const char		*name;
@@ -94,6 +106,9 @@ struct clk *hisi_register_clkgate_sep(struct device *, const char *,
 				const char *, unsigned long,
 				void __iomem *, u8,
 				u8, spinlock_t *);
+struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
+	const char *parent_name, unsigned long flags, void __iomem *reg,
+	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock);
 
 struct hisi_clock_data *hisi_clk_init(struct device_node *, int);
 void hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
@@ -108,4 +123,6 @@ void hisi_clk_register_gate(struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
 void hisi_clk_register_gate_sep(struct hisi_gate_clock *,
 				int, struct hisi_clock_data *);
+void hi6220_clk_register_divider(struct hi6220_divider_clock *,
+				int, struct hisi_clock_data *);
 #endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/clkdivider-hi6220.c b/drivers/clk/hisilicon/clkdivider-hi6220.c
new file mode 100644
index 0000000..113eee8
--- /dev/null
+++ b/drivers/clk/hisilicon/clkdivider-hi6220.c
@@ -0,0 +1,156 @@
+/*
+ * Hisilicon hi6220 SoC divider clock driver
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ *
+ * Author: Bintian Wang <bintian.wang@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/spinlock.h>
+
+#define div_mask(width)	((1 << (width)) - 1)
+
+/**
+ * struct hi6220_clk_divider - divider clock for hi6220
+ *
+ * @hw:		handle between common and hardware-specific interfaces
+ * @reg:	register containing divider
+ * @shift:	shift to the divider bit field
+ * @width:	width of the divider bit field
+ * @mask:	mask for setting divider rate
+ * @table:	the div table that the divider supports
+ * @lock:	register lock
+ */
+struct hi6220_clk_divider {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		shift;
+	u8		width;
+	u32		mask;
+	const struct clk_div_table *table;
+	spinlock_t	*lock;
+};
+
+#define to_hi6220_clk_divider(_hw)	\
+	container_of(_hw, struct hi6220_clk_divider, hw)
+
+static unsigned long hi6220_clkdiv_recalc_rate(struct clk_hw *hw,
+					unsigned long parent_rate)
+{
+	unsigned int val;
+	struct hi6220_clk_divider *dclk = to_hi6220_clk_divider(hw);
+
+	val = readl_relaxed(dclk->reg) >> dclk->shift;
+	val &= div_mask(dclk->width);
+
+	return divider_recalc_rate(hw, parent_rate, val, dclk->table,
+				   CLK_DIVIDER_ROUND_CLOSEST);
+}
+
+static long hi6220_clkdiv_round_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long *prate)
+{
+	struct hi6220_clk_divider *dclk = to_hi6220_clk_divider(hw);
+
+	return divider_round_rate(hw, rate, prate, dclk->table,
+				  dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
+}
+
+static int hi6220_clkdiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					unsigned long parent_rate)
+{
+	int value;
+	unsigned long flags = 0;
+	u32 data;
+	struct hi6220_clk_divider *dclk = to_hi6220_clk_divider(hw);
+
+	value = divider_get_val(rate, parent_rate, dclk->table,
+				dclk->width, CLK_DIVIDER_ROUND_CLOSEST);
+
+	if (dclk->lock)
+		spin_lock_irqsave(dclk->lock, flags);
+
+	data = readl_relaxed(dclk->reg);
+	data &= ~(div_mask(dclk->width) << dclk->shift);
+	data |= value << dclk->shift;
+	data |= dclk->mask;
+
+	writel_relaxed(data, dclk->reg);
+
+	if (dclk->lock)
+		spin_unlock_irqrestore(dclk->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops hi6220_clkdiv_ops = {
+	.recalc_rate = hi6220_clkdiv_recalc_rate,
+	.round_rate = hi6220_clkdiv_round_rate,
+	.set_rate = hi6220_clkdiv_set_rate,
+};
+
+struct clk *hi6220_register_clkdiv(struct device *dev, const char *name,
+	const char *parent_name, unsigned long flags, void __iomem *reg,
+	u8 shift, u8 width, u32 mask_bit, spinlock_t *lock)
+{
+	struct hi6220_clk_divider *div;
+	struct clk *clk;
+	struct clk_init_data init;
+	struct clk_div_table *table;
+	u32 max_div, min_div;
+	int i;
+
+	/* allocate the divider */
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	/* Init the divider table */
+	max_div = div_mask(width) + 1;
+	min_div = 1;
+
+	table = kcalloc(max_div + 1, sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		kfree(div);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < max_div; i++) {
+		table[i].div = min_div + i;
+		table[i].val = table[i].div - 1;
+	}
+
+	init.name = name;
+	init.ops = &hi6220_clkdiv_ops;
+	init.flags = flags;
+	init.parent_names = parent_name ? &parent_name : NULL;
+	init.num_parents = parent_name ? 1 : 0;
+
+	/* struct hi6220_clk_divider assignments */
+	div->reg = reg;
+	div->shift = shift;
+	div->width = width;
+	div->mask = mask_bit ? BIT(mask_bit) : 0;
+	div->lock = lock;
+	div->hw.init = &init;
+	div->table = table;
+
+	/* register the clock */
+	clk = clk_register(dev, &div->hw);
+	if (IS_ERR(clk)) {
+		kfree(table);
+		kfree(div);
+	}
+
+	return clk;
+}
diff --git a/include/dt-bindings/clock/hi6220-clock.h b/include/dt-bindings/clock/hi6220-clock.h
new file mode 100644
index 0000000..70ee383
--- /dev/null
+++ b/include/dt-bindings/clock/hi6220-clock.h
@@ -0,0 +1,173 @@
+/*
+ * Copyright (c) 2015 Hisilicon Limited.
+ *
+ * Author: Bintian Wang <bintian.wang@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_HI6220_H
+#define __DT_BINDINGS_CLOCK_HI6220_H
+
+/* clk in Hi6220 AO (always on) controller */
+#define HI6220_NONE_CLOCK	0
+
+/* fixed rate clocks */
+#define HI6220_REF32K		1
+#define HI6220_CLK_TCXO		2
+#define HI6220_MMC1_PAD		3
+#define HI6220_MMC2_PAD		4
+#define HI6220_MMC0_PAD		5
+#define HI6220_PLL_BBP		6
+#define HI6220_PLL_GPU		7
+#define HI6220_PLL1_DDR		8
+#define HI6220_PLL_SYS		9
+#define HI6220_PLL_SYS_MEDIA	10
+#define HI6220_DDR_SRC		11
+#define HI6220_PLL_MEDIA	12
+#define HI6220_PLL_DDR		13
+
+/* fixed factor clocks */
+#define HI6220_300M		14
+#define HI6220_150M		15
+#define HI6220_PICOPHY_SRC	16
+#define HI6220_MMC0_SRC_SEL	17
+#define HI6220_MMC1_SRC_SEL	18
+#define HI6220_MMC2_SRC_SEL	19
+#define HI6220_VPU_CODEC	20
+#define HI6220_MMC0_SMP		21
+#define HI6220_MMC1_SMP		22
+#define HI6220_MMC2_SMP		23
+
+/* gate clocks */
+#define HI6220_WDT0_PCLK	24
+#define HI6220_WDT1_PCLK	25
+#define HI6220_WDT2_PCLK	26
+#define HI6220_TIMER0_PCLK	27
+#define HI6220_TIMER1_PCLK	28
+#define HI6220_TIMER2_PCLK	29
+#define HI6220_TIMER3_PCLK	30
+#define HI6220_TIMER4_PCLK	31
+#define HI6220_TIMER5_PCLK	32
+#define HI6220_TIMER6_PCLK	33
+#define HI6220_TIMER7_PCLK	34
+#define HI6220_TIMER8_PCLK	35
+#define HI6220_UART0_PCLK	36
+
+#define HI6220_AO_NR_CLKS	37
+
+/* clk in Hi6220 systrl */
+/* gate clock */
+#define HI6220_MMC0_CLK		1
+#define HI6220_MMC0_CIUCLK	2
+#define HI6220_MMC1_CLK		3
+#define HI6220_MMC1_CIUCLK	4
+#define HI6220_MMC2_CLK		5
+#define HI6220_MMC2_CIUCLK	6
+#define HI6220_USBOTG_HCLK	7
+#define HI6220_CLK_PICOPHY	8
+#define HI6220_HIFI		9
+#define HI6220_DACODEC_PCLK	10
+#define HI6220_EDMAC_ACLK	11
+#define HI6220_CS_ATB		12
+#define HI6220_I2C0_CLK		13
+#define HI6220_I2C1_CLK		14
+#define HI6220_I2C2_CLK		15
+#define HI6220_I2C3_CLK		16
+#define HI6220_UART1_PCLK	17
+#define HI6220_UART2_PCLK	18
+#define HI6220_UART3_PCLK	19
+#define HI6220_UART4_PCLK	20
+#define HI6220_SPI_CLK		21
+#define HI6220_TSENSOR_CLK	22
+#define HI6220_MMU_CLK		23
+#define HI6220_HIFI_SEL		24
+#define HI6220_MMC0_SYSPLL	25
+#define HI6220_MMC1_SYSPLL	26
+#define HI6220_MMC2_SYSPLL	27
+#define HI6220_MMC0_SEL		28
+#define HI6220_MMC1_SEL		29
+#define HI6220_BBPPLL_SEL	30
+#define HI6220_MEDIA_PLL_SRC	31
+#define HI6220_MMC2_SEL		32
+#define HI6220_CS_ATB_SYSPLL	33
+
+/* mux clocks */
+#define HI6220_MMC0_SRC		34
+#define HI6220_MMC0_SMP_IN	35
+#define HI6220_MMC1_SRC		36
+#define HI6220_MMC1_SMP_IN	37
+#define HI6220_MMC2_SRC		38
+#define HI6220_MMC2_SMP_IN	39
+#define HI6220_HIFI_SRC		40
+#define HI6220_UART1_SRC	41
+#define HI6220_UART2_SRC	42
+#define HI6220_UART3_SRC	43
+#define HI6220_UART4_SRC	44
+#define HI6220_MMC0_MUX0	45
+#define HI6220_MMC1_MUX0	46
+#define HI6220_MMC2_MUX0	47
+#define HI6220_MMC0_MUX1	48
+#define HI6220_MMC1_MUX1	49
+#define HI6220_MMC2_MUX1	50
+
+/* divider clocks */
+#define HI6220_CLK_BUS		51
+#define HI6220_MMC0_DIV		52
+#define HI6220_MMC1_DIV		53
+#define HI6220_MMC2_DIV		54
+#define HI6220_HIFI_DIV		55
+#define HI6220_BBPPLL0_DIV	56
+#define HI6220_CS_DAPB		57
+#define HI6220_CS_ATB_DIV	58
+
+#define HI6220_SYS_NR_CLKS	59
+
+/* clk in Hi6220 media controller */
+/* gate clocks */
+#define HI6220_DSI_PCLK		1
+#define HI6220_G3D_PCLK		2
+#define HI6220_ACLK_CODEC_VPU	3
+#define HI6220_ISP_SCLK		4
+#define HI6220_ADE_CORE		5
+#define HI6220_MED_MMU		6
+#define HI6220_CFG_CSI4PHY	7
+#define HI6220_CFG_CSI2PHY	8
+#define HI6220_ISP_SCLK_GATE	9
+#define HI6220_ISP_SCLK_GATE1	10
+#define HI6220_ADE_CORE_GATE	11
+#define HI6220_CODEC_VPU_GATE	12
+#define HI6220_MED_SYSPLL	13
+
+/* mux clocks */
+#define HI6220_1440_1200	14
+#define HI6220_1000_1200	15
+#define HI6220_1000_1440	16
+
+/* divider clocks */
+#define HI6220_CODEC_JPEG	17
+#define HI6220_ISP_SCLK_SRC	18
+#define HI6220_ISP_SCLK1	19
+#define HI6220_ADE_CORE_SRC	20
+#define HI6220_ADE_PIX_SRC	21
+#define HI6220_G3D_CLK		22
+#define HI6220_CODEC_VPU_SRC	23
+
+#define HI6220_MEDIA_NR_CLKS	24
+
+/* clk in Hi6220 power controller */
+/* gate clocks */
+#define HI6220_PLL_GPU_GATE	1
+#define HI6220_PLL1_DDR_GATE	2
+#define HI6220_PLL_DDR_GATE	3
+#define HI6220_PLL_MEDIA_GATE	4
+#define HI6220_PLL0_BBP_GATE	5
+
+/* divider clocks */
+#define HI6220_DDRC_SRC		6
+#define HI6220_DDRC_AXI1	7
+
+#define HI6220_POWER_NR_CLKS	8
+#endif
-- 
1.7.9.5
