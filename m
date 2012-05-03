From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:42:06 +0530
Subject: [PATCH V2 4/5] pinctrl: SPEAr: Add gpio ranges support
In-Reply-To: <cover.1336039716.git.viresh.kumar@st.com>
References: <cover.1336039716.git.viresh.kumar@st.com>
Message-ID: <2b4c7e15add17a63aeab924b5b5dc2d6fadfd259.1336039716.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of SPEAr SoCs, which support pinctrl, can configure & use pads as gpio.
This patch gpio enable support for SPEAr pinctrl drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/pinctrl/spear/Kconfig             |    4 +
 drivers/pinctrl/spear/pinctrl-spear.c     |  110 ++++-
 drivers/pinctrl/spear/pinctrl-spear.h     |   15 +
 drivers/pinctrl/spear/pinctrl-spear1310.c |  810 +++++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear1340.c |    8 +
 drivers/pinctrl/spear/pinctrl-spear300.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear310.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear320.c  |    2 +
 drivers/pinctrl/spear/pinctrl-spear3xx.c  |  120 +++++
 9 files changed, 1061 insertions(+), 12 deletions(-)

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
index 8653569..2596fa6 100644
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
+	if (PTR_ERR(gpio_pingroup))
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
index 9155783..dd0d88e 100644
--- a/drivers/pinctrl/spear/pinctrl-spear.h
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -46,6 +46,12 @@ struct spear_muxreg {
 	u32 val;
 };
 
+struct spear_gpio_pingroup {
+	const unsigned *pins;
+	unsigned npins;
+	struct spear_muxreg muxreg;
+};
+
 /**
  * struct spear_modemux - SPEAr mode mux configuration
  * @modes: mode ids supported by this group of muxregs
@@ -100,6 +106,9 @@ struct spear_function {
  * @nfunctions: The numbmer of entries in @functions.
  * @groups: An array describing all pin groups the pin SoC supports.
  * @ngroups: The numbmer of entries in @groups.
+ * @ranges: PLGPIO ranges for the machine
+ * @gpio_pingroups: gpio pingroups
+ * @ngpio_pingroups: gpio pingroups count
  *
  * @modes_supported: Does SoC support modes
  * @mode: mode configured from probe
@@ -113,6 +122,9 @@ struct spear_pinctrl_machdata {
 	unsigned nfunctions;
 	struct spear_pingroup **groups;
 	unsigned ngroups;
+	struct pinctrl_gpio_range *ranges;
+	struct spear_gpio_pingroup *gpio_pingroups;
+	unsigned ngpio_pingroups;
 
 	bool modes_supported;
 	u16 mode;
@@ -136,6 +148,9 @@ struct spear_pmx {
 
 /* exported routines */
 void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
+void __devinit
+pmx_init_gpio_pingroup_addr(struct spear_gpio_pingroup *gpio_pingroup,
+		unsigned count, u16 reg);
 int __devinit spear_pinctrl_probe(struct platform_device *pdev,
 		struct spear_pinctrl_machdata *machdata);
 int __devexit spear_pinctrl_remove(struct platform_device *pdev);
diff --git a/drivers/pinctrl/spear/pinctrl-spear1310.c b/drivers/pinctrl/spear/pinctrl-spear1310.c
index fff168b..362808d 100644
--- a/drivers/pinctrl/spear/pinctrl-spear1310.c
+++ b/drivers/pinctrl/spear/pinctrl-spear1310.c
@@ -2143,6 +2143,813 @@ static struct spear_function *spear1310_functions[] = {
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
+	{
+		.pins = i2c0_pins,
+		.npins = ARRAY_SIZE(i2c0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_I2C0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = ssp0_pins,
+		.npins = ARRAY_SIZE(ssp0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_SSP0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = ssp0_cs0_pins,
+		.npins = ARRAY_SIZE(ssp0_cs0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_SSP0_CS0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = ssp0_cs1_2_pins,
+		.npins = ARRAY_SIZE(ssp0_cs1_2_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_SSP0_CS1_2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = i2s0_pins,
+		.npins = ARRAY_SIZE(i2s0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_I2S0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = i2s1_pins,
+		.npins = ARRAY_SIZE(i2s1_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_I2S1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = clcd_pins,
+		.npins = ARRAY_SIZE(clcd_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_CLCD1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = clcd_high_res_pins,
+		.npins = ARRAY_SIZE(clcd_high_res_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_CLCD2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin18,
+		.npins = ARRAY_SIZE(pin18),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO15_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin19,
+		.npins = ARRAY_SIZE(pin19),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO14_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin20,
+		.npins = ARRAY_SIZE(pin20),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO13_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin21,
+		.npins = ARRAY_SIZE(pin21),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO12_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin22,
+		.npins = ARRAY_SIZE(pin22),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO11_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin23,
+		.npins = ARRAY_SIZE(pin23),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO10_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin143,
+		.npins = ARRAY_SIZE(pin143),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO00_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin144,
+		.npins = ARRAY_SIZE(pin144),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO01_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin145,
+		.npins = ARRAY_SIZE(pin145),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO02_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin146,
+		.npins = ARRAY_SIZE(pin146),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO03_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin147,
+		.npins = ARRAY_SIZE(pin147),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO04_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin148,
+		.npins = ARRAY_SIZE(pin148),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO05_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin149,
+		.npins = ARRAY_SIZE(pin149),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO06_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin150,
+		.npins = ARRAY_SIZE(pin150),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO07_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin151,
+		.npins = ARRAY_SIZE(pin151),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO08_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin152,
+		.npins = ARRAY_SIZE(pin152),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_EGPIO09_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = smi_2_chips_pins,
+		.npins = ARRAY_SIZE(smi_2_chips_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_SMI_MASK,
+			.val = 0,
+			},
+	}, {
+		.pins = pin54,
+		.npins = ARRAY_SIZE(pin54),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_SMINCS3_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin55,
+		.npins = ARRAY_SIZE(pin55),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_SMINCS2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin56,
+		.npins = ARRAY_SIZE(pin56),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_NFRSTPWDWN3_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin57,
+		.npins = ARRAY_SIZE(pin57),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFRSTPWDWN2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin58,
+		.npins = ARRAY_SIZE(pin58),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFRSTPWDWN1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin59,
+		.npins = ARRAY_SIZE(pin59),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFRSTPWDWN0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin60,
+		.npins = ARRAY_SIZE(pin60),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFWPRT3_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin61,
+		.npins = ARRAY_SIZE(pin61),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFCE3_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin62,
+		.npins = ARRAY_SIZE(pin62),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFAD25_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin63,
+		.npins = ARRAY_SIZE(pin63),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFAD24_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp0,
+		.npins = ARRAY_SIZE(pin_grp0),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_GMIICLK_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp1,
+		.npins = ARRAY_SIZE(pin_grp1),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_GMIICOL_CRS_XFERER_MIITXCLK_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp2,
+		.npins = ARRAY_SIZE(pin_grp2),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_RXCLK_RDV_TXEN_D03_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp3,
+		.npins = ARRAY_SIZE(pin_grp3),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_GMIID47_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp4,
+		.npins = ARRAY_SIZE(pin_grp4),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_MDC_MDIO_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp5,
+		.npins = ARRAY_SIZE(pin_grp5),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_NFAD23_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp6,
+		.npins = ARRAY_SIZE(pin_grp6),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_MCI_DATA8_15_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp7,
+		.npins = ARRAY_SIZE(pin_grp7),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_NFCE2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin_grp8,
+		.npins = ARRAY_SIZE(pin_grp8),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_NAND8_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = nand_16bit_pins,
+		.npins = ARRAY_SIZE(nand_16bit_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_NAND16BIT_1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin205,
+		.npins = ARRAY_SIZE(pin205),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_KBD_COL1_MASK | PMX_NFCE1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin206,
+		.npins = ARRAY_SIZE(pin206),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_KBD_COL0_MASK | PMX_NFCE2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin211,
+		.npins = ARRAY_SIZE(pin211),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_KBD_ROW1_MASK | PMX_NFWPRT1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin212,
+		.npins = ARRAY_SIZE(pin212),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_KBD_ROW0_MASK | PMX_NFWPRT2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin213,
+		.npins = ARRAY_SIZE(pin213),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_MCIDATA0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin214,
+		.npins = ARRAY_SIZE(pin214),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_MCIDATA1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin215,
+		.npins = ARRAY_SIZE(pin215),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_MCIDATA2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin216,
+		.npins = ARRAY_SIZE(pin216),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_MCIDATA3_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin217,
+		.npins = ARRAY_SIZE(pin217),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_MCIDATA4_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin218,
+		.npins = ARRAY_SIZE(pin218),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA5_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin219,
+		.npins = ARRAY_SIZE(pin219),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA6_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin220,
+		.npins = ARRAY_SIZE(pin220),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA7_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin221,
+		.npins = ARRAY_SIZE(pin221),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA1SD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin222,
+		.npins = ARRAY_SIZE(pin222),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA2SD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin223,
+		.npins = ARRAY_SIZE(pin223),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATA3SD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin224,
+		.npins = ARRAY_SIZE(pin224),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIADDR0ALE_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin225,
+		.npins = ARRAY_SIZE(pin225),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIADDR1CLECLK_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin226,
+		.npins = ARRAY_SIZE(pin226),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIADDR2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin227,
+		.npins = ARRAY_SIZE(pin227),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICECF_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin228,
+		.npins = ARRAY_SIZE(pin228),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICEXD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin229,
+		.npins = ARRAY_SIZE(pin229),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICESDMMC_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin230,
+		.npins = ARRAY_SIZE(pin230),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICDCF1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin231,
+		.npins = ARRAY_SIZE(pin231),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICDCF2_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin232,
+		.npins = ARRAY_SIZE(pin232),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICDXD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin233,
+		.npins = ARRAY_SIZE(pin233),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICDSDMMC_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin234,
+		.npins = ARRAY_SIZE(pin234),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDATADIR_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin235,
+		.npins = ARRAY_SIZE(pin235),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDMARQWP_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin236,
+		.npins = ARRAY_SIZE(pin236),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIIORDRE_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin237,
+		.npins = ARRAY_SIZE(pin237),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIIOWRWE_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin238,
+		.npins = ARRAY_SIZE(pin238),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIRESETCF_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin239,
+		.npins = ARRAY_SIZE(pin239),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICS0CE_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin240,
+		.npins = ARRAY_SIZE(pin240),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICFINTR_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin241,
+		.npins = ARRAY_SIZE(pin241),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIIORDY_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin242,
+		.npins = ARRAY_SIZE(pin242),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCICS1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin243,
+		.npins = ARRAY_SIZE(pin243),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCIDMAACK_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin244,
+		.npins = ARRAY_SIZE(pin244),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCISDCMD_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = pin245,
+		.npins = ARRAY_SIZE(pin245),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_MCILEDS_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = keyboard_rowcol6_8_pins,
+		.npins = ARRAY_SIZE(keyboard_rowcol6_8_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_KBD_ROWCOL68_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = uart0_pins,
+		.npins = ARRAY_SIZE(uart0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_0,
+			.mask = PMX_UART0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = uart0_modem_pins,
+		.npins = ARRAY_SIZE(uart0_modem_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_UART0_MODEM_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = gpt0_tmr0_pins,
+		.npins = ARRAY_SIZE(gpt0_tmr0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_GPT0_TMR0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = gpt0_tmr1_pins,
+		.npins = ARRAY_SIZE(gpt0_tmr1_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_GPT0_TMR1_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = gpt1_tmr0_pins,
+		.npins = ARRAY_SIZE(gpt1_tmr0_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_GPT1_TMR0_MASK,
+			.val = 0,
+		},
+	}, {
+		.pins = gpt1_tmr1_pins,
+		.npins = ARRAY_SIZE(gpt1_tmr1_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_1,
+			.mask = PMX_GPT1_TMR1_MASK,
+			.val = 0,
+		},
+	}, {
+		.npins = ARRAY_SIZE(touch_xy_pins),
+		.muxreg = {
+			.reg = PAD_FUNCTION_EN_2,
+			.mask = PMX_TOUCH_XY_MASK,
+			.val = 0,
+		},
+	},
+};
+
 static struct spear_pinctrl_machdata spear1310_machdata = {
 	.pins = spear1310_pins,
 	.npins = ARRAY_SIZE(spear1310_pins),
@@ -2150,6 +2957,9 @@ static struct spear_pinctrl_machdata spear1310_machdata = {
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
index 91c883b..1c04033 100644
--- a/drivers/pinctrl/spear/pinctrl-spear3xx.c
+++ b/drivers/pinctrl/spear/pinctrl-spear3xx.c
@@ -481,7 +481,127 @@ struct spear_function spear3xx_timer_2_3_function = {
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
+	{
+		.pins = firda_pins,
+		.npins = ARRAY_SIZE(firda_pins),
+		.muxreg = {
+			.mask = PMX_FIRDA_MASK,
+			.val = PMX_FIRDA_MASK,
+		},
+	}, {
+		.pins = i2c_pins,
+		.npins = ARRAY_SIZE(i2c_pins),
+		.muxreg = {
+			.mask = PMX_I2C_MASK,
+			.val = PMX_I2C_MASK,
+		},
+	}, {
+		.pins = ssp_cs_pins,
+		.npins = ARRAY_SIZE(ssp_cs_pins),
+		.muxreg = {
+			.mask = PMX_SSP_CS_MASK,
+			.val = PMX_SSP_CS_MASK,
+		},
+	}, {
+		.pins = ssp_pins,
+		.npins = ARRAY_SIZE(ssp_pins),
+		.muxreg = {
+			.mask = PMX_SSP_MASK,
+			.val = PMX_SSP_MASK,
+		},
+	}, {
+		.pins = mii_pins,
+		.npins = ARRAY_SIZE(mii_pins),
+		.muxreg = {
+			.mask = PMX_MII_MASK,
+			.val = PMX_MII_MASK,
+		},
+	}, {
+		.pins = gpio0_pin0_pins,
+		.npins = ARRAY_SIZE(gpio0_pin0_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN0_MASK,
+			.val = PMX_GPIO_PIN0_MASK,
+		},
+	}, {
+		.pins = gpio0_pin1_pins,
+		.npins = ARRAY_SIZE(gpio0_pin1_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN1_MASK,
+			.val = PMX_GPIO_PIN1_MASK,
+		},
+	}, {
+		.pins = gpio0_pin2_pins,
+		.npins = ARRAY_SIZE(gpio0_pin2_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN2_MASK,
+			.val = PMX_GPIO_PIN2_MASK,
+		},
+	}, {
+		.pins = gpio0_pin3_pins,
+		.npins = ARRAY_SIZE(gpio0_pin3_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN3_MASK,
+			.val = PMX_GPIO_PIN3_MASK,
+		},
+	}, {
+		.pins = gpio0_pin4_pins,
+		.npins = ARRAY_SIZE(gpio0_pin4_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN4_MASK,
+			.val = PMX_GPIO_PIN4_MASK,
+		},
+	}, {
+		.pins = gpio0_pin5_pins,
+		.npins = ARRAY_SIZE(gpio0_pin5_pins),
+		.muxreg = {
+			.mask = PMX_GPIO_PIN5_MASK,
+			.val = PMX_GPIO_PIN5_MASK,
+		},
+	}, {
+		.pins = uart0_ext_pins,
+		.npins = ARRAY_SIZE(uart0_ext_pins),
+		.muxreg = {
+			.mask = PMX_UART0_MODEM_MASK,
+			.val = PMX_UART0_MODEM_MASK,
+		},
+	}, {
+		.pins = uart0_pins,
+		.npins = ARRAY_SIZE(uart0_pins),
+		.muxreg = {
+			.mask = PMX_UART0_MASK,
+			.val = PMX_UART0_MASK,
+		},
+	}, {
+		.pins = timer_0_1_pins,
+		.npins = ARRAY_SIZE(timer_0_1_pins),
+		.muxreg = {
+			.mask = PMX_TIMER_0_1_MASK,
+			.val = PMX_TIMER_0_1_MASK,
+		},
+	}, {
+		.pins = timer_2_3_pins,
+		.npins = ARRAY_SIZE(timer_2_3_pins),
+		.muxreg = {
+			.mask = PMX_TIMER_2_3_MASK,
+			.val = PMX_TIMER_2_3_MASK,
+		},
+	},
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
