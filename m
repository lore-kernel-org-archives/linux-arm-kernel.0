From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Aug 2015 10:25:34 +0100
Subject: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
In-Reply-To: <20150805092318.GB6092@arm.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com> <20150805092318.GB6092@arm.com>
Message-ID: <20150805092533.GC6092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 10:23:18AM +0100, Will Deacon wrote:
> That said, I just tried to build this and it fails to compile the x-gene
> PCI host driver. Fixup below.

Wait, there's more!

Will

--->8

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 514f41b86c49..8ab3bd098424 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -506,7 +506,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 {
 	struct device_node *msi_node;
 
-	msi_node = of_parse_phandle(port->dev.of_node, "msi-parent", 0);
+	msi_node = of_parse_phandle(port->dev->of_node, "msi-parent", 0);
 	if (!msi_node)
 		return -ENODEV;
 
@@ -515,7 +515,7 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	port->msi->dev = &port->dev;
+	port->msi->dev = port->dev;
 	return 0;
 }
 
