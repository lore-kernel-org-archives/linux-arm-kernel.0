From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 13 Aug 2014 19:16:21 +0300
Subject: [PATCH 3/4] gpio: syscon: reuse for keystone 2 socs
In-Reply-To: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
References: <1407946582-20927-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1407946582-20927-4-git-send-email-grygorii.strashko@ti.com>
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
 .../bindings/gpio/gpio-mctrl-keystone.txt          |   39 ++++++++++++++++++++
 drivers/gpio/gpio-syscon.c                         |   39 ++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt b/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt
new file mode 100644
index 0000000..0687f5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-mctrl-keystone.txt
@@ -0,0 +1,39 @@
+Keystone 2 DSP MCTRL GPIO controller bindings
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
+- compatible: should be "ti,keystone-mctrl-gpio"
+- ti,syscon-dev: phandle/offset pair. The phandle to syscon used to
+  access device state control registers and the offset of device's specific
+  registers within device state control registers range.
+- gpio-controller: Marks the device node as a gpio controller.
+- #gpio-cells: Should be 2.
+
+Please refer to gpio.txt in this directory for details of the common GPIO
+bindings used by client devices.
+
+Example:
+	dspgpio0: keystone_dsp_gpio at 02620240 {
+		compatible = "ti,keystone-mctrl-gpio";
+		ti,syscon-dev = <&devctrl 0x240>;
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
index 05d528f..8a7f715 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -145,11 +145,50 @@ static const struct syscon_gpio_data clps711x_mctrl_gpio = {
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
+	offs = priv->dreg_offset + priv->data->dat_bit_offset + offset;
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
+static const struct syscon_gpio_data keystone_mctrl_gpio = {
+	/* ARM Keystone 2 */
+	.compatible	= NULL,
+	.flags		= GPIO_SYSCON_FEAT_OUT,
+	.bit_count	= 28,
+	.dat_bit_offset	= 4,
+	.set		= keystone_gpio_set,
+};
+#endif
+
 static const struct of_device_id syscon_gpio_ids[] = {
 	{
 		.compatible	= "cirrus,clps711x-mctrl-gpio",
 		.data		= &clps711x_mctrl_gpio,
 	},
+#ifdef CONFIG_ARCH_KEYSTONE
+	{
+		.compatible	= "ti,keystone-mctrl-gpio",
+		.data		= &keystone_mctrl_gpio,
+	},
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, syscon_gpio_ids);
-- 
1.7.9.5
