From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Fri, 16 Mar 2012 18:38:03 +0100
Subject: [RFC/PATCH 4/4] pxa: convert to common clock framework
Message-ID: <1331919483.31118.23.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
* moves the PXA-specific delay out of clk_enable into callbacks,
* removes the custom clk API functions which are now provided
  by the common clk framework,
* converts from struct clkops to struct clk_ops,
* removes the dummy clock enable/disable functions,
* changes clock definition macros to define the cross-linked
  struct clk / struct clk_pxa pair, and
* initializes the statically defined clocks with __clk_init

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 arch/arm/Kconfig                 |    1 +
 arch/arm/mach-pxa/clock-pxa25x.c |   30 ++++++-----
 arch/arm/mach-pxa/clock-pxa27x.c |   16 +++---
 arch/arm/mach-pxa/clock-pxa2xx.c |   26 ++++++++-
 arch/arm/mach-pxa/clock-pxa3xx.c |   49 ++++++++++++-----
 arch/arm/mach-pxa/clock.c        |   76 +-------------------------
 arch/arm/mach-pxa/clock.h        |  108 +++++++++++++++++++++++--------------
 arch/arm/mach-pxa/eseries.c      |   11 +----
 arch/arm/mach-pxa/pxa25x.c       |   22 ++++++++
 arch/arm/mach-pxa/pxa27x.c       |   30 +++++++++++
 arch/arm/mach-pxa/pxa3xx.c       |   26 +++++++++
 11 files changed, 232 insertions(+), 163 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3cc5897..ab46c97 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -684,6 +684,7 @@ config ARCH_PXA
 	select ARCH_HAS_CPUFREQ
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select COMMON_CLK
 	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
diff --git a/arch/arm/mach-pxa/clock-pxa25x.c b/arch/arm/mach-pxa/clock-pxa25x.c
index 53fd568..de2a2e7 100644
--- a/arch/arm/mach-pxa/clock-pxa25x.c
+++ b/arch/arm/mach-pxa/clock-pxa25x.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 
+#include <mach/mfp-pxa25x.h>
 #include <mach/pxa2xx-regs.h>
 
 #include "clock.h"
@@ -67,21 +68,20 @@ unsigned int pxa25x_get_clk_frequency_khz(int info)
 	return (turbo & 1) ? (N/1000) : (M/1000);
 }
 
-static unsigned long clk_pxa25x_mem_getrate(struct clk *clk)
+static unsigned long clk_pxa25x_mem_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	return L_clk_mult[(CCCR >> 0) & 0x1f] * BASE_CLK;
 }
 
-const struct clkops clk_pxa25x_mem_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-	.getrate	= clk_pxa25x_mem_getrate,
+const struct clk_ops clk_pxa25x_mem_ops = {
+	.recalc_rate	= clk_pxa25x_mem_recalc_rate,
 };
 
-const struct clkops clk_pxa25x_lcd_ops = {
+const struct clk_ops clk_pxa25x_lcd_ops = {
 	.enable		= clk_pxa2xx_cken_enable,
 	.disable	= clk_pxa2xx_cken_disable,
-	.getrate	= clk_pxa25x_mem_getrate,
+	.recalc_rate	= clk_pxa25x_mem_recalc_rate,
 };
 
 static unsigned long gpio12_config_32k[] = {
@@ -92,17 +92,19 @@ static unsigned long gpio12_config_gpio[] = {
 	GPIO12_GPIO,
 };
 
-static void clk_gpio12_enable(struct clk *clk)
+static int clk_gpio12_enable(struct clk_hw *hw)
 {
 	pxa2xx_mfp_config(gpio12_config_32k, 1);
+
+	return 0;
 }
 
-static void clk_gpio12_disable(struct clk *clk)
+static void clk_gpio12_disable(struct clk_hw *hw)
 {
 	pxa2xx_mfp_config(gpio12_config_gpio, 1);
 }
 
-const struct clkops clk_pxa25x_gpio12_ops = {
+const struct clk_ops clk_pxa25x_gpio12_ops = {
 	.enable         = clk_gpio12_enable,
 	.disable        = clk_gpio12_disable,
 };
@@ -115,17 +117,19 @@ static unsigned long gpio11_config_gpio[] = {
 	GPIO11_GPIO,
 };
 
-static void clk_gpio11_enable(struct clk *clk)
+static int clk_gpio11_enable(struct clk_hw *hw)
 {
 	pxa2xx_mfp_config(gpio11_config_3m6, 1);
+
+	return 0;
 }
 
-static void clk_gpio11_disable(struct clk *clk)
+static void clk_gpio11_disable(struct clk_hw *hw)
 {
 	pxa2xx_mfp_config(gpio11_config_gpio, 1);
 }
 
-const struct clkops clk_pxa25x_gpio11_ops = {
+const struct clk_ops clk_pxa25x_gpio11_ops = {
 	.enable         = clk_gpio11_enable,
 	.disable        = clk_gpio11_disable,
 };
diff --git a/arch/arm/mach-pxa/clock-pxa27x.c b/arch/arm/mach-pxa/clock-pxa27x.c
index 734864d..6b5ebba 100644
--- a/arch/arm/mach-pxa/clock-pxa27x.c
+++ b/arch/arm/mach-pxa/clock-pxa27x.c
@@ -63,7 +63,8 @@ unsigned int pxa27x_get_clk_frequency_khz(int info)
 /*
  * Return the current mem clock frequency as reflected by CCCR[A], B, and L
  */
-static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
+static unsigned long clk_pxa27x_mem_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	unsigned long ccsr, clkcfg;
 	unsigned int l, L, m, M;
@@ -85,10 +86,8 @@ static unsigned long clk_pxa27x_mem_getrate(struct clk *clk)
 	return M;
 }
 
-const struct clkops clk_pxa27x_mem_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
-	.getrate	= clk_pxa27x_mem_getrate,
+const struct clk_ops clk_pxa27x_mem_ops = {
+	.recalc_rate	= clk_pxa27x_mem_recalc_rate,
 };
 
 /*
@@ -110,14 +109,15 @@ static unsigned int pxa27x_get_lcdclk_frequency_10khz(void)
 	return K / 10000;
 }
 
-static unsigned long clk_pxa27x_lcd_getrate(struct clk *clk)
+static unsigned long clk_pxa27x_lcd_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	return pxa27x_get_lcdclk_frequency_10khz() * 10000;
 }
 
-const struct clkops clk_pxa27x_lcd_ops = {
+const struct clk_ops clk_pxa27x_lcd_ops = {
 	.enable		= clk_pxa2xx_cken_enable,
 	.disable	= clk_pxa2xx_cken_disable,
-	.getrate	= clk_pxa27x_lcd_getrate,
+	.recalc_rate	= clk_pxa27x_lcd_recalc_rate,
 };
 
diff --git a/arch/arm/mach-pxa/clock-pxa2xx.c b/arch/arm/mach-pxa/clock-pxa2xx.c
index 1d5859d..5ab5cb6 100644
--- a/arch/arm/mach-pxa/clock-pxa2xx.c
+++ b/arch/arm/mach-pxa/clock-pxa2xx.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -15,19 +17,37 @@
 
 #include "clock.h"
 
-void clk_pxa2xx_cken_enable(struct clk *clk)
+int clk_pxa2xx_cken_enable(struct clk_hw *hw)
 {
+	struct clk_pxa *clk = to_clk_pxa(hw);
+
 	CKEN |= 1 << clk->cken;
+
+	if (clk->delay)
+		udelay(clk->delay);
+
+	return 0;
 }
 
-void clk_pxa2xx_cken_disable(struct clk *clk)
+void clk_pxa2xx_cken_disable(struct clk_hw *hw)
 {
+	struct clk_pxa *clk = to_clk_pxa(hw);
+
 	CKEN &= ~(1 << clk->cken);
 }
 
-const struct clkops clk_pxa2xx_cken_ops = {
+static unsigned long clk_pxa2xx_cken_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	struct clk_pxa *clk = to_clk_pxa(hw);
+
+	return clk->rate;
+}
+
+const struct clk_ops clk_pxa2xx_cken_ops = {
 	.enable		= clk_pxa2xx_cken_enable,
 	.disable	= clk_pxa2xx_cken_disable,
+	.recalc_rate	= clk_pxa2xx_cken_recalc_rate,
 };
 
 #ifdef CONFIG_PM
diff --git a/arch/arm/mach-pxa/clock-pxa3xx.c b/arch/arm/mach-pxa/clock-pxa3xx.c
index 2a37a9a..93064b4 100644
--- a/arch/arm/mach-pxa/clock-pxa3xx.c
+++ b/arch/arm/mach-pxa/clock-pxa3xx.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -76,7 +78,8 @@ unsigned int pxa3xx_get_clk_frequency_khz(int info)
 /*
  * Return the current AC97 clock frequency.
  */
-static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
+static unsigned long clk_pxa3xx_ac97_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	unsigned long rate = 312000000;
 	unsigned long ac97_div;
@@ -95,7 +98,8 @@ static unsigned long clk_pxa3xx_ac97_getrate(struct clk *clk)
 /*
  * Return the current HSIO bus clock frequency
  */
-static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
+static unsigned long clk_pxa3xx_hsio_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	unsigned long acsr;
 	unsigned int hss, hsio_clk;
@@ -112,7 +116,8 @@ static unsigned long clk_pxa3xx_hsio_getrate(struct clk *clk)
 static unsigned int smcfs_mult[8] = { 6, 0, 8, 0, 0, 16, };
 static unsigned int df_clkdiv[4] = { 1, 2, 4, 1 };
 
-static unsigned long clk_pxa3xx_smemc_getrate(struct clk *clk)
+static unsigned long clk_pxa3xx_smemc_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
 {
 	unsigned long acsr = ACSR;
 	unsigned long memclkcfg = __raw_readl(MEMCLKCFG);
@@ -121,18 +126,25 @@ static unsigned long clk_pxa3xx_smemc_getrate(struct clk *clk)
 			df_clkdiv[(memclkcfg >> 16) & 0x3];
 }
 
-void clk_pxa3xx_cken_enable(struct clk *clk)
+int clk_pxa3xx_cken_enable(struct clk_hw *hw)
 {
+	struct clk_pxa *clk = to_clk_pxa(hw);
 	unsigned long mask = 1ul << (clk->cken & 0x1f);
 
 	if (clk->cken < 32)
 		CKENA |= mask;
 	else
 		CKENB |= mask;
+
+	if (clk->delay)
+		udelay(clk->delay);
+
+	return 0;
 }
 
-void clk_pxa3xx_cken_disable(struct clk *clk)
+void clk_pxa3xx_cken_disable(struct clk_hw *hw)
 {
+	struct clk_pxa *clk = to_clk_pxa(hw);
 	unsigned long mask = 1ul << (clk->cken & 0x1f);
 
 	if (clk->cken < 32)
@@ -141,40 +153,47 @@ void clk_pxa3xx_cken_disable(struct clk *clk)
 		CKENB &= ~mask;
 }
 
-const struct clkops clk_pxa3xx_cken_ops = {
+const struct clk_ops clk_pxa3xx_cken_ops = {
 	.enable		= clk_pxa3xx_cken_enable,
 	.disable	= clk_pxa3xx_cken_disable,
 };
 
-const struct clkops clk_pxa3xx_hsio_ops = {
+const struct clk_ops clk_pxa3xx_hsio_ops = {
 	.enable		= clk_pxa3xx_cken_enable,
 	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_hsio_getrate,
+	.recalc_rate	= clk_pxa3xx_hsio_recalc_rate,
 };
 
-const struct clkops clk_pxa3xx_ac97_ops = {
+const struct clk_ops clk_pxa3xx_ac97_ops = {
 	.enable		= clk_pxa3xx_cken_enable,
 	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_ac97_getrate,
+	.recalc_rate	= clk_pxa3xx_ac97_recalc_rate,
 };
 
-const struct clkops clk_pxa3xx_smemc_ops = {
+const struct clk_ops clk_pxa3xx_smemc_ops = {
 	.enable		= clk_pxa3xx_cken_enable,
 	.disable	= clk_pxa3xx_cken_disable,
-	.getrate	= clk_pxa3xx_smemc_getrate,
+	.recalc_rate	= clk_pxa3xx_smemc_recalc_rate,
 };
 
-static void clk_pout_enable(struct clk *clk)
+static int clk_pout_enable(struct clk_hw *hw)
 {
+	struct clk_pxa *clk = to_clk_pxa(hw);
+
 	OSCC |= OSCC_PEN;
+
+	if (clk->delay)
+		udelay(clk->delay);
+
+	return 0;
 }
 
-static void clk_pout_disable(struct clk *clk)
+static void clk_pout_disable(struct clk_hw *hw)
 {
 	OSCC &= ~OSCC_PEN;
 }
 
-const struct clkops clk_pxa3xx_pout_ops = {
+const struct clk_ops clk_pxa3xx_pout_ops = {
 	.enable		= clk_pout_enable,
 	.disable	= clk_pout_disable,
 };
diff --git a/arch/arm/mach-pxa/clock.c b/arch/arm/mach-pxa/clock.c
index 4d46610..d5d5876 100644
--- a/arch/arm/mach-pxa/clock.c
+++ b/arch/arm/mach-pxa/clock.c
@@ -3,82 +3,12 @@
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
-#include <linux/clk.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/clk-private.h>
 
 #include "clock.h"
 
-static DEFINE_SPINLOCK(clocks_lock);
-
-int clk_enable(struct clk *clk)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (clk->enabled++ == 0)
-		clk->ops->enable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-
-	if (clk->delay)
-		udelay(clk->delay);
-
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-	unsigned long flags;
-
-	WARN_ON(clk->enabled == 0);
-
-	spin_lock_irqsave(&clocks_lock, flags);
-	if (--clk->enabled == 0)
-		clk->ops->disable(clk);
-	spin_unlock_irqrestore(&clocks_lock, flags);
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	unsigned long rate;
-
-	rate = clk->rate;
-	if (clk->ops->getrate)
-		rate = clk->ops->getrate(clk);
-
-	return rate;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	unsigned long flags;
-	int ret = -EINVAL;
-
-	if (clk->ops->setrate) {
-		spin_lock_irqsave(&clocks_lock, flags);
-		ret = clk->ops->setrate(clk, rate);
-		spin_unlock_irqrestore(&clocks_lock, flags);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(clk_set_rate);
-
-void clk_dummy_enable(struct clk *clk)
-{
-}
-
-void clk_dummy_disable(struct clk *clk)
-{
-}
-
-const struct clkops clk_dummy_ops = {
-	.enable		= clk_dummy_enable,
-	.disable	= clk_dummy_disable,
+const struct clk_ops clk_dummy_ops = {
 };
 
 struct clk clk_dummy = {
diff --git a/arch/arm/mach-pxa/clock.h b/arch/arm/mach-pxa/clock.h
index a3585a2..7c04f9b 100644
--- a/arch/arm/mach-pxa/clock.h
+++ b/arch/arm/mach-pxa/clock.h
@@ -1,80 +1,106 @@
 #include <linux/clkdev.h>
+#include <linux/clk-private.h>
+#include <linux/clk-provider.h>
 #include <linux/syscore_ops.h>
 
-struct clkops {
-	void			(*enable)(struct clk *);
-	void			(*disable)(struct clk *);
-	unsigned long		(*getrate)(struct clk *);
-	int			(*setrate)(struct clk *, unsigned long);
-};
+#define to_clk_pxa(_hw) container_of(_hw, struct clk_pxa, hw)
 
-struct clk {
-	const struct clkops	*ops;
-	unsigned long		rate;
+struct clk_pxa {
+	struct clk_hw		hw;
 	unsigned int		cken;
 	unsigned int		delay;
-	unsigned int		enabled;
+	unsigned long		rate;
 };
 
-void clk_dummy_enable(struct clk *);
-void clk_dummy_disable(struct clk *);
-
-extern const struct clkops clk_dummy_ops;
+extern const struct clk_ops clk_dummy_ops;
 extern struct clk clk_dummy;
 
 #define DEFINE_CK(_name, _cken, _ops)			\
-struct clk clk_##_name = {				\
-		.ops	= _ops,				\
+	struct clk clk_##_name;				\
+	static struct clk_pxa clk_pxa_##_name = {	\
+		.hw = {					\
+			.clk = &clk_##_name,		\
+		},					\
 		.cken	= CKEN_##_cken,			\
+	};						\
+	static struct clk clk_##_name = {		\
+		.name   = #_name,			\
+		.ops	= _ops,				\
+		.hw	= &clk_pxa_##_name.hw,		\
 	}
 
 #define DEFINE_CLK(_name, _ops, _rate, _delay)		\
-struct clk clk_##_name = {				\
-		.ops	= _ops, 			\
-		.rate	= _rate,			\
+	struct clk clk_##_name;				\
+	static struct clk_pxa clk_pxa_##_name = {	\
+		.hw = {					\
+			.clk = &clk_##_name,		\
+		},					\
 		.delay	= _delay,			\
+		.rate	= _rate,			\
+	};						\
+	static struct clk clk_##_name = {		\
+		.name   = #_name,			\
+		.ops	= _ops,				\
+		.hw	= &clk_pxa_##_name.hw,		\
 	}
 
 #define DEFINE_PXA2_CKEN(_name, _cken, _rate, _delay)	\
-struct clk clk_##_name = {				\
-		.ops	= &clk_pxa2xx_cken_ops,		\
-		.rate	= _rate,			\
+	struct clk clk_##_name;				\
+	static struct clk_pxa clk_pxa_##_name = {	\
+		.hw = {					\
+			.clk = &clk_##_name,		\
+		},					\
 		.cken	= CKEN_##_cken,			\
 		.delay	= _delay,			\
+		.rate	= _rate,			\
+	};						\
+	static struct clk clk_##_name = {		\
+		.name   = #_name,			\
+		.ops	= &clk_pxa2xx_cken_ops,		\
+		.hw	= &clk_pxa_##_name.hw,		\
 	}
 
-extern const struct clkops clk_pxa2xx_cken_ops;
+extern const struct clk_ops clk_pxa2xx_cken_ops;
+
+extern const struct clk_ops clk_pxa25x_mem_ops;
+extern const struct clk_ops clk_pxa25x_lcd_ops;
+extern const struct clk_ops clk_pxa25x_gpio12_ops;
+extern const struct clk_ops clk_pxa25x_gpio11_ops;
 
-extern const struct clkops clk_pxa25x_mem_ops;
-extern const struct clkops clk_pxa25x_lcd_ops;
-extern const struct clkops clk_pxa25x_gpio12_ops;
-extern const struct clkops clk_pxa25x_gpio11_ops;
+extern const struct clk_ops clk_pxa27x_mem_ops;
+extern const struct clk_ops clk_pxa27x_lcd_ops;
 
-extern const struct clkops clk_pxa27x_mem_ops;
-extern const struct clkops clk_pxa27x_lcd_ops;
+int clk_pxa2xx_cken_enable(struct clk_hw *hw);
+void clk_pxa2xx_cken_disable(struct clk_hw *hw);
 
-void clk_pxa2xx_cken_enable(struct clk *clk);
-void clk_pxa2xx_cken_disable(struct clk *clk);
 
 extern struct syscore_ops pxa2xx_clock_syscore_ops;
 
 #if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA95x)
 #define DEFINE_PXA3_CKEN(_name, _cken, _rate, _delay)	\
-struct clk clk_##_name = {				\
-		.ops	= &clk_pxa3xx_cken_ops,		\
-		.rate	= _rate,			\
+	struct clk clk_##_name;				\
+	static struct clk_pxa clk_pxa_##_name = {	\
+		.hw = {					\
+			.clk = &clk_##_name,		\
+		},					\
 		.cken	= CKEN_##_cken,			\
 		.delay	= _delay,			\
+		.rate	= _rate,			\
+	};						\
+	static struct clk clk_##_name = {		\
+		.name   = #_name,			\
+		.ops	= &clk_pxa3xx_cken_ops,		\
+		.hw	= &clk_pxa_##_name.hw,		\
 	}
 
-extern const struct clkops clk_pxa3xx_cken_ops;
-extern const struct clkops clk_pxa3xx_hsio_ops;
-extern const struct clkops clk_pxa3xx_ac97_ops;
-extern const struct clkops clk_pxa3xx_pout_ops;
-extern const struct clkops clk_pxa3xx_smemc_ops;
+extern const struct clk_ops clk_pxa3xx_cken_ops;
+extern const struct clk_ops clk_pxa3xx_hsio_ops;
+extern const struct clk_ops clk_pxa3xx_ac97_ops;
+extern const struct clk_ops clk_pxa3xx_pout_ops;
+extern const struct clk_ops clk_pxa3xx_smemc_ops;
 
-extern void clk_pxa3xx_cken_enable(struct clk *);
-extern void clk_pxa3xx_cken_disable(struct clk *);
+extern int clk_pxa3xx_cken_enable(struct clk_hw *);
+extern void clk_pxa3xx_cken_disable(struct clk_hw *);
 
 extern struct syscore_ops pxa3xx_clock_syscore_ops;
 
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index 3c29343..9214e03 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -126,17 +126,8 @@ struct resource eseries_tmio_resources[] = {
 };
 
 /* Some e-series hardware cannot control the 32K clock */
-static void clk_32k_dummy(struct clk *clk)
-{
-}
-
-static const struct clkops clk_32k_dummy_ops = {
-	.enable         = clk_32k_dummy,
-	.disable        = clk_32k_dummy,
-};
-
 static struct clk tmio_dummy_clk = {
-	.ops	= &clk_32k_dummy_ops,
+	.ops	= &clk_dummy_ops,
 	.rate	= 32768,
 };
 
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index 2c2eb41..a5a42bc 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -16,6 +16,7 @@
  * initialization stuff for PXA machines which can be overridden later if
  * need be.
  */
+#include <linux/clk-private.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/module.h>
@@ -241,6 +242,27 @@ static int __init pxa25x_init(void)
 
 		reset_status = RCSR;
 
+		__clk_init(NULL, &clk_pxa25x_hwuart);
+		__clk_init(NULL, &clk_pxa25x_ffuart);
+		__clk_init(NULL, &clk_pxa25x_btuart);
+		__clk_init(NULL, &clk_pxa25x_stuart);
+		__clk_init(NULL, &clk_pxa25x_usb);
+		__clk_init(NULL, &clk_pxa25x_mmc);
+		__clk_init(NULL, &clk_pxa25x_i2c);
+		__clk_init(NULL, &clk_pxa25x_ssp);
+		__clk_init(NULL, &clk_pxa25x_nssp);
+		__clk_init(NULL, &clk_pxa25x_assp);
+		__clk_init(NULL, &clk_pxa25x_pwm0);
+		__clk_init(NULL, &clk_pxa25x_pwm1);
+		__clk_init(NULL, &clk_pxa25x_ac97);
+		__clk_init(NULL, &clk_pxa25x_i2s);
+		__clk_init(NULL, &clk_pxa25x_ficp);
+
+		__clk_init(NULL, &clk_pxa25x_lcd);
+		__clk_init(NULL, &clk_pxa25x_gpio11);
+		__clk_init(NULL, &clk_pxa25x_gpio12);
+		__clk_init(NULL, &clk_pxa25x_mem);
+
 		clkdev_add_table(pxa25x_clkregs, ARRAY_SIZE(pxa25x_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 16)))
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index b9dc6ac..8f98413 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -11,6 +11,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clk-private.h>
 #include <linux/gpio.h>
 #include <linux/gpio-pxa.h>
 #include <linux/module.h>
@@ -339,6 +340,35 @@ static int __init pxa27x_init(void)
 
 		reset_status = RCSR;
 
+		__clk_init(NULL, &clk_pxa27x_ffuart);
+		__clk_init(NULL, &clk_pxa27x_btuart);
+		__clk_init(NULL, &clk_pxa27x_stuart);
+		__clk_init(NULL, &clk_pxa27x_i2s);
+		__clk_init(NULL, &clk_pxa27x_i2c);
+		__clk_init(NULL, &clk_pxa27x_usb);
+		__clk_init(NULL, &clk_pxa27x_mmc);
+		__clk_init(NULL, &clk_pxa27x_ficp);
+		__clk_init(NULL, &clk_pxa27x_usbhost);
+		__clk_init(NULL, &clk_pxa27x_pwri2c);
+		__clk_init(NULL, &clk_pxa27x_keypad);
+		__clk_init(NULL, &clk_pxa27x_ssp1);
+		__clk_init(NULL, &clk_pxa27x_ssp2);
+		__clk_init(NULL, &clk_pxa27x_ssp3);
+		__clk_init(NULL, &clk_pxa27x_pwm0);
+		__clk_init(NULL, &clk_pxa27x_pwm1);
+		__clk_init(NULL, &clk_pxa27x_ac97);
+		__clk_init(NULL, &clk_pxa27x_ac97conf);
+		__clk_init(NULL, &clk_pxa27x_msl);
+		__clk_init(NULL, &clk_pxa27x_usim);
+		__clk_init(NULL, &clk_pxa27x_memstk);
+		__clk_init(NULL, &clk_pxa27x_im);
+		__clk_init(NULL, &clk_pxa27x_memc);
+
+		__clk_init(NULL, &clk_pxa27x_lcd);
+		__clk_init(NULL, &clk_pxa27x_camera);
+		__clk_init(NULL, &clk_pxa27x_mem);
+		__clk_init(NULL, &clk_dummy);
+
 		clkdev_add_table(pxa27x_clkregs, ARRAY_SIZE(pxa27x_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 25a093e..de6c85c 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -12,6 +12,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#include <linux/clkdev.h>
+#include <linux/clk-private.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -453,6 +455,30 @@ static int __init pxa3xx_init(void)
 		 */
 		ASCR &= ~(ASCR_RDH | ASCR_D1S | ASCR_D2S | ASCR_D3S);
 
+		__clk_init(NULL, &clk_pxa3xx_pout);
+		__clk_init(NULL, &clk_dummy);
+		__clk_init(NULL, &clk_pxa3xx_lcd);
+		__clk_init(NULL, &clk_pxa3xx_camera);
+		__clk_init(NULL, &clk_pxa3xx_ac97);
+		__clk_init(NULL, &clk_pxa3xx_ffuart);
+		__clk_init(NULL, &clk_pxa3xx_btuart);
+		__clk_init(NULL, &clk_pxa3xx_stuart);
+		__clk_init(NULL, &clk_pxa3xx_i2c);
+		__clk_init(NULL, &clk_pxa3xx_udc);
+		__clk_init(NULL, &clk_pxa3xx_usbh);
+		__clk_init(NULL, &clk_pxa3xx_u2d);
+		__clk_init(NULL, &clk_pxa3xx_keypad);
+		__clk_init(NULL, &clk_pxa3xx_ssp1);
+		__clk_init(NULL, &clk_pxa3xx_ssp2);
+		__clk_init(NULL, &clk_pxa3xx_ssp3);
+		__clk_init(NULL, &clk_pxa3xx_ssp4);
+		__clk_init(NULL, &clk_pxa3xx_pwm0);
+		__clk_init(NULL, &clk_pxa3xx_pwm1);
+		__clk_init(NULL, &clk_pxa3xx_mmc1);
+		__clk_init(NULL, &clk_pxa3xx_mmc2);
+		__clk_init(NULL, &clk_pxa3xx_smemc);
+		__clk_init(NULL, &clk_pxa3xx_gpio);
+
 		clkdev_add_table(pxa3xx_clkregs, ARRAY_SIZE(pxa3xx_clkregs));
 
 		if ((ret = pxa_init_dma(IRQ_DMA, 32)))
-- 
1.7.9.1
