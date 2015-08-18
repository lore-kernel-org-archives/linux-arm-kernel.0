From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue, 18 Aug 2015 23:45:55 +0800
Subject: [Bugfix] PCI: Fix a typo in file pcie-xilinx.c caused by commit
 e39758e0ea76
In-Reply-To: <CAErSpo6aryRYOJpfXfY6SuJoVe72MYd8RKgPhiDZ9pt5+zmXBQ@mail.gmail.com>
References: <CAErSpo6aryRYOJpfXfY6SuJoVe72MYd8RKgPhiDZ9pt5+zmXBQ@mail.gmail.com>
Message-ID: <1439912763-10645-1-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a typo in commit e39758e0ea76 ("PCI: Use helper functions to access
fields in struct msi_desc") in linux-next, which incorrectly spells
"msi_desc_to_pci_sysdata()" as "msi_desc_to_pci_sys_data()" and causes
buidling failure:
> ../drivers/pci/host/pcie-xilinx.c:235:3: error: implicit declaration of function 'msi_desc_to_pci_sys_data' [-Werror=implicit-function-declaration]

Links: https://lkml.org/lkml/2015/7/9/100

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/host/pcie-xilinx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
index 64454f416639..be494e46bbd1 100644
--- a/drivers/pci/host/pcie-xilinx.c
+++ b/drivers/pci/host/pcie-xilinx.c
@@ -232,7 +232,7 @@ static void xilinx_pcie_destroy_msi(unsigned int irq)
 
 	if (!test_bit(irq, msi_irq_in_use)) {
 		msi = irq_get_msi_desc(irq);
-		port = sys_to_pcie(msi_desc_to_pci_sys_data(msi));
+		port = sys_to_pcie(msi_desc_to_pci_sysdata(msi));
 		dev_err(port->dev, "Trying to free unused MSI#%d\n", irq);
 	} else {
 		clear_bit(irq, msi_irq_in_use);
-- 
1.7.10.4
