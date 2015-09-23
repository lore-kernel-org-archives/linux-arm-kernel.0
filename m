From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Sep 2015 18:17:42 +0100
Subject: [PATCH 4/6] pci: mvebu: use for_each_available_child_of_node() to
 walk child nodes
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Message-ID: <E1Zenfq-0004dH-Tm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than using for_each_child_of_node() and testing each child's
availability, use the for_each_available_child_of_node() helper instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 0ed14f477bf8..d331d2664580 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -978,13 +978,10 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	i = 0;
-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
 		struct mvebu_pcie_port *port = &pcie->ports[i];
 		enum of_gpio_flags flags;
 
-		if (!of_device_is_available(child))
-			continue;
-
 		port->pcie = pcie;
 
 		if (of_property_read_u32(child, "marvell,pcie-port",
-- 
2.1.0
