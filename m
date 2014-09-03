From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 3 Sep 2014 20:05:33 +0300
Subject: [PATCH v3 2/4] gpio: syscon: retrive syscon node and regs offsets
 from dt
In-Reply-To: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
References: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1409763935-5713-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds handling of new "gpio,syscon-dev" DT property,
which allows to specify syscon node and data/direction registers
offsets in DT.

"gpio,syscon-dev" has following format:
	gpio,syscon-dev = <&syscon_dev data_reg_offset [direction_reg_offset]>;

where
 - syscon_dev - phandle on syscon node
 - data_reg_offset - offset of data register (in bytes)
 - direction_reg_offset - offset of dirrection register (optional, in bytes)

for example:
	gpio,syscon-dev = <&devctrl 0x254>;

In such way, the support of multiple Syscon GPIO devices is added.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-syscon.c | 51 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index d50ff93..049391b 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -55,6 +55,8 @@ struct syscon_gpio_priv {
 	struct gpio_chip		chip;
 	struct regmap			*syscon;
 	const struct syscon_gpio_data	*data;
+	u32				dreg_offset;
+	u32				dir_reg_offset;
 };
 
 static inline struct syscon_gpio_priv *to_syscon_gpio(struct gpio_chip *chip)
@@ -65,9 +67,11 @@ static inline struct syscon_gpio_priv *to_syscon_gpio(struct gpio_chip *chip)
 static int syscon_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
-	unsigned int val, offs = priv->data->dat_bit_offset + offset;
+	unsigned int val, offs;
 	int ret;
 
+	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
+
 	ret = regmap_read(priv->syscon,
 			  (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE, &val);
 	if (ret)
@@ -79,7 +83,9 @@ static int syscon_gpio_get(struct gpio_chip *chip, unsigned offset)
 static void syscon_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 {
 	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
-	unsigned int offs = priv->data->dat_bit_offset + offset;
+	unsigned int offs;
+
+	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
 
 	regmap_update_bits(priv->syscon,
 			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
@@ -92,7 +98,10 @@ static int syscon_gpio_dir_in(struct gpio_chip *chip, unsigned offset)
 	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
 
 	if (priv->data->flags & GPIO_SYSCON_FEAT_DIR) {
-		unsigned int offs = priv->data->dir_bit_offset + offset;
+		unsigned int offs;
+
+		offs = priv->dir_reg_offset +
+		       priv->data->dir_bit_offset + offset;
 
 		regmap_update_bits(priv->syscon,
 				   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
@@ -107,7 +116,10 @@ static int syscon_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int val)
 	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
 
 	if (priv->data->flags & GPIO_SYSCON_FEAT_DIR) {
-		unsigned int offs = priv->data->dir_bit_offset + offset;
+		unsigned int offs;
+
+		offs = priv->dir_reg_offset +
+		       priv->data->dir_bit_offset + offset;
 
 		regmap_update_bits(priv->syscon,
 				   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
@@ -142,6 +154,8 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *of_id = of_match_device(syscon_gpio_ids, dev);
 	struct syscon_gpio_priv *priv;
+	struct device_node *np = dev->of_node;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -149,10 +163,31 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 
 	priv->data = of_id->data;
 
-	priv->syscon =
-		syscon_regmap_lookup_by_compatible(priv->data->compatible);
-	if (IS_ERR(priv->syscon))
-		return PTR_ERR(priv->syscon);
+	if (priv->data->compatible) {
+		priv->syscon = syscon_regmap_lookup_by_compatible(
+					priv->data->compatible);
+		if (IS_ERR(priv->syscon))
+			return PTR_ERR(priv->syscon);
+	} else {
+		priv->syscon =
+			syscon_regmap_lookup_by_phandle(np, "gpio,syscon-dev");
+		if (IS_ERR(priv->syscon))
+			return PTR_ERR(priv->syscon);
+
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1,
+						 &priv->dreg_offset);
+		if (ret)
+			dev_err(dev, "can't read the data register offset!\n");
+
+		priv->dreg_offset <<= 3;
+
+		ret = of_property_read_u32_index(np, "gpio,syscon-dev", 2,
+						 &priv->dir_reg_offset);
+		if (ret)
+			dev_err(dev, "can't read the dir register offset!\n");
+
+		priv->dir_reg_offset <<= 3;
+	}
 
 	priv->chip.dev = dev;
 	priv->chip.owner = THIS_MODULE;
-- 
1.9.1
