From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Mon, 16 Nov 2015 16:19:07 +0100
Subject: [PATCH] PCI: imx6: Fix reset-gpio to work with active low GPIO
Message-ID: <1447687147-19436-1-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's currently not possible to use reset-gpio on board where the GPIO is
active low as the code incorrectly assumes, that reset-gpio will be
always active high.

In my case the broken behavior was observed on Toradex Apalis SoM with
Ixora base board.

Signed-off-by: Petr ?tetiar <ynezz@true.cz>
---
 drivers/pci/host/pci-imx6.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index fdb9536..cd7ed71 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -293,9 +293,11 @@ static int imx6_pcie_deassert_core_reset(struct pcie_port *pp)
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value(imx6_pcie->reset_gpio, 0);
+		struct gpio_desc *gd = gpio_to_desc(imx6_pcie->reset_gpio);
+
+		gpiod_set_value(gd, 0);
 		msleep(100);
-		gpio_set_value(imx6_pcie->reset_gpio, 1);
+		gpiod_set_value(gd, 1);
 	}
 	return 0;
 
@@ -559,6 +561,8 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 	struct pcie_port *pp;
 	struct device_node *np = pdev->dev.of_node;
 	struct resource *dbi_base;
+	enum of_gpio_flags of_flags;
+	int flags = GPIOF_OUT_INIT_LOW;
 	int ret;
 
 	imx6_pcie = devm_kzalloc(&pdev->dev, sizeof(*imx6_pcie), GFP_KERNEL);
@@ -578,10 +582,13 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pp->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);
+	imx6_pcie->reset_gpio = of_get_named_gpio_flags(np, "reset-gpio", 0,
+							&of_flags);
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
+		if (of_flags & OF_GPIO_ACTIVE_LOW)
+			flags |= GPIOF_ACTIVE_LOW;
 		ret = devm_gpio_request_one(&pdev->dev, imx6_pcie->reset_gpio,
-					    GPIOF_OUT_INIT_LOW, "PCIe reset");
+					    flags, "PCIe reset");
 		if (ret) {
 			dev_err(&pdev->dev, "unable to get reset gpio\n");
 			return ret;
-- 
1.7.9.5
