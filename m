From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:21 +0100
Subject: [PATCH 02/12] PCI: aardvark: add reset GPIO support
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-3-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IP supports a reset GPIO. When S2RAM will be added, we must ensure
the reset line (if any) is deasserted when resuming. Add support for
it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 57 +++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index b95eb2aa00bb..1d31d74ddab7 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -17,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 
 #include "../pci.h"
@@ -201,6 +203,7 @@ struct advk_pcie {
 	u16 msi_msg;
 	int root_bus_nr;
 	struct pci_bridge_emul bridge;
+	struct gpio_desc *reset_gpio;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -973,6 +976,55 @@ static int advk_pcie_parse_request_of_pci_ranges(struct advk_pcie *pcie)
 	return err;
 }
 
+static int advk_pcie_hard_reset(struct advk_pcie *pcie)
+{
+	if (!pcie->reset_gpio)
+		return -EINVAL;
+
+	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
+	msleep(1);
+	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
+
+	return 0;
+}
+
+static int advk_pcie_setup_reset_gpio(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	enum of_gpio_flags of_flags;
+	unsigned long gpio_flags;
+	int gpio_nb;
+	int ret;
+
+	gpio_nb = of_get_named_gpio_flags(dev->of_node, "reset-gpios", 0,
+					  &of_flags);
+	if (gpio_nb == -EPROBE_DEFER)
+		return gpio_nb;
+
+	/* Old bindings miss the reset GPIO handle */
+	if (!gpio_is_valid(gpio_nb)) {
+		dev_warn(dev, "Reset GPIO unavailable\n");
+		return 0;
+	}
+
+	if (of_flags & OF_GPIO_ACTIVE_LOW)
+		gpio_flags = GPIOF_ACTIVE_LOW |
+			     GPIOF_OUT_INIT_LOW;
+	else
+		gpio_flags = GPIOF_OUT_INIT_HIGH;
+
+	ret = devm_gpio_request_one(dev, gpio_nb, gpio_flags,
+				    "pcie-aardvark-reset");
+	if (ret) {
+		dev_err(dev, "Failed to retrieve reset GPIO (%d)\n", ret);
+		return ret;
+	}
+
+	pcie->reset_gpio = gpio_to_desc(gpio_nb);
+
+	return 0;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1008,6 +1060,11 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = advk_pcie_setup_reset_gpio(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_hard_reset(pcie);
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.19.1
