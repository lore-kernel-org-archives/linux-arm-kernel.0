From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 10 Aug 2016 13:31:19 +0800
Subject: [PATCH v2 2/2] PCI: designware: let dw_pcie_link_up() beware of LTSSM
 training bit
In-Reply-To: <1470807079-366-1-git-send-email-jszhang@marvell.com>
References: <1470807079-366-1-git-send-email-jszhang@marvell.com>
Message-ID: <1470807079-366-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The link may be UP but still in link training. In this case, we can't
think the link is up and operating correctly. So we need to teach
dw_pcie_link_up() beware of the PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING bit.

This patch also rewrite PCIE_PHY_DEBUG_R1_LINK_UP definition so that
it's consistent with other MACROS.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Joao Pinto <jpinto@synopsys.com>
---
 drivers/pci/host/pcie-designware.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index 24a16dd..6cc21bb 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -73,7 +73,8 @@
 /* PCIe Port Logic registers */
 #define PLR_OFFSET			0x700
 #define PCIE_PHY_DEBUG_R1		(PLR_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_LINK_UP	0x00000010
+#define PCIE_PHY_DEBUG_R1_LINK_UP	(0x1 << 4)
+#define PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING	(0x1 << 29)
 
 /* Parameters for the waiting for link up routine */
 #define LINK_WAIT_MAX_RETRIES		10
@@ -417,7 +418,8 @@ int dw_pcie_link_up(struct pcie_port *pp)
 		return pp->ops->link_up(pp);
 
 	val = readl(pp->dbi_base + PCIE_PHY_DEBUG_R1);
-	return val & PCIE_PHY_DEBUG_R1_LINK_UP;
+	return ((val & PCIE_PHY_DEBUG_R1_LINK_UP) &&
+		(!(val & PCIE_PHY_DEBUG_R1_LINK_IN_TRAINING)));
 }
 
 static int dw_pcie_msi_map(struct irq_domain *domain, unsigned int irq,
-- 
2.8.1
