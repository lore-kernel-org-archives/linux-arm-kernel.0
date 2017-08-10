From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Thu, 10 Aug 2017 14:34:57 +0800
Subject: [PATCH v4 4/7] PCI: mediatek: switch to use
 platform_get_resource_byname()
In-Reply-To: <cover.1502336769.git.honghui.zhang@mediatek.com>
References: <cover.1502336769.git.honghui.zhang@mediatek.com>
Message-ID: <f7810da34df710a2b98f903e7a95247ee9387032.1502336769.git.honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This is a transitional patch. We currently use platfarm_get_resource() for
retrieving the IOMEM resources, but there might be some chips don't have
subsys/shared registers part, which depends on platform design, and these
will be introduced in further patches.

Switch this function to use the platform_get_resource_byname() so that the
binding can be agnostic of the resource order.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 01caa98..c649ab4 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -295,7 +295,8 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 		return err;
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, slot + 1);
+	snprintf(name, sizeof(name), "port%d", slot);
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	port->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", slot);
@@ -336,12 +337,14 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	struct resource *regs;
 	int err;
 
-	/* get shared registers */
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	pcie->base = devm_ioremap_resource(dev, regs);
-	if (IS_ERR(pcie->base)) {
-		dev_err(dev, "failed to map shared register\n");
-		return PTR_ERR(pcie->base);
+	/* get shared registers, which are optional */
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "subsys");
+	if (regs) {
+		pcie->base = devm_ioremap_resource(dev, regs);
+		if (IS_ERR(pcie->base)) {
+			dev_err(dev, "failed to map shared register\n");
+			return PTR_ERR(pcie->base);
+		}
 	}
 
 	pcie->free_ck = devm_clk_get(dev, "free_ck");
-- 
2.6.4
