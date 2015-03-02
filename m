From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Mar 2015 18:28:43 +0100
Subject: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator
 quirk
Message-ID: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The r8a7791/koelsch development board has da9063 and da9210 regulators.
Both regulators have their interrupt request lines tied to the same
interrupt pin (IRQ2) on the SoC.

After boot-up, both the da9063 and da9210 seem to assert their interrupt
request lines.  Hence as soon as one driver requests this irq, it gets
stuck in an interrupt storm, as it only manages to deassert its own
interrupt request line, and the other driver hasn't installed an
interrupt handler yet.

To handle this, install a quirk that masks the interrupts in both the
da9063 and da9210.  This quirk has to run after the i2c master driver
has been initialized, but before the i2c slave drivers are initialized.

On koelsch, the following happens:

  - Cold boot or reboot using the da9063 restart handler:

	IRQ2 is asserted, installing da9063/da9210 regulator quirk
	...
	i2c i2c-6: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
	i2c 6-0058: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
	i2c 6-0058: Detected da9063
	i2c 6-0058: Masking da9063 interrupt sources
	i2c 6-0068: regulator_quirk_notify: 1, IRQC_MONITOR = 0x3fb
	i2c 6-0068: Detected da9210
	i2c 6-0068: Masking da9210 interrupt sources
	i2c 6-0068: IRQ2 is not asserted, removing quirk

  - Warm boot (reset button):

	rcar_gen2_regulator_quirk: IRQ2 is not asserted, not installing quirk

Not-yet-signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Based on the schematics, I believe r8a7790/lager is also affected.

I do not have schematics for r8a7793/gose, but according to the BSP, it
has both da9210 and da9063, so most probably it's also affected.

Other R-Car Gen2 boards (r8a7791/henninger, r8a7791/porter, r8a7794/alt,
r8a7794/silk) may only have the da9063. They are affected if the da9063
interrupt line is shared with another device.

This patch, against renesas-devel-20150301-v4.0-rc1, includes DTS
updates for koelsch and lager to allow testing.
To test on other boards, you'll have to add the nodes for the regulators
to the right i2c buses yourselves. These can be fairly minimal
("compatible" and "reg" should suffice).

Testing on other R-Car Gen2 platforms would be highly appreciated.
Thanks!

References:
  - "ARM: shmobile: koelsch: da9210/da9063 interrupt storm (was: Re:
    [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node for
    system restart") (https://lkml.org/lkml/2015/2/17/254),
  - "[PATCH/RFC 1/2] regulator: da9210: Mask all interrupt sources to
    deassert interrupt line" (https://lkml.org/lkml/2015/2/17/274)
  - "[PATCH/RFC 2/2] regulator: da9210: Add optional interrupt support"
    (https://lkml.org/lkml/2015/2/17/275)
---
 arch/arm/boot/dts/r8a7790-lager.dts      |  18 ++++
 arch/arm/boot/dts/r8a7791-koelsch.dts    |  18 ++++
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 152 +++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 329bb994aac04084..aaa4f258e279ccfa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -582,9 +582,27 @@
 	pinctrl-0 = <&iic3_pins>;
 	status = "okay";
 
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
 	vdd_dvfs: regulator at 68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 75fa9852e235455c..74c3212f1f11e47e 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -584,9 +584,27 @@
 	status = "okay";
 	clock-frequency = <100000>;
 
+	pmic at 58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
 	vdd_dvfs: regulator at 68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 5d13595aa027447d..71700ad7e2d24b74 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  * R-Car Generation 2 support
  *
@@ -19,9 +20,12 @@
 #include <linux/clocksource.h>
 #include <linux/device.h>
 #include <linux/dma-contiguous.h>
+#include <linux/i2c.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/memblock.h>
+#include <linux/mfd/da9063/registers.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <asm/mach/arch.h>
@@ -201,3 +205,151 @@ void __init rcar_gen2_reserve(void)
 					    &rcar_gen2_dma_contiguous, true);
 #endif
 }
+
+
+#ifdef CONFIG_I2C
+
+/*
+ *  The r8a7791/koelsch (and FIXME) development boards have da9210 and da9063
+ *  regulators.  Both regulators have their interrupt request lines tied to the
+ *  same interrupt pin (IRQ2) on the SoC.
+ *
+ *  After boot-up, both the da9210 and da9063 seem to assert their interrupt
+ *  request lines.  Hence as soon as one driver requests this irq, it gets
+ *  stuck in an interrupt storm, as it only manages to deassert its own
+ *  interrupt request line, and the other driver hasn't installed an interrupt
+ *  handler yet.
+ *
+ *  To handle this, install a quirk that masks the interrupts in both the
+ *  da9210 and da9063.  This quirk has to run after the i2c master driver has
+ *  been initialized, but before the i2c slave drivers are initialized.
+ */
+
+#define IRQC_BASE		0xe61c0000
+#define IRQC_MONITOR		0x104	/* IRQn Signal Level Monitor Register */
+
+#define REGULATOR_IRQ_MASK	BIT(2)	/* IRQ2, active low */
+
+static void __iomem *irqc;
+
+
+/* DA9210 System Control and Event Registers */
+#define DA9210_REG_MASK_A		0x54
+#define DA9210_REG_MASK_B		0x55
+
+static const u8 da9063_mask_regs[] = {
+	DA9063_REG_IRQ_MASK_A,
+	DA9063_REG_IRQ_MASK_B,
+	DA9063_REG_IRQ_MASK_C,
+	DA9063_REG_IRQ_MASK_D,
+};
+
+static const u8 da9210_mask_regs[] = {
+	DA9210_REG_MASK_A,
+	DA9210_REG_MASK_B,
+};
+
+static void da9xxx_mask_irqs(struct i2c_client *client, const u8 regs[],
+			     unsigned int nregs)
+{
+	unsigned int i;
+
+	dev_info(&client->dev, "Masking %s interrupt sources\n", client->name);
+
+	for (i = 0; i < nregs; i++) {
+		int error = i2c_smbus_write_byte_data(client, regs[i], ~0);
+		if (error) {
+			dev_err(&client->dev, "i2c error %d\n", error);
+			return;
+		}
+	}
+}
+
+static int regulator_quirk_notify(struct notifier_block *nb,
+				  unsigned long action, void *data);
+
+static struct notifier_block regulator_quirk_nb = {
+	.notifier_call = regulator_quirk_notify
+};
+
+static int regulator_quirk_notify(struct notifier_block *nb,
+				  unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct i2c_client *client;
+	int error;
+	u32 mon;
+
+	mon = ioread32(irqc + IRQC_MONITOR);
+	dev_dbg(dev, "%s: %ld, IRQC_MONITOR = 0x%x\n", __func__, action, mon);
+	if (mon & REGULATOR_IRQ_MASK)
+		goto remove;
+
+	if (action != BUS_NOTIFY_ADD_DEVICE || dev->type == &i2c_adapter_type)
+		return 0;
+
+	client = to_i2c_client(dev);
+	dev_dbg(dev, "Detected %s\n", client->name);
+
+	if ((client->addr == 0x58 && !strcmp(client->name, "da9063")))
+		da9xxx_mask_irqs(client, da9063_mask_regs,
+				 ARRAY_SIZE(da9063_mask_regs));
+	else if (client->addr == 0x68 && !strcmp(client->name, "da9210"))
+		da9xxx_mask_irqs(client, da9210_mask_regs,
+				 ARRAY_SIZE(da9210_mask_regs));
+
+	mon = ioread32(irqc + IRQC_MONITOR);
+	if (mon & REGULATOR_IRQ_MASK)
+		goto remove;
+
+	return 0;
+
+remove:
+	dev_info(dev, "IRQ2 is not asserted, removing quirk\n");
+	iounmap(irqc);
+
+	error = bus_unregister_notifier(&i2c_bus_type, &regulator_quirk_nb);
+	if (error)
+		pr_err("%s: Failed to unregister bus notifier: %d\n", __func__,
+		       error);
+	return 0;
+}
+
+static int __init rcar_gen2_regulator_quirk(void)
+{
+	u32 mon;
+	int error;
+
+	// FIXME Use list of affected boards
+	if (!of_machine_is_compatible("renesas,koelsch") &&
+	    !of_machine_is_compatible("renesas,r8a7790") &&
+	    !of_machine_is_compatible("renesas,r8a7791") &&
+	    !of_machine_is_compatible("renesas,r8a7792") &&
+	    !of_machine_is_compatible("renesas,r8a7793") &&
+	    !of_machine_is_compatible("renesas,r8a7794"))
+		return -ENODEV;
+
+	irqc = ioremap(IRQC_BASE, PAGE_SIZE);
+	if (!irqc)
+		return -ENOMEM;
+
+	mon = ioread32(irqc + IRQC_MONITOR);
+	if (mon & REGULATOR_IRQ_MASK) {
+		pr_debug("%s: IRQ2 is not asserted, not installing quirk\n",
+			 __func__);
+		iounmap(irqc);
+		return 0;
+	}
+
+	pr_info("IRQ2 is asserted, installing da9063/da9210 regulator quirk\n");
+
+	error = bus_register_notifier(&i2c_bus_type, &regulator_quirk_nb);
+	if (error)
+		pr_err("%s: Failed to register bus notifier: %d\n", __func__,
+		       error);
+
+	return error;
+}
+
+arch_initcall(rcar_gen2_regulator_quirk);
+#endif /* CONFIG_I2C */
-- 
1.9.1
