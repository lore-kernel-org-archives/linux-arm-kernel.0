From: Barry.Song@csr.com (Barry Song)
Date: Fri, 14 Dec 2012 17:15:59 +0800
Subject: [PATCH] pinctrl: sirf: enable GPIO pullup/down configuration from dts
Message-ID: <1355476559-27550-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

commit 7bec207427c2efb794 remove sirfsoc_gpio_set_pull function,
this patches takes the feature back by adding sirf,pullups and
sirf,pulldowns prop in dts, and the driver will set the GPIO
pull according to the dts.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 Depends on:
 [PATCH] pinctrl: sirf: add missing DT-binding document
 http://www.spinics.net/lists/arm-kernel/msg212485.html

 .../devicetree/bindings/pinctrl/pinctrl-sirf.txt   |    3 +
 drivers/pinctrl/pinctrl-sirf.c                     |   48 ++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
index a2896df..c596a6a 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-sirf.txt
@@ -6,6 +6,9 @@ Required properties:
 - interrupts    : Interrupts used by every GPIO group
 - gpio-controller : Indicates this device is a GPIO controller
 - interrupt-controller  : Marks the device node as an interrupt controller
+Optional properties:
+- sirf,pullups : if n-th bit of m-th bank is set, set a pullup on GPIO-n of bank m
+- sirf,pulldowns : if n-th bit of m-th bank is set, set a pulldown on GPIO-n of bank m
 
 Please refer to pinctrl-bindings.txt in this directory for details of the common
 pinctrl bindings used by client devices.
diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
index 09eadb5..22a408c 100644
--- a/drivers/pinctrl/pinctrl-sirf.c
+++ b/drivers/pinctrl/pinctrl-sirf.c
@@ -1663,6 +1663,44 @@ const struct irq_domain_ops sirfsoc_gpio_irq_simple_ops = {
 	.xlate = irq_domain_xlate_twocell,
 };
 
+static void sirfsoc_gpio_set_pullup(const u32 *pullups)
+{
+	int i, n;
+	const unsigned long *p = (const unsigned long *)pullups;
+
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
+		n = find_first_bit(p + i, BITS_PER_LONG);
+		while (n < BITS_PER_LONG) {
+			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
+			u32 val = readl(sgpio_bank[i].chip.regs + offset);
+			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
+			val |= SIRFSOC_GPIO_CTL_PULL_HIGH;
+			writel(val, sgpio_bank[i].chip.regs + offset);
+
+			n = find_next_bit(p + i, BITS_PER_LONG, n + 1);
+		}
+	}
+}
+
+static void sirfsoc_gpio_set_pulldown(const u32 *pulldowns)
+{
+	int i, n;
+	const unsigned long *p = (const unsigned long *)pulldowns;
+
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
+		n = find_first_bit(p + i, BITS_PER_LONG);
+		while (n < BITS_PER_LONG) {
+			u32 offset = SIRFSOC_GPIO_CTRL(i, n);
+			u32 val = readl(sgpio_bank[i].chip.regs + offset);
+			val |= SIRFSOC_GPIO_CTL_PULL_MASK;
+			val &= ~SIRFSOC_GPIO_CTL_PULL_HIGH;
+			writel(val, sgpio_bank[i].chip.regs + offset);
+
+			n = find_next_bit(p + i, BITS_PER_LONG, n + 1);
+		}
+	}
+}
+
 static int __devinit sirfsoc_gpio_probe(struct device_node *np)
 {
 	int i, err = 0;
@@ -1671,6 +1709,8 @@ static int __devinit sirfsoc_gpio_probe(struct device_node *np)
 	struct platform_device *pdev;
 	bool is_marco = false;
 
+	u32 pullups[SIRFSOC_GPIO_NO_OF_BANKS], pulldowns[SIRFSOC_GPIO_NO_OF_BANKS];
+
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return -ENODEV;
@@ -1734,6 +1774,14 @@ static int __devinit sirfsoc_gpio_probe(struct device_node *np)
 		irq_set_handler_data(bank->parent_irq, bank);
 	}
 
+	if (!of_property_read_u32_array(np, "sirf,pullups", pullups,
+		SIRFSOC_GPIO_NO_OF_BANKS))
+		sirfsoc_gpio_set_pullup(pullups);
+
+	if (!of_property_read_u32_array(np, "sirf,pulldowns", pulldowns,
+		SIRFSOC_GPIO_NO_OF_BANKS))
+		sirfsoc_gpio_set_pulldown(pulldowns);
+
 	return 0;
 
 out:
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
