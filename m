From: hzhuang1@marvell.com (Haojian Zhuang)
Date: Mon, 22 Nov 2010 23:12:52 -0800
Subject: [PATCH 2/2] ARM: pxa: separate the clock support into
	clock-{pxa2xx,pxa3xx}.c
In-Reply-To: <1290406957-21601-2-git-send-email-eric.y.miao@gmail.com>
References: <1290406957-21601-1-git-send-email-eric.y.miao@gmail.com>
	<1290406957-21601-2-git-send-email-eric.y.miao@gmail.com>
Message-ID: <25B60CDC2F704E4E9D88FFD52780CB4C059ABECE34@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>-----Original Message-----
>From: Eric Miao [mailto:eric.y.miao at gmail.com]
>Sent: 2010?11?22? 2:23 PM
>To: linux-arm-kernel
>Cc: Haojian Zhuang; Eric Miao
>Subject: [PATCH 2/2] ARM: pxa: separate the clock support into clock-
>{pxa2xx,pxa3xx}.c
>
>Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
>---
> arch/arm/mach-pxa/Makefile       |    6 +-
> arch/arm/mach-pxa/clock-pxa2xx.c |   30 +++++++
> arch/arm/mach-pxa/clock-pxa3xx.c |  161
>++++++++++++++++++++++++++++++++++++
> arch/arm/mach-pxa/clock.c        |   26 ++----
> arch/arm/mach-pxa/clock.h        |   21 ++++--
> arch/arm/mach-pxa/pxa25x.c       |   41 +++++-----
> arch/arm/mach-pxa/pxa27x.c       |   51 ++++++------
> arch/arm/mach-pxa/pxa3xx.c       |  170 +-------------------------------------
> 8 files changed, 266 insertions(+), 240 deletions(-)
> create mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
> create mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
>
>diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
>index e2f89c2..c90789e 100644
>--- a/arch/arm/mach-pxa/Makefile
>+++ b/arch/arm/mach-pxa/Makefile
>@@ -16,9 +16,9 @@ endif
> # Generic drivers that other drivers may depend upon
>
> # SoC-specific code
>-obj-$(CONFIG_PXA25x)          += mfp-pxa2xx.o pxa2xx.o pxa25x.o
>-obj-$(CONFIG_PXA27x)          += mfp-pxa2xx.o pxa2xx.o pxa27x.o
>-obj-$(CONFIG_PXA3xx)          += mfp-pxa3xx.o pxa3xx.o smemc.o pxa3xx-ulpi.o
>+obj-$(CONFIG_PXA25x)          += mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa25x.o
>+obj-$(CONFIG_PXA27x)          += mfp-pxa2xx.o clock-pxa2xx.o pxa2xx.o pxa27x.o
>+obj-$(CONFIG_PXA3xx)          += mfp-pxa3xx.o clock-pxa3xx.o pxa3xx.o smemc.o
>pxa3xx-ulpi.o
> obj-$(CONFIG_CPU_PXA300)      += pxa300.o
> obj-$(CONFIG_CPU_PXA320)      += pxa320.o
> obj-$(CONFIG_CPU_PXA930)      += pxa930.o
>diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
>new file mode 100644
>index 0000000..416b3f0
>--- /dev/null
>+++ b/arch/arm/mach-pxa/clock-pxa2xx.c
>@@ -0,0 +1,30 @@
>+/*
>+ * linux/arch/arm/mach-pxa/clock-pxa2xx.c
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/kernel.h>
>+#include <linux/init.h>
>+
>+#include <mach/pxa2xx-regs.h>
>+
>+#include "clock.h"
>+
>+void clk_pxa2xx_cken_enable(struct clk *clk)
>+{
>+      CKEN |= 1 << clk->cken;
>+}
>+
>+void clk_pxa2xx_cken_disable(struct clk *clk)
>+{
>+      CKEN &= ~(1 << clk->cken);
>+}
>+
>+const struct clkops clk_pxa2xx_cken_ops = {
>+      .enable         = clk_pxa2xx_cken_enable,
>+      .disable        = clk_pxa2xx_cken_disable,
>+};
>diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
>new file mode 100644
>index 0000000..34a36c4
>--- /dev/null
>+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
>@@ -0,0 +1,161 @@
>+/*
>+ * linux/arch/arm/mach-pxa/clock-pxa3xx.c
>+ *
>+ * This program is free software; you can redistribute it and/or modify
>+ * it under the terms of the GNU General Public License version 2 as
>+ * published by the Free Software Foundation.
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/kernel.h>
>+#include <linux/init.h>
>+
>+#include <mach/pxa3xx-regs.h>
>+
>+#include "clock.h"
>+
>+/* Crystal clock: 13MHz */
>+#define BASE_CLK      13000000
>+
>+/* Ring Oscillator Clock: 60MHz */
>+#define RO_CLK                60000000
>+
>+#define ACCR_D0CS     (1 << 26)
>+#define ACCR_PCCE     (1 << 11)
>+
>+/* crystal frequency to static memory controller multiplier (SMCFS) */
>+static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
>+
>+/* crystal frequency to HSIO bus frequency multiplier (HSS) */
>+static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
>+
>+/*
>+ * Get the clock frequency as reflected by CCSR and the turbo flag.
>+ * We assume these values have been applied via a fcs.
>+ * If info is not 0 we also display the current settings.
>+ */
>+unsigned int pxa3xx_get_clk_frequency_khz(int info)
>+{
>+      unsigned long acsr, xclkcfg;
>+      unsigned int t, xl, xn, hss, ro, XL, XN, CLK, HSS;
>+
>+      /* Read XCLKCFG register turbo bit */
>+      __asm__ __volatile__("mrc\tp14, 0, %0, c6, c0, 0" : "=r"(xclkcfg));
>+      t = xclkcfg & 0x1;
>+
>+      acsr = ACSR;
>+
>+      xl  = acsr & 0x1f;
>+      xn  = (acsr >> 8) & 0x7;
>+      hss = (acsr >> 14) & 0x3;
>+
>+      XL = xl * BASE_CLK;
>+      XN = xn * XL;
>+
>+      ro = acsr & ACCR_D0CS;
>+
>+      CLK = (ro) ? RO_CLK : ((t) ? XN : XL);
>+      HSS = (ro) ? RO_CLK : hss_mult[hss] * BASE_CLK;
>+
>+      if (info) {
>+              pr_info("RO Mode clock: %d.%02dMHz (%sactive)\n",
>+                      RO_CLK / 1000000, (RO_CLK % 1000000) / 10000,
>+                      (ro) ? "" : "in");
>+              pr_info("Run Mode clock: %d.%02dMHz (*%d)\n",
>+                      XL / 1000000, (XL % 1000000) / 10000, xl);
>+              pr_info("Turbo Mode clock: %d.%02dMHz (*%d, %sactive)\n",
>+                      XN / 1000000, (XN % 1000000) / 10000, xn,
>+                      (t) ? "" : "in");
>+              pr_info("HSIO bus clock: %d.%02dMHz\n",
>+                      HSS / 1000000, (HSS % 1000000) / 10000);
>+      }
>+
>+      return CLK / 1000;
>+}
>+
>+/*
>+ * Return the current AC97 clock frequency.
>+ */
>+static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
>+{
>+      unsigned long rate = 312000000;
>+      unsigned long ac97_div;
>+
>+      ac97_div = AC97_DIV;
>+
>+      /* This may loose precision for some rates but won't for the
>+       * standard 24.576MHz.
>+       */
>+      rate /= (ac97_div >> 12) & 0x7fff;
>+      rate *= (ac97_div & 0xfff);
>+
>+      return rate;
>+}
>+
>+/*
>+ * Return the current HSIO bus clock frequency
>+ */
>+static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
>+{
>+      unsigned long acsr;
>+      unsigned int hss, hsio_clk;
>+
>+      acsr = ACSR;
>+
>+      hss = (acsr >> 14) & 0x3;
>+      hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
>+
>+      return hsio_clk;
>+}
>+
>+void clk_pxa3xx_cken_enable(struct clk *clk)
>+{
>+      unsigned long mask = 1ul << (clk->cken & 0x1f);
>+
>+      if (clk->cken < 32)
>+              CKENA |= mask;
>+      else
>+              CKENB |= mask;
>+}
>+
>+void clk_pxa3xx_cken_disable(struct clk *clk)
>+{
>+      unsigned long mask = 1ul << (clk->cken & 0x1f);
>+
>+      if (clk->cken < 32)
>+              CKENA &= ~mask;
>+      else
>+              CKENB &= ~mask;
>+}
>+
>+const struct clkops clk_pxa3xx_cken_ops = {
>+      .enable         = clk_pxa3xx_cken_enable,
>+      .disable        = clk_pxa3xx_cken_disable,
>+};
>+
>+const struct clkops clk_pxa3xx_hsio_ops = {
>+      .enable         = clk_pxa3xx_cken_enable,
>+      .disable        = clk_pxa3xx_cken_disable,
>+      .getrate        = clk_pxa3xx_hsio_getrate,
>+};
>+
>+const struct clkops clk_pxa3xx_ac97_ops = {
>+      .enable         = clk_pxa3xx_cken_enable,
>+      .disable        = clk_pxa3xx_cken_disable,
>+      .getrate        = clk_pxa3xx_ac97_getrate,
>+};
>+
>+static void clk_pout_enable(struct clk *clk)
>+{
>+      OSCC |= OSCC_PEN;
>+}
>+
>+static void clk_pout_disable(struct clk *clk)
>+{
>+      OSCC &= ~OSCC_PEN;
>+}
>+
>+const struct clkops clk_pxa3xx_pout_ops = {
>+      .enable         = clk_pout_enable,
>+      .disable        = clk_pout_disable,
>+};
>diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
>index abba008..8184fe2 100644
>--- a/arch/arm/mach-pxa/clock.c
>+++ b/arch/arm/mach-pxa/clock.c
>@@ -3,21 +3,12 @@
>  */
> #include <linux/module.h>
> #include <linux/kernel.h>
>-#include <linux/list.h>
>-#include <linux/errno.h>
>-#include <linux/err.h>
>-#include <linux/string.h>
> #include <linux/clk.h>
> #include <linux/spinlock.h>
>-#include <linux/platform_device.h>
> #include <linux/delay.h>
>
> #include <asm/clkdev.h>
>-#include <mach/pxa2xx-regs.h>
>-#include <mach/hardware.h>
>
>-#include "devices.h"
>-#include "generic.h"
> #include "clock.h"
>
> static DEFINE_SPINLOCK(clocks_lock);
>@@ -63,18 +54,19 @@ unsigned long clk_get_rate(struct clk *clk)
> }
> EXPORT_SYMBOL(clk_get_rate);
>
>-
>-void clk_cken_enable(struct clk *clk)
>+void clk_dummy_enable(struct clk *clk)
> {
>-      CKEN |= 1 << clk->cken;
> }
>
>-void clk_cken_disable(struct clk *clk)
>+void clk_dummy_disable(struct clk *clk)
> {
>-      CKEN &= ~(1 << clk->cken);
> }
>
>-const struct clkops clk_cken_ops = {
>-      .enable         = clk_cken_enable,
>-      .disable        = clk_cken_disable,
>+const struct clkops clk_dummy_ops = {
>+      .enable         = clk_dummy_enable,
>+      .disable        = clk_dummy_disable,
>+};
>+
>+struct clk clk_dummy = {
>+      .ops            = &clk_dummy_ops,
> };
>diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
>index f09ecb1..0434878 100644
>--- a/arch/arm/mach-pxa/clock.h
>+++ b/arch/arm/mach-pxa/clock.h
>@@ -14,6 +14,12 @@ struct clk {
>       unsigned int            enabled;
> };
>
>+void clk_dummy_enable(struct clk *);
>+void clk_dummy_disable(struct clk *);
>+
>+extern const struct clkops clk_dummy_ops;
>+extern struct clk clk_dummy;
>+
> #define INIT_CLKREG(_clk,_devname,_conname)           \
>       {                                               \
>               .clk            = _clk,                 \
>@@ -34,18 +40,18 @@ struct clk clk_##_name = {                         \
>               .delay  = _delay,                       \
>       }
>
>-#define DEFINE_CKEN(_name, _cken, _rate, _delay)      \
>+#define DEFINE_PXA2_CKEN(_name, _cken, _rate, _delay) \
> struct clk clk_##_name = {                            \
>-              .ops    = &clk_cken_ops,                \
>+              .ops    = &clk_pxa2xx_cken_ops,         \
>               .rate   = _rate,                        \
>               .cken   = CKEN_##_cken,                 \
>               .delay  = _delay,                       \
>       }
>
>-extern const struct clkops clk_cken_ops;
>+extern const struct clkops clk_pxa2xx_cken_ops;
>
>-void clk_cken_enable(struct clk *clk);
>-void clk_cken_disable(struct clk *clk);
>+void clk_pxa2xx_cken_enable(struct clk *clk);
>+void clk_pxa2xx_cken_disable(struct clk *clk);
>
> #ifdef CONFIG_PXA3xx
> #define DEFINE_PXA3_CKEN(_name, _cken, _rate, _delay) \
>@@ -57,7 +63,10 @@ struct clk clk_##_name = {                          \
>       }
>
> extern const struct clkops clk_pxa3xx_cken_ops;
>+extern const struct clkops clk_pxa3xx_hsio_ops;
>+extern const struct clkops clk_pxa3xx_ac97_ops;
>+extern const struct clkops clk_pxa3xx_pout_ops;
>+
> extern void clk_pxa3xx_cken_enable(struct clk *);
> extern void clk_pxa3xx_cken_disable(struct clk *);
> #endif
>-
>diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
>index 23136b6..f29775e 100644
>--- a/arch/arm/mach-pxa/pxa25x.c
>+++ b/arch/arm/mach-pxa/pxa25x.c
>@@ -106,8 +106,8 @@ static unsigned long clk_pxa25x_lcd_getrate(struct clk *clk)
> }
>
> static const struct clkops clk_pxa25x_lcd_ops = {
>-      .enable         = clk_cken_enable,
>-      .disable        = clk_cken_disable,
>+      .enable         = clk_pxa2xx_cken_enable,
>+      .disable        = clk_pxa2xx_cken_disable,
>       .getrate        = clk_pxa25x_lcd_getrate,
> };
>
>@@ -162,31 +162,29 @@ static const struct clkops clk_pxa25x_gpio11_ops = {
>  * 95.842MHz -> MMC 19.169MHz, I2C 31.949MHz, FICP 47.923MHz, USB 47.923MHz
>  * 147.456MHz -> UART 14.7456MHz, AC97 12.288MHz, I2S 5.672MHz (allegedly)
>  */
>-static DEFINE_CKEN(pxa25x_hwuart, HWUART, 14745600, 1);
>-
>-static struct clk_lookup pxa25x_hwuart_clkreg =
>-      INIT_CLKREG(&clk_pxa25x_hwuart, "pxa2xx-uart.3", NULL);
>
> /*
>  * PXA 2xx clock declarations.
>  */
>+static DEFINE_PXA2_CKEN(pxa25x_hwuart, HWUART, 14745600, 1);
>+static DEFINE_PXA2_CKEN(pxa25x_ffuart, FFUART, 14745600, 1);
>+static DEFINE_PXA2_CKEN(pxa25x_btuart, BTUART, 14745600, 1);
>+static DEFINE_PXA2_CKEN(pxa25x_stuart, STUART, 14745600, 1);
>+static DEFINE_PXA2_CKEN(pxa25x_usb, USB, 47923000, 5);
>+static DEFINE_PXA2_CKEN(pxa25x_mmc, MMC, 19169000, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_i2c, I2C, 31949000, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_ssp, SSP, 3686400, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_nssp, NSSP, 3686400, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_assp, ASSP, 3686400, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_pwm0, PWM0, 3686400, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_pwm1, PWM1, 3686400, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_ac97, AC97, 24576000, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_i2s, I2S, 14745600, 0);
>+static DEFINE_PXA2_CKEN(pxa25x_ficp, FICP, 47923000, 0);
>+
> static DEFINE_CK(pxa25x_lcd, LCD, &clk_pxa25x_lcd_ops);
>-static DEFINE_CKEN(pxa25x_ffuart, FFUART, 14745600, 1);
>-static DEFINE_CKEN(pxa25x_btuart, BTUART, 14745600, 1);
>-static DEFINE_CKEN(pxa25x_stuart, STUART, 14745600, 1);
>-static DEFINE_CKEN(pxa25x_usb, USB, 47923000, 5);
> static DEFINE_CLK(pxa25x_gpio11, &clk_pxa25x_gpio11_ops, 3686400, 0);
> static DEFINE_CLK(pxa25x_gpio12, &clk_pxa25x_gpio12_ops, 32768, 0);
>-static DEFINE_CKEN(pxa25x_mmc, MMC, 19169000, 0);
>-static DEFINE_CKEN(pxa25x_i2c, I2C, 31949000, 0);
>-static DEFINE_CKEN(pxa25x_ssp, SSP, 3686400, 0);
>-static DEFINE_CKEN(pxa25x_nssp, NSSP, 3686400, 0);
>-static DEFINE_CKEN(pxa25x_assp, ASSP, 3686400, 0);
>-static DEFINE_CKEN(pxa25x_pwm0, PWM0, 3686400, 0);
>-static DEFINE_CKEN(pxa25x_pwm1, PWM1, 3686400, 0);
>-static DEFINE_CKEN(pxa25x_ac97, AC97, 24576000, 0);
>-static DEFINE_CKEN(pxa25x_i2s, I2S, 14745600, 0);
>-static DEFINE_CKEN(pxa25x_ficp, FICP, 47923000, 0);
>
> static struct clk_lookup pxa25x_clkregs[] = {
>       INIT_CLKREG(&clk_pxa25x_lcd, "pxa2xx-fb", NULL),
>@@ -209,6 +207,9 @@ static struct clk_lookup pxa25x_clkregs[] = {
>       INIT_CLKREG(&clk_pxa25x_gpio12, NULL, "GPIO12_CLK"),
> };
>
>+static struct clk_lookup pxa25x_hwuart_clkreg =
>+      INIT_CLKREG(&clk_pxa25x_hwuart, "pxa2xx-uart.3", NULL);
>+
> #ifdef CONFIG_PM
>
> #define SAVE(x)               sleep_save[SLEEP_SAVE_##x] = x
>diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
>index 839548d..13242f2 100644
>--- a/arch/arm/mach-pxa/pxa27x.c
>+++ b/arch/arm/mach-pxa/pxa27x.c
>@@ -161,36 +161,37 @@ static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
> }
>
> static const struct clkops clk_pxa27x_lcd_ops = {
>-      .enable         = clk_cken_enable,
>-      .disable        = clk_cken_disable,
>+      .enable         = clk_pxa2xx_cken_enable,
>+      .disable        = clk_pxa2xx_cken_disable,
>       .getrate        = clk_pxa27x_lcd_getrate,
> };
>
>+static DEFINE_PXA2_CKEN(pxa27x_ffuart, FFUART, 14857000, 1);
>+static DEFINE_PXA2_CKEN(pxa27x_btuart, BTUART, 14857000, 1);
>+static DEFINE_PXA2_CKEN(pxa27x_stuart, STUART, 14857000, 1);
>+static DEFINE_PXA2_CKEN(pxa27x_i2s, I2S, 14682000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_i2c, I2C, 32842000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_usb, USB, 48000000, 5);
>+static DEFINE_PXA2_CKEN(pxa27x_mmc, MMC, 19500000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ficp, FICP, 48000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_usbhost, USBHOST, 48000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_pwri2c, PWRI2C, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_keypad, KEYPAD, 32768, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ssp1, SSP1, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ssp2, SSP2, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ssp3, SSP3, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_pwm0, PWM0, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_pwm1, PWM1, 13000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ac97, AC97, 24576000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_ac97conf, AC97CONF, 24576000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_msl, MSL, 48000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_usim, USIM, 48000000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_memstk, MEMSTK, 19500000, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_im, IM, 0, 0);
>+static DEFINE_PXA2_CKEN(pxa27x_memc, MEMC, 0, 0);
>+
> static DEFINE_CK(pxa27x_lcd, LCD, &clk_pxa27x_lcd_ops);
> static DEFINE_CK(pxa27x_camera, CAMERA, &clk_pxa27x_lcd_ops);
>-static DEFINE_CKEN(pxa27x_ffuart, FFUART, 14857000, 1);
>-static DEFINE_CKEN(pxa27x_btuart, BTUART, 14857000, 1);
>-static DEFINE_CKEN(pxa27x_stuart, STUART, 14857000, 1);
>-static DEFINE_CKEN(pxa27x_i2s, I2S, 14682000, 0);
>-static DEFINE_CKEN(pxa27x_i2c, I2C, 32842000, 0);
>-static DEFINE_CKEN(pxa27x_usb, USB, 48000000, 5);
>-static DEFINE_CKEN(pxa27x_mmc, MMC, 19500000, 0);
>-static DEFINE_CKEN(pxa27x_ficp, FICP, 48000000, 0);
>-static DEFINE_CKEN(pxa27x_usbhost, USBHOST, 48000000, 0);
>-static DEFINE_CKEN(pxa27x_pwri2c, PWRI2C, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_keypad, KEYPAD, 32768, 0);
>-static DEFINE_CKEN(pxa27x_ssp1, SSP1, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_ssp2, SSP2, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_ssp3, SSP3, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_pwm0, PWM0, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_pwm1, PWM1, 13000000, 0);
>-static DEFINE_CKEN(pxa27x_ac97, AC97, 24576000, 0);
>-static DEFINE_CKEN(pxa27x_ac97conf, AC97CONF, 24576000, 0);
>-static DEFINE_CKEN(pxa27x_msl, MSL, 48000000, 0);
>-static DEFINE_CKEN(pxa27x_usim, USIM, 48000000, 0);
>-static DEFINE_CKEN(pxa27x_memstk, MEMSTK, 19500000, 0);
>-static DEFINE_CKEN(pxa27x_im, IM, 0, 0);
>-static DEFINE_CKEN(pxa27x_memc, MEMC, 0, 0);
>
> static struct clk_lookup pxa27x_clkregs[] = {
>       INIT_CLKREG(&clk_pxa27x_lcd, "pxa2xx-fb", NULL),
>diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
>index a0b123c..b239c1a 100644
>--- a/arch/arm/mach-pxa/pxa3xx.c
>+++ b/arch/arm/mach-pxa/pxa3xx.c
>@@ -38,184 +38,15 @@
> #include "devices.h"
> #include "clock.h"
>
>-/* Crystal clock: 13MHz */
>-#define BASE_CLK      13000000
>-
>-/* Ring Oscillator Clock: 60MHz */
>-#define RO_CLK                60000000
>-
>-#define ACCR_D0CS     (1 << 26)
>-#define ACCR_PCCE     (1 << 11)
>-
> #define PECR_IE(n)    ((1 << ((n) * 2)) << 28)
> #define PECR_IS(n)    ((1 << ((n) * 2)) << 29)
>
>-/* crystal frequency to static memory controller multiplier (SMCFS) */
>-static unsigned char smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
>-
>-/* crystal frequency to HSIO bus frequency multiplier (HSS) */
>-static unsigned char hss_mult[4] = { 8, 12, 16, 24 };
>-
>-/*
>- * Get the clock frequency as reflected by CCSR and the turbo flag.
>- * We assume these values have been applied via a fcs.
>- * If info is not 0 we also display the current settings.
>- */
>-unsigned int pxa3xx_get_clk_frequency_khz(int info)
>-{
>-      unsigned long acsr, xclkcfg;
>-      unsigned int t, xl, xn, hss, ro, XL, XN, CLK, HSS;
>-
>-      /* Read XCLKCFG register turbo bit */
>-      __asm__ __volatile__("mrc\tp14, 0, %0, c6, c0, 0" : "=r"(xclkcfg));
>-      t = xclkcfg & 0x1;
>-
>-      acsr = ACSR;
>-
>-      xl  = acsr & 0x1f;
>-      xn  = (acsr >> 8) & 0x7;
>-      hss = (acsr >> 14) & 0x3;
>-
>-      XL = xl * BASE_CLK;
>-      XN = xn * XL;
>-
>-      ro = acsr & ACCR_D0CS;
>-
>-      CLK = (ro) ? RO_CLK : ((t) ? XN : XL);
>-      HSS = (ro) ? RO_CLK : hss_mult[hss] * BASE_CLK;
>-
>-      if (info) {
>-              pr_info("RO Mode clock: %d.%02dMHz (%sactive)\n",
>-                      RO_CLK / 1000000, (RO_CLK % 1000000) / 10000,
>-                      (ro) ? "" : "in");
>-              pr_info("Run Mode clock: %d.%02dMHz (*%d)\n",
>-                      XL / 1000000, (XL % 1000000) / 10000, xl);
>-              pr_info("Turbo Mode clock: %d.%02dMHz (*%d, %sactive)\n",
>-                      XN / 1000000, (XN % 1000000) / 10000, xn,
>-                      (t) ? "" : "in");
>-              pr_info("HSIO bus clock: %d.%02dMHz\n",
>-                      HSS / 1000000, (HSS % 1000000) / 10000);
>-      }
>-
>-      return CLK / 1000;
>-}
>-
> void pxa3xx_clear_reset_status(unsigned int mask)
> {
>       /* RESET_STATUS_* has a 1:1 mapping with ARSR */
>       ARSR = mask;
> }
>
>-/*
>- * Return the current AC97 clock frequency.
>- */
>-static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
>-{
>-      unsigned long rate = 312000000;
>-      unsigned long ac97_div;
>-
>-      ac97_div = AC97_DIV;
>-
>-      /* This may loose precision for some rates but won't for the
>-       * standard 24.576MHz.
>-       */
>-      rate /= (ac97_div >> 12) & 0x7fff;
>-      rate *= (ac97_div & 0xfff);
>-
>-      return rate;
>-}
>-
>-/*
>- * Return the current HSIO bus clock frequency
>- */
>-static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
>-{
>-      unsigned long acsr;
>-      unsigned int hss, hsio_clk;
>-
>-      acsr = ACSR;
>-
>-      hss = (acsr >> 14) & 0x3;
>-      hsio_clk = (acsr & ACCR_D0CS) ? RO_CLK : hss_mult[hss] * BASE_CLK;
>-
>-      return hsio_clk;
>-}
>-
>-void clk_pxa3xx_cken_enable(struct clk *clk)
>-{
>-      unsigned long mask = 1ul << (clk->cken & 0x1f);
>-
>-      if (clk->cken < 32)
>-              CKENA |= mask;
>-      else
>-              CKENB |= mask;
>-}
>-
>-void clk_pxa3xx_cken_disable(struct clk *clk)
>-{
>-      unsigned long mask = 1ul << (clk->cken & 0x1f);
>-
>-      if (clk->cken < 32)
>-              CKENA &= ~mask;
>-      else
>-              CKENB &= ~mask;
>-}
>-
>-const struct clkops clk_pxa3xx_cken_ops = {
>-      .enable         = clk_pxa3xx_cken_enable,
>-      .disable        = clk_pxa3xx_cken_disable,
>-};
>-
>-static const struct clkops clk_pxa3xx_hsio_ops = {
>-      .enable         = clk_pxa3xx_cken_enable,
>-      .disable        = clk_pxa3xx_cken_disable,
>-      .getrate        = clk_pxa3xx_hsio_getrate,
>-};
>-
>-static const struct clkops clk_pxa3xx_ac97_ops = {
>-      .enable         = clk_pxa3xx_cken_enable,
>-      .disable        = clk_pxa3xx_cken_disable,
>-      .getrate        = clk_pxa3xx_ac97_getrate,
>-};
>-
>-static void clk_pout_enable(struct clk *clk)
>-{
>-      OSCC |= OSCC_PEN;
>-}
>-
>-static void clk_pout_disable(struct clk *clk)
>-{
>-      OSCC &= ~OSCC_PEN;
>-}
>-
>-static const struct clkops clk_pout_ops = {
>-      .enable         = clk_pout_enable,
>-      .disable        = clk_pout_disable,
>-};
>-
>-static void clk_dummy_enable(struct clk *clk)
>-{
>-}
>-
>-static void clk_dummy_disable(struct clk *clk)
>-{
>-}
>-
>-static const struct clkops clk_dummy_ops = {
>-      .enable         = clk_dummy_enable,
>-      .disable        = clk_dummy_disable,
>-};
>-
>-static struct clk clk_pxa3xx_pout = {
>-      .ops            = &clk_pout_ops,
>-      .rate           = 13000000,
>-      .delay          = 70,
>-};
>-
>-static struct clk clk_dummy = {
>-      .ops            = &clk_dummy_ops,
>-};
>-
> static DEFINE_PXA3_CKEN(pxa3xx_ffuart, FFUART, 14857000, 1);
> static DEFINE_PXA3_CKEN(pxa3xx_btuart, BTUART, 14857000, 1);
> static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
>@@ -236,6 +67,7 @@ static DEFINE_PXA3_CKEN(pxa3xx_mmc2, MMC2, 19500000, 0);
> static DEFINE_CK(pxa3xx_lcd, LCD, &clk_pxa3xx_hsio_ops);
> static DEFINE_CK(pxa3xx_camera, CAMERA, &clk_pxa3xx_hsio_ops);
> static DEFINE_CK(pxa3xx_ac97, AC97, &clk_pxa3xx_ac97_ops);
>+static DEFINE_CLK(pxa3xx_pout, &clk_pxa3xx_pout_ops, 13000000, 70);
>
> static struct clk_lookup pxa3xx_clkregs[] = {
>       INIT_CLKREG(&clk_pxa3xx_pout, NULL, "CLK_POUT"),
>--
>1.7.1

Passed test.

Thanks
Haojian
