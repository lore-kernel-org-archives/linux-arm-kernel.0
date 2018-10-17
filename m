From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Oct 2018 13:11:11 +0530
Subject: [PATCH v2 18/21] PCI: keystone: Use ERR_IRQ_STATUS instead of
 ERR_IRQ_STATUS_RAW to get interrupt status
In-Reply-To: <20181017074114.28239-1-kishon@ti.com>
References: <20181017074114.28239-1-kishon@ti.com>
Message-ID: <20181017074114.28239-19-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use ERR_IRQ_STATUS instead of ERR_IRQ_STATUS_RAW to get interrupt
status. ERR_IRQ_STATUS_RAW has the status of the interrupts
before masking whereas ERR_IRQ_STATUS has the status of the interrupts
after masking. Since all the interrupts are unmasked here, use
ERR_IRQ_STATUS.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e181e6277323..c0bba7b604fa 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -80,7 +80,6 @@
 #define ERR_IRQ_ALL	(ERR_AER | ERR_AXI | ERR_CORR | \
 			 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 #define ERR_FATAL_IRQ	(ERR_FATAL | ERR_AXI)
-#define ERR_IRQ_STATUS_RAW		0x1c0
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_IRQ_ENABLE_CLR		0x1cc
@@ -249,7 +248,7 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 status;
 
-	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS_RAW) & ERR_IRQ_ALL;
+	status = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
 	if (!status)
 		return IRQ_NONE;
 
-- 
2.17.1
