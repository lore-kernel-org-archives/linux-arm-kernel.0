From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 19 Jan 2017 08:36:30 -0800
Subject: [PATCH 2/3] PCI: imx6: Allow probe deferal by reset GPIO
In-Reply-To: <20170119163631.10668-1-andrew.smirnov@gmail.com>
References: <20170119163631.10668-1-andrew.smirnov@gmail.com>
Message-ID: <20170119163631.10668-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some designs implement reset GPIO via a GPIO expander connected to a
peripheral bus. One such example would be i.MX7 Sabre board where said
GPIO is provided by SPI shift register connected to a bitbanged SPI
bus. In order to support such designs allow reset GPIO request to defer
probing of the driver.

Cc: yurovsky at gmail.com
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/pci/host/pci-imx6.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
index 50a1291..574f026 100644
--- a/drivers/pci/host/pci-imx6.c
+++ b/drivers/pci/host/pci-imx6.c
@@ -653,6 +653,9 @@ static int __init imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "unable to get reset gpio\n");
 			return ret;
 		}
+	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
+		dev_info(dev, "probe is defered by reset GPIO\n");
+		return imx6_pcie->reset_gpio;
 	}
 
 	/* Fetch clocks */
@@ -746,11 +749,12 @@ static struct platform_driver imx6_pcie_driver = {
 		.name	= "imx6q-pcie",
 		.of_match_table = imx6_pcie_of_match,
 	},
+	.probe    = imx6_pcie_probe,
 	.shutdown = imx6_pcie_shutdown,
 };
 
 static int __init imx6_pcie_init(void)
 {
-	return platform_driver_probe(&imx6_pcie_driver, imx6_pcie_probe);
+	return platform_driver_register(&imx6_pcie_driver);
 }
 device_initcall(imx6_pcie_init);
-- 
2.9.3
