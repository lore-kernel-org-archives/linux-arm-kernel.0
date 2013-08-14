From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 14 Aug 2013 22:04:53 +0200
Subject: [PATCH] clk: new driver for efm32 SoC
Message-ID: <1376510693-12491-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Hello,

I'm not sure if there is a naming convention for #defines in headers below
dt-bindings. I named my clocks clk_$namefromreferencemanual to have some
namespacing.

The clock stuff on the different variants of efm32 are similar, but
different enough to not be able to use the same driver, so this is only
for the Giant Gecko (efm32gg) variant, still I used "efm32" in some
places because the other variants would fit there, too. (For
include/dt-bindings/clock/efm32-cmu.h I would need some #ifdefs, is that
OK or should the name of the defines include efm32gg? (That would make
the names still longer and so more ugly.))

Best regards
Uwe

 .../devicetree/bindings/clock/efm32-clock.txt      | 11 +++
 drivers/clk/Makefile                               |  1 +
 drivers/clk/clk-efm32gg.c                          | 79 ++++++++++++++++++++++
 include/dt-bindings/clock/efm32-cmu.h              | 42 ++++++++++++
 include/linux/clk/efm32.h                          |  6 ++
 5 files changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/efm32-clock.txt
 create mode 100644 drivers/clk/clk-efm32gg.c
 create mode 100644 include/dt-bindings/clock/efm32-cmu.h
 create mode 100644 include/linux/clk/efm32.h

diff --git a/Documentation/devicetree/bindings/clock/efm32-clock.txt b/Documentation/devicetree/bindings/clock/efm32-clock.txt
new file mode 100644
index 0000000..263d293
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/efm32-clock.txt
@@ -0,0 +1,11 @@
+* Clock bindings for Energy Micro efm32 Giant Gecko's Clock Management Unit
+
+Required properties:
+- compatible: Should be "efm32gg,cmu"
+- reg: Base address and length of the register set
+- interrupts: Interrupt used by the CMU
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock ID in
+its "clocks" phandle cell. The header efm32-clk.h contains a list of available
+IDs.
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 4038c2b..99d9ad0 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_COMMON_CLK)	+= clk-composite.o
 
 # SoCs specific
 obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
+obj-$(CONFIG_ARCH_EFM32)	+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_NOMADIK)	+= clk-nomadik.o
 obj-$(CONFIG_ARCH_HIGHBANK)	+= clk-highbank.o
 obj-$(CONFIG_ARCH_NSPIRE)	+= clk-nspire.o
diff --git a/drivers/clk/clk-efm32gg.c b/drivers/clk/clk-efm32gg.c
new file mode 100644
index 0000000..2e63584
--- /dev/null
+++ b/drivers/clk/clk-efm32gg.c
@@ -0,0 +1,79 @@
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <dt-bindings/clock/efm32-cmu.h>
+
+#define CMU_HFPERCLKEN0		0x44
+
+static struct clk *clk[37];
+static struct clk_onecell_data clk_data = {
+	.clks = clk,
+	.clk_num = ARRAY_SIZE(clk),
+};
+
+int __init efm32gg_clk_init(void)
+{
+	int i;
+	struct device_node *np;
+	void __iomem *base;
+
+	for (i = 0; i < ARRAY_SIZE(clk); ++i)
+		clk[i] = ERR_PTR(-ENOENT);
+
+	np = of_find_compatible_node(NULL, NULL, "efm32gg,cmu");
+	if (!np) {
+		pr_warn("No efm32gg,cmu node found in device tree\n");
+		return -ENOENT;
+	}
+
+	base = of_iomap(np, 0);
+	if (!base) {
+		pr_warn("Failed to map address range for efm32gg,cmu node\n");
+		return -EADDRNOTAVAIL;
+	}
+
+	clk[clk_HFXO] = clk_register_fixed_rate(NULL, "HFXO", NULL,
+			CLK_IS_ROOT, 48000000);
+
+	clk[clk_HFPERCLKUSART0] = clk_register_gate(NULL, "HFPERCLK.USART0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 0, 0, NULL);
+	clk[clk_HFPERCLKUSART1] = clk_register_gate(NULL, "HFPERCLK.USART1",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 1, 0, NULL);
+	clk[clk_HFPERCLKUSART2] = clk_register_gate(NULL, "HFPERCLK.USART2",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 2, 0, NULL);
+	clk[clk_HFPERCLKUART0] = clk_register_gate(NULL, "HFPERCLK.UART0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 3, 0, NULL);
+	clk[clk_HFPERCLKUART1] = clk_register_gate(NULL, "HFPERCLK.UART1",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 4, 0, NULL);
+	clk[clk_HFPERCLKTIMER0] = clk_register_gate(NULL, "HFPERCLK.TIMER0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 5, 0, NULL);
+	clk[clk_HFPERCLKTIMER1] = clk_register_gate(NULL, "HFPERCLK.TIMER1",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 6, 0, NULL);
+	clk[clk_HFPERCLKTIMER2] = clk_register_gate(NULL, "HFPERCLK.TIMER2",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 7, 0, NULL);
+	clk[clk_HFPERCLKTIMER3] = clk_register_gate(NULL, "HFPERCLK.TIMER3",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 8, 0, NULL);
+	clk[clk_HFPERCLKACMP0] = clk_register_gate(NULL, "HFPERCLK.ACMP0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 9, 0, NULL);
+	clk[clk_HFPERCLKACMP1] = clk_register_gate(NULL, "HFPERCLK.ACMP1",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 10, 0, NULL);
+	clk[clk_HFPERCLKI2C0] = clk_register_gate(NULL, "HFPERCLK.I2C0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 11, 0, NULL);
+	clk[clk_HFPERCLKI2C1] = clk_register_gate(NULL, "HFPERCLK.I2C1",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 12, 0, NULL);
+	clk[clk_HFPERCLKGPIO] = clk_register_gate(NULL, "HFPERCLK.GPIO",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 13, 0, NULL);
+	clk[clk_HFPERCLKVCMP] = clk_register_gate(NULL, "HFPERCLK.VCMP",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 14, 0, NULL);
+	clk[clk_HFPERCLKPRS] = clk_register_gate(NULL, "HFPERCLK.PRS",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 15, 0, NULL);
+	clk[clk_HFPERCLKADC0] = clk_register_gate(NULL, "HFPERCLK.ADC0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 16, 0, NULL);
+	clk[clk_HFPERCLKDAC0] = clk_register_gate(NULL, "HFPERCLK.DAC0",
+			"HFXO", 0, base + CMU_HFPERCLKEN0, 17, 0, NULL);
+
+	return of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+}
diff --git a/include/dt-bindings/clock/efm32-cmu.h b/include/dt-bindings/clock/efm32-cmu.h
new file mode 100644
index 0000000..b21b91e
--- /dev/null
+++ b/include/dt-bindings/clock/efm32-cmu.h
@@ -0,0 +1,42 @@
+#ifndef __DT_BINDINGS_CLOCK_EFM32_CMU_H
+#define __DT_BINDINGS_CLOCK_EFM32_CMU_H
+
+#define clk_HFXO		0
+#define clk_HFRCO		1
+#define clk_LFXO		2
+#define clk_LFRCO		3
+#define clk_ULFRCO		4
+#define clk_AUXHFRCO		5
+#define clk_HFCLKNODIV		6
+#define clk_HFCLK		7
+#define clk_HFPERCLK		8
+#define clk_HFCORECLK		9
+#define clk_LFACLK		10
+#define clk_LFBCLK		11
+#define clk_WDOGCLK		12
+#define clk_HFCORECLKDMA	13
+#define clk_HFCORECLKAES	14
+#define clk_HFCORECLKUSBC	15
+#define clk_HFCORECLKUSB	16
+#define clk_HFCORECLKLE		17
+#define clk_HFCORECLKEBI	18
+#define clk_HFPERCLKUSART0	19
+#define clk_HFPERCLKUSART1	20
+#define clk_HFPERCLKUSART2	21
+#define clk_HFPERCLKUART0	22
+#define clk_HFPERCLKUART1	23
+#define clk_HFPERCLKTIMER0	24
+#define clk_HFPERCLKTIMER1	25
+#define clk_HFPERCLKTIMER2	26
+#define clk_HFPERCLKTIMER3	27
+#define clk_HFPERCLKACMP0	28
+#define clk_HFPERCLKACMP1	29
+#define clk_HFPERCLKI2C0	30
+#define clk_HFPERCLKI2C1	31
+#define clk_HFPERCLKGPIO	32
+#define clk_HFPERCLKVCMP	33
+#define clk_HFPERCLKPRS		34
+#define clk_HFPERCLKADC0	35
+#define clk_HFPERCLKDAC0	36
+
+#endif /* __DT_BINDINGS_CLOCK_EFM32_CMU_H */
diff --git a/include/linux/clk/efm32.h b/include/linux/clk/efm32.h
new file mode 100644
index 0000000..4032dc0
--- /dev/null
+++ b/include/linux/clk/efm32.h
@@ -0,0 +1,6 @@
+#ifndef __LINUX_CLK_EFM32_H__
+#define __LINUX_CLK_EFM32_H__
+
+int efm32gg_clk_init(void);
+
+#endif /* __LINUX_CLK_EFM32_H__ */
-- 
1.8.4.rc0
