From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 24 Mar 2015 11:34:19 +0800
Subject: [PATCH v8 25/30] PCI/designware: Use pci_scan_root_bus() for
 simplicity
In-Reply-To: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
References: <1427168064-8657-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1427168064-8657-26-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use pci_scan_root_bus() instead of pci_create_root_bus() +
pci_scan_child_bus() for simplicity.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Mohit Kumar <mohit.kumar@st.com>
CC: Jingoo Han <jg1.han@samsung.com>
---
 drivers/pci/host/pcie-designware.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 93778b9..3d7d6fb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -728,13 +728,11 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
 	struct pcie_port *pp = sys_to_pcie(sys);
 
 	pp->root_bus_nr = sys->busnr;
-	bus = pci_create_root_bus(pp->dev, -1, sys->busnr,
+	bus = pci_scan_root_bus(pp->dev, -1, sys->busnr,
 				  &dw_pcie_ops, sys, &sys->resources);
 	if (!bus)
 		return NULL;
 
-	pci_scan_child_bus(bus);
-
 	if (bus && pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-- 
1.7.1
