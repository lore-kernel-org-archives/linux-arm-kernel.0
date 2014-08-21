From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 19:23:21 +0300
Subject: [PATCH v2 1/3] gpio: syscon: add soc specific callback to assign
 output value
In-Reply-To: <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
References: <53ECE9B1.4060303@ti.com>
 <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408638203-8246-2-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs (like Keystone) may require to perform special
sequence of operations to assign output GPIO value, so default
implementation of .set() callback from gpio-syscon driver
can't be used.

Hence, add optional, SoC specific callback to assign output
gpio value.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-syscon.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 30884fb..03b4699 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -37,6 +37,8 @@
  * dat_bit_offset:	Offset (in bits) to the first GPIO bit.
  * dir_bit_offset:	Optional offset (in bits) to the first bit to switch
  *			GPIO direction (Used with GPIO_SYSCON_FEAT_DIR flag).
+ * set:		HW specific callback to assigns output value
+ *			for signal "offset"
  */
 
 struct syscon_gpio_data {
@@ -45,6 +47,8 @@ struct syscon_gpio_data {
 	unsigned int	bit_count;
 	unsigned int	dat_bit_offset;
 	unsigned int	dir_bit_offset;
+	void		(*set)(struct gpio_chip *chip,
+			       unsigned offset, int value);
 };
 
 struct syscon_gpio_priv {
@@ -77,6 +81,11 @@ static void syscon_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
 	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
 	unsigned int offs = priv->data->dat_bit_offset + offset;
 
+	if (priv->data->set) {
+		priv->data->set(chip, offset, val);
+		return;
+	}
+
 	regmap_update_bits(priv->syscon,
 			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
 			   BIT(offs % SYSCON_REG_BITS),
-- 
1.7.9.5
