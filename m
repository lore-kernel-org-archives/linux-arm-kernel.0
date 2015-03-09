From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:34:22 +0800
Subject: [PATCH v6 25/30] PCI/designware: Use pci_scan_root_bus() for
 simplicity
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425868467-9667-26-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pci_scan_root_bus() instead of pci_create_root_bus() +
pci_scan_child_bus() for simplicity.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Mohit Kumar <mohit.kumar@st.com>
CC: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pcie-designware.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 1f4ea6f..658b46b 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -728,13 +728,11 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pcie_port *pp = sys_to_pcie(sys);
 
 	pp->root_bus_nr = sys->busnr;
-	bus = pci_create_root_bus(pp->dev, sys->busnr,
+	bus = pci_scan_root_bus(pp->dev, sys->busnr,
 				  &dw_pcie_ops, sys, &sys->resources);
 	if (!bus)
 		return NULL;
 
-	pci_scan_child_bus(bus);
-
 	if (bus && pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-- 
1.7.1
