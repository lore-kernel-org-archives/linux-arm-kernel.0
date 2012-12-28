From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 13:25:09 +0100
Subject: [PATCH 1/4] Power: Reset: Driver to turn QNAP board power off.
In-Reply-To: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
Message-ID: <1356697512-3950-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew.lunn@ruag.com>

The QNAP NAS boxes have a microcontroller attached to the SoCs second
serial port. By sending it a simple command, it will turn the power
for the board off. This driver registers a function for pm_power_off
to send such a command.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 .../bindings/power_supply/qnap-poweroff.txt        |   14 +++
 drivers/power/reset/Kconfig                        |    9 ++
 drivers/power/reset/Makefile                       |    1 +
 drivers/power/reset/qnap-poweroff.c                |  124 ++++++++++++++++++++
 4 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
 create mode 100644 drivers/power/reset/qnap-poweroff.c

diff --git a/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
new file mode 100644
index 0000000..0951952
--- /dev/null
+++ b/Documentation/devicetree/bindings/power_supply/qnap-poweroff.txt
@@ -0,0 +1,14 @@
+* QNAP Power Off
+
+QNAP NAS devices have a microcontroller controlling the main power
+supply. This microcontroller is connected to UART1 of the Kirkwood and
+Orion5x SoCs. Sending the charactor 'A', at 19200 baud, tells the
+microcontroller to turn the power off. This driver adds a handler to
+pm_power_off which is called to turn the power off.
+
+Required Properties:
+- compatible: Should be "qnap,power-off"
+
+- reg: Address and length of the register set for UART1
+- clocks: tclk clock
+
diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 6461b48..6453aac 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -13,3 +13,12 @@ config POWER_RESET_GPIO
 	  This driver supports turning off your board via a GPIO line.
 	  If your board needs a GPIO high/low to power down, say Y and
 	  create a binding in your devicetree.
+
+config POWER_RESET_QNAP
+	bool "QNAP power-off driver"
+	depends on OF_GPIO && POWER_RESET && PLAT_ORION
+	help
+	  This driver supports turning off QNAP NAS devices by sending
+	  commands to the microcontroller which controls the main power.
+
+	  Say Y if you have a QNAP NAS.
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 751488a..c4d3b2d 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
+obj-$(CONFIG_POWER_RESET_QNAP) += qnap-poweroff.o
diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
new file mode 100644
index 0000000..ca0b476
--- /dev/null
+++ b/drivers/power/reset/qnap-poweroff.c
@@ -0,0 +1,124 @@
+/*
+ * QNAP Turbo NAS Board power off
+ *
+ * Copyright (C) 2012 Andrew Lunn <andrew@lunn.ch>
+ *
+ * Based on the code from:
+ *
+ * Copyright (C) 2009  Martin Michlmayr <tbm@cyrius.com>
+ * Copyright (C) 2008  Byron Bradley <byron.bbradley@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/serial_reg.h>
+#include <linux/kallsyms.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#define UART1_REG(x)	(base + ((UART_##x) << 2))
+
+static void __iomem *base;
+static unsigned long tclk;
+
+static void
+qnap_power_off(void)
+{
+	/* 19200 baud divisor */
+	const unsigned divisor = ((tclk + (8 * 19200)) / (16 * 19200));
+
+	pr_err("%s: triggering power-off...\n", __func__);
+
+	/* hijack UART1 and reset into sane state (19200,8n1) */
+	writel(0x83, UART1_REG(LCR));
+	writel(divisor & 0xff, UART1_REG(DLL));
+	writel((divisor >> 8) & 0xff, UART1_REG(DLM));
+	writel(0x03, UART1_REG(LCR));
+	writel(0x00, UART1_REG(IER));
+	writel(0x00, UART1_REG(FCR));
+	writel(0x00, UART1_REG(MCR));
+
+	/* send the power-off command 'A' to PIC */
+	writel('A', UART1_REG(TX));
+}
+
+static int
+qnap_power_off_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct clk *clk;
+	char symname[KSYM_NAME_LEN];
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "Missing resource");
+		return -EINVAL;
+	}
+
+	base = devm_ioremap(&pdev->dev, res->start,
+			    resource_size(res));
+	if (base == NULL) {
+		dev_err(&pdev->dev, "Unable to map resource");
+		return -EINVAL;
+	}
+
+	/* We need to know tclk in order to calculate the UART
+	   divisor */
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Clk missing");
+		return PTR_ERR(clk);
+	}
+
+	tclk = clk_get_rate(clk);
+
+	/* Check that nothing else has already setup a handler */
+	if (pm_power_off != NULL) {
+		lookup_symbol_name(pm_power_off, symname);
+		dev_err(&pdev->dev,
+			"pm_power_off already claimed %p %s",
+			pm_power_off, symname);
+		return -EBUSY;
+	}
+	pm_power_off = qnap_power_off;
+
+	return 0;
+}
+
+static int
+qnap_power_off_remove(struct platform_device *pdev)
+{
+	pm_power_off = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id qnap_power_off_of_match_table[] = {
+	{ .compatible = "qnap,power-off", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, qnap_power_off_of_match_table);
+
+static struct platform_driver qnap_power_off_driver = {
+	.probe	= qnap_power_off_probe,
+	.remove	= qnap_power_off_remove,
+	.driver	= {
+		.owner	= THIS_MODULE,
+		.name	= "qnap_power_off",
+		.of_match_table = of_match_ptr(qnap_power_off_of_match_table),
+	},
+};
+
+module_platform_driver(qnap_power_off_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
+MODULE_DESCRIPTION("QNAP Power off driver");
+MODULE_LICENSE("GPLv2+");
-- 
1.7.10.4
