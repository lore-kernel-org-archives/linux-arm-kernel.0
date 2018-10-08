From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 8 Oct 2018 11:24:45 +0800
Subject: [PATCH v6 6/9] PCI: mediatek: Fixup enable msi logic by enable msi
 after clock enabled
In-Reply-To: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
References: <1538969088-7136-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1538969088-7136-7-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The commit 43e6409db64d ("PCI: mediatek: Add MSI support for MT2712 and
MT7622") added MSI support but enable MSI in wrong place, clocks was not
enabled when enable MSI. This patch fix this issue by calling
mtk_pcie_enable_msi in mtk_pcie_startup_port_v2 since the clock was all
enabled at that time.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 654a63e..d3f4694 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -568,8 +568,6 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 		ret = mtk_pcie_allocate_msi_domains(port);
 		if (ret)
 			return ret;
-
-		mtk_pcie_enable_msi(port);
 	}
 
 	return 0;
@@ -690,6 +688,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	val &= ~INTX_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
 
+	if (IS_ENABLED(CONFIG_PCI_MSI))
+		mtk_pcie_enable_msi(port);
+
 	/* Set AHB to PCIe translation windows */
 	size = mem->end - mem->start;
 	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
-- 
2.6.4
