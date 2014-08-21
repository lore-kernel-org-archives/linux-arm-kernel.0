From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 19:23:22 +0300
Subject: [PATCH v2 2/3] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
References: <53ECE9B1.4060303@ti.com>
 <1408638203-8246-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1408638203-8246-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Keystone SOCs, ARM host can send interrupts to DSP cores using the
DSP GPIO controller IP. Each DSP GPIO controller provides 28 IRQ signals for
each DSP core. This is one of the component used by the IPC mechanism used
on Keystone SOCs.

Keystone 2 DSP GPIO controller has specific features:
- each GPIO can be configured only as output pin;
- setting GPIO value to 1 causes IRQ generation on target DSP core;
- reading pin value returns 0 - if IRQ was handled or 1 - IRQ is still
  pending.

This patch updates gpio-syscon driver to be reused by Keystone 2 SoCs,
because the Keystone 2 DSP GPIO controller is controlled through Syscon
devices and, as requested by Linus Walleij, such kind of GPIO controllers
should be integrated with drivers/gpio/gpio-syscon.c driver.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../bindings/gpio/gpio-mctrl-keystone.txt          |   42 +++++++
 drivers/gpio/gpio-syscon.c                         |  131 ++++++++++++++++++++
 2 files changed, 173 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt b/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt
new file mode 100644
index 0000000..d3858aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt
@@ -0,0 +1,42 @@
+Keystone 2 DSP GPIO controller bindings
+
+HOST OS userland running on ARM can send interrupts to DSP cores using
+the DSP GPIO controller IP. It provides 28 IRQ signals per each DSP core.
+This is one of the component used by the IPC mechanism used on Keystone SOCs.
+
+For example TCI6638K2K SoC has 8 DSP GPIO controllers:
+ - 8 for C66x CorePacx CPUs 0-7
+
+Keystone 2 DSP GPIO controller has specific features:
+- each GPIO can be configured only as output pin;
+- setting GPIO value to 1 causes IRQ generation on target DSP core;
+- reading pin value returns 0 - if IRQ was handled or 1 - IRQ is still
+  pending.
+
+Required Properties:
+- compatible: should be "ti,keystone-dsp-gpio0" or
+			"ti,keystone-dsp-gpio1" or
+			"ti,keystone-dsp-gpio2" or
+			"ti,keystone-dsp-gpio3" or
+			"ti,keystone-dsp-gpio4" or
+			"ti,keystone-dsp-gpio5" or
+			"ti,keystone-dsp-gpio6" or
+			"ti,keystone-dsp-gpio7" or
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be 2.
+
+Please refer to gpio.txt in this directory for details of the common GPIO
+bindings used by client devices.
+
+Example:
+	dspgpio0: keystone_dsp_gpio at 02620240 {
+		compatible = "ti,keystone-mctrl-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	dsp0: dsp0 {
+		compatible = "linux,rproc-user";
+		...
+		kick-gpio = <&dspgpio0 27>;
+	};
diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 03b4699..0b5f998 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -133,11 +133,142 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
 	.dat_bit_offset	= 0x40 * 8 + 8,
 };
 
+#ifdef CONFIG_ARCH_KEYSTONE
+#define KEYSTONE_LOCK_BIT BIT(0)
+
+static void keystone_gpio_set(struct gpio_chip *chip, unsigned offset, int val)
+{
+	struct syscon_gpio_priv *priv = to_syscon_gpio(chip);
+	unsigned int offs;
+	int ret;
+
+	offs = priv->data->dat_bit_offset + offset;
+
+	if (!val)
+		return;
+
+	ret = regmap_update_bits(
+			priv->syscon,
+			(offs / SYSCON_REG_BITS) * SYSCON_REG_SIZE,
+			BIT(offs % SYSCON_REG_BITS) | KEYSTONE_LOCK_BIT,
+			BIT(offs % SYSCON_REG_BITS) | KEYSTONE_LOCK_BIT);
+	if (ret < 0)
+		dev_err(chip->dev, "gpio write failed ret(%d)\n", ret);
+}
+
+static const struct syscon_gpio_data keystone_dsp_gpio0 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x240 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio1 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x244 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio2 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x248 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio3 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x24c * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio4 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x250 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio5 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x254 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio6 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x258 * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+static const struct syscon_gpio_data keystone_dsp_gpio7 = {
+	/* ARM Keystone 2 */
+	.compatible	= "ti,keystone-devctrl",
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 0x25c * 8 + 4,
+	.set		= keystone_gpio_set,
+};
+
+#endif
+
 static const struct of_device_id syscon_gpio_ids[] = {
 	{
 		.compatible	= "cirrus,clps711x-mctrl-gpio",
 		.data		= &clps711x_mctrl_gpio,
 	},
+#ifdef CONFIG_ARCH_KEYSTONE
+	{
+		.compatible	= "ti,keystone-dsp-gpio0",
+		.data		= &keystone_dsp_gpio0,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio1",
+		.data		= &keystone_dsp_gpio1,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio2",
+		.data		= &keystone_dsp_gpio2,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio3",
+		.data		= &keystone_dsp_gpio3,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio4",
+		.data		= &keystone_dsp_gpio5,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio5",
+		.data		= &keystone_dsp_gpio6,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio6",
+		.data		= &keystone_dsp_gpio6,
+	},
+	{
+		.compatible	= "ti,keystone-dsp-gpio7",
+		.data		= &keystone_dsp_gpio7,
+	},
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
1.7.9.5
