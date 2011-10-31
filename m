From: marvin24@gmx.de (Marc Dietrich)
Date: Mon, 31 Oct 2011 20:58:54 +0100
Subject: [PATCH 2/3] staging: nvec: add device tree support
In-Reply-To: <cover.1320088857.git.marvin24@gmx.de>
References: <cover.1320088857.git.marvin24@gmx.de>
Message-ID: <04ffd9770698b7efb119b92fa379eb2e2698e223.1320088857.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree support to the nvec driver. By using this method
it is no longer necessary to specify platform data through a board
file.

Cc: devel at driverdev.osuosl.org
Cc: Greg KH <gregkh@suse.de>
Cc: Julian Andres Klode <jak@jak-linux.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Marc Dietrich <marvin24@gmx.de>
---
 .../devicetree/bindings/nvec/nvec_nvidia.txt       |    9 +++++
 drivers/staging/nvec/nvec.c                        |   35 ++++++++++++++++++-
 2 files changed, 42 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvec/nvec_nvidia.txt

diff --git a/Documentation/devicetree/bindings/nvec/nvec_nvidia.txt b/Documentation/devicetree/bindings/nvec/nvec_nvidia.txt
new file mode 100644
index 0000000..5aeee53
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvec/nvec_nvidia.txt
@@ -0,0 +1,9 @@
+NVIDIA compliant embedded controller
+
+Required properties:
+- compatible : should be "nvidia,nvec".
+- reg : the iomem of the i2c slave controller
+- interrupts : the interrupt line of the i2c slave controller
+- clock-frequency : the frequency of the i2c bus
+- gpios : the gpio used for ec request
+- slave-addr: the i2c address of the slave controller
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index e06b867..ffb73c0 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -27,6 +27,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
 #include <linux/list.h>
 #include <linux/mfd/core.h>
 #include <linux/mutex.h>
@@ -36,6 +38,8 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include <asm/byteorder.h>
+
 #include <mach/clk.h>
 #include <mach/iomap.h>
 
@@ -719,6 +723,7 @@ static int __devinit tegra_nvec_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct resource *iomem;
 	void __iomem *base;
+	const unsigned int *prop;
 
 	nvec = kzalloc(sizeof(struct nvec_chip), GFP_KERNEL);
 	if (nvec == NULL) {
@@ -727,8 +732,26 @@ static int __devinit tegra_nvec_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, nvec);
 	nvec->dev = &pdev->dev;
-	nvec->gpio = pdata->gpio;
-	nvec->i2c_addr = pdata->i2c_addr;
+
+	if (pdata) {
+		nvec->gpio = pdata->gpio;
+		nvec->i2c_addr = pdata->i2c_addr;
+	} else if (nvec->dev->of_node) {
+		nvec->gpio = of_get_named_gpio(nvec->dev->of_node, "request-gpios", 0);
+		if (nvec->gpio < 0) {
+			dev_err(&pdev->dev, "no gpio specified");
+			goto failed;
+		}
+		prop = of_get_property(nvec->dev->of_node, "slave-addr", NULL);
+		if (!prop) {
+			dev_err(&pdev->dev, "no i2c address specified");
+			goto failed;
+		}
+		nvec->i2c_addr = be32_to_cpup(prop);
+	} else {
+		dev_err(&pdev->dev, "no platform data\n");
+		goto failed;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -893,6 +916,13 @@ static int tegra_nvec_resume(struct platform_device *pdev)
 #define tegra_nvec_resume NULL
 #endif
 
+/* Match table for of_platform binding */
+static const struct of_device_id nvidia_nvec_of_match[] __devinitconst = {
+	{ .compatible = "nvidia,nvec", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, nvidia_nvec_of_match);
+
 static struct platform_driver nvec_device_driver = {
 	.probe   = tegra_nvec_probe,
 	.remove  = __devexit_p(tegra_nvec_remove),
@@ -901,6 +931,7 @@ static struct platform_driver nvec_device_driver = {
 	.driver  = {
 		.name = "nvec",
 		.owner = THIS_MODULE,
+		.of_match_table = nvidia_nvec_of_match,
 	}
 };
 
-- 
1.7.5.4
