From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 4 May 2010 14:27:29 +0530
Subject: [PATCH 2/2] nomadik-gpio: use clk API
In-Reply-To: <1272963449-17657-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272963449-17657-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272963449-17657-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clocks with appropriate names in platforms that use it, and use the
clk API in nomadik-gpio.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-nomadik/clock.c |   10 ++++++++++
 arch/arm/mach-ux500/clock.c   |   16 +++++++++++-----
 arch/arm/plat-nomadik/gpio.c  |   20 +++++++++++++++++++-
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-nomadik/clock.c b/arch/arm/mach-nomadik/clock.c
index 7af7850..60f5bee 100644
--- a/arch/arm/mach-nomadik/clock.c
+++ b/arch/arm/mach-nomadik/clock.c
@@ -37,6 +37,12 @@ static struct clk clk_48 = {
 	.rate = 48 * 1000 * 1000,
 };
 
+/*
+ * Catch-all default clock to satisfy drivers using the clk API.  We don't
+ * model the actual hardware clocks yet.
+ */
+static struct clk clk_default;
+
 #define CLK(_clk, dev)				\
 	{					\
 		.clk		= _clk,		\
@@ -46,6 +52,10 @@ static struct clk clk_48 = {
 static struct clk_lookup lookups[] = {
 	CLK(&clk_48, "uart0"),
 	CLK(&clk_48, "uart1"),
+	CLK(&clk_default, "gpio.0"),
+	CLK(&clk_default, "gpio.1"),
+	CLK(&clk_default, "gpio.2"),
+	CLK(&clk_default, "gpio.3"),
 };
 
 static int __init clk_init(void)
diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index c325dad..1b2c989 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -364,7 +364,8 @@ static DEFINE_PRCC_CLK(7, cfgreg_ed, 	0, -1, NULL);
 
 static struct clk_lookup u8500_common_clks[] = {
 	/* Peripheral Cluster #1 */
-	CLK(gpio0,	"gpioblock0",	NULL),
+	CLK(gpio0,	"gpio.0",	NULL),
+	CLK(gpio0,	"gpio.1",	NULL),
 	CLK(slimbus0,	"slimbus0",	NULL),
 	CLK(i2c2,	"nmk-i2c.2",	NULL),
 	CLK(sdi0,	"sdi0",		NULL),
@@ -374,7 +375,10 @@ static struct clk_lookup u8500_common_clks[] = {
 	CLK(uart0,	"uart0",	NULL),
 
 	/* Peripheral Cluster #3 */
-	CLK(gpio2,	"gpioblock2",	NULL),
+	CLK(gpio2,	"gpio.2",	NULL),
+	CLK(gpio2,	"gpio.3",	NULL),
+	CLK(gpio2,	"gpio.4",	NULL),
+	CLK(gpio2,	"gpio.5",	NULL),
 	CLK(sdi5,	"sdi5",		NULL),
 	CLK(uart2,	"uart2",	NULL),
 	CLK(ske,	"ske",		NULL),
@@ -383,7 +387,7 @@ static struct clk_lookup u8500_common_clks[] = {
 	CLK(fsmc,	"fsmc",		NULL),
 
 	/* Peripheral Cluster #5 */
-	CLK(gpio3,	"gpioblock3",	NULL),
+	CLK(gpio3,	"gpio.8",	NULL),
 
 	/* Peripheral Cluster #6 */
 	CLK(hash1,	"hash1",	NULL),
@@ -418,7 +422,8 @@ static struct clk_lookup u8500_ed_clks[] = {
 	CLK(msp1_ed,	"msp1",		NULL),
 
 	/* Peripheral Cluster #2 */
-	CLK(gpio1_ed,	"gpioblock1",	NULL),
+	CLK(gpio1_ed,	"gpio.6",	NULL),
+	CLK(gpio1_ed,	"gpio.7",	NULL),
 	CLK(ssitx_ed,	"ssitx",	NULL),
 	CLK(ssirx_ed,	"ssirx",	NULL),
 	CLK(spi0_ed,	"spi0",		NULL),
@@ -458,7 +463,8 @@ static struct clk_lookup u8500_v1_clks[] = {
 	CLK(msp1_v1,	"msp1",		NULL),
 
 	/* Peripheral Cluster #2 */
-	CLK(gpio1_v1,	"gpioblock1",	NULL),
+	CLK(gpio1_v1,	"gpio.6",	NULL),
+	CLK(gpio1_v1,	"gpio.7",	NULL),
 	CLK(ssitx_v1,	"ssitx",	NULL),
 	CLK(ssirx_v1,	"ssirx",	NULL),
 	CLK(spi0_v1,	"spi0",		NULL),
diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 15d247a..5a6ef25 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -15,6 +15,8 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
@@ -36,6 +38,7 @@
 struct nmk_gpio_chip {
 	struct gpio_chip chip;
 	void __iomem *addr;
+	struct clk *clk;
 	unsigned int parent_irq;
 	spinlock_t lock;
 	/* Keep track of configured edges */
@@ -311,6 +314,7 @@ static int __init nmk_gpio_probe(struct platform_device *dev)
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
 	struct resource *res;
+	struct clk *clk;
 	int irq;
 	int ret;
 
@@ -335,15 +339,24 @@ static int __init nmk_gpio_probe(struct platform_device *dev)
 		goto out;
 	}
 
+	clk = clk_get(&dev->dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto out_release;
+	}
+
+	clk_enable(clk);
+
 	nmk_chip = kzalloc(sizeof(*nmk_chip), GFP_KERNEL);
 	if (!nmk_chip) {
 		ret = -ENOMEM;
-		goto out_release;
+		goto out_clk;
 	}
 	/*
 	 * The virt address in nmk_chip->addr is in the nomadik register space,
 	 * so we can simply convert the resource address, without remapping
 	 */
+	nmk_chip->clk = clk;
 	nmk_chip->addr = io_p2v(res->start);
 	nmk_chip->chip = nmk_gpio_template;
 	nmk_chip->parent_irq = irq;
@@ -369,6 +382,9 @@ static int __init nmk_gpio_probe(struct platform_device *dev)
 
 out_free:
 	kfree(nmk_chip);
+out_clk:
+	clk_disable(clk);
+	clk_put(clk);
 out_release:
 	release_mem_region(res->start, resource_size(res));
 out:
@@ -386,6 +402,8 @@ static int __exit nmk_gpio_remove(struct platform_device *dev)
 
 	nmk_chip = platform_get_drvdata(dev);
 	gpiochip_remove(&nmk_chip->chip);
+	clk_disable(nmk_chip->clk);
+	clk_put(nmk_chip->clk);
 	kfree(nmk_chip);
 	release_mem_region(res->start, resource_size(res));
 	return 0;
-- 
1.7.0
