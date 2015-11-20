From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:28:39 +0200
Subject: [PATCH 04/10] arm: lpc32xx: add wakeup platform driver
In-Reply-To: <1447982925-30138-1-git-send-email-vz@mleia.com>
References: <1447982925-30138-1-git-send-email-vz@mleia.com>
Message-ID: <1447982925-30138-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx has three wakeup controllers of two types, this change
adds support of two wakeup controllers connected to MIC, SIC1 and SIC2
interrupt controllers, which may propagate interrupt wakeup source
status to one of the wakeup controllers. Wakeup controllers are found
as subdevices of System Control Block with offsets 0x20 and 0x30.

The change does not add support of P01 wakeup controller, which may
define Port0 and Port1 I/O pins as wakeup sources.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/Makefile              |   2 +-
 arch/arm/mach-lpc32xx/include/mach/wakeup.h |  21 ++++
 arch/arm/mach-lpc32xx/wakeup.c              | 144 ++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-lpc32xx/include/mach/wakeup.h
 create mode 100644 arch/arm/mach-lpc32xx/wakeup.c

diff --git a/arch/arm/mach-lpc32xx/Makefile b/arch/arm/mach-lpc32xx/Makefile
index c70709a..b1023c0 100644
--- a/arch/arm/mach-lpc32xx/Makefile
+++ b/arch/arm/mach-lpc32xx/Makefile
@@ -3,5 +3,5 @@
 #
 
 obj-y	:= irq.o common.o serial.o
-obj-y	+= pm.o suspend.o
+obj-y	+= pm.o suspend.o wakeup.o
 obj-y	+= phy3250.o
diff --git a/arch/arm/mach-lpc32xx/include/mach/wakeup.h b/arch/arm/mach-lpc32xx/include/mach/wakeup.h
new file mode 100644
index 0000000..2c6c5fa
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/include/mach/wakeup.h
@@ -0,0 +1,21 @@
+/*
+ * Copyright 2015 Vladimir Zapolskiy <vz@mleia.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#ifndef __LPC32XX_WAKEUP_H
+#define __LPC32XX_WAKEUP_H
+
+struct wakeup_controller;
+
+void lpc32xx_wakeup_clear(struct wakeup_controller *wuc, u32 bit);
+void lpc32xx_wakeup_set_edge(struct wakeup_controller *wuc, u32 bit, bool val);
+void lpc32xx_wakeup_enable(struct wakeup_controller *wuc, u32 bit, bool on);
+
+#endif
diff --git a/arch/arm/mach-lpc32xx/wakeup.c b/arch/arm/mach-lpc32xx/wakeup.c
new file mode 100644
index 0000000..a2b7747
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/wakeup.c
@@ -0,0 +1,144 @@
+/*
+ * Copyright 2015 Vladimir Zapolskiy <vz@mleia.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <mach/wakeup.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define LPC32XX_CLKPWR_P01_ER		0x0
+
+#define LPC32XX_CLKPWR_PIN_ER		0x0
+#define LPC32XX_CLKPWR_PIN_RS		0x4
+#define LPC32XX_CLKPWR_PIN_SR		0x8
+#define LPC32XX_CLKPWR_PIN_AP		0xC
+
+struct wakeup_ops {
+	void (*clear)(struct wakeup_controller *wuc, u32 bit);
+	void (*set_edge)(struct wakeup_controller *wuc, u32 bit, bool val);
+	void (*enable)(struct wakeup_controller *wuc, u32 bit, bool on);
+};
+
+struct wakeup_controller {
+	void __iomem *base;
+	struct wakeup_ops ops;
+};
+
+void lpc32xx_wakeup_clear(struct wakeup_controller *wuc, u32 bit)
+{
+	wuc->ops.clear(wuc, bit);
+}
+
+void lpc32xx_wakeup_set_edge(struct wakeup_controller *wuc, u32 bit, bool val)
+{
+	wuc->ops.set_edge(wuc, bit, val);
+}
+
+void lpc32xx_wakeup_enable(struct wakeup_controller *wuc, u32 bit, bool on)
+{
+	wuc->ops.enable(wuc, bit, on);
+}
+
+static inline u32 lpc32xx_wakeup_read(struct wakeup_controller *wuc, u32 reg)
+{
+	return readl(wuc->base + reg);
+}
+
+static inline void lpc32xx_wakeup_write(struct wakeup_controller *wuc,
+					u32 reg, u32 val)
+{
+	writel(val, wuc->base + reg);
+}
+
+static void wakeup_clear(struct wakeup_controller *wuc, u32 bit)
+{
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_RS, BIT(bit));
+}
+
+static void wakeup_set_edge(struct wakeup_controller *wuc, u32 bit, bool pol)
+{
+	u32 val = lpc32xx_wakeup_read(wuc, LPC32XX_CLKPWR_PIN_AP);
+
+	/* Here pol == true means rising edge */
+	if (pol)
+		val |= BIT(bit);
+	else
+		val &= ~BIT(bit);
+
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_AP, val);
+}
+
+static void wakeup_enable(struct wakeup_controller *wuc, u32 bit, bool on)
+{
+	u32 val = lpc32xx_wakeup_read(wuc, LPC32XX_CLKPWR_PIN_ER);
+
+	if (on)
+		val |= BIT(bit);
+	else
+		val &= ~BIT(bit);
+
+	wakeup_clear(wuc, bit);
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_ER, val);
+}
+
+static int lpc32xx_wakeup_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct wakeup_controller *wuc;
+	u32 val;
+
+	wuc = devm_kzalloc(&pdev->dev, sizeof(*wuc), GFP_KERNEL);
+	if (!wuc)
+		return -ENOMEM;
+
+	wuc->base = of_iomap(node, 0);
+	if (!wuc->base) {
+		pr_err("%s: unable to map registers\n", node->full_name);
+		return -ENODEV;
+	}
+
+	wuc->ops.clear = wakeup_clear,
+	wuc->ops.set_edge = wakeup_set_edge,
+	wuc->ops.enable = wakeup_enable,
+
+	platform_set_drvdata(pdev, wuc);
+
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_ER, 0x00);
+	val = lpc32xx_wakeup_read(wuc, LPC32XX_CLKPWR_PIN_RS);
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_RS, val);
+	lpc32xx_wakeup_write(wuc, LPC32XX_CLKPWR_PIN_AP, 0x00);
+
+	pr_debug("%s: wakeup controller is initialized\n", node->full_name);
+
+	return 0;
+}
+
+static const struct of_device_id lpc32xx_wakeup_dt_ids[] = {
+	{ .compatible = "nxp,lpc3220-wakeup" },
+	{ }
+};
+
+static struct platform_driver lpc32xx_wakeup_driver = {
+	.driver = {
+		.name = "lpc32xx-wakeup",
+		.of_match_table = lpc32xx_wakeup_dt_ids,
+	},
+	.probe = lpc32xx_wakeup_probe,
+};
+
+static int __init lpc32xx_wakeup_init(void)
+{
+	return platform_driver_register(&lpc32xx_wakeup_driver);
+}
+postcore_initcall(lpc32xx_wakeup_init);
-- 
2.1.4
