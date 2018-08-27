From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 27 Aug 2018 18:10:03 +0800
Subject: [PATCH 04/16] pinctrl: mediatek: extend struct mtk_pin_desc to
 pinctrl-mtk-common-v2.c
In-Reply-To: <cover.1535363951.git.sean.wang@mediatek.com>
References: <cover.1535363951.git.sean.wang@mediatek.com>
Message-ID: <97a03bd4a45db17d72c2f8214406e4e4a6903cf8.1535363951.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patch introduces a data structure mtk_pin_desc, which is used to
provide information per pin characteristic such as driving current,
eint number and a driving index, that is used to lookup table describing
the details about the groups of driving current by which the pin is able
to adjust the driving strength so that the driver could get the
appropriate driving group when calls .pin_config_get()/set().

Signed-off-by: Ryder.Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-moore.c         |  49 ++++--
 drivers/pinctrl/mediatek/pinctrl-moore.h         |   8 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 213 ++++++++++++-----------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  28 +++
 4 files changed, 183 insertions(+), 115 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.c b/drivers/pinctrl/mediatek/pinctrl-moore.c
index fef8db8..ba7511d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.c
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.c
@@ -402,31 +402,36 @@ static int mtk_gpio_direction_output(struct gpio_chip *chip, unsigned int gpio,
 static int mtk_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-	unsigned long eint_n;
+	const struct mtk_pin_desc *desc;
 
 	if (!hw->eint)
 		return -ENOTSUPP;
 
-	eint_n = offset;
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
 
-	return mtk_eint_find_irq(hw->eint, eint_n);
+	if (desc->eint_n == EINT_NA)
+		return -ENOTSUPP;
+
+	return mtk_eint_find_irq(hw->eint, desc->eint_n);
 }
 
 static int mtk_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			       unsigned long config)
 {
 	struct mtk_pinctrl *hw = gpiochip_get_data(chip);
-	unsigned long eint_n;
+	const struct mtk_pin_desc *desc;
 	u32 debounce;
 
+	desc = (const struct mtk_pin_desc *)&hw->soc->pins[offset];
+
 	if (!hw->eint ||
-	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
+	    pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE ||
+	    desc->eint_n == EINT_NA)
 		return -ENOTSUPP;
 
 	debounce = pinconf_to_config_argument(config);
-	eint_n = offset;
 
-	return mtk_eint_set_debounce(hw->eint, eint_n, debounce);
+	return mtk_eint_set_debounce(hw->eint, desc->eint_n, debounce);
 }
 
 static int mtk_build_gpiochip(struct mtk_pinctrl *hw, struct device_node *np)
@@ -513,16 +518,40 @@ static int mtk_build_functions(struct mtk_pinctrl *hw)
 	return 0;
 }
 
+static int mtk_xt_find_eint_num(struct mtk_pinctrl *hw,
+				unsigned long eint_n)
+{
+	const struct mtk_pin_desc *desc;
+	int i = 0;
+
+	desc = (const struct mtk_pin_desc *)hw->soc->pins;
+
+	while (i < hw->soc->npins) {
+		if (desc[i].eint_n == eint_n)
+			return desc[i].number;
+		i++;
+	}
+
+	return EINT_NA;
+}
+
 static int mtk_xt_get_gpio_n(void *data, unsigned long eint_n,
 			     unsigned int *gpio_n,
 			     struct gpio_chip **gpio_chip)
 {
 	struct mtk_pinctrl *hw = (struct mtk_pinctrl *)data;
+	const struct mtk_pin_desc *desc;
 
+	desc = (const struct mtk_pin_desc *)hw->soc->pins;
 	*gpio_chip = &hw->chip;
-	*gpio_n = eint_n;
 
-	return 0;
+	/* Be greedy to guess first gpio_n is equal to eint_n */
+	if (desc[eint_n].eint_n == eint_n)
+		*gpio_n = eint_n;
+	else
+		*gpio_n = mtk_xt_find_eint_num(hw, eint_n);
+
+	return *gpio_n == EINT_NA ? -EINVAL : 0;
 }
 
 static int mtk_xt_get_gpio_state(void *data, unsigned long eint_n)
@@ -635,7 +664,7 @@ int mtk_moore_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(hw->base);
 
 	/* Setup pins descriptions per SoC types */
-	mtk_desc.pins = hw->soc->pins;
+	mtk_desc.pins = (const struct pinctrl_pin_desc *)hw->soc->pins;
 	mtk_desc.npins = hw->soc->npins;
 	mtk_desc.num_custom_params = ARRAY_SIZE(mtk_custom_bindings);
 	mtk_desc.custom_params = mtk_custom_bindings;
diff --git a/drivers/pinctrl/mediatek/pinctrl-moore.h b/drivers/pinctrl/mediatek/pinctrl-moore.h
index 72cbf37..6b1d051 100644
--- a/drivers/pinctrl/mediatek/pinctrl-moore.h
+++ b/drivers/pinctrl/mediatek/pinctrl-moore.h
@@ -30,6 +30,14 @@
 #include "pinctrl-mtk-common-v2.h"
 
 #define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }
+
+#define MTK_PIN(_number, _name, _eint_n, _drv_n) {	\
+		.number = _number,			\
+		.name = _name,				\
+		.eint_n = _eint_n,			\
+		.drv_n = _drv_n,			\
+	}
+
 #define PINCTRL_PIN_GROUP(name, id)			\
 	{						\
 		name,					\
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index b9c1680..a0045bb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -8,6 +8,9 @@
 
 #include "pinctrl-moore.h"
 
+#define MT7622_PIN(_number, _name)					\
+	MTK_PIN(_number, _name, _number, DRV_GRP0)
+
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
 	PIN_FIELD(0, 0, 0x320, 0x10, 16, 4),
 	PIN_FIELD(1, 4, 0x3a0, 0x10, 16, 4),
@@ -149,110 +152,110 @@ static const struct mtk_pin_reg_calc mt7622_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_RDSEL] = MTK_RANGE(mt7622_pin_rdsel_range),
 };
 
-static const struct pinctrl_pin_desc mt7622_pins[] = {
-	PINCTRL_PIN(0, "GPIO_A"),
-	PINCTRL_PIN(1, "I2S1_IN"),
-	PINCTRL_PIN(2, "I2S1_OUT"),
-	PINCTRL_PIN(3, "I2S_BCLK"),
-	PINCTRL_PIN(4, "I2S_WS"),
-	PINCTRL_PIN(5, "I2S_MCLK"),
-	PINCTRL_PIN(6, "TXD0"),
-	PINCTRL_PIN(7, "RXD0"),
-	PINCTRL_PIN(8, "SPI_WP"),
-	PINCTRL_PIN(9, "SPI_HOLD"),
-	PINCTRL_PIN(10, "SPI_CLK"),
-	PINCTRL_PIN(11, "SPI_MOSI"),
-	PINCTRL_PIN(12, "SPI_MISO"),
-	PINCTRL_PIN(13, "SPI_CS"),
-	PINCTRL_PIN(14, "I2C_SDA"),
-	PINCTRL_PIN(15, "I2C_SCL"),
-	PINCTRL_PIN(16, "I2S2_IN"),
-	PINCTRL_PIN(17, "I2S3_IN"),
-	PINCTRL_PIN(18, "I2S4_IN"),
-	PINCTRL_PIN(19, "I2S2_OUT"),
-	PINCTRL_PIN(20, "I2S3_OUT"),
-	PINCTRL_PIN(21, "I2S4_OUT"),
-	PINCTRL_PIN(22, "GPIO_B"),
-	PINCTRL_PIN(23, "MDC"),
-	PINCTRL_PIN(24, "MDIO"),
-	PINCTRL_PIN(25, "G2_TXD0"),
-	PINCTRL_PIN(26, "G2_TXD1"),
-	PINCTRL_PIN(27, "G2_TXD2"),
-	PINCTRL_PIN(28, "G2_TXD3"),
-	PINCTRL_PIN(29, "G2_TXEN"),
-	PINCTRL_PIN(30, "G2_TXC"),
-	PINCTRL_PIN(31, "G2_RXD0"),
-	PINCTRL_PIN(32, "G2_RXD1"),
-	PINCTRL_PIN(33, "G2_RXD2"),
-	PINCTRL_PIN(34, "G2_RXD3"),
-	PINCTRL_PIN(35, "G2_RXDV"),
-	PINCTRL_PIN(36, "G2_RXC"),
-	PINCTRL_PIN(37, "NCEB"),
-	PINCTRL_PIN(38, "NWEB"),
-	PINCTRL_PIN(39, "NREB"),
-	PINCTRL_PIN(40, "NDL4"),
-	PINCTRL_PIN(41, "NDL5"),
-	PINCTRL_PIN(42, "NDL6"),
-	PINCTRL_PIN(43, "NDL7"),
-	PINCTRL_PIN(44, "NRB"),
-	PINCTRL_PIN(45, "NCLE"),
-	PINCTRL_PIN(46, "NALE"),
-	PINCTRL_PIN(47, "NDL0"),
-	PINCTRL_PIN(48, "NDL1"),
-	PINCTRL_PIN(49, "NDL2"),
-	PINCTRL_PIN(50, "NDL3"),
-	PINCTRL_PIN(51, "MDI_TP_P0"),
-	PINCTRL_PIN(52, "MDI_TN_P0"),
-	PINCTRL_PIN(53, "MDI_RP_P0"),
-	PINCTRL_PIN(54, "MDI_RN_P0"),
-	PINCTRL_PIN(55, "MDI_TP_P1"),
-	PINCTRL_PIN(56, "MDI_TN_P1"),
-	PINCTRL_PIN(57, "MDI_RP_P1"),
-	PINCTRL_PIN(58, "MDI_RN_P1"),
-	PINCTRL_PIN(59, "MDI_RP_P2"),
-	PINCTRL_PIN(60, "MDI_RN_P2"),
-	PINCTRL_PIN(61, "MDI_TP_P2"),
-	PINCTRL_PIN(62, "MDI_TN_P2"),
-	PINCTRL_PIN(63, "MDI_TP_P3"),
-	PINCTRL_PIN(64, "MDI_TN_P3"),
-	PINCTRL_PIN(65, "MDI_RP_P3"),
-	PINCTRL_PIN(66, "MDI_RN_P3"),
-	PINCTRL_PIN(67, "MDI_RP_P4"),
-	PINCTRL_PIN(68, "MDI_RN_P4"),
-	PINCTRL_PIN(69, "MDI_TP_P4"),
-	PINCTRL_PIN(70, "MDI_TN_P4"),
-	PINCTRL_PIN(71, "PMIC_SCL"),
-	PINCTRL_PIN(72, "PMIC_SDA"),
-	PINCTRL_PIN(73, "SPIC1_CLK"),
-	PINCTRL_PIN(74, "SPIC1_MOSI"),
-	PINCTRL_PIN(75, "SPIC1_MISO"),
-	PINCTRL_PIN(76, "SPIC1_CS"),
-	PINCTRL_PIN(77, "GPIO_D"),
-	PINCTRL_PIN(78, "WATCHDOG"),
-	PINCTRL_PIN(79, "RTS3_N"),
-	PINCTRL_PIN(80, "CTS3_N"),
-	PINCTRL_PIN(81, "TXD3"),
-	PINCTRL_PIN(82, "RXD3"),
-	PINCTRL_PIN(83, "PERST0_N"),
-	PINCTRL_PIN(84, "PERST1_N"),
-	PINCTRL_PIN(85, "WLED_N"),
-	PINCTRL_PIN(86, "EPHY_LED0_N"),
-	PINCTRL_PIN(87, "AUXIN0"),
-	PINCTRL_PIN(88, "AUXIN1"),
-	PINCTRL_PIN(89, "AUXIN2"),
-	PINCTRL_PIN(90, "AUXIN3"),
-	PINCTRL_PIN(91, "TXD4"),
-	PINCTRL_PIN(92, "RXD4"),
-	PINCTRL_PIN(93, "RTS4_N"),
-	PINCTRL_PIN(94, "CTS4_N"),
-	PINCTRL_PIN(95, "PWM1"),
-	PINCTRL_PIN(96, "PWM2"),
-	PINCTRL_PIN(97, "PWM3"),
-	PINCTRL_PIN(98, "PWM4"),
-	PINCTRL_PIN(99, "PWM5"),
-	PINCTRL_PIN(100, "PWM6"),
-	PINCTRL_PIN(101, "PWM7"),
-	PINCTRL_PIN(102, "GPIO_E"),
+static const struct mtk_pin_desc mt7622_pins[] = {
+	MT7622_PIN(0, "GPIO_A"),
+	MT7622_PIN(1, "I2S1_IN"),
+	MT7622_PIN(2, "I2S1_OUT"),
+	MT7622_PIN(3, "I2S_BCLK"),
+	MT7622_PIN(4, "I2S_WS"),
+	MT7622_PIN(5, "I2S_MCLK"),
+	MT7622_PIN(6, "TXD0"),
+	MT7622_PIN(7, "RXD0"),
+	MT7622_PIN(8, "SPI_WP"),
+	MT7622_PIN(9, "SPI_HOLD"),
+	MT7622_PIN(10, "SPI_CLK"),
+	MT7622_PIN(11, "SPI_MOSI"),
+	MT7622_PIN(12, "SPI_MISO"),
+	MT7622_PIN(13, "SPI_CS"),
+	MT7622_PIN(14, "I2C_SDA"),
+	MT7622_PIN(15, "I2C_SCL"),
+	MT7622_PIN(16, "I2S2_IN"),
+	MT7622_PIN(17, "I2S3_IN"),
+	MT7622_PIN(18, "I2S4_IN"),
+	MT7622_PIN(19, "I2S2_OUT"),
+	MT7622_PIN(20, "I2S3_OUT"),
+	MT7622_PIN(21, "I2S4_OUT"),
+	MT7622_PIN(22, "GPIO_B"),
+	MT7622_PIN(23, "MDC"),
+	MT7622_PIN(24, "MDIO"),
+	MT7622_PIN(25, "G2_TXD0"),
+	MT7622_PIN(26, "G2_TXD1"),
+	MT7622_PIN(27, "G2_TXD2"),
+	MT7622_PIN(28, "G2_TXD3"),
+	MT7622_PIN(29, "G2_TXEN"),
+	MT7622_PIN(30, "G2_TXC"),
+	MT7622_PIN(31, "G2_RXD0"),
+	MT7622_PIN(32, "G2_RXD1"),
+	MT7622_PIN(33, "G2_RXD2"),
+	MT7622_PIN(34, "G2_RXD3"),
+	MT7622_PIN(35, "G2_RXDV"),
+	MT7622_PIN(36, "G2_RXC"),
+	MT7622_PIN(37, "NCEB"),
+	MT7622_PIN(38, "NWEB"),
+	MT7622_PIN(39, "NREB"),
+	MT7622_PIN(40, "NDL4"),
+	MT7622_PIN(41, "NDL5"),
+	MT7622_PIN(42, "NDL6"),
+	MT7622_PIN(43, "NDL7"),
+	MT7622_PIN(44, "NRB"),
+	MT7622_PIN(45, "NCLE"),
+	MT7622_PIN(46, "NALE"),
+	MT7622_PIN(47, "NDL0"),
+	MT7622_PIN(48, "NDL1"),
+	MT7622_PIN(49, "NDL2"),
+	MT7622_PIN(50, "NDL3"),
+	MT7622_PIN(51, "MDI_TP_P0"),
+	MT7622_PIN(52, "MDI_TN_P0"),
+	MT7622_PIN(53, "MDI_RP_P0"),
+	MT7622_PIN(54, "MDI_RN_P0"),
+	MT7622_PIN(55, "MDI_TP_P1"),
+	MT7622_PIN(56, "MDI_TN_P1"),
+	MT7622_PIN(57, "MDI_RP_P1"),
+	MT7622_PIN(58, "MDI_RN_P1"),
+	MT7622_PIN(59, "MDI_RP_P2"),
+	MT7622_PIN(60, "MDI_RN_P2"),
+	MT7622_PIN(61, "MDI_TP_P2"),
+	MT7622_PIN(62, "MDI_TN_P2"),
+	MT7622_PIN(63, "MDI_TP_P3"),
+	MT7622_PIN(64, "MDI_TN_P3"),
+	MT7622_PIN(65, "MDI_RP_P3"),
+	MT7622_PIN(66, "MDI_RN_P3"),
+	MT7622_PIN(67, "MDI_RP_P4"),
+	MT7622_PIN(68, "MDI_RN_P4"),
+	MT7622_PIN(69, "MDI_TP_P4"),
+	MT7622_PIN(70, "MDI_TN_P4"),
+	MT7622_PIN(71, "PMIC_SCL"),
+	MT7622_PIN(72, "PMIC_SDA"),
+	MT7622_PIN(73, "SPIC1_CLK"),
+	MT7622_PIN(74, "SPIC1_MOSI"),
+	MT7622_PIN(75, "SPIC1_MISO"),
+	MT7622_PIN(76, "SPIC1_CS"),
+	MT7622_PIN(77, "GPIO_D"),
+	MT7622_PIN(78, "WATCHDOG"),
+	MT7622_PIN(79, "RTS3_N"),
+	MT7622_PIN(80, "CTS3_N"),
+	MT7622_PIN(81, "TXD3"),
+	MT7622_PIN(82, "RXD3"),
+	MT7622_PIN(83, "PERST0_N"),
+	MT7622_PIN(84, "PERST1_N"),
+	MT7622_PIN(85, "WLED_N"),
+	MT7622_PIN(86, "EPHY_LED0_N"),
+	MT7622_PIN(87, "AUXIN0"),
+	MT7622_PIN(88, "AUXIN1"),
+	MT7622_PIN(89, "AUXIN2"),
+	MT7622_PIN(90, "AUXIN3"),
+	MT7622_PIN(91, "TXD4"),
+	MT7622_PIN(92, "RXD4"),
+	MT7622_PIN(93, "RTS4_N"),
+	MT7622_PIN(94, "CTS4_N"),
+	MT7622_PIN(95, "PWM1"),
+	MT7622_PIN(96, "PWM2"),
+	MT7622_PIN(97, "PWM3"),
+	MT7622_PIN(98, "PWM4"),
+	MT7622_PIN(99, "PWM5"),
+	MT7622_PIN(100, "PWM6"),
+	MT7622_PIN(101, "PWM7"),
+	MT7622_PIN(102, "GPIO_E"),
 };
 
 /* List all groups consisting of these pins dedicated to the enablement of
@@ -755,7 +758,7 @@ static const struct mtk_eint_hw mt7622_eint_hw = {
 
 static const struct mtk_pin_soc mt7622_data = {
 	.reg_cal = mt7622_reg_cals,
-	.pins = mt7622_pins,
+	.pins = (const struct pinctrl_pin_desc *)mt7622_pins,
 	.npins = ARRAY_SIZE(mt7622_pins),
 	.grps = mt7622_groups,
 	.ngrps = ARRAY_SIZE(mt7622_groups),
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index f05c802..174e75b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -15,6 +15,8 @@
 #define MTK_DISABLE    0
 #define MTK_ENABLE     1
 
+#define EINT_NA 255
+
 #define PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
 			_x_bits, _sz_reg, _fixed) {			\
 		.s_pin = _s_pin,					\
@@ -52,6 +54,17 @@ enum {
 	PINCTRL_PIN_REG_MAX,
 };
 
+/* Group the pins by the driving current */
+enum {
+	DRV_FIXED,
+	DRV_GRP0,
+	DRV_GRP1,
+	DRV_GRP2,
+	DRV_GRP3,
+	DRV_GRP4,
+	DRV_GRP_MAX,
+};
+
 /* struct mtk_pin_field - the structure that holds the information of the field
  *			  used to describe the attribute for the pin
  * @offset:		the register offset relative to the base address
@@ -103,6 +116,21 @@ struct mtk_pin_reg_calc {
 	unsigned int nranges;
 };
 
+/**
+ * struct mtk_pin_desc - the structure that providing information
+ *			       for each pin of chips
+ * @number:		unique pin number from the global pin number space
+ * @name:		name for this pin
+ * @eint_n:		the eint number for this pin
+ * @drv_n:		the index with the driving group
+ */
+struct mtk_pin_desc {
+	unsigned int number;
+	const char *name;
+	u8 eint_n;
+	u8 drv_n;
+};
+
 /* struct mtk_pin_soc - the structure that holds SoC-specific data */
 struct mtk_pin_soc {
 	const struct mtk_pin_reg_calc	*reg_cal;
-- 
2.7.4
