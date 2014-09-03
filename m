From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 3 Sep 2014 20:05:32 +0300
Subject: [PATCH v3 1/4] gpio: syscon: add soc specific callback to assign
 output value
In-Reply-To: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
References: <1409763935-5713-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1409763935-5713-2-git-send-email-grygorii.strashko@ti.com>
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
 drivers/gpio/gpio-syscon.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 30884fb..d50ff93 100644
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
@@ -111,7 +115,7 @@ static int syscon_gpio_dir_out(struct gpio_chip *chip, unsigned offset, int val)
 				   BIT(offs % SYSCON_REG_BITS));
 	}
 
-	syscon_gpio_set(chip, offset, val);
+	priv->data->set(chip, offset, val);
 
 	return 0;
 }
@@ -159,7 +163,7 @@ static int syscon_gpio_probe(struct platform_device *pdev)
 	if (priv->data->flags & GPIO_SYSCON_FEAT_IN)
 		priv->chip.direction_input = syscon_gpio_dir_in;
 	if (priv->data->flags & GPIO_SYSCON_FEAT_OUT) {
-		priv->chip.set = syscon_gpio_set;
+		priv->chip.set = priv->data->set ? : syscon_gpio_set;
 		priv->chip.direction_output = syscon_gpio_dir_out;
 	}
 
-- 
1.9.1
