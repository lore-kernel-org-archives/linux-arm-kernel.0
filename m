From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu,  6 Oct 2011 17:41:34 +0200
Subject: [PATCH 2/2] hw_random: add driver for atmel true hardware random
	number generator
In-Reply-To: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <1317915694-27564-2-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the IP block on 9g45/9g46/9m10/9m11.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 drivers/char/hw_random/Kconfig     |   13 +++
 drivers/char/hw_random/Makefile    |    1 +
 drivers/char/hw_random/atmel-rng.c |  168 ++++++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/atmel-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 1d2ebc7..e013587 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -60,6 +60,19 @@ config HW_RANDOM_AMD
 
 	  If unsure, say Y.
 
+config HW_RANDOM_ATMEL
+	tristate "Atmel Random Number Generator support"
+	depends on HW_RANDOM && ARCH_AT91SAM9G45
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on Atmel AT91 devices.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atmel-rng.
+
+	  If unsure, say Y.
+
 config HW_RANDOM_GEODE
 	tristate "AMD Geode HW Random Number Generator support"
 	depends on HW_RANDOM && X86_32 && PCI
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index c88f244..b2ff526 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -7,6 +7,7 @@ rng-core-y := core.o
 obj-$(CONFIG_HW_RANDOM_TIMERIOMEM) += timeriomem-rng.o
 obj-$(CONFIG_HW_RANDOM_INTEL) += intel-rng.o
 obj-$(CONFIG_HW_RANDOM_AMD) += amd-rng.o
+obj-$(CONFIG_HW_RANDOM_ATMEL) += atmel-rng.o
 obj-$(CONFIG_HW_RANDOM_GEODE) += geode-rng.o
 obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
 n2-rng-y := n2-drv.o n2-asm.o
diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
new file mode 100644
index 0000000..c69eccb
--- /dev/null
+++ b/drivers/char/hw_random/atmel-rng.c
@@ -0,0 +1,168 @@
+/*
+ * Copyright (c) 2011 Peter Korsgaard <jacmet@sunsite.dk>
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/hw_random.h>
+#include <linux/platform_device.h>
+
+#define TRNG_CR		0x00
+#define TRNG_ISR	0x1c
+#define TRNG_ODATA	0x50
+
+#define TRNG_KEY	0x524e4700 /* RNG */
+
+struct atmel_trng {
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static int atmel_trng_read(struct hwrng *rng, void *buf, size_t max,
+			   bool wait)
+{
+	struct atmel_trng *trng = (struct atmel_trng *)rng->priv;
+	u32 *data = buf;
+
+	/* data ready? */
+	if (readl(trng->base + TRNG_ODATA) & 1) {
+		*data = readl(trng->base + TRNG_ODATA);
+		return 4;
+	} else
+		return 0;
+}
+
+static struct hwrng atmel_trng = {
+	.name	= "atmel-trng",
+	.read	= atmel_trng_read,
+};
+
+static int atmel_trng_probe(struct platform_device *pdev)
+{
+	struct atmel_trng *trng;
+	struct resource *res;
+	int ret;
+
+	if (atmel_trng.priv) {
+		dev_err(&pdev->dev, "multiple instances not supported\n");
+		return -EBUSY;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	trng = devm_kzalloc(&pdev->dev, sizeof(*trng), GFP_KERNEL);
+	if (!trng)
+		return -ENOMEM;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), pdev->name))
+		return -EBUSY;
+
+	trng->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (!trng->base)
+		return -EBUSY;
+
+	trng->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(trng->clk))
+		return PTR_ERR(trng->clk);
+
+	ret = clk_enable(trng->clk);
+	if (ret)
+		goto err_enable;
+
+	writel(TRNG_KEY | 1, trng->base + TRNG_CR);
+
+	atmel_trng.priv = (unsigned long)trng;
+
+	ret = hwrng_register(&atmel_trng);
+	if (ret)
+		goto err_register;
+
+	platform_set_drvdata(pdev, trng);
+
+	return 0;
+
+err_register:
+	atmel_trng.priv = 0;
+	clk_disable(trng->clk);
+err_enable:
+	clk_put(trng->clk);
+
+	return ret;
+}
+
+static int __devexit atmel_trng_remove(struct platform_device *pdev)
+{
+	struct atmel_trng *trng = platform_get_drvdata(pdev);
+
+	hwrng_unregister(&atmel_trng);
+
+	writel(TRNG_KEY, trng->base + TRNG_CR);
+	clk_disable(trng->clk);
+	clk_put(trng->clk);
+
+	atmel_trng.priv = 0;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int atmel_trng_suspend(struct device *dev)
+{
+	struct atmel_trng *trng = dev_get_drvdata(dev);
+
+	clk_disable(trng->clk);
+
+	return 0;
+}
+
+static int atmel_trng_resume(struct device *dev)
+{
+	struct atmel_trng *trng = dev_get_drvdata(dev);
+
+	return clk_enable(trng->clk);
+}
+
+static const struct dev_pm_ops atmel_trng_pm_ops = {
+	.suspend	= atmel_trng_suspend,
+	.resume		= atmel_trng_resume,
+};
+#endif /* CONFIG_PM */
+
+static struct platform_driver atmel_trng_driver = {
+	.probe		= atmel_trng_probe,
+	.remove		= __devexit_p(atmel_trng_remove),
+	.driver		= {
+		.name	= "atmel-trng",
+		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &atmel_trng_pm_ops,
+#endif /* CONFIG_PM */
+	},
+};
+
+static int __init atmel_trng_init(void)
+{
+	return platform_driver_register(&atmel_trng_driver);
+}
+module_init(atmel_trng_init);
+
+static void __exit atmel_trng_exit(void)
+{
+	platform_driver_unregister(&atmel_trng_driver);
+}
+module_exit(atmel_trng_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
+MODULE_DESCRIPTION("Atmel true random number generator driver");
-- 
1.7.6.3
