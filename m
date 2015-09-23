From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Sep 2015 18:17:48 +0100
Subject: [PATCH 5/6] pci: mvebu: report full node name when reporting a DT
 error
In-Reply-To: <20150923171706.GL21084@n2100.arm.linux.org.uk>
References: <20150923171706.GL21084@n2100.arm.linux.org.uk>
Message-ID: <E1Zenfw-0004dN-8k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we have a missing required property, report the full node name rather
than a vague "PCIe DT node" statement.  This allows the exact node in
error to be identified immediately.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pci/host/pci-mvebu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index d331d2664580..8c715444b722 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -987,7 +987,8 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 		if (of_property_read_u32(child, "marvell,pcie-port",
 					 &port->port)) {
 			dev_warn(&pdev->dev,
-				 "ignoring PCIe DT node, missing pcie-port property\n");
+				 "ignoring %s, missing pcie-port property\n",
+				 of_node_full_name(child));
 			continue;
 		}
 
-- 
2.1.0
