From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 17 Dec 2014 11:34:46 +0100
Subject: [PATCH 5/5] PCI: st: disable IO support
In-Reply-To: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1418812486-12394-6-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sti SoCs PCIe IPs are built around DesignWare IP Core.
But in these SoCs, PCIe IP doesn't support IO.
By default, when no IO space is provided, a default one is assigned.

Add an empty IO resource to the bus, and disable IO by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pci/host/pci-st.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/host/pci-st.c b/drivers/pci/host/pci-st.c
index bd3d32d..c0d3895 100644
--- a/drivers/pci/host/pci-st.c
+++ b/drivers/pci/host/pci-st.c
@@ -357,9 +357,15 @@ static void st_pcie_board_reset(struct pcie_port *pp)
 static void st_pcie_hw_setup(struct pcie_port *pp)
 {
 	struct st_pcie *pcie = to_st_pcie(pp);
+	u32 val;
 
 	dw_pcie_setup_rc(pp);
 
+	/* Disable IO support */
+	val = readl_relaxed(pp->dbi_base + PCI_COMMAND);
+	val &= ~PCI_COMMAND_IO;
+	writel_relaxed(val, pp->dbi_base + PCI_COMMAND);
+
 	/* Set up the config window to the top of the PCI address space */
 	writel_relaxed(pcie->config_window_start,
 		       pp->dbi_base + CFG_BASE_ADDRESS);
@@ -445,11 +451,28 @@ static void st_pcie_host_init(struct pcie_port *pp)
 		st_msi_init_one(pp);
 }
 
+static void st_pcie_setup_bus(struct pcie_port *pp, struct pci_sys_data *sys)
+{
+	struct resource *res;
+
+	/* This PCIe controller does not support IO, set an empty one. */
+	res = devm_kzalloc(pp->dev, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return;
+
+	res->start = 0;
+	res->end = 0;
+	res->name = "PCIe empty IO space";
+	res->flags = IORESOURCE_IO;
+	pci_add_resource(&sys->resources, res);
+}
+
 static struct pcie_host_ops st_pcie_host_ops = {
 	.rd_other_conf = st_pcie_rd_other_conf,
 	.wr_other_conf = st_pcie_wr_other_conf,
 	.link_up = st_pcie_link_up,
 	.host_init = st_pcie_host_init,
+	.setup_bus = st_pcie_setup_bus,
 };
 
 static int st_pcie_init(struct pcie_port *pp)
-- 
1.9.1
