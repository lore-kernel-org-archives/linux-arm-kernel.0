From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 13 Nov 2013 09:31:13 +0800
Subject: [PATCH v11 1/2] clk: hisilicon: add common clock support
In-Reply-To: <1384306274-27315-1-git-send-email-haojian.zhuang@gmail.com>
References: <1384306274-27315-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1384306274-27315-2-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable common clock driver of Hi3620 SoC. clkgate-seperated driver is
used to support the clock gate that enable/disable/status registers
are seperated.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/clock/hi3620-clock.txt     |  19 ++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/hisilicon/Makefile                     |   5 +
 drivers/clk/hisilicon/clk-hi3620.c                 | 242 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        | 171 +++++++++++++++
 drivers/clk/hisilicon/clk.h                        | 103 +++++++++
 drivers/clk/hisilicon/clkgate-seperated.c          | 130 +++++++++++
 include/dt-bindings/clock/hi3620-clock.h           | 152 +++++++++++++
 8 files changed, 823 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/hi3620-clock.txt
 create mode 100644 drivers/clk/hisilicon/Makefile
 create mode 100644 drivers/clk/hisilicon/clk-hi3620.c
 create mode 100644 drivers/clk/hisilicon/clk.c
 create mode 100644 drivers/clk/hisilicon/clk.h
 create mode 100644 drivers/clk/hisilicon/clkgate-seperated.c
 create mode 100644 include/dt-bindings/clock/hi3620-clock.h

diff --git a/Documentation/devicetree/bindings/clock/hi3620-clock.txt b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
new file mode 100644
index 0000000..80e134d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
@@ -0,0 +1,19 @@
+* Hisilicon Hi3620 Clock Controller
+
+The Hi3620 clock controller generates and supplies clock to various
+controllers within the Hi3620 SoC.
+
+Required Properties:
+
+- comptible: should be one of the following.
+  - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
+
+- reg: physical base address of the controller and length of memory mapped
+  region.
+
+- #clock-cells: should be 1.
+
+Each clock is assigned an identifier and client nodes use this identifier
+to specify the clock which they consume.
+
+All these identifier could be found in <dt-bindings/clock/hi3620-clock.h>.
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7b11106..e156b53 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
+obj-$(CONFIG_ARCH_HI3xxx)	+= hisilicon/
 obj-$(CONFIG_ARCH_NSPIRE)	+= clk-nspire.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs/
 obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
new file mode 100644
index 0000000..fad958b
--- /dev/null
+++ b/drivers/clk/hisilicon/Makefile
@@ -0,0 +1,5 @@
+#
+# Hisilicon Clock specific Makefile
+#
+
+obj-y	+= clk.o clkgate-seperated.o clk-hi3620.o
diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
new file mode 100644
index 0000000..b66b074
--- /dev/null
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -0,0 +1,242 @@
+/*
+ * Hisilicon Hi3620 clock driver
+ *
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
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
+#include <linux/clk.h>
+
+#include <dt-bindings/clock/hi3620-clock.h>
+
+#include "clk.h"
+
+/* clock parent list */
+static const char *timer0_mux_p[] __initdata = { "osc32k", "timerclk01", };
+static const char *timer1_mux_p[] __initdata = { "osc32k", "timerclk01", };
+static const char *timer2_mux_p[] __initdata = { "osc32k", "timerclk23", };
+static const char *timer3_mux_p[] __initdata = { "osc32k", "timerclk23", };
+static const char *timer4_mux_p[] __initdata = { "osc32k", "timerclk45", };
+static const char *timer5_mux_p[] __initdata = { "osc32k", "timerclk45", };
+static const char *timer6_mux_p[] __initdata = { "osc32k", "timerclk67", };
+static const char *timer7_mux_p[] __initdata = { "osc32k", "timerclk67", };
+static const char *timer8_mux_p[] __initdata = { "osc32k", "timerclk89", };
+static const char *timer9_mux_p[] __initdata = { "osc32k", "timerclk89", };
+static const char *uart0_mux_p[] __initdata = { "osc26m", "pclk", };
+static const char *uart1_mux_p[] __initdata = { "osc26m", "pclk", };
+static const char *uart2_mux_p[] __initdata = { "osc26m", "pclk", };
+static const char *uart3_mux_p[] __initdata = { "osc26m", "pclk", };
+static const char *uart4_mux_p[] __initdata = { "osc26m", "pclk", };
+static const char *spi0_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
+static const char *spi1_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
+static const char *spi2_mux_p[] __initdata = { "osc26m", "rclk_cfgaxi", };
+/* share axi parent */
+static const char *saxi_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *pwm0_mux_p[] __initdata = { "osc32k", "osc26m", };
+static const char *pwm1_mux_p[] __initdata = { "osc32k", "osc26m", };
+static const char *sd_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *mmc1_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *mmc1_mux2_p[] __initdata = { "osc26m", "mmc1_div", };
+static const char *g2d_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *venc_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *vdec_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *vpp_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *edc0_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *ldi0_mux_p[] __initdata = { "armpll2", "armpll4",
+					     "armpll3", "armpll5", };
+static const char *edc1_mux_p[] __initdata = { "armpll2", "armpll3", };
+static const char *ldi1_mux_p[] __initdata = { "armpll2", "armpll4",
+					     "armpll3", "armpll5", };
+static const char *rclk_hsic_p[] __initdata = { "armpll3", "armpll2", };
+static const char *mmc2_mux_p[] __initdata = { "armpll3", "armpll2", };
+static const char *mmc3_mux_p[] __initdata = { "armpll3", "armpll2", };
+
+
+/* fixed rate clocks */
+static struct hisi_fixed_rate_clock hi3620_fixed_rate_clks[] __initdata = {
+	{ HI3620_OSC32K,   "osc32k",   NULL, CLK_IS_ROOT, 32768, },
+	{ HI3620_OSC26M,   "osc26m",   NULL, CLK_IS_ROOT, 26000000, },
+	{ HI3620_PCLK,     "pclk",     NULL, CLK_IS_ROOT, 26000000, },
+	{ HI3620_PLL_ARM0, "armpll0",  NULL, CLK_IS_ROOT, 1600000000, },
+	{ HI3620_PLL_ARM1, "armpll1",  NULL, CLK_IS_ROOT, 1600000000, },
+	{ HI3620_PLL_PERI, "armpll2",  NULL, CLK_IS_ROOT, 1440000000, },
+	{ HI3620_PLL_USB,  "armpll3",  NULL, CLK_IS_ROOT, 1440000000, },
+	{ HI3620_PLL_HDMI, "armpll4",  NULL, CLK_IS_ROOT, 1188000000, },
+	{ HI3620_PLL_GPU,  "armpll5",  NULL, CLK_IS_ROOT, 1300000000, },
+};
+
+/* fixed factor clocks */
+static struct hisi_fixed_factor_clock hi3620_fixed_factor_clks[] __initdata = {
+	{ HI3620_RCLK_TCXO,   "rclk_tcxo",   "osc26m",   1, 4,  0, },
+	{ HI3620_RCLK_CFGAXI, "rclk_cfgaxi", "armpll2",  1, 30, 0, },
+	{ HI3620_RCLK_PICO,   "rclk_pico",   "hsic_div", 1, 40, 0, },
+};
+
+static struct hisi_mux_clock hi3620_mux_clks[] __initdata = {
+	{ HI3620_TIMER0_MUX, "timer0_mux", timer0_mux_p, ARRAY_SIZE(timer0_mux_p), CLK_SET_RATE_PARENT, 0,     15, 2, 0,                   },
+	{ HI3620_TIMER1_MUX, "timer1_mux", timer1_mux_p, ARRAY_SIZE(timer1_mux_p), CLK_SET_RATE_PARENT, 0,     17, 2, 0,                   },
+	{ HI3620_TIMER2_MUX, "timer2_mux", timer2_mux_p, ARRAY_SIZE(timer2_mux_p), CLK_SET_RATE_PARENT, 0,     19, 2, 0,                   },
+	{ HI3620_TIMER3_MUX, "timer3_mux", timer3_mux_p, ARRAY_SIZE(timer3_mux_p), CLK_SET_RATE_PARENT, 0,     21, 2, 0,                   },
+	{ HI3620_TIMER4_MUX, "timer4_mux", timer4_mux_p, ARRAY_SIZE(timer4_mux_p), CLK_SET_RATE_PARENT, 0x18,  0,  2, 0,                   },
+	{ HI3620_TIMER5_MUX, "timer5_mux", timer5_mux_p, ARRAY_SIZE(timer5_mux_p), CLK_SET_RATE_PARENT, 0x18,  2,  2, 0,                   },
+	{ HI3620_TIMER6_MUX, "timer6_mux", timer6_mux_p, ARRAY_SIZE(timer6_mux_p), CLK_SET_RATE_PARENT, 0x18,  4,  2, 0,                   },
+	{ HI3620_TIMER7_MUX, "timer7_mux", timer7_mux_p, ARRAY_SIZE(timer7_mux_p), CLK_SET_RATE_PARENT, 0x18,  6,  2, 0,                   },
+	{ HI3620_TIMER8_MUX, "timer8_mux", timer8_mux_p, ARRAY_SIZE(timer8_mux_p), CLK_SET_RATE_PARENT, 0x18,  8,  2, 0,                   },
+	{ HI3620_TIMER9_MUX, "timer9_mux", timer9_mux_p, ARRAY_SIZE(timer9_mux_p), CLK_SET_RATE_PARENT, 0x18,  10, 2, 0,                   },
+	{ HI3620_UART0_MUX,  "uart0_mux",  uart0_mux_p,  ARRAY_SIZE(uart0_mux_p),  CLK_SET_RATE_PARENT, 0x100, 7,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_UART1_MUX,  "uart1_mux",  uart1_mux_p,  ARRAY_SIZE(uart1_mux_p),  CLK_SET_RATE_PARENT, 0x100, 8,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_UART2_MUX,  "uart2_mux",  uart2_mux_p,  ARRAY_SIZE(uart2_mux_p),  CLK_SET_RATE_PARENT, 0x100, 9,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_UART3_MUX,  "uart3_mux",  uart3_mux_p,  ARRAY_SIZE(uart3_mux_p),  CLK_SET_RATE_PARENT, 0x100, 10, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_UART4_MUX,  "uart4_mux",  uart4_mux_p,  ARRAY_SIZE(uart4_mux_p),  CLK_SET_RATE_PARENT, 0x100, 11, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_SPI0_MUX,   "spi0_mux",   spi0_mux_p,   ARRAY_SIZE(spi0_mux_p),   CLK_SET_RATE_PARENT, 0x100, 12, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_SPI1_MUX,   "spi1_mux",   spi1_mux_p,   ARRAY_SIZE(spi1_mux_p),   CLK_SET_RATE_PARENT, 0x100, 13, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_SPI2_MUX,   "spi2_mux",   spi2_mux_p,   ARRAY_SIZE(spi2_mux_p),   CLK_SET_RATE_PARENT, 0x100, 14, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_SAXI_MUX,   "saxi_mux",   saxi_mux_p,   ARRAY_SIZE(saxi_mux_p),   CLK_SET_RATE_PARENT, 0x100, 15, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_PWM0_MUX,   "pwm0_mux",   pwm0_mux_p,   ARRAY_SIZE(pwm0_mux_p),   CLK_SET_RATE_PARENT, 0x104, 10, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_PWM1_MUX,   "pwm1_mux",   pwm1_mux_p,   ARRAY_SIZE(pwm1_mux_p),   CLK_SET_RATE_PARENT, 0x104, 11, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_SD_MUX,     "sd_mux",     sd_mux_p,     ARRAY_SIZE(sd_mux_p),     CLK_SET_RATE_PARENT, 0x108, 4,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_MMC1_MUX,   "mmc1_mux",   mmc1_mux_p,   ARRAY_SIZE(mmc1_mux_p),   CLK_SET_RATE_PARENT, 0x108, 9,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_MMC1_MUX2,  "mmc1_mux2",  mmc1_mux2_p,  ARRAY_SIZE(mmc1_mux2_p),  CLK_SET_RATE_PARENT, 0x108, 10, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_G2D_MUX,    "g2d_mux",    g2d_mux_p,    ARRAY_SIZE(g2d_mux_p),    CLK_SET_RATE_PARENT, 0x10c, 5,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_VENC_MUX,   "venc_mux",   venc_mux_p,   ARRAY_SIZE(venc_mux_p),   CLK_SET_RATE_PARENT, 0x10c, 11, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_VDEC_MUX,   "vdec_mux",   vdec_mux_p,   ARRAY_SIZE(vdec_mux_p),   CLK_SET_RATE_PARENT, 0x110, 5,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_VPP_MUX,    "vpp_mux",    vpp_mux_p,    ARRAY_SIZE(vpp_mux_p),    CLK_SET_RATE_PARENT, 0x110, 11, 1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_EDC0_MUX,   "edc0_mux",   edc0_mux_p,   ARRAY_SIZE(edc0_mux_p),   CLK_SET_RATE_PARENT, 0x114, 6,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_LDI0_MUX,   "ldi0_mux",   ldi0_mux_p,   ARRAY_SIZE(ldi0_mux_p),   CLK_SET_RATE_PARENT, 0x114, 13, 2, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_EDC1_MUX,   "edc1_mux",   edc1_mux_p,   ARRAY_SIZE(edc1_mux_p),   CLK_SET_RATE_PARENT, 0x118, 6,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_LDI1_MUX,   "ldi1_mux",   ldi1_mux_p,   ARRAY_SIZE(ldi1_mux_p),   CLK_SET_RATE_PARENT, 0x118, 14, 2, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_RCLK_HSIC,  "rclk_hsic",  rclk_hsic_p,  ARRAY_SIZE(rclk_hsic_p),  CLK_SET_RATE_PARENT, 0x130, 2,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_MMC2_MUX,   "mmc2_mux",   mmc2_mux_p,   ARRAY_SIZE(mmc2_mux_p),   CLK_SET_RATE_PARENT, 0x140, 4,  1, CLK_MUX_HIWORD_MASK, },
+	{ HI3620_MMC3_MUX,   "mmc3_mux",   mmc3_mux_p,   ARRAY_SIZE(mmc3_mux_p),   CLK_SET_RATE_PARENT, 0x140, 9,  1, CLK_MUX_HIWORD_MASK, },
+};
+
+static struct hisi_divider_clock hi3620_div_clks[] __initdata = {
+	{ HI3620_SHAREAXI_DIV, "saxi_div",   "saxi_mux",  0, 0x100, 0, 5, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_CFGAXI_DIV,   "cfgaxi_div", "saxi_div",  0, 0x100, 5, 2, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_SD_DIV,       "sd_div",     "sd_mux",	  0, 0x108, 0, 4, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_MMC1_DIV,     "mmc1_div",   "mmc1_mux",  0, 0x108, 5, 4, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_HSIC_DIV,     "hsic_div",   "rclk_hsic", 0, 0x130, 0, 2, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_MMC2_DIV,     "mmc2_div",   "mmc2_mux",  0, 0x140, 0, 4, CLK_MUX_HIWORD_MASK, NULL, },
+	{ HI3620_MMC3_DIV,     "mmc3_div",   "mmc3_mux",  0, 0x140, 5, 4, CLK_MUX_HIWORD_MASK, NULL, },
+};
+
+static struct hisi_gate_clock hi3620_seperated_gate_clks[] __initdata = {
+	{ HI3620_TIMERCLK01,   "timerclk01",   "timer_rclk01", 0, 0x20, 0, 0, },
+	{ HI3620_TIMER_RCLK01, "timer_rclk01", "rclk_tcxo",    0, 0x20, 1, 0, },
+	{ HI3620_TIMERCLK23,   "timerclk23",   "timer_rclk23", 0, 0x20, 2, 0, },
+	{ HI3620_TIMER_RCLK23, "timer_rclk23", "rclk_tcxo",    0, 0x20, 3, 0, },
+	{ HI3620_RTCCLK,       "rtcclk",       "pclk",         0, 0x20, 5, 0, },
+	{ HI3620_KPC_CLK,      "kpc_clk",      "pclk",         0, 0x20, 6, 0, },
+	{ HI3620_GPIOCLK0,     "gpioclk0",     "pclk",         0, 0x20, 8, 0, },
+	{ HI3620_GPIOCLK1,     "gpioclk1",     "pclk",         0, 0x20, 9, 0, },
+	{ HI3620_GPIOCLK2,     "gpioclk2",     "pclk",         0, 0x20, 10, 0, },
+	{ HI3620_GPIOCLK3,     "gpioclk3",     "pclk",         0, 0x20, 11, 0, },
+	{ HI3620_GPIOCLK4,     "gpioclk4",     "pclk",         0, 0x20, 12, 0, },
+	{ HI3620_GPIOCLK5,     "gpioclk5",     "pclk",         0, 0x20, 13, 0, },
+	{ HI3620_GPIOCLK6,     "gpioclk6",     "pclk",         0, 0x20, 14, 0, },
+	{ HI3620_GPIOCLK7,     "gpioclk7",     "pclk",         0, 0x20, 15, 0, },
+	{ HI3620_GPIOCLK8,     "gpioclk8",     "pclk",         0, 0x20, 16, 0, },
+	{ HI3620_GPIOCLK9,     "gpioclk9",     "pclk",         0, 0x20, 17, 0, },
+	{ HI3620_GPIOCLK10,    "gpioclk10",    "pclk",         0, 0x20, 18, 0, },
+	{ HI3620_GPIOCLK11,    "gpioclk11",    "pclk",         0, 0x20, 19, 0, },
+	{ HI3620_GPIOCLK12,    "gpioclk12",    "pclk",         0, 0x20, 20, 0, },
+	{ HI3620_GPIOCLK13,    "gpioclk13",    "pclk",         0, 0x20, 21, 0, },
+	{ HI3620_GPIOCLK14,    "gpioclk14",    "pclk",         0, 0x20, 22, 0, },
+	{ HI3620_GPIOCLK15,    "gpioclk15",    "pclk",         0, 0x20, 23, 0, },
+	{ HI3620_GPIOCLK16,    "gpioclk16",    "pclk",         0, 0x20, 24, 0, },
+	{ HI3620_GPIOCLK17,    "gpioclk17",    "pclk",         0, 0x20, 25, 0, },
+	{ HI3620_GPIOCLK18,    "gpioclk18",    "pclk",         0, 0x20, 26, 0, },
+	{ HI3620_GPIOCLK19,    "gpioclk19",    "pclk",         0, 0x20, 27, 0, },
+	{ HI3620_GPIOCLK20,    "gpioclk20",    "pclk",         0, 0x20, 28, 0, },
+	{ HI3620_GPIOCLK21,    "gpioclk21",    "pclk",         0, 0x20, 29, 0, },
+	{ HI3620_DPHY0_CLK,    "dphy0_clk",    "osc26m",       0, 0x30, 15, 0, },
+	{ HI3620_DPHY1_CLK,    "dphy1_clk",    "osc26m",       0, 0x30, 16, 0, },
+	{ HI3620_DPHY2_CLK,    "dphy2_clk",    "osc26m",       0, 0x30, 17, 0, },
+	{ HI3620_USBPHY_CLK,   "usbphy_clk",   "rclk_pico",    0, 0x30, 24, 0, },
+	{ HI3620_ACP_CLK,      "acp_clk",      "rclk_cfgaxi",  0, 0x30, 28, 0, },
+	{ HI3620_TIMERCLK45,   "timerclk45",   "rclk_tcxo",    0, 0x40, 3, 0, },
+	{ HI3620_TIMERCLK67,   "timerclk67",   "rclk_tcxo",    0, 0x40, 4, 0, },
+	{ HI3620_TIMERCLK89,   "timerclk89",   "rclk_tcxo",    0, 0x40, 5, 0, },
+	{ HI3620_PWMCLK0,      "pwmclk0",      "pwm0_mux",     0, 0x40, 7, 0, },
+	{ HI3620_PWMCLK1,      "pwmclk1",      "pwm1_mux",     0, 0x40, 8, 0, },
+	{ HI3620_UARTCLK0,     "uartclk0",     "uart0_mux",    0, 0x40, 16, 0, },
+	{ HI3620_UARTCLK1,     "uartclk1",     "uart1_mux",    0, 0x40, 17, 0, },
+	{ HI3620_UARTCLK2,     "uartclk2",     "uart2_mux",    0, 0x40, 18, 0, },
+	{ HI3620_UARTCLK3,     "uartclk3",     "uart3_mux",    0, 0x40, 19, 0, },
+	{ HI3620_UARTCLK4,     "uartclk4",     "uart4_mux",    0, 0x40, 20, 0, },
+	{ HI3620_SPICLK0,      "spiclk0",      "spi0_mux",     0, 0x40, 21, 0, },
+	{ HI3620_SPICLK1,      "spiclk1",      "spi1_mux",     0, 0x40, 22, 0, },
+	{ HI3620_SPICLK2,      "spiclk2",      "spi2_mux",     0, 0x40, 23, 0, },
+	{ HI3620_I2CCLK0,      "i2cclk0",      "pclk",         0, 0x40, 24, 0, },
+	{ HI3620_I2CCLK1,      "i2cclk1",      "pclk",         0, 0x40, 25, 0, },
+	{ HI3620_SCI_CLK,      "sci_clk",      "osc26m",       0, 0x40, 26, 0, },
+	{ HI3620_I2CCLK2,      "i2cclk2",      "pclk",         0, 0x40, 28, 0, },
+	{ HI3620_I2CCLK3,      "i2cclk3",      "pclk",         0, 0x40, 29, 0, },
+	{ HI3620_DDRC_PER_CLK, "ddrc_per_clk", "rclk_cfgaxi",  0, 0x50, 9, 0, },
+	{ HI3620_DMAC_CLK,     "dmac_clk",     "rclk_cfgaxi",  0, 0x50, 10, 0, },
+	{ HI3620_USB2DVC_CLK,  "usb2dvc_clk",  "rclk_cfgaxi",  0, 0x50, 17, 0, },
+	{ HI3620_SD_CLK,       "sd_clk",       "sd_div",       0, 0x50, 20, 0, },
+	{ HI3620_MMC_CLK1,     "mmc_clk1",     "mmc1_mux2",    0, 0x50, 21, 0, },
+	{ HI3620_MMC_CLK2,     "mmc_clk2",     "mmc2_div",     0, 0x50, 22, 0, },
+	{ HI3620_MMC_CLK3,     "mmc_clk3",     "mmc3_div",     0, 0x50, 23, 0, },
+	{ HI3620_MCU_CLK,      "mcu_clk",      "acp_clk",      0, 0x50, 24, 0, },
+};
+
+static void __init hi3620_clk_init(struct device_node *np)
+{
+	void __iomem *base;
+
+	if (np) {
+		base = of_iomap(np, 0);
+		if (!base) {
+			pr_err("failed to map Hi3620 clock registers\n");
+			return;
+		}
+	} else {
+		pr_err("failed to find Hi3620 clock node in DTS\n");
+		return;
+	}
+
+	hisi_clk_init(np, HI3620_NR_CLKS);
+
+	hisi_clk_register_fixed_rate(hi3620_fixed_rate_clks,
+				     ARRAY_SIZE(hi3620_fixed_rate_clks),
+				     base);
+	hisi_clk_register_fixed_factor(hi3620_fixed_factor_clks,
+				       ARRAY_SIZE(hi3620_fixed_factor_clks),
+				       base);
+	hisi_clk_register_mux(hi3620_mux_clks, ARRAY_SIZE(hi3620_mux_clks),
+			      base);
+	hisi_clk_register_divider(hi3620_div_clks, ARRAY_SIZE(hi3620_div_clks),
+				  base);
+	hisi_clk_register_gate_sep(hi3620_seperated_gate_clks,
+				   ARRAY_SIZE(hi3620_seperated_gate_clks),
+				   base);
+}
+CLK_OF_DECLARE(hi3620_clk, "hisilicon,hi3620-clock", hi3620_clk_init);
diff --git a/drivers/clk/hisilicon/clk.c b/drivers/clk/hisilicon/clk.c
new file mode 100644
index 0000000..a3a7152
--- /dev/null
+++ b/drivers/clk/hisilicon/clk.c
@@ -0,0 +1,171 @@
+/*
+ * Hisilicon clock driver
+ *
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include "clk.h"
+
+static DEFINE_SPINLOCK(hisi_clk_lock);
+static struct clk **clk_table;
+static struct clk_onecell_data clk_data;
+
+void __init hisi_clk_init(struct device_node *np, int nr_clks)
+{
+	clk_table = kzalloc(sizeof(struct clk *) * nr_clks, GFP_KERNEL);
+	if (!clk_table) {
+		pr_err("%s: could not allocate clock lookup table\n", __func__);
+		return;
+	}
+	clk_data.clks = clk_table;
+	clk_data.clk_num = nr_clks;
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
+
+void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *clks,
+					 int nums, void __iomem *base)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_fixed_rate(NULL, clks[i].name,
+					      clks[i].parent_name,
+					      clks[i].flags,
+					      clks[i].fixed_rate);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+	}
+}
+
+void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *clks,
+					   int nums, void __iomem *base)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_fixed_factor(NULL, clks[i].name,
+						clks[i].parent_name,
+						clks[i].flags, clks[i].mult,
+						clks[i].div);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+	}
+}
+
+void __init hisi_clk_register_mux(struct hisi_mux_clock *clks,
+				  int nums, void __iomem *base)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_mux(NULL, clks[i].name, clks[i].parent_names,
+				       clks[i].num_parents, clks[i].flags,
+				       base + clks[i].offset, clks[i].shift,
+				       clks[i].width, clks[i].mux_flags,
+				       &hisi_clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		clk_table[clks[i].id] = clk;
+	}
+}
+
+void __init hisi_clk_register_divider(struct hisi_divider_clock *clks,
+				      int nums, void __iomem *base)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = clk_register_divider_table(NULL, clks[i].name,
+						 clks[i].parent_name,
+						 clks[i].flags,
+						 base + clks[i].offset,
+						 clks[i].shift, clks[i].width,
+						 clks[i].div_flags,
+						 clks[i].table,
+						 &hisi_clk_lock);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+
+		if (clks[i].alias)
+			clk_register_clkdev(clk, clks[i].alias, NULL);
+
+		clk_table[clks[i].id] = clk;
+	}
+}
+
+void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *clks,
+				       int nums, void __iomem *base)
+{
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = hisi_register_clkgate_sep(NULL, clks[i].name,
+						clks[i].parent_name,
+						clks[i].flags,
+						base + clks[i].offset,
+						clks[i].bit_idx,
+						clks[i].gate_flags,
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
+		clk_table[clks[i].id] = clk;
+	}
+}
diff --git a/drivers/clk/hisilicon/clk.h b/drivers/clk/hisilicon/clk.h
new file mode 100644
index 0000000..4a6beeb
--- /dev/null
+++ b/drivers/clk/hisilicon/clk.h
@@ -0,0 +1,103 @@
+/*
+ * Hisilicon Hi3620 clock gate driver
+ *
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#ifndef	__HISI_CLK_H
+#define	__HISI_CLK_H
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/spinlock.h>
+
+struct hisi_fixed_rate_clock {
+	unsigned int		id;
+	char			*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		fixed_rate;
+};
+
+struct hisi_fixed_factor_clock {
+	unsigned int		id;
+	char			*name;
+	const char		*parent_name;
+	unsigned long		mult;
+	unsigned long		div;
+	unsigned long		flags;
+};
+
+struct hisi_mux_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		**parent_names;
+	u8			num_parents;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			mux_flags;
+	const char		*alias;
+};
+
+struct hisi_divider_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			shift;
+	u8			width;
+	u8			div_flags;
+	struct clk_div_table	*table;
+	const char		*alias;
+};
+
+struct hisi_gate_clock {
+	unsigned int		id;
+	const char		*name;
+	const char		*parent_name;
+	unsigned long		flags;
+	unsigned long		offset;
+	u8			bit_idx;
+	u8			gate_flags;
+	const char		*alias;
+};
+
+struct clk *hisi_register_clkgate_sep(struct device *, const char *,
+				const char *, unsigned long,
+				void __iomem *, u8,
+				u8, spinlock_t *);
+
+void __init hisi_clk_init(struct device_node *, int);
+void __init hisi_clk_register_fixed_rate(struct hisi_fixed_rate_clock *,
+					int, void __iomem *);
+void __init hisi_clk_register_fixed_factor(struct hisi_fixed_factor_clock *,
+					int, void __iomem *);
+void __init hisi_clk_register_mux(struct hisi_mux_clock *, int,
+				void __iomem *);
+void __init hisi_clk_register_divider(struct hisi_divider_clock *,
+				int, void __iomem *);
+void __init hisi_clk_register_gate_sep(struct hisi_gate_clock *,
+					int, void __iomem *);
+#endif	/* __HISI_CLK_H */
diff --git a/drivers/clk/hisilicon/clkgate-seperated.c b/drivers/clk/hisilicon/clkgate-seperated.c
new file mode 100644
index 0000000..cddc6d3
--- /dev/null
+++ b/drivers/clk/hisilicon/clkgate-seperated.c
@@ -0,0 +1,130 @@
+/*
+ * Hisilicon clock seperated gate driver
+ *
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clk.h>
+
+#include "clk.h"
+
+/* clock seperated gate register offset */
+#define CLKGATE_SEPERATED_ENABLE		0x0
+#define CLKGATE_SEPERATED_DISABLE		0x4
+#define CLKGATE_SEPERATED_STATUS		0x8
+
+struct clkgate_seperated {
+	struct clk_hw	hw;
+	void __iomem	*enable;	/* enable register */
+	u8		bit_idx;	/* bits in enable/disable register */
+	u8		flags;
+	spinlock_t	*lock;
+};
+
+static int clkgate_seperated_enable(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	unsigned long flags = 0;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	if (sclk->lock)
+		spin_lock_irqsave(sclk->lock, flags);
+	reg = BIT(sclk->bit_idx);
+	writel_relaxed(reg, sclk->enable);
+	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	if (sclk->lock)
+		spin_unlock_irqrestore(sclk->lock, flags);
+	return 0;
+}
+
+static void clkgate_seperated_disable(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	unsigned long flags = 0;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	if (sclk->lock)
+		spin_lock_irqsave(sclk->lock, flags);
+	reg = BIT(sclk->bit_idx);
+	writel_relaxed(reg, sclk->enable + CLKGATE_SEPERATED_DISABLE);
+	readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	if (sclk->lock)
+		spin_unlock_irqrestore(sclk->lock, flags);
+}
+
+static int clkgate_seperated_is_enabled(struct clk_hw *hw)
+{
+	struct clkgate_seperated *sclk;
+	u32 reg;
+
+	sclk = container_of(hw, struct clkgate_seperated, hw);
+	reg = readl_relaxed(sclk->enable + CLKGATE_SEPERATED_STATUS);
+	reg &= BIT(sclk->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+static struct clk_ops clkgate_seperated_ops = {
+	.enable		= clkgate_seperated_enable,
+	.disable	= clkgate_seperated_disable,
+	.is_enabled	= clkgate_seperated_is_enabled,
+};
+
+struct clk *hisi_register_clkgate_sep(struct device *dev, const char *name,
+				      const char *parent_name,
+				      unsigned long flags,
+				      void __iomem *reg, u8 bit_idx,
+				      u8 clk_gate_flags, spinlock_t *lock)
+{
+	struct clkgate_seperated *sclk;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	sclk = kzalloc(sizeof(struct clkgate_seperated), GFP_KERNEL);
+	if (!sclk) {
+		pr_err("%s: fail to allocate seperated gated clk\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	init.name = name;
+	init.ops = &clkgate_seperated_ops;
+	init.flags = flags | CLK_IS_BASIC;
+	init.parent_names = (parent_name ? &parent_name : NULL);
+	init.num_parents = (parent_name ? 1 : 0);
+
+	sclk->enable = reg + CLKGATE_SEPERATED_ENABLE;
+	sclk->bit_idx = bit_idx;
+	sclk->flags = clk_gate_flags;
+	sclk->hw.init = &init;
+
+	clk = clk_register(dev, &sclk->hw);
+	if (IS_ERR(clk))
+		kfree(sclk);
+	return clk;
+}
diff --git a/include/dt-bindings/clock/hi3620-clock.h b/include/dt-bindings/clock/hi3620-clock.h
new file mode 100644
index 0000000..6eaa6a4
--- /dev/null
+++ b/include/dt-bindings/clock/hi3620-clock.h
@@ -0,0 +1,152 @@
+/*
+ * Copyright (c) 2012-2013 Hisilicon Limited.
+ * Copyright (c) 2012-2013 Linaro Limited.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
+ *	   Xin Li <li.xin@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#ifndef __DTS_HI3620_CLOCK_H
+#define __DTS_HI3620_CLOCK_H
+
+#define HI3620_NONE_CLOCK	0
+
+/* fixed rate & fixed factor clocks */
+#define HI3620_OSC32K		1
+#define HI3620_OSC26M		2
+#define HI3620_PCLK		3
+#define HI3620_PLL_ARM0		4
+#define HI3620_PLL_ARM1		5
+#define HI3620_PLL_PERI		6
+#define HI3620_PLL_USB		7
+#define HI3620_PLL_HDMI		8
+#define HI3620_PLL_GPU		9
+#define HI3620_RCLK_TCXO	10
+#define HI3620_RCLK_CFGAXI	11
+#define HI3620_RCLK_PICO	12
+
+/* mux clocks */
+#define HI3620_TIMER0_MUX	32
+#define HI3620_TIMER1_MUX	33
+#define HI3620_TIMER2_MUX	34
+#define HI3620_TIMER3_MUX	35
+#define HI3620_TIMER4_MUX	36
+#define HI3620_TIMER5_MUX	37
+#define HI3620_TIMER6_MUX	38
+#define HI3620_TIMER7_MUX	39
+#define HI3620_TIMER8_MUX	40
+#define HI3620_TIMER9_MUX	41
+#define HI3620_UART0_MUX	42
+#define HI3620_UART1_MUX	43
+#define HI3620_UART2_MUX	44
+#define HI3620_UART3_MUX	45
+#define HI3620_UART4_MUX	46
+#define HI3620_SPI0_MUX		47
+#define HI3620_SPI1_MUX		48
+#define HI3620_SPI2_MUX		49
+#define HI3620_SAXI_MUX		50
+#define HI3620_PWM0_MUX		51
+#define HI3620_PWM1_MUX		52
+#define HI3620_SD_MUX		53
+#define HI3620_MMC1_MUX		54
+#define HI3620_MMC1_MUX2	55
+#define HI3620_G2D_MUX		56
+#define HI3620_VENC_MUX		57
+#define HI3620_VDEC_MUX		58
+#define HI3620_VPP_MUX		59
+#define HI3620_EDC0_MUX		60
+#define HI3620_LDI0_MUX		61
+#define HI3620_EDC1_MUX		62
+#define HI3620_LDI1_MUX		63
+#define HI3620_RCLK_HSIC	64
+#define HI3620_MMC2_MUX		65
+#define HI3620_MMC3_MUX		66
+
+/* divider clocks */
+#define HI3620_SHAREAXI_DIV	128
+#define HI3620_CFGAXI_DIV	129
+#define HI3620_SD_DIV		130
+#define HI3620_MMC1_DIV		131
+#define HI3620_HSIC_DIV		132
+#define HI3620_MMC2_DIV		133
+#define HI3620_MMC3_DIV		134
+
+/* gate clocks */
+#define HI3620_TIMERCLK01	160
+#define HI3620_TIMER_RCLK01	161
+#define HI3620_TIMERCLK23	162
+#define HI3620_TIMER_RCLK23	163
+#define HI3620_TIMERCLK45	164
+#define HI3620_TIMERCLK67	165
+#define HI3620_TIMERCLK89	166
+#define HI3620_RTCCLK		167
+#define HI3620_KPC_CLK		168
+#define HI3620_GPIOCLK0		169
+#define HI3620_GPIOCLK1		170
+#define HI3620_GPIOCLK2		171
+#define HI3620_GPIOCLK3		172
+#define HI3620_GPIOCLK4		173
+#define HI3620_GPIOCLK5		174
+#define HI3620_GPIOCLK6		175
+#define HI3620_GPIOCLK7		176
+#define HI3620_GPIOCLK8		177
+#define HI3620_GPIOCLK9		178
+#define HI3620_GPIOCLK10	179
+#define HI3620_GPIOCLK11	180
+#define HI3620_GPIOCLK12	181
+#define HI3620_GPIOCLK13	182
+#define HI3620_GPIOCLK14	183
+#define HI3620_GPIOCLK15	184
+#define HI3620_GPIOCLK16	185
+#define HI3620_GPIOCLK17	186
+#define HI3620_GPIOCLK18	187
+#define HI3620_GPIOCLK19	188
+#define HI3620_GPIOCLK20	189
+#define HI3620_GPIOCLK21	190
+#define HI3620_DPHY0_CLK	191
+#define HI3620_DPHY1_CLK	192
+#define HI3620_DPHY2_CLK	193
+#define HI3620_USBPHY_CLK	194
+#define HI3620_ACP_CLK		195
+#define HI3620_PWMCLK0		196
+#define HI3620_PWMCLK1		197
+#define HI3620_UARTCLK0		198
+#define HI3620_UARTCLK1		199
+#define HI3620_UARTCLK2		200
+#define HI3620_UARTCLK3		201
+#define HI3620_UARTCLK4		202
+#define HI3620_SPICLK0		203
+#define HI3620_SPICLK1		204
+#define HI3620_SPICLK2		205
+#define HI3620_I2CCLK0		206
+#define HI3620_I2CCLK1		207
+#define HI3620_I2CCLK2		208
+#define HI3620_I2CCLK3		209
+#define HI3620_SCI_CLK		210
+#define HI3620_DDRC_PER_CLK	211
+#define HI3620_DMAC_CLK		212
+#define HI3620_USB2DVC_CLK	213
+#define HI3620_SD_CLK		214
+#define HI3620_MMC_CLK1		215
+#define HI3620_MMC_CLK2		216
+#define HI3620_MMC_CLK3		217
+#define HI3620_MCU_CLK		218
+
+#define HI3620_NR_CLKS		219
+
+#endif	/* __DTS_HI3620_CLOCK_H */
-- 
1.8.3.2
