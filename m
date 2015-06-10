From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 10 Jun 2015 17:04:58 +0200
Subject: [RESEND PROTO] pinctrl: rough draft for a future controller
In-Reply-To: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
References: <1433948699-19800-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1433948699-19800-4-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Draft for a future controller which can mux each pin to any functions.

There are up to 6 functions plus a gpio mode (gpio controller driver
won't be included in the pincontroller driver).

There is a concept of ioset. An ioset is a set of pins for a device.
A device can have several iosets.
There is no obligation to use the whole ioset, for example if you have a
mmc 4-bits data bus, you can use data4,5,6,7 for another devices.
The pincontroller has no knowledge about the iosets. So potentially you
don't have to take care about it BUT validation is done by ioset. It
means that if you mix device signals from several iosets, you may have
some bugs. That's why we need to warn the user if he mixes pins from
several iosets.

There is no chip dependant table, that's why groups (mainly used for
ioset and debug sysfs readability) are defined in the device tree.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Conflicts:
	drivers/pinctrl/Kconfig
	drivers/pinctrl/Makefile
---
 drivers/pinctrl/Kconfig             |  10 +
 drivers/pinctrl/Makefile            |   1 +
 drivers/pinctrl/pinctrl-at91-pio4.c | 625 ++++++++++++++++++++++++++++++++++++
 3 files changed, 636 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-at91-pio4.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index aeb5729..dcde103 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -67,6 +67,16 @@ config PINCTRL_AT91
 	help
 	  Say Y here to enable the at91 pinctrl driver
 
+config PINCTRL_AT91PIO4
+	bool "AT91 PIO4 pinctrl driver"
+	depends on OF
+	depends on ARCH_AT91
+	select PINMUX
+	select PINCONF
+	select GENERIC_PINCONF
+	help
+	  Say Y here to enable the at91-pio4 pinctrl driver
+
 config PINCTRL_AMD
 	bool "AMD GPIO pin control"
 	depends on GPIOLIB
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 6eadf04..a685d86 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PINCTRL_AS3722)	+= pinctrl-as3722.o
 obj-$(CONFIG_PINCTRL_BF54x)	+= pinctrl-adi2-bf54x.o
 obj-$(CONFIG_PINCTRL_BF60x)	+= pinctrl-adi2-bf60x.o
 obj-$(CONFIG_PINCTRL_AT91)	+= pinctrl-at91.o
+obj-$(CONFIG_PINCTRL_AT91PIO4)	+= pinctrl-at91-pio4.o
 obj-$(CONFIG_PINCTRL_AMD)	+= pinctrl-amd.o
 obj-$(CONFIG_PINCTRL_FALCON)	+= pinctrl-falcon.o
 obj-$(CONFIG_PINCTRL_MESON)	+= meson/
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
new file mode 100644
index 0000000..4df2dd5
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -0,0 +1,625 @@
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include "core.h"
+#include "pinctrl-utils.h"
+
+#define ATMEL_PIO3_BANK_OFFSET	0x1000
+#define ATMEL_PIO3_PER		0x0000
+#define ATMEL_PIO3_PDR		0x0004
+#define ATMEL_PIO3_PSR		0x0008
+#define ATMEL_PIO3_OER		0x0010
+#define ATMEL_PIO3_ODR		0x0014
+#define ATMEL_PIO3_OSR		0x0018
+#define ATMEL_PIO3_IFER		0x0020
+#define ATMEL_PIO3_IFDR		0x0024
+#define ATMEL_PIO3_IFSR		0x0028
+#define ATMEL_PIO3_SODR		0x0030
+#define ATMEL_PIO3_CODR		0x0034
+#define ATMEL_PIO3_ODSR		0x0038
+#define ATMEL_PIO3_PDSR		0x003C
+#define ATMEL_PIO3_IER		0x0040
+#define ATMEL_PIO3_IDR		0x0044
+#define ATMEL_PIO3_IMR		0x0048
+#define ATMEL_PIO3_ISR		0x004C
+#define ATMEL_PIO3_MDER		0x0050
+#define ATMEL_PIO3_MDDR		0x0054
+#define ATMEL_PIO3_MDSR		0x0058
+#define ATMEL_PIO3_PUDR		0x0060
+#define ATMEL_PIO3_PUER		0x0064
+#define ATMEL_PIO3_PUSR		0x0068
+#define ATMEL_PIO3_ABCDSR1	0x0070
+#define ATMEL_PIO3_ABCDSR2	0x0074
+#define ATMEL_PIO3_IFSCDR	0x0080
+#define ATMEL_PIO3_IFSCER	0x0084
+#define ATMEL_PIO3_IFSCSR	0x0088
+#define ATMEL_PIO3_SCDR		0x008C
+#define ATMEL_PIO3_PPDDR	0x0090
+#define ATMEL_PIO3_PPDER	0x0094
+#define ATMEL_PIO3_PPDSR	0x0098
+#define ATMEL_PIO3_OWER		0x00A0
+#define ATMEL_PIO3_OWDR		0x00A4
+#define ATMEL_PIO3_OWSR		0x00A8
+
+struct atmel_group {
+	const char *name;
+	u32 *pins;
+	unsigned npins;
+};
+
+static const char * const atmel_functions[] = {
+	"A", "B", "C", "D", "E", "F",
+};
+
+const struct pinctrl_pin_desc atmel_pins[] = {
+	PINCTRL_PIN(0,   "PA0"),
+	PINCTRL_PIN(1,   "PA1"),
+	PINCTRL_PIN(2,   "PA2"),
+	PINCTRL_PIN(3,   "PA3"),
+	PINCTRL_PIN(4,   "PA4"),
+	PINCTRL_PIN(5,   "PA5"),
+	PINCTRL_PIN(6,   "PA6"),
+	PINCTRL_PIN(7,   "PA7"),
+	PINCTRL_PIN(8,   "PA8"),
+	PINCTRL_PIN(9,   "PA9"),
+	PINCTRL_PIN(10,  "PA10"),
+	PINCTRL_PIN(11,  "PA11"),
+	PINCTRL_PIN(12,  "PA12"),
+	PINCTRL_PIN(13,  "PA13"),
+	PINCTRL_PIN(14,  "PA14"),
+	PINCTRL_PIN(15,  "PA15"),
+	PINCTRL_PIN(16,  "PA16"),
+	PINCTRL_PIN(17,  "PA17"),
+	PINCTRL_PIN(18,  "PA18"),
+	PINCTRL_PIN(19,  "PA19"),
+	PINCTRL_PIN(20,  "PA20"),
+	PINCTRL_PIN(21,  "PA21"),
+	PINCTRL_PIN(22,  "PA22"),
+	PINCTRL_PIN(23,  "PA23"),
+	PINCTRL_PIN(24,  "PA24"),
+	PINCTRL_PIN(25,  "PA25"),
+	PINCTRL_PIN(26,  "PA26"),
+	PINCTRL_PIN(27,  "PA27"),
+	PINCTRL_PIN(28,  "PA28"),
+	PINCTRL_PIN(29,  "PA29"),
+	PINCTRL_PIN(30,  "PA30"),
+	PINCTRL_PIN(31,  "PA31"),
+	PINCTRL_PIN(32,  "PB0"),
+	PINCTRL_PIN(33,  "PB1"),
+	PINCTRL_PIN(34,  "PB2"),
+	PINCTRL_PIN(35,  "PB3"),
+	PINCTRL_PIN(36,  "PB4"),
+	PINCTRL_PIN(37,  "PB5"),
+	PINCTRL_PIN(38,  "PB6"),
+	PINCTRL_PIN(39,  "PB7"),
+	PINCTRL_PIN(40,  "PB8"),
+	PINCTRL_PIN(41,  "PB9"),
+	PINCTRL_PIN(42,  "PB10"),
+	PINCTRL_PIN(43,  "PB11"),
+	PINCTRL_PIN(44,  "PB12"),
+	PINCTRL_PIN(45,  "PB13"),
+	PINCTRL_PIN(46,  "PB14"),
+	PINCTRL_PIN(47,  "PB15"),
+	PINCTRL_PIN(48,  "PB16"),
+	PINCTRL_PIN(49,  "PB17"),
+	PINCTRL_PIN(50,  "PB18"),
+	PINCTRL_PIN(51,  "PB19"),
+	PINCTRL_PIN(52,  "PB20"),
+	PINCTRL_PIN(53,  "PB21"),
+	PINCTRL_PIN(54,  "PB22"),
+	PINCTRL_PIN(55,  "PB23"),
+	PINCTRL_PIN(56,  "PB24"),
+	PINCTRL_PIN(57,  "PB25"),
+	PINCTRL_PIN(58,  "PB26"),
+	PINCTRL_PIN(59,  "PB27"),
+	PINCTRL_PIN(60,  "PB28"),
+	PINCTRL_PIN(61,  "PB29"),
+	PINCTRL_PIN(62,  "PB30"),
+	PINCTRL_PIN(63,  "PB31"),
+	PINCTRL_PIN(64,  "PC0"),
+	PINCTRL_PIN(65,  "PC1"),
+	PINCTRL_PIN(66,  "PC2"),
+	PINCTRL_PIN(67,  "PC3"),
+	PINCTRL_PIN(68,  "PC4"),
+	PINCTRL_PIN(69,  "PC5"),
+	PINCTRL_PIN(70,  "PC6"),
+	PINCTRL_PIN(71,  "PC7"),
+	PINCTRL_PIN(72,  "PC8"),
+	PINCTRL_PIN(73,  "PC9"),
+	PINCTRL_PIN(74,  "PC10"),
+	PINCTRL_PIN(75,  "PC11"),
+	PINCTRL_PIN(76,  "PC12"),
+	PINCTRL_PIN(77,  "PC13"),
+	PINCTRL_PIN(78,  "PC14"),
+	PINCTRL_PIN(79,  "PC15"),
+	PINCTRL_PIN(80,  "PC16"),
+	PINCTRL_PIN(81,  "PC17"),
+	PINCTRL_PIN(82,  "PC18"),
+	PINCTRL_PIN(83,  "PC19"),
+	PINCTRL_PIN(84,  "PC20"),
+	PINCTRL_PIN(85,  "PC21"),
+	PINCTRL_PIN(86,  "PC22"),
+	PINCTRL_PIN(87,  "PC23"),
+	PINCTRL_PIN(88,  "PC24"),
+	PINCTRL_PIN(89,  "PC25"),
+	PINCTRL_PIN(90,  "PC26"),
+	PINCTRL_PIN(91,  "PC27"),
+	PINCTRL_PIN(92,  "PC28"),
+	PINCTRL_PIN(93,  "PC29"),
+	PINCTRL_PIN(94,  "PC30"),
+	PINCTRL_PIN(95,  "PC31"),
+	PINCTRL_PIN(96,  "PD0"),
+	PINCTRL_PIN(97,  "PD1"),
+	PINCTRL_PIN(98,  "PD2"),
+	PINCTRL_PIN(99,  "PD3"),
+	PINCTRL_PIN(100, "PD4"),
+	PINCTRL_PIN(101, "PD5"),
+	PINCTRL_PIN(102, "PD6"),
+	PINCTRL_PIN(103, "PD7"),
+	PINCTRL_PIN(104, "PD8"),
+	PINCTRL_PIN(105, "PD9"),
+	PINCTRL_PIN(106, "PD10"),
+	PINCTRL_PIN(107, "PD11"),
+	PINCTRL_PIN(108, "PD12"),
+	PINCTRL_PIN(109, "PD13"),
+	PINCTRL_PIN(110, "PD14"),
+	PINCTRL_PIN(111, "PD15"),
+	PINCTRL_PIN(112, "PD16"),
+	PINCTRL_PIN(113, "PD17"),
+	PINCTRL_PIN(114, "PD18"),
+	PINCTRL_PIN(115, "PD19"),
+	PINCTRL_PIN(116, "PD20"),
+	PINCTRL_PIN(117, "PD21"),
+	PINCTRL_PIN(118, "PD22"),
+	PINCTRL_PIN(119, "PD23"),
+	PINCTRL_PIN(120, "PD24"),
+	PINCTRL_PIN(121, "PD25"),
+	PINCTRL_PIN(122, "PD26"),
+	PINCTRL_PIN(123, "PD27"),
+	PINCTRL_PIN(124, "PD28"),
+	PINCTRL_PIN(125, "PD29"),
+	PINCTRL_PIN(126, "PD30"),
+	PINCTRL_PIN(127, "PD31"),
+	PINCTRL_PIN(128, "PE0"),
+	PINCTRL_PIN(129, "PE1"),
+	PINCTRL_PIN(130, "PE2"),
+	PINCTRL_PIN(131, "PE3"),
+	PINCTRL_PIN(132, "PE4"),
+	PINCTRL_PIN(133, "PE5"),
+	PINCTRL_PIN(134, "PE6"),
+	PINCTRL_PIN(135, "PE7"),
+	PINCTRL_PIN(136, "PE8"),
+	PINCTRL_PIN(137, "PE9"),
+	PINCTRL_PIN(138, "PE10"),
+	PINCTRL_PIN(139, "PE11"),
+	PINCTRL_PIN(140, "PE12"),
+	PINCTRL_PIN(141, "PE13"),
+	PINCTRL_PIN(142, "PE14"),
+	PINCTRL_PIN(143, "PE15"),
+	PINCTRL_PIN(144, "PE16"),
+	PINCTRL_PIN(145, "PE17"),
+	PINCTRL_PIN(146, "PE18"),
+	PINCTRL_PIN(147, "PE19"),
+	PINCTRL_PIN(148, "PE20"),
+	PINCTRL_PIN(149, "PE21"),
+	PINCTRL_PIN(150, "PE22"),
+	PINCTRL_PIN(151, "PE23"),
+	PINCTRL_PIN(152, "PE24"),
+	PINCTRL_PIN(153, "PE25"),
+	PINCTRL_PIN(154, "PE26"),
+	PINCTRL_PIN(155, "PE27"),
+	PINCTRL_PIN(156, "PE28"),
+	PINCTRL_PIN(157, "PE29"),
+	PINCTRL_PIN(158, "PE30"),
+	PINCTRL_PIN(159, "PE31"),
+};
+
+/**
+ * struct atmel_pinctrl - driver data
+ * @pctrl:		pinctrl device
+ */
+struct atmel_pinctrl {
+	struct pinctrl_dev 	*pctrl;
+	struct regmap		*regmap_base;
+	unsigned int 		nbanks;
+	unsigned int		npins_per_bank;
+	struct atmel_group	*groups;
+	unsigned int		ngroups;
+	//struct atmel_function	*funcs;
+	unsigned int nfuncs;
+};
+
+/* ----- pinctrl part ----- */
+
+static int atmel_pctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctrl->ngroups;
+}
+
+static const char *atmel_pctrl_get_group_name(struct pinctrl_dev *pctldev,
+						  unsigned selector)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	return pctrl->groups[selector].name;
+}
+
+static int atmel_get_group_pins(struct pinctrl_dev *pctldev,
+				    unsigned selector,
+				    const unsigned **pins,
+				    unsigned *num_pins)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = pctrl->groups[selector].pins;
+	*num_pins = pctrl->groups[selector].npins;
+
+	return 0;
+}
+
+static const struct pinctrl_ops atmel_pctlops = {
+	.get_groups_count = atmel_pctrl_get_groups_count,
+	.get_group_name = atmel_pctrl_get_group_name,
+	.get_group_pins = atmel_get_group_pins,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinctrl_utils_dt_free_map,
+};
+
+/* ----- pinmux part ----- */
+
+static int atmel_pmux_get_functions_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(atmel_functions);
+}
+
+static const char *atmel_pmux_get_function_name(struct pinctrl_dev *pctldev,
+						    unsigned selector)
+{
+	return atmel_functions[selector];
+}
+
+static int atmel_pio3_set_mux(struct pinctrl_dev *pctldev,
+			     unsigned function,
+			     unsigned group)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+
+	dev_dbg(pctldev->dev, "enable function %s group %s\n",
+		atmel_functions[function], pctrl->groups[group].name);
+
+	return 0;
+}
+
+static const struct pinmux_ops atmel_pio3_pmxops = {
+	.mux_per_pin = true,
+	.request = NULL,
+	.free = NULL,
+	.get_functions_count = atmel_pmux_get_functions_count,
+	.get_function_name = atmel_pmux_get_function_name,
+	.set_mux = atmel_pio3_set_mux,
+	.gpio_request_enable = NULL,
+	.gpio_disable_free = NULL,
+	.gpio_set_direction = NULL,
+};
+
+/* ----- pinconf part ----- */
+
+int atmel_pio3_pin_config_read(struct atmel_pinctrl *pctrl, unsigned reg, unsigned pin_id, u32 *res)
+{
+	unsigned bank, pin;
+
+	bank = pin_id / pctrl->npins_per_bank;
+	pin = pin_id % pctrl->npins_per_bank;
+	printk("bank %u, pin %u\n", bank, pin);
+
+	return regmap_read(pctrl->regmap_base, bank * ATMEL_PIO3_BANK_OFFSET + reg, res);
+}
+
+void atmel_pio3_pin_config_write(struct atmel_pinctrl *pctrl, unsigned reg, unsigned pin_id)
+{
+	unsigned bank, mask, pin;
+
+	bank = pin_id / pctrl->npins_per_bank;
+	pin = pin_id % pctrl->npins_per_bank;
+	mask = 1 << pin;
+
+	regmap_write(pctrl->regmap_base,
+		     bank * ATMEL_PIO3_BANK_OFFSET +reg,
+		     mask);
+}
+
+static int atmel_pio3_pin_config_get(struct pinctrl_dev *pctldev,
+				     unsigned pin,
+				     unsigned long *config)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int arg = 0;
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned mask;
+	u32 res;
+	int ret;
+
+	mask = 1 << pin;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_PULL_UP:
+		ret = atmel_pio3_pin_config_read(pctrl, ATMEL_PIO3_PUSR, pin, &res);
+		if (ret)
+			return -EIO;
+		if (!(res & mask))
+			return -EINVAL;
+		arg = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		ret = atmel_pio3_pin_config_read(pctrl, ATMEL_PIO3_PPDSR, pin, &res);
+		if (ret)
+			return -EIO;
+		if (!(res & mask))
+			return -EINVAL;
+		arg = 1;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		ret = atmel_pio3_pin_config_read(pctrl, ATMEL_PIO3_PUSR, pin, &res);
+		if (ret)
+			return -EIO;
+		if (!(res & mask))
+			return -EINVAL;
+		arg = 1;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		ret = atmel_pio3_pin_config_read(pctrl, ATMEL_PIO3_MDSR, pin, &res);
+		if (ret)
+			return -EIO;
+		if (!(res & mask))
+			return -EINVAL;
+		arg = 1;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+	return 0;
+}
+
+static int atmel_pio3_pin_config_set(struct pinctrl_dev *pctldev,
+				     unsigned pin,
+				     unsigned long *configs,
+				     unsigned num_configs)
+{
+	struct atmel_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
+	int i;
+
+	for (i = 0; i < num_configs; i++) {
+		unsigned int param = pinconf_to_config_param(configs[i]);
+		//unsigned int arg = pinconf_to_config_argument(configs[i]);
+
+		dev_dbg(pctldev->dev, "%s: pin=%u, config=0x%lx\n",
+			__func__, pin, configs[i]);
+
+		switch(param) {
+		case PIN_CONFIG_BIAS_DISABLE:
+			atmel_pio3_pin_config_write(pctrl, ATMEL_PIO3_PUDR, pin);
+			atmel_pio3_pin_config_write(pctrl, ATMEL_PIO3_PPDDR, pin);
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			atmel_pio3_pin_config_write(pctrl, ATMEL_PIO3_PUER, pin);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			atmel_pio3_pin_config_write(pctrl, ATMEL_PIO3_PPDER, pin);
+			break;
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			atmel_pio3_pin_config_write(pctrl, ATMEL_PIO3_MDER, pin);
+			break;
+		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		case PIN_CONFIG_BIAS_BUS_HOLD:
+		case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+		case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		case PIN_CONFIG_DRIVE_STRENGTH:
+		case PIN_CONFIG_INPUT_ENABLE:
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		case PIN_CONFIG_INPUT_SCHMITT:
+		case PIN_CONFIG_INPUT_DEBOUNCE:
+		case PIN_CONFIG_POWER_SOURCE:
+		case PIN_CONFIG_SLEW_RATE:
+		case PIN_CONFIG_LOW_POWER_MODE:
+		case PIN_CONFIG_OUTPUT:
+		default:
+			dev_warn(pctldev->dev,
+				 "unsupported configuration parameter: %u\n",
+				 param);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops atmel_pio3_confops = {
+	.is_generic = true,
+	.pin_config_get = atmel_pio3_pin_config_get,
+	.pin_config_set = atmel_pio3_pin_config_set,
+	.pin_config_group_get = NULL,
+	.pin_config_group_set = NULL,
+	.pin_config_dbg_parse_modify = NULL,
+	.pin_config_dbg_show = NULL,
+	.pin_config_group_dbg_show = NULL,
+	.pin_config_config_dbg_show = NULL,
+};
+
+static struct pinctrl_desc atmel_sama5d4_pctrl_desc = {
+	.name = "atmel_sama5d4_pinctrl",
+	.pins = atmel_pins,
+	.npins = 160,
+	.complex_pin_desc = true,
+	.pctlops = &atmel_pctlops,
+	.pmxops = &atmel_pio3_pmxops,
+	.confops = &atmel_pio3_confops,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id atmel_pinctrl_of_match[] = {
+	{
+		.compatible = "atmel,sama5d4-pinctrl",
+		.data = &atmel_sama5d4_pctrl_desc,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, atmel_pinctrl_of_match);
+
+static struct pinctrl_desc *atmel_get_pctrl_desc(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+
+	match = of_match_node(atmel_pinctrl_of_match, pdev->dev.of_node);
+	if (!match)
+		return NULL;
+	return (struct pinctrl_desc *) match->data;
+}
+
+static int atmel_pinctrl_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct atmel_pinctrl *pctrl;
+	struct pinctrl_desc *pctrl_desc;
+	struct device_node *np = pdev->dev.of_node, *regmap_np;
+
+	struct device_node *defs_np, *group_np;
+	int i, j;
+	struct atmel_group *group;
+	unsigned pin_number;
+	const struct pinctrl_pin_desc *pin_desc;
+	u32	pingrp_pin;
+	int ioset;
+
+	if (!np) {
+		dev_err(&pdev->dev, "device tree node not found\n");
+		return -ENODEV;
+	}
+
+	pctrl = devm_kzalloc(&pdev->dev, sizeof(*pctrl), GFP_KERNEL);
+	if (!pctrl)
+		return -ENOMEM;
+
+	/* Get pinctrl descriptor according to the device used. */
+	pctrl_desc = atmel_get_pctrl_desc(pdev);
+	if (!pctrl_desc)
+		return -EINVAL;
+
+	/* Some registers are shared with the gpio controller. */
+	regmap_np = of_parse_phandle(np, "atmel,pio_reg", 0);
+	if (regmap_np) {
+		pctrl->regmap_base = syscon_node_to_regmap(regmap_np);
+		if (IS_ERR(pctrl->regmap_base)) {
+			dev_err(&pdev->dev, "can't get regmap\n");
+			return PTR_ERR(pctrl->regmap_base);
+		}
+	} else {
+		dev_err(&pdev->dev, "atmel,pio_reg property is missing\n");
+		return -EINVAL;
+	}
+
+	pctrl->npins_per_bank = 32;
+
+	/*  */
+	defs_np = of_find_node_by_name(np, "group_defs");
+	if (!defs_np) {
+		dev_err(&pdev->dev, "pinctrl_defs not found\n");
+		//TODO
+	}
+	/* Count funcs and groups. */
+	pctrl->ngroups = of_get_child_count(defs_np);
+
+	dev_dbg(&pdev->dev, "%u groups\n", pctrl->ngroups);
+
+	pctrl->groups = devm_kzalloc(&pdev->dev, sizeof(*pctrl->groups) * pctrl->ngroups, GFP_KERNEL);
+	//if (!groups) TODO
+	group = pctrl->groups;
+
+	dev_dbg(&pdev->dev, "parsing groups...\n");
+	i = 0;
+	ioset = -1;
+	for_each_child_of_node(defs_np, group_np) {
+		group->name = group_np->name;
+		group->npins = of_property_count_u32_elems(group_np, "pins");
+		dev_dbg(&pdev->dev, "%s with %u pin(s)\n",
+			group->name, group->npins);
+		group->pins = devm_kzalloc(&pdev->dev, sizeof(*group->pins) * group->npins, GFP_KERNEL);
+		//if (!group->pins) TODO
+		for (i = 0; i < group->npins; i++) {
+			ret = of_property_read_u32_index(group_np, "pins", i, &pingrp_pin);
+			//if (ret) TODO
+			group->pins[i] = pingrp_pin & PINCTRL_PIN_MASK;
+			if (ioset < 0)
+				ioset = pingrp_pin >> 16;
+			if ((pingrp_pin >> 16) != ioset)
+				dev_warn(&pdev->dev,
+				         "/!\\ pins from group %s are not using the same ioset /!\\\n",
+					 group->name);
+		}
+
+		group++;
+	}
+
+	/* debug */
+	for (i = 0; i < pctrl->ngroups; i++) {
+		group = &pctrl->groups[i];
+		dev_dbg(&pdev->dev, "registring %s, %u pin(s):\n",
+			group->name, group->npins);
+		for (j = 0; j < group->npins; j++) {
+			pin_number = group->pins[j];
+			pin_desc =  &pctrl_desc->pins[pin_number];
+			dev_dbg(&pdev->dev, "%s (%u)",
+				pin_desc->name,
+				pin_desc->number);
+		}
+	}
+	/* end of debug */
+
+	pctrl->pctrl = pinctrl_register(pctrl_desc, &pdev->dev, pctrl);
+	if (!pctrl->pctrl) {
+		dev_err(&pdev->dev, "pinctrl registration failed\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, pctrl);
+
+	dev_info(&pdev->dev, "atmel pinctrl initialized\n");
+
+	return 0;
+}
+
+int atmel_pinctrl_remove(struct platform_device *pdev)
+{
+	struct atmel_pinctrl *pctrl = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(pctrl->pctrl);
+
+	return 0;
+}
+
+static struct platform_driver atmel_pinctrl_driver = {
+	.driver = {
+		.name = "atmel-pinctrl",
+		.of_match_table = atmel_pinctrl_of_match,
+	},
+	.probe = atmel_pinctrl_probe,
+	.remove = atmel_pinctrl_remove,
+};
+
+module_platform_driver(atmel_pinctrl_driver);
+
+MODULE_AUTHOR(Ludovic Desroches <ludovic.desroches@atmel.com>);
+MODULE_DESCRIPTION("Atmel new pinctrl driver");
+MODULE_LICENSE("GPL");
-- 
2.2.0
