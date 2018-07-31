From: djw@t-chip.com.cn (djw at t-chip.com.cn)
Date: Tue, 31 Jul 2018 13:59:19 +0800
Subject: [PATCH v4 1/4] gpio: syscon: rockchip: add GRF GPIO support for rk3328
In-Reply-To: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
References: <1533016762-5268-1-git-send-email-djw@t-chip.com.cn>
Message-ID: <1533016762-5268-2-git-send-email-djw@t-chip.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Levin Du <djw@t-chip.com.cn>

In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
mute control, can also be used for general purpose. It is manipulated by
the GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI
pins can also be set in the same way.

Currently this GRF GPIO controller only supports the mute pin. If needed
in the future, the HDMI pins support can also be added.

Signed-off-by: Levin Du <djw@t-chip.com.cn>

---

Changes in v4:
- Rename the GPIO binding to "rockchip,rk3328-grf-gpio"

Changes in v3:
- Change from general gpio-syscon to specific rk3328-gpio-mute

Changes in v2:
- Rename gpio_syscon10 to gpio_mute in doc

Changes in v1:
- Refactured for general gpio-syscon usage for Rockchip SoCs.
- Add doc rockchip,gpio-syscon.txt

 .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     | 32 ++++++++++++++++++++++
 drivers/gpio/gpio-syscon.c                         | 31 +++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt
new file mode 100644
index 0000000..f9231df
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt
@@ -0,0 +1,32 @@
+Rockchip RK3328 GRF (General Register Files) GPIO controller.
+
+In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec mute
+control, can also be used for general purpose. It is manipulated by the
+GRF_SOC_CON10 register in GRF. Aside from the GPIO_MUTE pin, the HDMI pins can
+also be set in the same way.
+
+Currently this GPIO controller only supports the mute pin. If needed in the
+future, the HDMI pins support can also be added.
+
+Required properties:
+- compatible: Should contain "rockchip,rk3328-grf-gpio".
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be 2. The first cell is the pin number and
+  the second cell is used to specify the gpio polarity:
+    0 = Active high,
+    1 = Active low.
+
+Example:
+
+	grf: syscon at ff100000 {
+		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
+
+		grf_gpio: grf-gpio {
+			compatible = "rockchip,rk3328-grf-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
+Note: The grf_gpio node should be declared as the child of the GRF (General
+Register File) node. The GPIO_MUTE pin is referred to as <&grf_gpio 0>.
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 8b0a69c..b9b5842 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -135,6 +135,33 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
 	.dat_bit_offset	= 0x40 * 8 + 8,
 };
 
+static void rockchip_gpio_set(struct gpio_chip *chip, unsigned int offset,
+			      int val)
+{
+	struct syscon_gpio_priv *priv = gpiochip_get_data(chip);
+	unsigned int offs;
+	u8 bit;
+	u32 data;
+	int ret;
+
+	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
+	bit = offs % SYSCON_REG_BITS;
+	data = (val ? BIT(bit) : 0) | BIT(bit + 16);
+	ret = regmap_write(priv->syscon,
+			   (offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
+			   data);
+	if (ret < 0)
+		dev_err(chip->parent, "gpio write failed ret(%d)\n", ret);
+}
+
+static const struct syscon_gpio_data rockchip_rk3328_gpio_mute = {
+	/* RK3328 GPIO_MUTE is an output only pin at GRF_SOC_CON10[1] */
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 1,
+	.dat_bit_offset = 0x0428 * 8 + 1,
+	.set		= rockchip_gpio_set,
+};
+
 #define KEYSTONE_LOCK_BIT BIT(0)
 
 static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
@@ -175,6 +202,10 @@ static const struct of_device_id syscon_gpio_ids[] = {
 		.compatible	= "ti,keystone-dsp-gpio",
 		.data		= &keystone_dsp_gpio,
 	},
+	{
+		.compatible	= "rockchip,rk3328-grf-gpio",
+		.data		= &rockchip_rk3328_gpio_mute,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
2.7.4
