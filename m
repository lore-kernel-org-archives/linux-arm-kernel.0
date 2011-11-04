From: olof@lixom.net (Olof Johansson)
Date: Thu,  3 Nov 2011 20:26:14 -0700
Subject: [PATCH 2/2] USB: ehci-tegra: add probing through device tree
In-Reply-To: <1320377174-28047-1-git-send-email-olof@lixom.net>
References: <1320377174-28047-1-git-send-email-olof@lixom.net>
Message-ID: <1320377174-28047-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rely on platform_data being passed through auxdata for now; more elaborate
bindings for phy config and tunings to be added.

Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/mach-tegra/board-dt.c |    8 +++++
 drivers/usb/host/ehci-tegra.c  |   62 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt.c b/arch/arm/mach-tegra/board-dt.c
index 74743ad..808a12e 100644
--- a/arch/arm/mach-tegra/board-dt.c
+++ b/arch/arm/mach-tegra/board-dt.c
@@ -61,12 +61,20 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.0", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-i2s", TEGRA_I2S1_BASE, "tegra-i2s.1", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-das", TEGRA_APB_MISC_DAS_BASE, "tegra-das", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB_BASE, "tegra-ehci.0",
+		       &tegra_ehci1_device.dev.platform_data),
+	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB2_BASE, "tegra-ehci.1",
+		       &tegra_ehci2_device.dev.platform_data),
+	OF_DEV_AUXDATA("nvidia,tegra20-ehci", TEGRA_USB3_BASE, "tegra-ehci.2",
+		       &tegra_ehci3_device.dev.platform_data),
 	{}
 };
 
 static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	/* name		parent		rate		enabled */
 	{ "uartd",	"pll_p",	216000000,	true },
+	{ "usbd",	"clk_m",	12000000,	false },
+	{ "usb3",	"clk_m",	12000000,	false },
 	{ NULL,		NULL,		0,		0},
 };
 
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index db9d1b4..58c3ccc 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -21,7 +21,12 @@
 #include <linux/platform_data/tegra_usb.h>
 #include <linux/irq.h>
 #include <linux/usb/otg.h>
+#include <linux/gpio.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+
 #include <mach/usb_phy.h>
+#include <mach/iomap.h>
 
 #define TEGRA_USB_DMA_ALIGN 32
 
@@ -574,6 +579,27 @@ static const struct hc_driver tegra_ehci_hc_driver = {
 	.port_handed_over	= ehci_port_handed_over,
 };
 
+static int setup_vbus_gpio(struct platform_device *pdev, int gpio)
+{
+	int err = 0;
+
+	err = gpio_request(gpio, "vbus_gpio");
+	if (err) {
+		dev_err(&pdev->dev, "can't request vbus gpio %d", gpio);
+		return err;
+	}
+	err = gpio_direction_output(gpio, 1);
+	if (err) {
+		dev_err(&pdev->dev, "can't enable vbus\n");
+		return err;
+	}
+	gpio_set_value(gpio, 1);
+
+	return err;
+}
+
+static u64 tegra_ehci_dma_mask = DMA_BIT_MASK(32);
+
 static int tegra_ehci_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -583,6 +609,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	int err = 0;
 	int irq;
 	int instance = pdev->id;
+	int vbus_gpio;
 
 	pdata = pdev->dev.platform_data;
 	if (!pdata) {
@@ -590,6 +617,13 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!pdev->dev.dma_mask)
+		pdev->dev.dma_mask = &tegra_ehci_dma_mask;
+
+	vbus_gpio = of_get_named_gpio(pdev->dev.of_node, "nvidia,vbus-gpio", 0);
+	if (vbus_gpio > 0)
+		setup_vbus_gpio(pdev, vbus_gpio);
+
 	tegra = kzalloc(sizeof(struct tegra_ehci_hcd), GFP_KERNEL);
 	if (!tegra)
 		return -ENOMEM;
@@ -640,6 +674,28 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto fail_io;
 	}
 
+	/* This is pretty ugly and needs to be fixed when we do only
+	 * device-tree probing. Old code relies on the platform_device
+	 * numbering that we lack for device-tree-instantiated devices.
+	 */
+	if (instance < 0) {
+		switch (res->start) {
+		case TEGRA_USB_BASE:
+			instance = 0;
+			break;
+		case TEGRA_USB2_BASE:
+			instance = 1;
+			break;
+		case TEGRA_USB3_BASE:
+			instance = 2;
+			break;
+		default:
+			err = -ENODEV;
+			dev_err(&pdev->dev, "unknown usb instance\n");
+			goto fail_phy;
+		}
+	}
+
 	tegra->phy = tegra_usb_phy_open(instance, hcd->regs, pdata->phy_config,
 						TEGRA_USB_PHY_MODE_HOST);
 	if (IS_ERR(tegra->phy)) {
@@ -773,6 +829,11 @@ static void tegra_ehci_hcd_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static struct of_device_id tegra_ehci_of_match[] __devinitdata = {
+	{ .compatible = "nvidia,tegra20-ehci", },
+	{ },
+};
+
 static struct platform_driver tegra_ehci_driver = {
 	.probe		= tegra_ehci_probe,
 	.remove		= tegra_ehci_remove,
@@ -783,5 +844,6 @@ static struct platform_driver tegra_ehci_driver = {
 	.shutdown	= tegra_ehci_hcd_shutdown,
 	.driver		= {
 		.name	= "tegra-ehci",
+		.of_match_table = tegra_ehci_of_match,
 	}
 };
-- 
1.7.4.1
