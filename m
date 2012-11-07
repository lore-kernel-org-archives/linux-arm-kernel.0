From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed,  7 Nov 2012 20:07:25 +0530
Subject: [PATCH] pinctrl: SPEAr: Add SoC specific gpio configuration routines
Message-ID: <440eeee0b362a9b2db3749a49c78b6aabdd5ad6a.1352298892.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Different SPEAr SoCs have different approach to configure pins as gpios. Some
configure a group of gpios with single register bit and others have one bit per
gpio pin. Only earlier one is implemented till now, this patch adds support for
later one.

Here we add callbacks to SoC specific code to configure gpios in
gpio_request_enable(). That will do additional SoC specific configuration to
enable gpio pins.

We also implement this callback for SPEAr1340 in this patch.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/pinctrl/spear/pinctrl-spear.c     | 26 ++++++++++++--------------
 drivers/pinctrl/spear/pinctrl-spear.h     | 14 ++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear1340.c | 27 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index cbca6dc..f9483ae 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -14,7 +14,6 @@
  */
 
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
@@ -29,16 +28,6 @@
 
 #define DRIVER_NAME "spear-pinmux"
 
-static inline u32 pmx_readl(struct spear_pmx *pmx, u32 reg)
-{
-	return readl_relaxed(pmx->vbase + reg);
-}
-
-static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
-{
-	writel_relaxed(val, pmx->vbase + reg);
-}
-
 static void muxregs_endisable(struct spear_pmx *pmx,
 		struct spear_muxreg *muxregs, u8 count, bool enable)
 {
@@ -316,16 +305,25 @@ static int gpio_request_endisable(struct pinctrl_dev *pctldev,
 		struct pinctrl_gpio_range *range, unsigned offset, bool enable)
 {
 	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct spear_pinctrl_machdata *machdata = pmx->machdata;
 	struct spear_gpio_pingroup *gpio_pingroup;
 
+	/*
+	 * Some SoC have configuration options applicable to group of pins,
+	 * rather than a single pin.
+	 */
 	gpio_pingroup = get_gpio_pingroup(pmx, offset);
-	if (IS_ERR(gpio_pingroup))
-		return PTR_ERR(gpio_pingroup);
-
 	if (gpio_pingroup)
 		muxregs_endisable(pmx, gpio_pingroup->muxregs,
 				gpio_pingroup->nmuxregs, enable);
 
+	/*
+	 * SoC may need some extra configurations, or configurations for single
+	 * pin
+	 */
+	if (machdata->gpio_request_endisable)
+		machdata->gpio_request_endisable(pmx, offset, enable);
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
index 94f142c..b063327 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -13,11 +13,13 @@
 #define __PINMUX_SPEAR_H__
 
 #include <linux/gpio.h>
+#include <linux/io.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/types.h>
 
 struct platform_device;
 struct device;
+struct spear_pmx;
 
 /**
  * struct spear_pmx_mode - SPEAr pmx mode
@@ -155,6 +157,8 @@ struct spear_pinctrl_machdata {
 	struct spear_pingroup **groups;
 	unsigned ngroups;
 	struct spear_gpio_pingroup *gpio_pingroups;
+	void (*gpio_request_endisable)(struct spear_pmx *pmx, int offset,
+			bool enable);
 	unsigned ngpio_pingroups;
 
 	bool modes_supported;
@@ -178,6 +182,16 @@ struct spear_pmx {
 };
 
 /* exported routines */
+static inline u32 pmx_readl(struct spear_pmx *pmx, u32 reg)
+{
+	return readl_relaxed(pmx->vbase + reg);
+}
+
+static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
+{
+	writel_relaxed(val, pmx->vbase + reg);
+}
+
 void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
 void __devinit
 pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index 0606b8c..0b4af0e 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -1971,6 +1971,32 @@ static struct spear_function *spear1340_functions[] = {
 	&sata_function,
 };
 
+static void gpio_request_endisable(struct spear_pmx *pmx, int pin,
+		bool enable)
+{
+	unsigned int regoffset, regindex, bitoffset;
+	unsigned int val;
+
+	/* pin++ as gpio configuration starts from 2nd bit of base register */
+	pin++;
+
+	regindex = pin / 32;
+	bitoffset = pin % 32;
+
+	if (regindex <= 3)
+		regoffset = PAD_FUNCTION_EN_1 + regindex * sizeof(int *);
+	else
+		regoffset = PAD_FUNCTION_EN_5 + (regindex - 4) * sizeof(int *);
+
+	val = pmx_readl(pmx, regoffset);
+	if (enable)
+		val &= ~(0x1 << bitoffset);
+	else
+		val |= 0x1 << bitoffset;
+
+	pmx_writel(pmx, val, regoffset);
+}
+
 static struct spear_pinctrl_machdata spear1340_machdata = {
 	.pins = spear1340_pins,
 	.npins = ARRAY_SIZE(spear1340_pins),
@@ -1978,6 +2004,7 @@ static struct spear_pinctrl_machdata spear1340_machdata = {
 	.ngroups = ARRAY_SIZE(spear1340_pingroups),
 	.functions = spear1340_functions,
 	.nfunctions = ARRAY_SIZE(spear1340_functions),
+	.gpio_request_endisable = gpio_request_endisable,
 	.modes_supported = false,
 };
 
-- 
1.7.12.rc2.18.g61b472e
