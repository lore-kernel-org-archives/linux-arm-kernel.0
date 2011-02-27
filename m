From: linux@prisktech.co.nz (Linux Mailing List Email Account)
Date: Sun, 27 Feb 2011 00:06:02 -0000
Subject: [PATCH 3/3] VIA/Wondermedia clock support
Message-ID: <76F764B079F92A4E843589C893D0A0228CCD@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Tony Prisk (linux at prisktech.co.nz)
--- /dev/null   2011-02-26 19:04:30.530140059 +1300
+++ arch/arm/mach-vt8500/wm8505-clocks.c   2011-02-27 12:40:35.000000000 +1300
@@ -0,0 +1,624 @@
+/*
+ *  arch/arm/mach-vt8500/wm8505_clocks.c
+ *
+ *  Copyright (C) 2011 Tony Prisk
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <mach/wm8505_regs.h>
+#include "clock.h"
+
+#define CLK_PM_STATUS_LOW 0x000
+#define CLK_PML_ANY_CLK_UPDATING    0x00000008
+#define CLK_PML_PLL_UPDATING        0x00000010
+#define CLK_PML_ARM_UPDATING        0x00000080
+#define CLK_PML_AHB_UPDATING        0x00000100
+#define CLK_PML_UPDATE_MASK         0x1FFF9B37
+#define CLK_PML_BUSY           0xFFFFFFFE
+#define CLK_PM_STATUS_HIGH     0x004
+
+#define CLK_PLLA_MULTIPLIER    0x200
+#define CLK_PLLB_MULTIPLIER    0x204
+#define CLK_PLLC_MULTIPLIER    0x208
+#define CLK_PLLD_MULTIPLIER    0x20C
+
+#define CLK_EN_LOW        0x250
+#define CLK_EN_HIGH       0x254
+
+#define CLK_ARM_DIVISOR        0x300
+#define CLK_AHB_DIVISOR        0x304
+#define CLK_DDR_DIVISOR        0x310 /* mask = 0x1F special */
+#define CLK_SFM_DIVISOR        0x314
+#define CLK_KBD_DIVISOR_PRE    0x318
+#define CLK_KBD_DIVISOR        0x31C
+#define CLK_SDMMC_DIVISOR 0x328 /* mask = 0x1F special */
+#define CLK_GENET_DIVISOR 0x32C
+#define CLK_NAND_DIVISOR  0x330
+#define CLK_NOR_DIVISOR        0x334
+#define CLK_SPI0_DIVISOR  0x33C
+#define CLK_SPI1_DIVISOR  0x340
+#define CLK_SPI2_DIVISOR  0x344
+#define CLK_PWM_DIVISOR        0x348
+#define CLK_APB_DIVISOR        0x350
+#define CLK_NA0_DIVISOR        0x358
+#define CLK_NA12_DIVISOR  0x35C
+#define CLK_I2C0_DIVISOR  0x36C
+#define CLK_I2C1_DIVISOR  0x370
+#define CLK_DVO_DIVISOR        0x374
+#define CLK_RO1_DIVISOR        0x378
+#define CLK_RO2_DIVISOR        0x37C
+
+void __iomem *clk_pmc_base;
+
+/*
+ * define our supported clocks
+ *
+ * Clock structure tree
+ *
+ * REF_CLK (25Mhz)
+ * |\     PLL_A
+ * | |-        cpu
+ * |  \-       ahb
+ * |   -       apb
+ * |\     PLL_B
+ * | |\-  nand flash
+ * | | -  nor flash
+ * | |-        sdmmc
+ * | |-        lcd controller
+ * | |-        pcm
+ * | |-        pwm
+ * | |-        spi
+ * | \-        kbdc
+ * |
+ *  \     PLL_C
+ *   \-        ddr
+ *
+ */
+
+static void wmt_pm_wait_update(void)
+{
+    while (readl(clk_pmc_base + CLK_PM_STATUS_LOW) & CLK_PML_UPDATE_MASK)
+          ;
+}
+
+static void wmt_pm_wait_busy(void)
+{
+    while (readl(clk_pmc_base + CLK_PM_STATUS_LOW) & CLK_PML_BUSY)
+          ;
+}
+
+void clk_cpu_speedstep(u32 plla_mul, u32 arm_div, u32 ahb_div)
+{
+    if (ahb_div > 1) {
+          /*
+             AHB, PLL, ARM
+          */
+          wmt_pm_wait_busy();
+          wmt_pm_wait_update();
+          writel(ahb_div, clk_pmc_base + CLK_AHB_DIVISOR);
+
+          wmt_pm_wait_update();
+          writel(plla_mul, clk_pmc_base + CLK_PLLA_MULTIPLIER);
+
+          wmt_pm_wait_update();
+          writel(arm_div, clk_pmc_base + CLK_ARM_DIVISOR);
+    } else {
+          /*
+            PLL, ARM, AHB
+          */
+          wmt_pm_wait_update();
+          writel(plla_mul, clk_pmc_base + CLK_PLLA_MULTIPLIER);
+
+          wmt_pm_wait_update();
+          writel(arm_div, clk_pmc_base + CLK_ARM_DIVISOR);
+
+          wmt_pm_wait_busy();
+          wmt_pm_wait_update();
+          writel(ahb_div, clk_pmc_base + CLK_AHB_DIVISOR);
+    }
+    wmt_pm_wait_update();
+}
+
+unsigned long getrate_pll(struct clk *clk)
+{
+    unsigned long prate = clk->parent->rate;
+    u32 pll_mul = (readl(clk_pmc_base + clk->div_reg) & 0x1F);
+    u32 pll_prediv = (readl(clk_pmc_base + clk->div_reg) & 0x100) ? 1 : 2;
+    if (pll_mul < 4)
+          pll_mul = 1;
+    else
+          pll_mul *= 2;
+
+    clk->rate = prate * pll_mul / pll_prediv;
+    return clk->rate;
+}
+
+int setrate_pll(struct clk *clk, unsigned long rate)
+{
+    unsigned long prate = clk->parent->rate;
+    unsigned long actual_plla_rate;
+    unsigned long actual_arm_rate;
+    u32 plla_mul;
+    u32 arm_div;
+    u32 ahb_div;
+    struct clk *arm_clk;
+    struct clk *ahb_clk;
+
+    arm_clk = clk_get(NULL, "arm");
+    ahb_clk = clk_get(NULL, "ahb");
+
+    /* calculate the PLL_A multiplier */
+    if (rate % prate)
+          plla_mul = rate / prate + 1;
+    else
+          plla_mul = rate / prate;
+
+    actual_plla_rate = prate * plla_mul;
+
+    /* calculate the new ARM divisor */
+    if (actual_plla_rate % arm_clk->rate)
+          arm_div = actual_plla_rate / arm_clk->rate + 1;
+    else
+          arm_div = actual_plla_rate / arm_clk->rate;
+
+    actual_arm_rate = actual_plla_rate / arm_div;
+
+    /* calculate the new AHB divisor */
+    if (actual_arm_rate % ahb_clk->rate)
+          ahb_div = actual_arm_rate / ahb_clk->rate + 1;
+    else
+          ahb_div = actual_arm_rate / ahb_clk->rate;
+
+    clk_cpu_speedstep(plla_mul, arm_div, ahb_div);
+
+    return 0;
+}
+
+unsigned long getrate_ahb(struct clk *clk)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div = (readl(clk_pmc_base + clk->div_reg) & 0x07);
+    if (clk_div == 0)
+          clk_div = 8;
+
+    clk->rate = prate / clk_div;
+    return clk->rate;
+}
+
+int setrate_ahb(struct clk *clk, unsigned long rate)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div;
+
+    /* divisor only, so the clk can't be higher than the parent clk */
+    if (rate > prate)
+          return -EINVAL;
+
+    if (prate % rate)
+          clk_div = prate / rate + 1;
+    else
+          clk_div = prate / rate;
+
+    /* handle special case */
+    if (clk_div == 8)
+          clk_div = 0;
+
+    if (clk_div > 8)
+          return -ENOENT;
+
+    wmt_pm_wait_busy();
+    wmt_pm_wait_update();
+    writel(clk_div, clk_pmc_base + clk->div_reg);
+
+    wmt_pm_wait_update();
+
+    return 0;
+}
+
+unsigned long getrate_arm(struct clk *clk)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div = (readl(clk_pmc_base + clk->div_reg) & 0x1F);
+    if (clk_div == 0)
+          clk_div = 32;
+
+    clk->rate = prate / clk_div;
+    return clk->rate;
+}
+
+int setrate_arm(struct clk *clk, unsigned long rate)
+{
+    unsigned long actual_plla_rate;
+    unsigned long actual_arm_rate;
+
+    u32 plla_mul;
+    u32 arm_div;
+    u32 ahb_div;
+
+    struct clk *plla_clk;
+    struct clk *ahb_clk;
+
+    plla_clk = clk_get(NULL, "pll_a");
+    ahb_clk = clk_get(NULL, "ahb");
+
+    /*
+       calculate the PLL_A multiplier
+       PLL_A will be set to 2 * ARM_clock (if possible)
+    */
+    actual_plla_rate = 2 * rate;
+    if (actual_plla_rate % plla_clk->parent->rate)
+          plla_mul = actual_plla_rate / plla_clk->parent->rate + 1;
+    else
+          plla_mul = actual_plla_rate / plla_clk->parent->rate;
+    actual_plla_rate = plla_clk->parent->rate * plla_mul;
+
+    /* calculate the new ARM divisor */
+    if (actual_plla_rate % rate)
+          arm_div = actual_plla_rate / rate + 1;
+    else
+          arm_div = actual_plla_rate / rate;
+
+    actual_arm_rate = actual_plla_rate / arm_div;
+
+    /* calculate the new AHB divisor */
+    if (actual_arm_rate % ahb_clk->rate)
+          ahb_div = actual_arm_rate / ahb_clk->rate + 1;
+    else
+          ahb_div = actual_arm_rate / ahb_clk->rate;
+
+    clk_cpu_speedstep(plla_mul, arm_div, ahb_div);
+
+    return 0;
+}
+
+int setrate_ddr(struct clk *clk, unsigned long rate)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div;
+
+    /* divisor only, so the clk can't be higher than the parent clk */
+    if (rate > prate)
+          return -EINVAL;
+
+    if (prate % rate)
+          clk_div = prate / rate + 1;
+    else
+          clk_div = prate / rate;
+
+    /* clk_div must be even if != 1, so +1 if odd */
+    if ((clk_div != 1) && (clk_div % 1))
+          clk_div++;
+
+    if (clk_div > 32)
+          return -ENOENT;
+
+    clk->rate = prate / clk_div;
+
+    if (clk_div == 32)
+          clk_div = 0;
+
+    wmt_pm_wait_update();
+    writel(clk_div, clk_pmc_base + clk->div_reg);
+
+    return 0;
+}
+
+unsigned long getrate_sdmmc(struct clk *clk)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div = (readl(clk_pmc_base + clk->div_reg) & 0x3F);
+
+    if (clk_div == 0)
+          clk_div = 32;
+
+    /* Check if fixed divisor is enabled (/64 fixed) */
+    if (clk_div & 0x20)
+          clk_div = 64;
+
+    clk->rate = prate / clk_div;
+    return clk->rate;
+}
+
+int setrate_sdmmc(struct clk *clk, unsigned long rate)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div;
+
+    /*
+       divisor only, so the clk can't be higher than the parent clk
+       also reject rate == 0 for now
+    */
+    if ((rate > prate) || (rate == 0))
+          return -EINVAL;
+
+    if (prate % rate)
+          clk_div = prate / rate + 1;
+    else
+          clk_div = prate / rate;
+
+    /* if clk_div > 32, enable the fixed divisor */
+    if (clk_div > 32)
+          clk_div = 0x20;
+
+    clk->rate = prate / clk_div;
+
+    if (clk_div == 32)
+          clk_div = 0;
+
+    writel(clk_div, clk_pmc_base + clk->div_reg);
+
+    return 0;
+}
+
+unsigned long getrate_stdmask(struct clk *clk)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div = (readl(clk_pmc_base + clk->div_reg) & 0x1F);
+    if (clk_div == 0)
+          clk_div = 32;
+
+    clk->rate = prate / clk_div;
+    return clk->rate;
+}
+
+int setrate_stdmask(struct clk *clk, unsigned long rate)
+{
+    unsigned long prate = clk_get_rate(clk->parent);
+    u32 clk_div;
+
+    /* divisor only, so the clk can't be higher than the parent clk */
+    if (rate > prate)
+          return -EINVAL;
+
+    if (prate % rate)
+          clk_div = prate / rate + 1;
+    else
+          clk_div = prate / rate;
+
+    if (clk_div > 32)
+          return -ENOENT;
+
+    clk->rate = prate / clk_div;
+
+    if (clk_div == 32)
+          clk_div = 0;
+
+    wmt_pm_wait_update();
+    writel(clk_div, clk_pmc_base + clk->div_reg);
+
+    return 0;
+}
+
+void enable_std(struct clk *clk)
+{
+    u32 regtmp = readl(clk_pmc_base + clk->en_reg);
+    writel(regtmp | (1 << clk->en_bit), clk_pmc_base + clk->en_reg);
+}
+
+void disable_std(struct clk *clk)
+{
+    u32 regtmp = readl(clk_pmc_base + clk->en_reg);
+    writel(regtmp & ~(1 << clk->en_bit), clk_pmc_base + clk->en_reg);
+}
+
+
+static struct clkops clkops_pll = {
+    .getrate   = &getrate_pll,
+    .setrate   = &setrate_pll,
+};
+
+static struct clkops clkops_arm = {
+    .getrate   = &getrate_arm,
+    .setrate   = &setrate_arm,
+};
+
+static struct clkops clkops_ahb = {
+    .getrate   = &getrate_ahb,
+    .setrate   = &setrate_ahb,
+};
+
+static struct clkops clkops_ddr = {
+    .getrate   = &getrate_stdmask,
+    .setrate   = &setrate_ddr,
+};
+
+static struct clkops clkops_sdmmc = {
+    .getrate   = &getrate_sdmmc,
+    .setrate   = &setrate_sdmmc,
+    .enable         = &enable_std,
+    .disable   = &disable_std,
+};
+
+static struct clkops clkops_stdmask = {
+    .getrate   = &getrate_stdmask,
+    .setrate   = &setrate_stdmask,
+    .enable         = &enable_std,
+    .disable   = &disable_std,
+};
+
+
+DEFINE_CKREF(ref, 25000000);
+
+DEFINE_CKPGNP(pll_a, &clk_ref, 0, &clkops_pll, CLK_PLLA_MULTIPLIER);
+DEFINE_CKPGNP(arm, &clk_pll_a, 0, &clkops_arm, CLK_ARM_DIVISOR);
+DEFINE_CKPG(ahb, &clk_arm, 0, &clkops_ahb, CLK_AHB_DIVISOR);
+DEFINE_CKPG(apb, &clk_arm, 0, &clkops_stdmask, CLK_APB_DIVISOR);
+
+DEFINE_CKPG(pll_b, &clk_ref, 0, &clkops_pll, CLK_PLLB_MULTIPLIER);
+DEFINE_CKPGEN(sdmmc, &clk_pll_b, 0, &clkops_sdmmc, CLK_SDMMC_DIVISOR ,      \
+               CLK_EN_HIGH, 18);
+DEFINE_CKPGEN(nand, &clk_pll_b, 0, &clkops_stdmask, CLK_NAND_DIVISOR,         \
+               CLK_EN_HIGH, 16);
+DEFINE_CKPGEN(kbd_pre, &clk_pll_b, 0, &clkops_stdmask, CLK_KBD_DIVISOR_PRE, \
+               CLK_EN_HIGH, 4);
+DEFINE_CKPGEN(kbd, &clk_pll_b, 0, &clkops_stdmask, CLK_KBD_DIVISOR,     \
+               CLK_EN_HIGH, 4);
+DEFINE_CKPGEN(sfm, &clk_pll_b, 0, &clkops_stdmask, CLK_SFM_DIVISOR,     \
+               CLK_EN_HIGH, 23);
+DEFINE_CKPG(genet, &clk_pll_b, 0, &clkops_stdmask, CLK_GENET_DIVISOR);
+DEFINE_CKPGEN(nor, &clk_pll_b, 0, &clkops_stdmask, CLK_NOR_DIVISOR,     \
+               CLK_EN_HIGH, 3);
+DEFINE_CKPGEN(spi0, &clk_pll_b, 0, &clkops_stdmask, CLK_SPI0_DIVISOR,         \
+               CLK_EN_LOW, 12);
+DEFINE_CKPGEN(spi1, &clk_pll_b, 0, &clkops_stdmask, CLK_SPI1_DIVISOR,         \
+               CLK_EN_LOW, 13);
+DEFINE_CKPGEN(spi2, &clk_pll_b, 0, &clkops_stdmask, CLK_SPI2_DIVISOR,         \
+               CLK_EN_LOW, 14);
+DEFINE_CKPGEN(pwm, &clk_pll_b, 0, &clkops_stdmask, CLK_PWM_DIVISOR,     \
+               CLK_EN_LOW, 10);
+DEFINE_CKPGEN(na0, &clk_pll_b, 0, &clkops_stdmask, CLK_NA0_DIVISOR,     \
+               CLK_EN_HIGH, 1);
+DEFINE_CKPGEN(na12, &clk_pll_b, 0, &clkops_stdmask, CLK_NA12_DIVISOR,         \
+               CLK_EN_HIGH, 2);
+DEFINE_CKPGEN(i2c0, &clk_pll_b, 0, &clkops_stdmask, CLK_I2C0_DIVISOR,         \
+               CLK_EN_LOW, 5);
+DEFINE_CKPGEN(i2c1, &clk_pll_b, 0, &clkops_stdmask, CLK_I2C1_DIVISOR,         \
+               CLK_EN_LOW, 0);
+DEFINE_CKPGEN(dvo, &clk_pll_b, 0, &clkops_stdmask, CLK_DVO_DIVISOR,     \
+               CLK_EN_LOW, 18);
+DEFINE_CKPG(ro1, &clk_pll_b, 0, &clkops_stdmask, CLK_RO1_DIVISOR);
+DEFINE_CKPG(ro2, &clk_pll_b, 0, &clkops_stdmask, CLK_RO2_DIVISOR);
+
+DEFINE_CKPG(pll_c, &clk_ref, 0, &clkops_pll, CLK_PLLC_MULTIPLIER);
+DEFINE_CKPGEN(ddr, &clk_pll_c, 0, &clkops_ddr, CLK_DDR_DIVISOR,               \
+          CLK_EN_HIGH, 0);
+
+DEFINE_CKPG(pll_d, &clk_ref, 0, &clkops_pll, CLK_PLLD_MULTIPLIER);
+
+
+/* Enable/Disable clocks - Non-programmable */
+DEFINE_CKEN(govrhd, &clkops_stdmask,     CLK_EN_LOW, 30);
+DEFINE_CKEN(ge,           &clkops_stdmask,     CLK_EN_LOW, 29);
+DEFINE_CKEN(jenc,   &clkops_stdmask,     CLK_EN_LOW, 27);
+DEFINE_CKEN(amp,    &clkops_stdmask,     CLK_EN_LOW, 24);
+DEFINE_CKEN(uart5,  &clkops_stdmask,     CLK_EN_LOW, 23);
+DEFINE_CKEN(uart4,  &clkops_stdmask,     CLK_EN_LOW, 22);
+DEFINE_CKEN(scc,    &clkops_stdmask,     CLK_EN_LOW, 21);
+DEFINE_CKEN(ac97,   &clkops_stdmask,     CLK_EN_LOW, 19);
+DEFINE_CKEN(cir,    &clkops_stdmask,     CLK_EN_LOW, 17);
+DEFINE_CKEN(i2s,    &clkops_stdmask,     CLK_EN_LOW, 16);
+DEFINE_CKEN(gpio,   &clkops_stdmask,     CLK_EN_LOW, 11);
+DEFINE_CKEN(keypad, &clkops_stdmask,     CLK_EN_LOW, 9);
+DEFINE_CKEN(rtc,    &clkops_stdmask,     CLK_EN_LOW, 7);
+DEFINE_CKEN(i2c_slave,    &clkops_stdmask,     CLK_EN_LOW, 6);
+DEFINE_CKEN(uart3,  &clkops_stdmask,     CLK_EN_LOW, 4);
+DEFINE_CKEN(uart2,  &clkops_stdmask,     CLK_EN_LOW, 3);
+DEFINE_CKEN(uart1,  &clkops_stdmask,     CLK_EN_LOW, 2);
+DEFINE_CKEN(uart0,  &clkops_stdmask,     CLK_EN_LOW, 1);
+DEFINE_CKEN(vpp,    &clkops_stdmask,     CLK_EN_HIGH, 31);
+DEFINE_CKEN(vid,    &clkops_stdmask,     CLK_EN_HIGH, 30);
+DEFINE_CKEN(govw,   &clkops_stdmask,     CLK_EN_HIGH, 29);
+DEFINE_CKEN(scl444u, &clkops_stdmask,     CLK_EN_HIGH, 28);
+DEFINE_CKEN(eth_phy, &clkops_stdmask,     CLK_EN_HIGH, 26);
+DEFINE_CKEN(sae,    &clkops_stdmask,     CLK_EN_HIGH, 24);
+DEFINE_CKEN(sys,    &clkops_stdmask,     CLK_EN_HIGH, 21);
+DEFINE_CKEN(eth_mac0,     &clkops_stdmask,     CLK_EN_HIGH, 20);
+DEFINE_CKEN(sdtv,   &clkops_stdmask,     CLK_EN_HIGH, 14);
+DEFINE_CKEN(ahb_bridge,   &clkops_stdmask,     CLK_EN_HIGH, 13);
+DEFINE_CKEN(pdma,   &clkops_stdmask,     CLK_EN_HIGH, 9);
+DEFINE_CKEN(udc,    &clkops_stdmask,     CLK_EN_HIGH, 8);
+DEFINE_CKEN(uhc,    &clkops_stdmask,     CLK_EN_HIGH, 7);
+DEFINE_CKEN(dma,    &clkops_stdmask,     CLK_EN_HIGH, 5);
+
+static struct clk_lookup wmt_clkregs[] = {
+    INIT_CLKREG(&clk_ref,      NULL, "ref"),
+    INIT_CLKREG(&clk_pll_a,         NULL, "pll_a"),
+    INIT_CLKREG(&clk_pll_b,         NULL, "pll_b"),
+    INIT_CLKREG(&clk_pll_c,         NULL, "pll_c"),
+    INIT_CLKREG(&clk_pll_d,         NULL, "pll_d"),
+    INIT_CLKREG(&clk_arm,      NULL, "arm"),
+    INIT_CLKREG(&clk_ahb,      NULL, "ahb"),
+    INIT_CLKREG(&clk_ahb_bridge,    NULL, "ahb_bridge"),
+    INIT_CLKREG(&clk_apb,      NULL, "apb"),
+    INIT_CLKREG(&clk_ddr,      NULL, "ddr"),
+
+    INIT_CLKREG(&clk_nor,      NULL, "nor"),
+    INIT_CLKREG(&clk_nand,          NULL, "nand"),
+    INIT_CLKREG(&clk_sdmmc,         NULL, "sdmmc"),
+
+    INIT_CLKREG(&clk_keypad,   NULL, "keypad"),
+    INIT_CLKREG(&clk_kbd_pre,  NULL, "kbd_pre"),
+    INIT_CLKREG(&clk_kbd,      NULL, "kbd"),
+    INIT_CLKREG(&clk_sfm,      NULL, "sfm"),
+    INIT_CLKREG(&clk_genet,         NULL, "genet"),
+
+    INIT_CLKREG(&clk_spi0,          NULL, "spi0"),
+    INIT_CLKREG(&clk_spi1,          NULL, "spi1"),
+    INIT_CLKREG(&clk_spi2,          NULL, "spi2"),
+
+    INIT_CLKREG(&clk_govrhd,   NULL, "govrhd"),
+    INIT_CLKREG(&clk_govw,          NULL, "govw"),
+    INIT_CLKREG(&clk_ge,       NULL, "ge"),
+    INIT_CLKREG(&clk_pwm,      NULL, "pwm"),
+    INIT_CLKREG(&clk_dvo,      NULL, "dvo"),
+    INIT_CLKREG(&clk_jenc,          NULL, "jenc"),
+    INIT_CLKREG(&clk_sdtv,          NULL, "sdtv"),
+
+    INIT_CLKREG(&clk_cir,      NULL, "cir"),
+    INIT_CLKREG(&clk_gpio,          NULL, "gpio"),
+    INIT_CLKREG(&clk_rtc,      NULL, "rtc"),
+
+    INIT_CLKREG(&clk_i2c0,          NULL, "i2c0"),
+    INIT_CLKREG(&clk_i2c1,          NULL, "i2c1"),
+    INIT_CLKREG(&clk_i2c_slave,     NULL, "i2c_slave"),
+
+    INIT_CLKREG(&clk_ac97,          NULL, "ac97"),
+    INIT_CLKREG(&clk_i2s,      NULL, "i2s"),
+
+    INIT_CLKREG(&clk_eth_phy,  NULL, "eth_phy"),
+    INIT_CLKREG(&clk_eth_mac0, NULL, "eth_mac0"),
+
+    INIT_CLKREG(&clk_uart5,         NULL, "uart5"),
+    INIT_CLKREG(&clk_uart4,         NULL, "uart4"),
+    INIT_CLKREG(&clk_uart3,         NULL, "uart3"),
+    INIT_CLKREG(&clk_uart2,         NULL, "uart2"),
+    INIT_CLKREG(&clk_uart1,         NULL, "uart1"),
+    INIT_CLKREG(&clk_uart0,         NULL, "uart0"),
+
+    INIT_CLKREG(&clk_na0,      NULL, "na0"),
+    INIT_CLKREG(&clk_na12,          NULL, "na12"),
+    INIT_CLKREG(&clk_ro1,      NULL, "ro1"),
+    INIT_CLKREG(&clk_ro2,      NULL, "ro2"),
+    INIT_CLKREG(&clk_amp,      NULL, "amp"),
+    INIT_CLKREG(&clk_scc,      NULL, "scc"),
+    INIT_CLKREG(&clk_vpp,      NULL, "vpp"),
+    INIT_CLKREG(&clk_vid,      NULL, "vid"),
+    INIT_CLKREG(&clk_scl444u,  NULL, "scl444u"),
+    INIT_CLKREG(&clk_sae,      NULL, "sae"),
+    INIT_CLKREG(&clk_sys,      NULL, "sys"),
+    INIT_CLKREG(&clk_udc,      NULL, "udc"),
+    INIT_CLKREG(&clk_uhc,      NULL, "uhc"),
+    INIT_CLKREG(&clk_dma,      NULL, "dma"),
+    INIT_CLKREG(&clk_pdma,          NULL, "pdma"),
+};
+
+int wmt_clock_init(void)
+{
+    struct clk_lookup *c;
+
+    /* map to PMC io memory */
+    clk_pmc_base = ioremap(WM8505_PMC_BASE, 0x380);
+
+    for (c = wmt_clkregs; c->clk; c++)
+          clk_register(c->clk);
+
+    clkdev_add_table(wmt_clkregs, ARRAY_SIZE(wmt_clkregs));
+
+    return 0;
+}

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110227/29dc7dc7/attachment.html>
