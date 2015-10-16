From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Fri, 16 Oct 2015 15:19:16 +0800
Subject: [PATCH v4 2/6] PCI: layerscape: check PCIe controller work mode
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1444979960-24100-2-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Layerscape PCIe controller supports root complex (RC) and
endpoint (EP) mode. The mode can be set by RCW. The patch
will check it. If not in RC mode, the driver directly
returns -ENODEV.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 6dd44a0..5eabe92 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -47,6 +47,16 @@ struct ls_pcie {
 
 #define to_ls_pcie(x)	container_of(x, struct ls_pcie, pp)
 
+static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
+{
+	u32 header_type;
+
+	header_type = ioread8(pcie->dbi + PCI_HEADER_TYPE);
+	header_type &= 0x7f;
+
+	return header_type == PCI_HEADER_TYPE_BRIDGE;
+}
+
 static int ls_pcie_link_up(struct pcie_port *pp)
 {
 	u32 state;
@@ -135,6 +145,9 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 		return ret;
 	pcie->index = index[1];
 
+	if (!ls_pcie_is_bridge(pcie))
+		return -ENODEV;
+
 	ret = ls_add_pcie_port(pcie);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
