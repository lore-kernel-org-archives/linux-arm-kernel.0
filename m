From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Aug 2013 20:46:47 +0200
Subject: [PATCH 1/9] PCI: mvebu: move clock enable before register access
In-Reply-To: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376333215-12885-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1376333215-12885-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock passed to PCI controller found on MVEBU SoCs may come from a
clock gate. This requires the clock to be enabled before any registers
are accessed. Therefore, move the clock enable before register iomap to
ensure it is enabled.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-pci at vger.kernel.org
---
 drivers/pci/host/pci-mvebu.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 6aa0daf..d5fe674 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -897,6 +897,16 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
+		port->clk = of_clk_get_by_name(child, NULL);
+		if (IS_ERR(port->clk)) {
+			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
+			       port->port, port->lane);
+			iounmap(port->base);
+			port->haslink = 0;
+			continue;
+		}
+		clk_prepare_enable(port->clk);
+
 		port->base = mvebu_pcie_map_registers(pdev, child, port);
 		if (!port->base) {
 			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
@@ -916,22 +926,9 @@ static int __init mvebu_pcie_probe(struct platform_device *pdev)
 				 port->port, port->lane);
 		}
 
-		port->clk = of_clk_get_by_name(child, NULL);
-		if (IS_ERR(port->clk)) {
-			dev_err(&pdev->dev, "PCIe%d.%d: cannot get clock\n",
-			       port->port, port->lane);
-			iounmap(port->base);
-			port->haslink = 0;
-			continue;
-		}
-
 		port->dn = child;
-
-		clk_prepare_enable(port->clk);
 		spin_lock_init(&port->conf_lock);
-
 		mvebu_sw_pci_bridge_init(port);
-
 		i++;
 	}
 
-- 
1.7.10.4
