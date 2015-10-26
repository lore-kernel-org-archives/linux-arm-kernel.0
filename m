From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 26 Oct 2015 19:02:14 +0800
Subject: [RFC PATCH 3/3] PCI: xgene: generate proper configuration access
 cycles
In-Reply-To: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
References: <1445857334-6936-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445857334-6936-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by Russell King's patch[1], I found current tegra also has the
same issue of "reading 32-bits from the command register, modifying the
command register, and then writing it back has the effect of clearing
any status bits that were indicating at that time" as pointed out by
Russell. This patch fix this issue by using the pci_generic_config_write.

[1]http://www.spinics.net/lists/linux-pci/msg44869.html

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pci/host/pci-xgene.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 0236ab9..8946a6c 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -176,7 +176,7 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 static struct pci_ops xgene_pcie_ops = {
 	.map_bus = xgene_pcie_map_bus,
 	.read = xgene_pcie_config_read32,
-	.write = pci_generic_config_write32,
+	.write = pci_generic_config_write,
 };
 
 static u64 xgene_pcie_set_ib_mask(void __iomem *csr_base, u32 addr,
-- 
2.6.2
