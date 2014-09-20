From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 20 Sep 2014 20:06:28 +0200
Subject: [PATCH 2/5] PCI: mvebu: Count number of lanes
In-Reply-To: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411236391-422-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PCIe controllers found on Armada XP SoCs can be configured as
either four single-lane x1 or one quad-lane x4 PCIe. Although we are
not (yet) interested in the physical configuration of the PCIe
controller, we will need it when proper PHY support for PCIe is added.
Adapt the driver to the amended DT semantic and count the number of
PCIe lanes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/pci/host/pci-mvebu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index a8c6f1a92e0f..0feee6cd395c 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -115,6 +115,7 @@ struct mvebu_pcie_port {
 	void __iomem *base;
 	u32 port;
 	u32 lane;
+	int num_lanes;
 	int devfn;
 	unsigned int mem_target;
 	unsigned int mem_attr;
@@ -982,9 +983,17 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		if (of_property_read_u32(child, "marvell,pcie-lane",
-					 &port->lane))
+		/*
+		 * If there are multiple lanes, we are only interested in the
+		 * number of the first lane and the lane count.
+		 */
+		if (of_property_read_u32_index(child, "marvell,pcie-lane",
+					       0, &port->lane))
 			port->lane = 0;
+		port->num_lanes = of_property_count_u32_elems(child,
+						      "marvell,pcie-lane");
+		if (!port->num_lanes)
+			port->num_lanes = 1;
 
 		port->name = kasprintf(GFP_KERNEL, "pcie%d.%d",
 				       port->port, port->lane);
-- 
2.0.0
