From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 22 Sep 2013 11:22:02 +0800
Subject: [PATCH] clk: sirf: re-arch to make the codes support both prima2 and
 atlas6
Message-ID: <1379820122-16076-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sirfprima2 and sirfatlas6 are two different SoCs in CSR SiRF series. for
prima2 and atlas6, there are many shared clocks but there are still
some different register layout and hardware clocks, then result in
different clock table.

here we re-arch the driver to
1. clk-common.c provides common clocks for prima2 and atlas6,
2. clk-prima2.h describles registers of prima2 and clk-prima2.c provides
prima2 specific clocks and clock table.
3. clk-atlas6.h describles registers of atlas6 and clk-atlas6.c provides
atlas6 specific clocks and clock table.
4. clk.h and clk.c expose external interfaces and provide uniform entry
for both prima2 and atlas6.

so both prima2 and atlas6 will get support by drivers/clk/sirf.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Rongjun Ying <Rongjun.Ying@csr.com>
---
 drivers/clk/Makefile                            |   2 +-
 drivers/clk/sirf/Makefile                       |   5 +
 drivers/clk/sirf/atlas6.h                       |  31 ++++
 drivers/clk/sirf/clk-atlas6.c                   | 140 +++++++++++++++++
 drivers/clk/{clk-prima2.c => sirf/clk-common.c} | 196 ++----------------------
 drivers/clk/sirf/clk-prima2.c                   | 137 +++++++++++++++++
 drivers/clk/sirf/clk.c                          |  61 ++++++++
 drivers/clk/sirf/clk.h                          |   5 +
 drivers/clk/sirf/prima2.h                       |  25 +++
 9 files changed, 416 insertions(+), 186 deletions(-)
 create mode 100644 drivers/clk/sirf/Makefile
 create mode 100644 drivers/clk/sirf/atlas6.h
 create mode 100644 drivers/clk/sirf/clk-atlas6.c
 rename drivers/clk/{clk-prima2.c => sirf/clk-common.c} (81%)
 create mode 100644 drivers/clk/sirf/clk-prima2.c
 create mode 100644 drivers/clk/sirf/clk.c
 create mode 100644 drivers/clk/sirf/clk.h
 create mode 100644 drivers/clk/sirf/prima2.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7b11106..589aed9 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -19,7 +19,7 @@ obj-$(CONFIG_ARCH_SOCFPGA)	+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)	+= spear/
 obj-$(CONFIG_ARCH_U300)		+= clk-u300.o
 obj-$(CONFIG_COMMON_CLK_VERSATILE) += versatile/
-obj-$(CONFIG_ARCH_SIRF)		+= clk-prima2.o
+obj-$(CONFIG_ARCH_SIRF)		+= sirf/
 obj-$(CONFIG_PLAT_ORION)	+= mvebu/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)		+= mmp/
diff --git a/drivers/clk/sirf/Makefile b/drivers/clk/sirf/Makefile
new file mode 100644
index 0000000..6ccdfd0
--- /dev/null
+++ b/drivers/clk/sirf/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for sirf specific clk
+#
+
+obj-$(CONFIG_ARCH_SIRF) += clk-prima2.o clk-atlas6.o clk.o
diff --git a/drivers/clk/sirf/atlas6.h b/drivers/clk/sirf/atlas6.h
new file mode 100644
index 0000000..376217f
--- /dev/null
+++ b/drivers/clk/sirf/atlas6.h
@@ -0,0 +1,31 @@
+#define SIRFSOC_CLKC_CLK_EN0    0x0000
+#define SIRFSOC_CLKC_CLK_EN1    0x0004
+#define SIRFSOC_CLKC_REF_CFG    0x0020
+#define SIRFSOC_CLKC_CPU_CFG    0x0024
+#define SIRFSOC_CLKC_MEM_CFG    0x0028
+#define SIRFSOC_CLKC_MEMDIV_CFG 0x002C
+#define SIRFSOC_CLKC_SYS_CFG    0x0030
+#define SIRFSOC_CLKC_IO_CFG     0x0034
+#define SIRFSOC_CLKC_DSP_CFG    0x0038
+#define SIRFSOC_CLKC_GFX_CFG    0x003c
+#define SIRFSOC_CLKC_MM_CFG     0x0040
+#define SIRFSOC_CLKC_GFX2D_CFG  0x0040
+#define SIRFSOC_CLKC_LCD_CFG    0x0044
+#define SIRFSOC_CLKC_MMC01_CFG  0x0048
+#define SIRFSOC_CLKC_MMC23_CFG  0x004C
+#define SIRFSOC_CLKC_MMC45_CFG  0x0050
+#define SIRFSOC_CLKC_NAND_CFG	0x0054
+#define SIRFSOC_CLKC_NANDDIV_CFG	0x0058
+#define SIRFSOC_CLKC_PLL1_CFG0  0x0080
+#define SIRFSOC_CLKC_PLL2_CFG0  0x0084
+#define SIRFSOC_CLKC_PLL3_CFG0  0x0088
+#define SIRFSOC_CLKC_PLL1_CFG1  0x008c
+#define SIRFSOC_CLKC_PLL2_CFG1  0x0090
+#define SIRFSOC_CLKC_PLL3_CFG1  0x0094
+#define SIRFSOC_CLKC_PLL1_CFG2  0x0098
+#define SIRFSOC_CLKC_PLL2_CFG2  0x009c
+#define SIRFSOC_CLKC_PLL3_CFG2  0x00A0
+#define SIRFSOC_USBPHY_PLL_CTRL 0x0008
+#define SIRFSOC_USBPHY_PLL_POWERDOWN  BIT(1)
+#define SIRFSOC_USBPHY_PLL_BYPASS     BIT(2)
+#define SIRFSOC_USBPHY_PLL_LOCK       BIT(3)
diff --git a/drivers/clk/sirf/clk-atlas6.c b/drivers/clk/sirf/clk-atlas6.c
new file mode 100644
index 0000000..b7c3d8f
--- /dev/null
+++ b/drivers/clk/sirf/clk-atlas6.c
@@ -0,0 +1,140 @@
+/*
+ * Clock tree for CSR SiRFatlasVI
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-private.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#include "clk.h"
+#include "atlas6.h"
+#include "clk-common.c"
+
+static struct clk_dmn clk_mmc01 = {
+	.regofs = SIRFSOC_CLKC_MMC01_CFG,
+	.enable_bit = 59,
+	.hw = {
+		.init = &clk_mmc01_init,
+	},
+};
+
+static struct clk_dmn clk_mmc23 = {
+	.regofs = SIRFSOC_CLKC_MMC23_CFG,
+	.enable_bit = 60,
+	.hw = {
+		.init = &clk_mmc23_init,
+	},
+};
+
+static struct clk_dmn clk_mmc45 = {
+	.regofs = SIRFSOC_CLKC_MMC45_CFG,
+	.enable_bit = 61,
+	.hw = {
+		.init = &clk_mmc45_init,
+	},
+};
+
+static struct clk_init_data clk_nand_init = {
+	.name = "nand",
+	.ops = &dmn_ops,
+	.parent_names = dmn_clk_parents,
+	.num_parents = ARRAY_SIZE(dmn_clk_parents),
+};
+
+static struct clk_dmn clk_nand = {
+	.regofs = SIRFSOC_CLKC_NAND_CFG,
+	.enable_bit = 34,
+	.hw = {
+		.init = &clk_nand_init,
+	},
+};
+
+enum atlas6_clk_index {
+	/* 0    1     2      3      4      5      6       7         8      9 */
+	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
+	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
+	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
+	usp2,   vip,   gfx,   gfx2d,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
+	usb0,  usb1,  maxclk,
+};
+
+static struct clk_hw *atlas6_clk_hw_array[maxclk] __initdata = {
+	NULL, /* dummy */
+	NULL,
+	&clk_pll1.hw,
+	&clk_pll2.hw,
+	&clk_pll3.hw,
+	&clk_mem.hw,
+	&clk_sys.hw,
+	&clk_security.hw,
+	&clk_dsp.hw,
+	&clk_gps.hw,
+	&clk_mf.hw,
+	&clk_io.hw,
+	&clk_cpu.hw,
+	&clk_uart0.hw,
+	&clk_uart1.hw,
+	&clk_uart2.hw,
+	&clk_tsc.hw,
+	&clk_i2c0.hw,
+	&clk_i2c1.hw,
+	&clk_spi0.hw,
+	&clk_spi1.hw,
+	&clk_pwmc.hw,
+	&clk_efuse.hw,
+	&clk_pulse.hw,
+	&clk_dmac0.hw,
+	&clk_dmac1.hw,
+	&clk_nand.hw,
+	&clk_audio.hw,
+	&clk_usp0.hw,
+	&clk_usp1.hw,
+	&clk_usp2.hw,
+	&clk_vip.hw,
+	&clk_gfx.hw,
+	&clk_gfx2d.hw,
+	&clk_lcd.hw,
+	&clk_vpp.hw,
+	&clk_mmc01.hw,
+	&clk_mmc23.hw,
+	&clk_mmc45.hw,
+	&usb_pll_clk_hw,
+	&clk_usb0.hw,
+	&clk_usb1.hw,
+};
+
+static struct clk *atlas6_clks[maxclk];
+
+void __init atlas6_clk_init(void)
+{
+	int i;
+
+	/* These are always available (RTC and 26MHz OSC)*/
+	atlas6_clks[rtc] = clk_register_fixed_rate(NULL, "rtc", NULL,
+		CLK_IS_ROOT, 32768);
+	atlas6_clks[osc] = clk_register_fixed_rate(NULL, "osc", NULL,
+		CLK_IS_ROOT, 26000000);
+
+	for (i = pll1; i < maxclk; i++) {
+		atlas6_clks[i] = clk_register(NULL, atlas6_clk_hw_array[i]);
+		BUG_ON(IS_ERR(atlas6_clks[i]));
+	}
+	clk_register_clkdev(atlas6_clks[cpu], NULL, "cpu");
+	clk_register_clkdev(atlas6_clks[io],  NULL, "io");
+	clk_register_clkdev(atlas6_clks[mem],  NULL, "mem");
+
+	clk_data.clks = atlas6_clks;
+	clk_data.clk_num = maxclk;
+
+	printk("%s\n", __func__);
+}
diff --git a/drivers/clk/clk-prima2.c b/drivers/clk/sirf/clk-common.c
similarity index 81%
rename from drivers/clk/clk-prima2.c
rename to drivers/clk/sirf/clk-common.c
index 5ab95f1..d7fa64c 100644
--- a/drivers/clk/clk-prima2.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -1,48 +1,11 @@
 /*
- * Clock tree for CSR SiRFprimaII
+ * common clks module for all SiRF SoCs
  *
  * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
  *
  * Licensed under GPLv2 or later.
  */
 
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/io.h>
-#include <linux/clk.h>
-#include <linux/clkdev.h>
-#include <linux/clk-provider.h>
-#include <linux/of_address.h>
-#include <linux/syscore_ops.h>
-
-#define SIRFSOC_CLKC_CLK_EN0    0x0000
-#define SIRFSOC_CLKC_CLK_EN1    0x0004
-#define SIRFSOC_CLKC_REF_CFG    0x0014
-#define SIRFSOC_CLKC_CPU_CFG    0x0018
-#define SIRFSOC_CLKC_MEM_CFG    0x001c
-#define SIRFSOC_CLKC_SYS_CFG    0x0020
-#define SIRFSOC_CLKC_IO_CFG     0x0024
-#define SIRFSOC_CLKC_DSP_CFG    0x0028
-#define SIRFSOC_CLKC_GFX_CFG    0x002c
-#define SIRFSOC_CLKC_MM_CFG     0x0030
-#define SIRFSOC_CLKC_LCD_CFG     0x0034
-#define SIRFSOC_CLKC_MMC_CFG    0x0038
-#define SIRFSOC_CLKC_PLL1_CFG0  0x0040
-#define SIRFSOC_CLKC_PLL2_CFG0  0x0044
-#define SIRFSOC_CLKC_PLL3_CFG0  0x0048
-#define SIRFSOC_CLKC_PLL1_CFG1  0x004c
-#define SIRFSOC_CLKC_PLL2_CFG1  0x0050
-#define SIRFSOC_CLKC_PLL3_CFG1  0x0054
-#define SIRFSOC_CLKC_PLL1_CFG2  0x0058
-#define SIRFSOC_CLKC_PLL2_CFG2  0x005c
-#define SIRFSOC_CLKC_PLL3_CFG2  0x0060
-#define SIRFSOC_USBPHY_PLL_CTRL 0x0008
-#define SIRFSOC_USBPHY_PLL_POWERDOWN  BIT(1)
-#define SIRFSOC_USBPHY_PLL_BYPASS     BIT(2)
-#define SIRFSOC_USBPHY_PLL_LOCK       BIT(3)
-
-static void *sirfsoc_clk_vbase, *sirfsoc_rsc_vbase;
-
 #define KHZ     1000
 #define MHZ     (KHZ * KHZ)
 
@@ -127,6 +90,7 @@ static long pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long *parent_rate)
 {
 	unsigned long fin, nf, nr, od;
+	u64 dividend;
 
 	/*
 	 * fout = fin * nf / (nr * od);
@@ -147,7 +111,10 @@ static long pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 		nr = BIT(6);
 	od = 1;
 
-	return fin * nf / (nr * od);
+	dividend = (u64)fin * nf;
+	do_div(dividend, nr * od);
+
+	return (long)dividend;
 }
 
 static int pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -532,6 +499,11 @@ static struct clk_dmn clk_mm = {
 	},
 };
 
+/*
+ * for atlas6, gfx2d holds the bit of prima2's clk_mm
+ */
+#define clk_gfx2d clk_mm
+
 static struct clk_init_data clk_lcd_init = {
 	.name = "lcd",
 	.ops = &dmn_ops,
@@ -569,14 +541,6 @@ static struct clk_init_data clk_mmc01_init = {
 	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk_dmn clk_mmc01 = {
-	.regofs = SIRFSOC_CLKC_MMC_CFG,
-	.enable_bit = 59,
-	.hw = {
-		.init = &clk_mmc01_init,
-	},
-};
-
 static struct clk_init_data clk_mmc23_init = {
 	.name = "mmc23",
 	.ops = &dmn_ops,
@@ -584,14 +548,6 @@ static struct clk_init_data clk_mmc23_init = {
 	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk_dmn clk_mmc23 = {
-	.regofs = SIRFSOC_CLKC_MMC_CFG,
-	.enable_bit = 60,
-	.hw = {
-		.init = &clk_mmc23_init,
-	},
-};
-
 static struct clk_init_data clk_mmc45_init = {
 	.name = "mmc45",
 	.ops = &dmn_ops,
@@ -599,14 +555,6 @@ static struct clk_init_data clk_mmc45_init = {
 	.num_parents = ARRAY_SIZE(dmn_clk_parents),
 };
 
-static struct clk_dmn clk_mmc45 = {
-	.regofs = SIRFSOC_CLKC_MMC_CFG,
-	.enable_bit = 61,
-	.hw = {
-		.init = &clk_mmc45_init,
-	},
-};
-
 /*
  * peripheral controllers in io domain
  */
@@ -695,20 +643,6 @@ static struct clk_std clk_dmac1 = {
 	},
 };
 
-static struct clk_init_data clk_nand_init = {
-	.name = "nand",
-	.ops = &ios_ops,
-	.parent_names = std_clk_io_parents,
-	.num_parents = ARRAY_SIZE(std_clk_io_parents),
-};
-
-static struct clk_std clk_nand = {
-	.enable_bit = 34,
-	.hw = {
-		.init = &clk_nand_init,
-	},
-};
-
 static struct clk_init_data clk_audio_init = {
 	.name = "audio",
 	.ops = &ios_ops,
@@ -1015,112 +949,4 @@ static struct clk_std clk_usb1 = {
 	},
 };
 
-static struct of_device_id clkc_ids[] = {
-	{ .compatible = "sirf,prima2-clkc" },
-	{},
-};
-
-static struct of_device_id rsc_ids[] = {
-	{ .compatible = "sirf,prima2-rsc" },
-	{},
-};
-
-enum prima2_clk_index {
-	/* 0    1     2      3      4      5      6       7         8      9 */
-	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
-	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
-	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
-	usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
-	usb0,  usb1,  maxclk,
-};
-
-static struct clk_hw *prima2_clk_hw_array[maxclk] __initdata = {
-	NULL, /* dummy */
-	NULL,
-	&clk_pll1.hw,
-	&clk_pll2.hw,
-	&clk_pll3.hw,
-	&clk_mem.hw,
-	&clk_sys.hw,
-	&clk_security.hw,
-	&clk_dsp.hw,
-	&clk_gps.hw,
-	&clk_mf.hw,
-	&clk_io.hw,
-	&clk_cpu.hw,
-	&clk_uart0.hw,
-	&clk_uart1.hw,
-	&clk_uart2.hw,
-	&clk_tsc.hw,
-	&clk_i2c0.hw,
-	&clk_i2c1.hw,
-	&clk_spi0.hw,
-	&clk_spi1.hw,
-	&clk_pwmc.hw,
-	&clk_efuse.hw,
-	&clk_pulse.hw,
-	&clk_dmac0.hw,
-	&clk_dmac1.hw,
-	&clk_nand.hw,
-	&clk_audio.hw,
-	&clk_usp0.hw,
-	&clk_usp1.hw,
-	&clk_usp2.hw,
-	&clk_vip.hw,
-	&clk_gfx.hw,
-	&clk_mm.hw,
-	&clk_lcd.hw,
-	&clk_vpp.hw,
-	&clk_mmc01.hw,
-	&clk_mmc23.hw,
-	&clk_mmc45.hw,
-	&usb_pll_clk_hw,
-	&clk_usb0.hw,
-	&clk_usb1.hw,
-};
-
-static struct clk *prima2_clks[maxclk];
-static struct clk_onecell_data clk_data;
-
-void __init sirfsoc_of_clk_init(void)
-{
-	struct device_node *np;
-	int i;
-
-	np = of_find_matching_node(NULL, rsc_ids);
-	if (!np)
-		panic("unable to find compatible rsc node in dtb\n");
 
-	sirfsoc_rsc_vbase = of_iomap(np, 0);
-	if (!sirfsoc_rsc_vbase)
-		panic("unable to map rsc registers\n");
-
-	of_node_put(np);
-
-	np = of_find_matching_node(NULL, clkc_ids);
-	if (!np)
-		return;
-
-	sirfsoc_clk_vbase = of_iomap(np, 0);
-	if (!sirfsoc_clk_vbase)
-		panic("unable to map clkc registers\n");
-
-	/* These are always available (RTC and 26MHz OSC)*/
-	prima2_clks[rtc] = clk_register_fixed_rate(NULL, "rtc", NULL,
-		CLK_IS_ROOT, 32768);
-	prima2_clks[osc]= clk_register_fixed_rate(NULL, "osc", NULL,
-		CLK_IS_ROOT, 26000000);
-
-	for (i = pll1; i < maxclk; i++) {
-		prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
-		BUG_ON(IS_ERR(prima2_clks[i]));
-	}
-	clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
-	clk_register_clkdev(prima2_clks[io],  NULL, "io");
-	clk_register_clkdev(prima2_clks[mem],  NULL, "mem");
-
-	clk_data.clks = prima2_clks;
-	clk_data.clk_num = maxclk;
-
-	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
-}
diff --git a/drivers/clk/sirf/clk-prima2.c b/drivers/clk/sirf/clk-prima2.c
new file mode 100644
index 0000000..5df1884
--- /dev/null
+++ b/drivers/clk/sirf/clk-prima2.c
@@ -0,0 +1,137 @@
+/*
+ * Clock tree for CSR SiRFprimaII
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clk-private.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+
+#include "clk.h"
+#include "prima2.h"
+#include "clk-common.c"
+
+static struct clk_dmn clk_mmc01 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 59,
+	.hw = {
+		.init = &clk_mmc01_init,
+	},
+};
+
+static struct clk_dmn clk_mmc23 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 60,
+	.hw = {
+		.init = &clk_mmc23_init,
+	},
+};
+
+static struct clk_dmn clk_mmc45 = {
+	.regofs = SIRFSOC_CLKC_MMC_CFG,
+	.enable_bit = 61,
+	.hw = {
+		.init = &clk_mmc45_init,
+	},
+};
+
+static struct clk_init_data clk_nand_init = {
+	.name = "nand",
+	.ops = &ios_ops,
+	.parent_names = std_clk_io_parents,
+	.num_parents = ARRAY_SIZE(std_clk_io_parents),
+};
+
+static struct clk_std clk_nand = {
+	.enable_bit = 34,
+	.hw = {
+		.init = &clk_nand_init,
+	},
+};
+
+enum prima2_clk_index {
+	/* 0    1     2      3      4      5      6       7         8      9 */
+	rtc,    osc,   pll1,  pll2,  pll3,  mem,   sys,   security, dsp,   gps,
+	mf,     io,    cpu,   uart0, uart1, uart2, tsc,   i2c0,     i2c1,  spi0,
+	spi1,   pwmc,  efuse, pulse, dmac0, dmac1, nand,  audio,    usp0,  usp1,
+	usp2,   vip,   gfx,   mm,    lcd,   vpp,   mmc01, mmc23,    mmc45, usbpll,
+	usb0,  usb1,  maxclk,
+};
+
+static struct clk_hw *prima2_clk_hw_array[maxclk] __initdata = {
+	NULL, /* dummy */
+	NULL,
+	&clk_pll1.hw,
+	&clk_pll2.hw,
+	&clk_pll3.hw,
+	&clk_mem.hw,
+	&clk_sys.hw,
+	&clk_security.hw,
+	&clk_dsp.hw,
+	&clk_gps.hw,
+	&clk_mf.hw,
+	&clk_io.hw,
+	&clk_cpu.hw,
+	&clk_uart0.hw,
+	&clk_uart1.hw,
+	&clk_uart2.hw,
+	&clk_tsc.hw,
+	&clk_i2c0.hw,
+	&clk_i2c1.hw,
+	&clk_spi0.hw,
+	&clk_spi1.hw,
+	&clk_pwmc.hw,
+	&clk_efuse.hw,
+	&clk_pulse.hw,
+	&clk_dmac0.hw,
+	&clk_dmac1.hw,
+	&clk_nand.hw,
+	&clk_audio.hw,
+	&clk_usp0.hw,
+	&clk_usp1.hw,
+	&clk_usp2.hw,
+	&clk_vip.hw,
+	&clk_gfx.hw,
+	&clk_mm.hw,
+	&clk_lcd.hw,
+	&clk_vpp.hw,
+	&clk_mmc01.hw,
+	&clk_mmc23.hw,
+	&clk_mmc45.hw,
+	&usb_pll_clk_hw,
+	&clk_usb0.hw,
+	&clk_usb1.hw,
+};
+
+static struct clk *prima2_clks[maxclk];
+
+void __init prima2_clk_init(void)
+{
+	int i;
+
+	/* These are always available (RTC and 26MHz OSC)*/
+	prima2_clks[rtc] = clk_register_fixed_rate(NULL, "rtc", NULL,
+		CLK_IS_ROOT, 32768);
+	prima2_clks[osc] = clk_register_fixed_rate(NULL, "osc", NULL,
+		CLK_IS_ROOT, 26000000);
+
+	for (i = pll1; i < maxclk; i++) {
+		prima2_clks[i] = clk_register(NULL, prima2_clk_hw_array[i]);
+		BUG_ON(IS_ERR(prima2_clks[i]));
+	}
+	clk_register_clkdev(prima2_clks[cpu], NULL, "cpu");
+	clk_register_clkdev(prima2_clks[io],  NULL, "io");
+	clk_register_clkdev(prima2_clks[mem],  NULL, "mem");
+
+	clk_data.clks = prima2_clks;
+	clk_data.clk_num = maxclk;
+}
diff --git a/drivers/clk/sirf/clk.c b/drivers/clk/sirf/clk.c
new file mode 100644
index 0000000..adbaec8
--- /dev/null
+++ b/drivers/clk/sirf/clk.c
@@ -0,0 +1,61 @@
+/*
+ * iomem mapping and initilization for SiRF SoC clock tree
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/of_address.h>
+#include <linux/syscore_ops.h>
+#include "clk.h"
+
+void *sirfsoc_clk_vbase, *sirfsoc_rsc_vbase;
+
+struct clk_onecell_data clk_data;
+
+static const struct of_device_id sirfsoc_clkc_ids[] = {
+	{ .compatible = "sirf,prima2-clkc", .data = prima2_clk_init, },
+	{ .compatible = "sirf,atlas6-clkc", .data = atlas6_clk_init, },
+	{},
+};
+
+static const struct of_device_id rsc_ids[] = {
+	{ .compatible = "sirf,prima2-rsc" },
+	{},
+};
+
+void __init sirfsoc_of_clk_init(void)
+{
+	struct device_node *np;
+	void (*clk_init)(void);
+
+	np = of_find_matching_node(NULL, rsc_ids);
+	if (!np)
+		panic("unable to find compatible rsc node in dtb\n");
+
+	sirfsoc_rsc_vbase = of_iomap(np, 0);
+	if (!sirfsoc_rsc_vbase)
+		panic("unable to map rsc registers\n");
+
+	of_node_put(np);
+
+	np = of_find_matching_node(NULL, sirfsoc_clkc_ids);
+	if (!np)
+		return;
+
+	sirfsoc_clk_vbase = of_iomap(np, 0);
+	if (!sirfsoc_clk_vbase)
+		panic("unable to map clkc registers\n");
+
+	clk_init = (void (*)(void))of_match_node(sirfsoc_clkc_ids, np)->data;
+	clk_init();
+
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
diff --git a/drivers/clk/sirf/clk.h b/drivers/clk/sirf/clk.h
new file mode 100644
index 0000000..189cab1
--- /dev/null
+++ b/drivers/clk/sirf/clk.h
@@ -0,0 +1,5 @@
+extern void *sirfsoc_clk_vbase;
+extern void *sirfsoc_rsc_vbase;
+extern struct clk_onecell_data clk_data;
+extern void __init prima2_clk_init(void);
+extern void __init atlas6_clk_init(void);
diff --git a/drivers/clk/sirf/prima2.h b/drivers/clk/sirf/prima2.h
new file mode 100644
index 0000000..01bc385
--- /dev/null
+++ b/drivers/clk/sirf/prima2.h
@@ -0,0 +1,25 @@
+#define SIRFSOC_CLKC_CLK_EN0    0x0000
+#define SIRFSOC_CLKC_CLK_EN1    0x0004
+#define SIRFSOC_CLKC_REF_CFG    0x0014
+#define SIRFSOC_CLKC_CPU_CFG    0x0018
+#define SIRFSOC_CLKC_MEM_CFG    0x001c
+#define SIRFSOC_CLKC_SYS_CFG    0x0020
+#define SIRFSOC_CLKC_IO_CFG     0x0024
+#define SIRFSOC_CLKC_DSP_CFG    0x0028
+#define SIRFSOC_CLKC_GFX_CFG    0x002c
+#define SIRFSOC_CLKC_MM_CFG     0x0030
+#define SIRFSOC_CLKC_LCD_CFG     0x0034
+#define SIRFSOC_CLKC_MMC_CFG    0x0038
+#define SIRFSOC_CLKC_PLL1_CFG0  0x0040
+#define SIRFSOC_CLKC_PLL2_CFG0  0x0044
+#define SIRFSOC_CLKC_PLL3_CFG0  0x0048
+#define SIRFSOC_CLKC_PLL1_CFG1  0x004c
+#define SIRFSOC_CLKC_PLL2_CFG1  0x0050
+#define SIRFSOC_CLKC_PLL3_CFG1  0x0054
+#define SIRFSOC_CLKC_PLL1_CFG2  0x0058
+#define SIRFSOC_CLKC_PLL2_CFG2  0x005c
+#define SIRFSOC_CLKC_PLL3_CFG2  0x0060
+#define SIRFSOC_USBPHY_PLL_CTRL 0x0008
+#define SIRFSOC_USBPHY_PLL_POWERDOWN  BIT(1)
+#define SIRFSOC_USBPHY_PLL_BYPASS     BIT(2)
+#define SIRFSOC_USBPHY_PLL_LOCK       BIT(3)
-- 
1.8.2.3
