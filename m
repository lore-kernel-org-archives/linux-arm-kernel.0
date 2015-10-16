From: Minghuan.Lian@freescale.com (Minghuan Lian)
Date: Fri, 16 Oct 2015 15:19:20 +0800
Subject: [PATCH v4 6/6] PCI: layerscape: add ls_pcie_msi_host_init
In-Reply-To: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1444979960-24100-1-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <1444979960-24100-6-git-send-email-Minghuan.Lian@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Layerscape PCIe has its own MSI implementation. The patch registers
ls_pcie_msi_host_init() to avoid using Designware's MSI.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
Change log
v4: split from [PATCH v3] PCI: layerscape: Add PCIe support for LS1043a and LS2080a

 drivers/pci/host/pci-layerscape.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index c53692a..8fac6c8 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -150,14 +150,31 @@ static void ls_pcie_host_init(struct pcie_port *pp)
 	iowrite32(0, pcie->dbi + PCIE_DBI_RO_WR_EN);
 }
 
+static int ls_pcie_msi_host_init(struct pcie_port *pp,
+				 struct msi_controller *chip)
+{
+	struct device_node *msi_node;
+	struct device_node *np = pp->dev->of_node;
+
+	msi_node = of_parse_phandle(np, "msi-parent", 0);
+	if (!msi_node) {
+		dev_err(pp->dev, "failed to find msi-parent\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static struct pcie_host_ops ls1021_pcie_host_ops = {
 	.link_up = ls1021_pcie_link_up,
 	.host_init = ls1021_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct pcie_host_ops ls_pcie_host_ops = {
 	.link_up = ls_pcie_link_up,
 	.host_init = ls_pcie_host_init,
+	.msi_host_init = ls_pcie_msi_host_init,
 };
 
 static struct ls_pcie_drvdata ls1021_drvdata = {
-- 
1.9.1
