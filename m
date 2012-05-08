From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 8 May 2012 09:10:28 +0530
Subject: [PATCH V3 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <cover.1336448307.git.viresh.kumar@st.com>
References: <cover.1336448307.git.viresh.kumar@st.com>
Message-ID: <740ff213663bd3cba54f89c3ce54acd2631cf73e.1336448307.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of SPEAr SoCs, which support pinctrl, can configure & use pads as gpio.
This patch gpio enable support for SPEAr pinctrl drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/spear/Kconfig             |    4 +
 drivers/pinctrl/spear/pinctrl-spear.c     |  110 ++++++++++++++++--
 drivers/pinctrl/spear/pinctrl-spear.h     |   26 ++++
 drivers/pinctrl/spear/pinctrl-spear1310.c |  180 +++++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear1340.c |    8 ++
 drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c  |   29 +++++
 9 files changed, 351 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/spear/Kconfig b/drivers/pinctrl/spear/Kconfig
index 6f9a1e8..04d93e6 100644
--- a/drivers/pinctrl/spear/Kconfig
+++ b/drivers/pinctrl/spear/Kconfig
@@ -25,21 +25,25 @@ config PINCTRL_SPEAR310
 	bool "ST Microelectronics SPEAr310 SoC pin controller driver"
 	depends on MACH_SPEAR310
 	select PINCTRL_SPEAR3XX
+	select PINCTRL_SPEAR_PLGPIO
 
 config PINCTRL_SPEAR320
 	bool "ST Microelectronics SPEAr320 SoC pin controller driver"
 	depends on MACH_SPEAR320
 	select PINCTRL_SPEAR3XX
+	select PINCTRL_SPEAR_PLGPIO
 
 config PINCTRL_SPEAR1310
 	bool "ST Microelectronics SPEAr1310 SoC pin controller driver"
 	depends on MACH_SPEAR1310
 	select PINCTRL_SPEAR
+	select PINCTRL_SPEAR_PLGPIO
 
 config PINCTRL_SPEAR1340
 	bool "ST Microelectronics SPEAr1340 SoC pin controller driver"
 	depends on MACH_SPEAR1340
 	select PINCTRL_SPEAR
+	select PINCTRL_SPEAR_PLGPIO
 
 config PINCTRL_SPEAR_PLGPIO
 	bool "SPEAr SoC PLGPIO Controller"
diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
index 8653569..c0c3b28 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.c
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -38,6 +39,23 @@ static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
 	writel_relaxed(val, pmx->vbase + reg);
 }
 
+static void muxreg_endisable(struct spear_pmx *pmx, struct spear_muxreg *muxreg,
+		bool enable)
+{
+	u32 val, temp;
+
+	val = pmx_readl(pmx, muxreg->reg);
+	val &= ~muxreg->mask;
+
+	if (enable)
+		temp = muxreg->val;
+	else
+		temp = ~muxreg->val;
+
+	val |= muxreg->mask & temp;
+	pmx_writel(pmx, val, muxreg->reg);
+}
+
 static int set_mode(struct spear_pmx *pmx, int mode)
 {
 	struct spear_pmx_mode *pmx_mode = NULL;
@@ -70,6 +88,16 @@ static int set_mode(struct spear_pmx *pmx, int mode)
 	return 0;
 }
 
+void __devinit
+pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
+		unsigned count, u16 reg)
+{
+	int i = 0;
+
+	for (; i < count; i++)
+		gpio_pingroup[i].muxreg.reg = reg;
+}
+
 void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg)
 {
 	struct spear_pingroup *pgroup;
@@ -217,7 +245,6 @@ static int spear_pinctrl_endisable(struct pinctrl_dev *pctldev,
 	const struct spear_pingroup *pgroup;
 	const struct spear_modemux *modemux;
 	struct spear_muxreg *muxreg;
-	u32 val, temp;
 	int i, j;
 	bool found = false;
 
@@ -235,17 +262,7 @@ static int spear_pinctrl_endisable(struct pinctrl_dev *pctldev,
 		found = true;
 		for (j = 0; j < modemux->nmuxregs; j++) {
 			muxreg = &modemux->muxregs[j];
-
-			val = pmx_readl(pmx, muxreg->reg);
-			val &= ~muxreg->mask;
-
-			if (enable)
-				temp = muxreg->val;
-			else
-				temp = ~muxreg->val;
-
-			val |= muxreg->mask & temp;
-			pmx_writel(pmx, val, muxreg->reg);
+			muxreg_endisable(pmx, muxreg, enable);
 		}
 	}
 
@@ -270,12 +287,68 @@ static void spear_pinctrl_disable(struct pinctrl_dev *pctldev,
 	spear_pinctrl_endisable(pctldev, function, group, false);
 }
 
+/* gpio with pinmux */
+static struct spear_gpio_pingroup *get_gpio_pingroup(struct spear_pmx *pmx,
+		unsigned pin)
+{
+	struct spear_gpio_pingroup *gpio_pingroup;
+	int i = 0, j;
+
+	if (!pmx->machdata->gpio_pingroups)
+		return NULL;
+
+	for (; i < pmx->machdata->ngpio_pingroups; i++) {
+		gpio_pingroup = &pmx->machdata->gpio_pingroups[i];
+
+		for (j = 0; j < gpio_pingroup->npins; j++) {
+			if (gpio_pingroup->pins[j] == pin)
+				return gpio_pingroup;
+		}
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static int gpio_request_endisable(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range, unsigned offset, bool enable)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct spear_gpio_pingroup *gpio_pingroup;
+
+	gpio_pingroup = get_gpio_pingroup(pmx, offset);
+	if (IS_ERR(gpio_pingroup))
+		return PTR_ERR(gpio_pingroup);
+
+	if (gpio_pingroup) {
+		struct spear_muxreg *muxreg;
+
+		muxreg = &gpio_pingroup->muxreg;
+		muxreg_endisable(pmx, muxreg, enable);
+	}
+
+	return 0;
+}
+
+static int gpio_request_enable(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range, unsigned offset)
+{
+	return gpio_request_endisable(pctldev, range, offset, true);
+}
+
+static void gpio_disable_free(struct pinctrl_dev *pctldev,
+		struct pinctrl_gpio_range *range, unsigned offset)
+{
+	gpio_request_endisable(pctldev, range, offset, false);
+}
+
 static struct pinmux_ops spear_pinmux_ops = {
 	.get_functions_count = spear_pinctrl_get_funcs_count,
 	.get_function_name = spear_pinctrl_get_func_name,
 	.get_function_groups = spear_pinctrl_get_func_groups,
 	.enable = spear_pinctrl_enable,
 	.disable = spear_pinctrl_disable,
+	.gpio_request_enable = gpio_request_enable,
+	.gpio_disable_free = gpio_disable_free,
 };
 
 static struct pinctrl_desc spear_pinctrl_desc = {
@@ -291,6 +364,7 @@ int __devinit spear_pinctrl_probe(struct platform_device *pdev,
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *res;
 	struct spear_pmx *pmx;
+	struct gpio_chip *gc;
 
 	if (!machdata)
 		return -ENODEV;
@@ -341,6 +415,18 @@ int __devinit spear_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pmx->pctl);
 	}
 
+	gc = of_get_gpio_chip_by_phandle(np);
+	if (!gc) {
+		dev_err(&pdev->dev, "Couldn't find gpiochip, no gpio ranges registered\n");
+		return 0;
+	}
+
+	dev_info(&pdev->dev, "gpiochip bound with pinctrl is %s with base %d\n",
+			dev_name(gc->dev), gc->base);
+
+	machdata->ranges->base = gc->base;
+	pinctrl_add_gpio_range(pmx->pctl, machdata->ranges);
+
 	return 0;
 }
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
index 9155783..11d23ad 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -46,6 +46,23 @@ struct spear_muxreg {
 	u32 val;
 };
 
+struct spear_gpio_pingroup {
+	const unsigned *pins;
+	unsigned npins;
+	struct spear_muxreg muxreg;
+};
+
+#define GPIO_PINGROUP(__pins, __reg, __mask, __set_to_enb)	\
+	{							\
+		.pins = __pins,					\
+		.npins = ARRAY_SIZE(__pins),			\
+		.muxreg = {					\
+			.reg = __reg,				\
+			.mask = __mask,				\
+			.val = __set_to_enb ? __mask : 0,	\
+		},						\
+	}
+
 /**
  * struct spear_modemux - SPEAr mode mux configuration
  * @modes: mode ids supported by this group of muxregs
@@ -100,6 +117,9 @@ struct spear_function {
  * @nfunctions: The numbmer of entries in @functions.
  * @groups: An array describing all pin groups the pin SoC supports.
  * @ngroups: The numbmer of entries in @groups.
+ * @ranges: PLGPIO ranges for the machine
+ * @gpio_pingroups: gpio pingroups
+ * @ngpio_pingroups: gpio pingroups count
  *
  * @modes_supported: Does SoC support modes
  * @mode: mode configured from probe
@@ -113,6 +133,9 @@ struct spear_pinctrl_machdata {
 	unsigned nfunctions;
 	struct spear_pingroup **groups;
 	unsigned ngroups;
+	struct pinctrl_gpio_range *ranges;
+	struct spear_gpio_pingroup *gpio_pingroups;
+	unsigned ngpio_pingroups;
 
 	bool modes_supported;
 	u16 mode;
@@ -136,6 +159,9 @@ struct spear_pmx {
 
 /* exported routines */
 void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
+void __devinit
+pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
+		unsigned count, u16 reg);
 int __devinit spear_pinctrl_probe(struct platform_device *pdev,
 		struct spear_pinctrl_machdata *machdata);
 int __devexit spear_pinctrl_remove(struct platform_device *pdev);
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index fff168b..1ae9842 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2143,6 +2143,183 @@ static struct spear_function *spear1310_functions[] = {
 	&gpt64_function,
 };
 
+static struct pinctrl_gpio_range spear1310_plgpio_range = {
+	.name		= "SPEAr1310 PLGPIO",
+	.id		= 0,
+	.pin_base	= 0,
+	.npins		= ARRAY_SIZE(spear1310_pins),
+};
+
+static const unsigned pin18[] = { 18, };
+static const unsigned pin19[] = { 19, };
+static const unsigned pin20[] = { 20, };
+static const unsigned pin21[] = { 21, };
+static const unsigned pin22[] = { 22, };
+static const unsigned pin23[] = { 23, };
+static const unsigned pin54[] = { 54, };
+static const unsigned pin55[] = { 55, };
+static const unsigned pin56[] = { 56, };
+static const unsigned pin57[] = { 57, };
+static const unsigned pin58[] = { 58, };
+static const unsigned pin59[] = { 59, };
+static const unsigned pin60[] = { 60, };
+static const unsigned pin61[] = { 61, };
+static const unsigned pin62[] = { 62, };
+static const unsigned pin63[] = { 63, };
+static const unsigned pin143[] = { 143, };
+static const unsigned pin144[] = { 144, };
+static const unsigned pin145[] = { 145, };
+static const unsigned pin146[] = { 146, };
+static const unsigned pin147[] = { 147, };
+static const unsigned pin148[] = { 148, };
+static const unsigned pin149[] = { 149, };
+static const unsigned pin150[] = { 150, };
+static const unsigned pin151[] = { 151, };
+static const unsigned pin152[] = { 152, };
+static const unsigned pin205[] = { 205, };
+static const unsigned pin206[] = { 206, };
+static const unsigned pin211[] = { 211, };
+static const unsigned pin212[] = { 212, };
+static const unsigned pin213[] = { 213, };
+static const unsigned pin214[] = { 214, };
+static const unsigned pin215[] = { 215, };
+static const unsigned pin216[] = { 216, };
+static const unsigned pin217[] = { 217, };
+static const unsigned pin218[] = { 218, };
+static const unsigned pin219[] = { 219, };
+static const unsigned pin220[] = { 220, };
+static const unsigned pin221[] = { 221, };
+static const unsigned pin222[] = { 222, };
+static const unsigned pin223[] = { 223, };
+static const unsigned pin224[] = { 224, };
+static const unsigned pin225[] = { 225, };
+static const unsigned pin226[] = { 226, };
+static const unsigned pin227[] = { 227, };
+static const unsigned pin228[] = { 228, };
+static const unsigned pin229[] = { 229, };
+static const unsigned pin230[] = { 230, };
+static const unsigned pin231[] = { 231, };
+static const unsigned pin232[] = { 232, };
+static const unsigned pin233[] = { 233, };
+static const unsigned pin234[] = { 234, };
+static const unsigned pin235[] = { 235, };
+static const unsigned pin236[] = { 236, };
+static const unsigned pin237[] = { 237, };
+static const unsigned pin238[] = { 238, };
+static const unsigned pin239[] = { 239, };
+static const unsigned pin240[] = { 240, };
+static const unsigned pin241[] = { 241, };
+static const unsigned pin242[] = { 242, };
+static const unsigned pin243[] = { 243, };
+static const unsigned pin244[] = { 244, };
+static const unsigned pin245[] = { 245, };
+
+static const unsigned pin_grp0[] = { 173, 174, };
+static const unsigned pin_grp1[] = { 175, 185, 188, 197, 198, };
+static const unsigned pin_grp2[] = { 176, 177, 178, 179, 184, 186, 187, 189,
+	190, 191, 192, };
+static const unsigned pin_grp3[] = { 180, 181, 182, 183, 193, 194, 195, 196, };
+static const unsigned pin_grp4[] = { 199, 200, };
+static const unsigned pin_grp5[] = { 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
+	75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, };
+static const unsigned pin_grp6[] = { 86, 87, 88, 89, 90, 91, 92, 93, };
+static const unsigned pin_grp7[] = { 98, 99, };
+static const unsigned pin_grp8[] = { 158, 159, 160, 161, 162, 163, 164, 165,
+	166, 167, 168, 169, 170, 171, 172, };
+
+static struct spear_gpio_pingroup spear1310_gpio_pingroup[] = {
+	GPIO_PINGROUP(i2c0_pins, PAD_FUNCTION_EN_0, PMX_I2C0_MASK, 0),
+	GPIO_PINGROUP(ssp0_pins, PAD_FUNCTION_EN_0, PMX_SSP0_MASK, 0),
+	GPIO_PINGROUP(ssp0_cs0_pins, PAD_FUNCTION_EN_2, PMX_SSP0_CS0_MASK, 0),
+	GPIO_PINGROUP(ssp0_cs1_2_pins, PAD_FUNCTION_EN_2, PMX_SSP0_CS1_2_MASK, 0),
+	GPIO_PINGROUP(i2s0_pins, PAD_FUNCTION_EN_0, PMX_I2S0_MASK, 0),
+	GPIO_PINGROUP(i2s1_pins, PAD_FUNCTION_EN_1, PMX_I2S1_MASK, 0),
+	GPIO_PINGROUP(clcd_pins, PAD_FUNCTION_EN_0, PMX_CLCD1_MASK, 0),
+	GPIO_PINGROUP(clcd_high_res_pins, PAD_FUNCTION_EN_1, PMX_CLCD2_MASK, 0),
+	GPIO_PINGROUP(pin18, PAD_FUNCTION_EN_0, PMX_EGPIO15_MASK, 0),
+	GPIO_PINGROUP(pin19, PAD_FUNCTION_EN_0, PMX_EGPIO14_MASK, 0),
+	GPIO_PINGROUP(pin20, PAD_FUNCTION_EN_0, PMX_EGPIO13_MASK, 0),
+	GPIO_PINGROUP(pin21, PAD_FUNCTION_EN_0, PMX_EGPIO12_MASK, 0),
+	GPIO_PINGROUP(pin22, PAD_FUNCTION_EN_0, PMX_EGPIO11_MASK, 0),
+	GPIO_PINGROUP(pin23, PAD_FUNCTION_EN_0, PMX_EGPIO10_MASK, 0),
+	GPIO_PINGROUP(pin143, PAD_FUNCTION_EN_0, PMX_EGPIO00_MASK, 0),
+	GPIO_PINGROUP(pin144, PAD_FUNCTION_EN_0, PMX_EGPIO01_MASK, 0),
+	GPIO_PINGROUP(pin145, PAD_FUNCTION_EN_0, PMX_EGPIO02_MASK, 0),
+	GPIO_PINGROUP(pin146, PAD_FUNCTION_EN_0, PMX_EGPIO03_MASK, 0),
+	GPIO_PINGROUP(pin147, PAD_FUNCTION_EN_0, PMX_EGPIO04_MASK, 0),
+	GPIO_PINGROUP(pin148, PAD_FUNCTION_EN_0, PMX_EGPIO05_MASK, 0),
+	GPIO_PINGROUP(pin149, PAD_FUNCTION_EN_0, PMX_EGPIO06_MASK, 0),
+	GPIO_PINGROUP(pin150, PAD_FUNCTION_EN_0, PMX_EGPIO07_MASK, 0),
+	GPIO_PINGROUP(pin151, PAD_FUNCTION_EN_0, PMX_EGPIO08_MASK, 0),
+	GPIO_PINGROUP(pin152, PAD_FUNCTION_EN_0, PMX_EGPIO09_MASK, 0),
+	GPIO_PINGROUP(smi_2_chips_pins, PAD_FUNCTION_EN_0, PMX_SMI_MASK, 0),
+	GPIO_PINGROUP(pin54, PAD_FUNCTION_EN_1, PMX_SMINCS3_MASK, 0),
+	GPIO_PINGROUP(pin55, PAD_FUNCTION_EN_1, PMX_SMINCS2_MASK, 0),
+	GPIO_PINGROUP(pin56, PAD_FUNCTION_EN_1, PMX_NFRSTPWDWN3_MASK, 0),
+	GPIO_PINGROUP(pin57, PAD_FUNCTION_EN_0, PMX_NFRSTPWDWN2_MASK, 0),
+	GPIO_PINGROUP(pin58, PAD_FUNCTION_EN_0, PMX_NFRSTPWDWN1_MASK, 0),
+	GPIO_PINGROUP(pin59, PAD_FUNCTION_EN_0, PMX_NFRSTPWDWN0_MASK, 0),
+	GPIO_PINGROUP(pin60, PAD_FUNCTION_EN_0, PMX_NFWPRT3_MASK, 0),
+	GPIO_PINGROUP(pin61, PAD_FUNCTION_EN_0, PMX_NFCE3_MASK, 0),
+	GPIO_PINGROUP(pin62, PAD_FUNCTION_EN_0, PMX_NFAD25_MASK, 0),
+	GPIO_PINGROUP(pin63, PAD_FUNCTION_EN_0, PMX_NFAD24_MASK, 0),
+	GPIO_PINGROUP(pin_grp0, PAD_FUNCTION_EN_0, PMX_GMIICLK_MASK, 0),
+	GPIO_PINGROUP(pin_grp1, PAD_FUNCTION_EN_0, PMX_GMIICOL_CRS_XFERER_MIITXCLK_MASK, 0),
+	GPIO_PINGROUP(pin_grp2, PAD_FUNCTION_EN_0, PMX_RXCLK_RDV_TXEN_D03_MASK, 0),
+	GPIO_PINGROUP(pin_grp3, PAD_FUNCTION_EN_0, PMX_GMIID47_MASK, 0),
+	GPIO_PINGROUP(pin_grp4, PAD_FUNCTION_EN_0, PMX_MDC_MDIO_MASK, 0),
+	GPIO_PINGROUP(pin_grp5, PAD_FUNCTION_EN_0, PMX_NFAD23_MASK, 0),
+	GPIO_PINGROUP(pin_grp6, PAD_FUNCTION_EN_0, PMX_MCI_DATA8_15_MASK, 0),
+	GPIO_PINGROUP(pin_grp7, PAD_FUNCTION_EN_1, PMX_NFCE2_MASK, 0),
+	GPIO_PINGROUP(pin_grp8, PAD_FUNCTION_EN_1, PMX_NAND8_MASK, 0),
+	GPIO_PINGROUP(nand_16bit_pins, PAD_FUNCTION_EN_1, PMX_NAND16BIT_1_MASK, 0),
+	GPIO_PINGROUP(pin205, PAD_FUNCTION_EN_1, PMX_KBD_COL1_MASK | PMX_NFCE1_MASK, 0),
+	GPIO_PINGROUP(pin206, PAD_FUNCTION_EN_1, PMX_KBD_COL0_MASK | PMX_NFCE2_MASK, 0),
+	GPIO_PINGROUP(pin211, PAD_FUNCTION_EN_1, PMX_KBD_ROW1_MASK | PMX_NFWPRT1_MASK, 0),
+	GPIO_PINGROUP(pin212, PAD_FUNCTION_EN_1, PMX_KBD_ROW0_MASK | PMX_NFWPRT2_MASK, 0),
+	GPIO_PINGROUP(pin213, PAD_FUNCTION_EN_1, PMX_MCIDATA0_MASK, 0),
+	GPIO_PINGROUP(pin214, PAD_FUNCTION_EN_1, PMX_MCIDATA1_MASK, 0),
+	GPIO_PINGROUP(pin215, PAD_FUNCTION_EN_1, PMX_MCIDATA2_MASK, 0),
+	GPIO_PINGROUP(pin216, PAD_FUNCTION_EN_1, PMX_MCIDATA3_MASK, 0),
+	GPIO_PINGROUP(pin217, PAD_FUNCTION_EN_1, PMX_MCIDATA4_MASK, 0),
+	GPIO_PINGROUP(pin218, PAD_FUNCTION_EN_2, PMX_MCIDATA5_MASK, 0),
+	GPIO_PINGROUP(pin219, PAD_FUNCTION_EN_2, PMX_MCIDATA6_MASK, 0),
+	GPIO_PINGROUP(pin220, PAD_FUNCTION_EN_2, PMX_MCIDATA7_MASK, 0),
+	GPIO_PINGROUP(pin221, PAD_FUNCTION_EN_2, PMX_MCIDATA1SD_MASK, 0),
+	GPIO_PINGROUP(pin222, PAD_FUNCTION_EN_2, PMX_MCIDATA2SD_MASK, 0),
+	GPIO_PINGROUP(pin223, PAD_FUNCTION_EN_2, PMX_MCIDATA3SD_MASK, 0),
+	GPIO_PINGROUP(pin224, PAD_FUNCTION_EN_2, PMX_MCIADDR0ALE_MASK, 0),
+	GPIO_PINGROUP(pin225, PAD_FUNCTION_EN_2, PMX_MCIADDR1CLECLK_MASK, 0),
+	GPIO_PINGROUP(pin226, PAD_FUNCTION_EN_2, PMX_MCIADDR2_MASK, 0),
+	GPIO_PINGROUP(pin227, PAD_FUNCTION_EN_2, PMX_MCICECF_MASK, 0),
+	GPIO_PINGROUP(pin228, PAD_FUNCTION_EN_2, PMX_MCICEXD_MASK, 0),
+	GPIO_PINGROUP(pin229, PAD_FUNCTION_EN_2, PMX_MCICESDMMC_MASK, 0),
+	GPIO_PINGROUP(pin230, PAD_FUNCTION_EN_2, PMX_MCICDCF1_MASK, 0),
+	GPIO_PINGROUP(pin231, PAD_FUNCTION_EN_2, PMX_MCICDCF2_MASK, 0),
+	GPIO_PINGROUP(pin232, PAD_FUNCTION_EN_2, PMX_MCICDXD_MASK, 0),
+	GPIO_PINGROUP(pin233, PAD_FUNCTION_EN_2, PMX_MCICDSDMMC_MASK, 0),
+	GPIO_PINGROUP(pin234, PAD_FUNCTION_EN_2, PMX_MCIDATADIR_MASK, 0),
+	GPIO_PINGROUP(pin235, PAD_FUNCTION_EN_2, PMX_MCIDMARQWP_MASK, 0),
+	GPIO_PINGROUP(pin236, PAD_FUNCTION_EN_2, PMX_MCIIORDRE_MASK, 0),
+	GPIO_PINGROUP(pin237, PAD_FUNCTION_EN_2, PMX_MCIIOWRWE_MASK, 0),
+	GPIO_PINGROUP(pin238, PAD_FUNCTION_EN_2, PMX_MCIRESETCF_MASK, 0),
+	GPIO_PINGROUP(pin239, PAD_FUNCTION_EN_2, PMX_MCICS0CE_MASK, 0),
+	GPIO_PINGROUP(pin240, PAD_FUNCTION_EN_2, PMX_MCICFINTR_MASK, 0),
+	GPIO_PINGROUP(pin241, PAD_FUNCTION_EN_2, PMX_MCIIORDY_MASK, 0),
+	GPIO_PINGROUP(pin242, PAD_FUNCTION_EN_2, PMX_MCICS1_MASK, 0),
+	GPIO_PINGROUP(pin243, PAD_FUNCTION_EN_2, PMX_MCIDMAACK_MASK, 0),
+	GPIO_PINGROUP(pin244, PAD_FUNCTION_EN_2, PMX_MCISDCMD_MASK, 0),
+	GPIO_PINGROUP(pin245, PAD_FUNCTION_EN_2, PMX_MCILEDS_MASK, 0),
+	GPIO_PINGROUP(keyboard_rowcol6_8_pins, PAD_FUNCTION_EN_1, PMX_KBD_ROWCOL68_MASK, 0),
+	GPIO_PINGROUP(uart0_pins, PAD_FUNCTION_EN_0, PMX_UART0_MASK, 0),
+	GPIO_PINGROUP(uart0_modem_pins, PAD_FUNCTION_EN_1, PMX_UART0_MODEM_MASK, 0),
+	GPIO_PINGROUP(gpt0_tmr0_pins, PAD_FUNCTION_EN_1, PMX_GPT0_TMR0_MASK, 0),
+	GPIO_PINGROUP(gpt0_tmr1_pins, PAD_FUNCTION_EN_1, PMX_GPT0_TMR1_MASK, 0),
+	GPIO_PINGROUP(gpt1_tmr0_pins, PAD_FUNCTION_EN_1, PMX_GPT1_TMR0_MASK, 0),
+	GPIO_PINGROUP(gpt1_tmr1_pins, PAD_FUNCTION_EN_1, PMX_GPT1_TMR1_MASK, 0),
+	GPIO_PINGROUP(touch_xy_pins, PAD_FUNCTION_EN_1, PMX_TOUCH_XY_MASK, 0),
+};
+
 static struct spear_pinctrl_machdata spear1310_machdata = {
 	.pins = spear1310_pins,
 	.npins = ARRAY_SIZE(spear1310_pins),
@@ -2150,6 +2327,9 @@ static struct spear_pinctrl_machdata spear1310_machdata = {
 	.ngroups = ARRAY_SIZE(spear1310_pingroups),
 	.functions = spear1310_functions,
 	.nfunctions = ARRAY_SIZE(spear1310_functions),
+	.ranges = &spear1310_plgpio_range,
+	.gpio_pingroups = spear1310_gpio_pingroup,
+	.ngpio_pingroups = ARRAY_SIZE(spear1310_gpio_pingroup),
 	.modes_supported = false,
 };
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear1340.c b/drivers/pinctrl/spear/pinctrl-spear1340.c
index a8ab2a6..9380507 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1340.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1340.c
@@ -1934,6 +1934,13 @@ static struct spear_function *spear1340_functions[] = {
 	&sata_function,
 };
 
+static struct pinctrl_gpio_range spear1340_plgpio_range = {
+	.name		= "SPEAr1340 PLGPIO",
+	.id		= 0,
+	.pin_base	= 0,
+	.npins		= ARRAY_SIZE(spear1340_pins),
+};
+
 static struct spear_pinctrl_machdata spear1340_machdata = {
 	.pins = spear1340_pins,
 	.npins = ARRAY_SIZE(spear1340_pins),
@@ -1941,6 +1948,7 @@ static struct spear_pinctrl_machdata spear1340_machdata = {
 	.ngroups = ARRAY_SIZE(spear1340_pingroups),
 	.functions = spear1340_functions,
 	.nfunctions = ARRAY_SIZE(spear1340_functions),
+	.ranges = &spear1340_plgpio_range,
 	.modes_supported = false,
 };
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear300.c b/drivers/pinctrl/spear/pinctrl-spear300.c
index 9c82a35..faa9169 100644
--- a/drivers/pinctrl/spear/pinctrl-spear300.c
+++ b/drivers/pinctrl/spear/pinctrl-spear300.c
@@ -661,6 +661,8 @@ static int __devinit spear300_pinctrl_probe(struct platform_device *pdev)
 	spear3xx_machdata.ngroups = ARRAY_SIZE(spear300_pingroups);
 	spear3xx_machdata.functions = spear300_functions;
 	spear3xx_machdata.nfunctions = ARRAY_SIZE(spear300_functions);
+	spear3xx_machdata.gpio_pingroups = NULL;
+	spear3xx_machdata.ngpio_pingroups = 0;
 
 	spear3xx_machdata.modes_supported = true;
 	spear3xx_machdata.pmx_modes = spear300_pmx_modes;
diff --git a/drivers/pinctrl/spear/pinctrl-spear310.c b/drivers/pinctrl/spear/pinctrl-spear310.c
index 1a97076..f393639 100644
--- a/drivers/pinctrl/spear/pinctrl-spear310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear310.c
@@ -388,6 +388,8 @@ static int __devinit spear310_pinctrl_probe(struct platform_device *pdev)
 	spear3xx_machdata.nfunctions = ARRAY_SIZE(spear310_functions);
 
 	pmx_init_addr(&spear3xx_machdata, PMX_CONFIG_REG);
+	pmx_init_gpio_pingroup_addr(spear3xx_machdata.gpio_pingroups,
+			spear3xx_machdata.ngpio_pingroups, PMX_CONFIG_REG);
 
 	spear3xx_machdata.modes_supported = false;
 
diff --git a/drivers/pinctrl/spear/pinctrl-spear320.c b/drivers/pinctrl/spear/pinctrl-spear320.c
index de726e6..e8c2d65 100644
--- a/drivers/pinctrl/spear/pinctrl-spear320.c
+++ b/drivers/pinctrl/spear/pinctrl-spear320.c
@@ -3427,6 +3427,8 @@ static int __devinit spear320_pinctrl_probe(struct platform_device *pdev)
 	spear3xx_machdata.npmx_modes = ARRAY_SIZE(spear320_pmx_modes);
 
 	pmx_init_addr(&spear3xx_machdata, PMX_CONFIG_REG);
+	pmx_init_gpio_pingroup_addr(spear3xx_machdata.gpio_pingroups,
+			spear3xx_machdata.ngpio_pingroups, PMX_CONFIG_REG);
 
 	ret = spear_pinctrl_probe(pdev, &spear3xx_machdata);
 	if (ret)
diff --git a/drivers/pinctrl/spear/pinctrl-spear3xx.c b/drivers/pinctrl/spear/pinctrl-spear3xx.c
index 91c883b..dfd90aa 100644
--- a/drivers/pinctrl/spear/pinctrl-spear3xx.c
+++ b/drivers/pinctrl/spear/pinctrl-spear3xx.c
@@ -481,7 +481,36 @@ struct spear_function spear3xx_timer_2_3_function = {
 	.ngroups = ARRAY_SIZE(timer_2_3_grps),
 };
 
+/* plgpio */
+static struct pinctrl_gpio_range spear3xx_plgpio_range = {
+	.name		= "SPEAr3xx PLGPIO",
+	.id		= 0,
+	.pin_base	= 0,
+	.npins		= ARRAY_SIZE(spear3xx_pins),
+};
+
+static struct spear_gpio_pingroup spear3xx_gpio_pingroup[] = {
+	GPIO_PINGROUP(firda_pins, 0, PMX_FIRDA_MASK, 1),
+	GPIO_PINGROUP(i2c_pins, 0, PMX_I2C_MASK, 1),
+	GPIO_PINGROUP(ssp_cs_pins, 0, PMX_SSP_CS_MASK, 1),
+	GPIO_PINGROUP(ssp_pins, 0, PMX_SSP_MASK, 1),
+	GPIO_PINGROUP(mii_pins, 0, PMX_MII_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin0_pins, 0, PMX_GPIO_PIN0_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin1_pins, 0, PMX_GPIO_PIN1_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin2_pins, 0, PMX_GPIO_PIN2_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin3_pins, 0, PMX_GPIO_PIN3_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin4_pins, 0, PMX_GPIO_PIN4_MASK, 1),
+	GPIO_PINGROUP(gpio0_pin5_pins, 0, PMX_GPIO_PIN5_MASK, 1),
+	GPIO_PINGROUP(uart0_ext_pins, 0, PMX_UART0_MODEM_MASK, 1),
+	GPIO_PINGROUP(uart0_pins, 0, PMX_UART0_MASK, 1),
+	GPIO_PINGROUP(timer_0_1_pins, 0, PMX_TIMER_0_1_MASK, 1),
+	GPIO_PINGROUP(timer_2_3_pins, 0, PMX_TIMER_2_3_MASK, 1),
+};
+
 struct spear_pinctrl_machdata spear3xx_machdata = {
 	.pins = spear3xx_pins,
 	.npins = ARRAY_SIZE(spear3xx_pins),
+	.ranges = &spear3xx_plgpio_range,
+	.gpio_pingroups = spear3xx_gpio_pingroup,
+	.ngpio_pingroups = ARRAY_SIZE(spear3xx_gpio_pingroup),
 };
-- 
1.7.9
