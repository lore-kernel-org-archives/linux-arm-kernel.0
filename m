From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 16 Mar 2015 08:03:05 +0900
Subject: [PATCH 1/5] ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator
 quirk
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
Message-ID: <663fbb52159cca6ffb049cb15b9f9d1cd7ad7d8a.1426456462.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
da9210 regulators.  Both regulators have their interrupt request lines
tied to the same interrupt pin (IRQ2) on the SoC.

After cold boot or da9063-induced restart, both the da9063 and da9210
seem to assert their interrupt request lines.  Hence as soon as one
driver requests this irq, it gets stuck in an interrupt storm, as it
only manages to deassert its own interrupt request line, and the other
driver hasn't installed an interrupt handler yet.

To handle this, install a quirk that masks the interrupts in both the
da9063 and da9210.  This quirk has to run after the i2c master driver
has been initialized, but before the i2c slave drivers are initialized.
As it depends on i2c, select I2C if one of the affected platforms is
enabled in the kernel config.

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

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                     |   2 +
 arch/arm/mach-shmobile/Makefile                    |   2 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 147 +++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..347b6a5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -69,10 +69,12 @@ config ARCH_R8A7779
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select ARCH_RCAR_GEN2
+	select I2C
 
 config ARCH_R8A7791
 	bool "R-Car M2-W (R8A77910)"
 	select ARCH_RCAR_GEN2
+	select I2C
 
 config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index d53996e..fb9ef90 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,6 +35,8 @@ cpu-y				:= platsmp.o headsmp.o
 # Shared SoC family objects
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
+obj-$(CONFIG_ARCH_R8A7790)	+= regulator-quirk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
new file mode 100644
index 0000000..384e6e9
--- /dev/null
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -0,0 +1,147 @@
+/*
+ * R-Car Generation 2 da9063/da9210 regulator quirk
+ *
+ * The r8a7790/lager and r8a7791/koelsch development boards have da9063 and
+ * da9210 regulators.  Both regulators have their interrupt request lines tied
+ * to the same interrupt pin (IRQ2) on the SoC.
+ *
+ * After cold boot or da9063-induced restart, both the da9063 and da9210 seem
+ * to assert their interrupt request lines.  Hence as soon as one driver
+ * requests this irq, it gets stuck in an interrupt storm, as it only manages
+ * to deassert its own interrupt request line, and the other driver hasn't
+ * installed an interrupt handler yet.
+ *
+ * To handle this, install a quirk that masks the interrupts in both the
+ * da9063 and da9210.  This quirk has to run after the i2c master driver has
+ * been initialized, but before the i2c slave drivers are initialized.
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/mfd/da9063/registers.h>
+
+
+#define IRQC_BASE		0xe61c0000
+#define IRQC_MONITOR		0x104	/* IRQn Signal Level Monitor Register */
+
+#define REGULATOR_IRQ_MASK	BIT(2)	/* IRQ2, active low */
+
+static void __iomem *irqc;
+
+static const u8 da9063_mask_regs[] = {
+	DA9063_REG_IRQ_MASK_A,
+	DA9063_REG_IRQ_MASK_B,
+	DA9063_REG_IRQ_MASK_C,
+	DA9063_REG_IRQ_MASK_D,
+};
+
+/* DA9210 System Control and Event Registers */
+#define DA9210_REG_MASK_A		0x54
+#define DA9210_REG_MASK_B		0x55
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
+				  unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct i2c_client *client;
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
+
+	bus_unregister_notifier(&i2c_bus_type, nb);
+	iounmap(irqc);
+	return 0;
+}
+
+static struct notifier_block regulator_quirk_nb = {
+	.notifier_call = regulator_quirk_notify
+};
+
+static int __init rcar_gen2_regulator_quirk(void)
+{
+	u32 mon;
+
+	if (!of_machine_is_compatible("renesas,koelsch") &&
+	    !of_machine_is_compatible("renesas,lager"))
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
+	bus_register_notifier(&i2c_bus_type, &regulator_quirk_nb);
+	return 0;
+}
+
+arch_initcall(rcar_gen2_regulator_quirk);
-- 
2.1.4
