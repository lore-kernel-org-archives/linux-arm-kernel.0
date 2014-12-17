From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Wed, 17 Dec 2014 11:34:45 +0100
Subject: [PATCH 4/5] PCI: designware: Add setup bus-related to pcie_host_ops
In-Reply-To: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1418812486-12394-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1418812486-12394-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ST sti SoCs PCIe IPs are built around DesignWare IP Core.
But in these SoCs PCIe IP doesn't support IO.

To support this, add setup_bus() to pcie_host_ops.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 drivers/pci/host/pcie-designware.c | 3 +++
 drivers/pci/host/pcie-designware.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index df781cd..98e19bc 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -719,6 +719,9 @@ static int dw_pcie_setup(int nr, struct pci_sys_data *sys)
 	pci_add_resource_offset(&sys->resources, &pp->mem, sys->mem_offset);
 	pci_add_resource(&sys->resources, &pp->busn);
 
+	if (pp->ops->setup_bus)
+		pp->ops->setup_bus(pp, sys);
+
 	return 1;
 }
 
diff --git a/drivers/pci/host/pcie-designware.h b/drivers/pci/host/pcie-designware.h
index d0bbd27..5c13de7 100644
--- a/drivers/pci/host/pcie-designware.h
+++ b/drivers/pci/host/pcie-designware.h
@@ -73,6 +73,7 @@ struct pcie_host_ops {
 	u32 (*get_msi_addr)(struct pcie_port *pp);
 	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
+	void (*setup_bus)(struct pcie_port *pp, struct pci_sys_data *sys);
 	int (*msi_host_init)(struct pcie_port *pp, struct msi_controller *chip);
 };
 
-- 
1.9.1
