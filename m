From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Tue, 16 Oct 2018 18:44:44 +0800
Subject: [PATCH v9 3/9] PCI: mediatek: Remove the redundant dev->pm_domain
 check
In-Reply-To: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539686690-24068-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1539686690-24068-4-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

It's no needed to check whether device have pm_domain attached before
calling the pm_runtime_XXX interface, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 288b8e2..6080b29 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -225,10 +225,8 @@ static void mtk_pcie_subsys_powerdown(struct mtk_pcie *pcie)
 
 	clk_disable_unprepare(pcie->free_ck);
 
-	if (dev->pm_domain) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-	}
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 }
 
 static void mtk_pcie_port_free(struct mtk_pcie_port *port)
@@ -998,10 +996,8 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 		pcie->free_ck = NULL;
 	}
 
-	if (dev->pm_domain) {
-		pm_runtime_enable(dev);
-		pm_runtime_get_sync(dev);
-	}
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	/* enable top level clock */
 	err = clk_prepare_enable(pcie->free_ck);
@@ -1013,10 +1009,8 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
 	return 0;
 
 err_free_ck:
-	if (dev->pm_domain) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-	}
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return err;
 }
-- 
2.6.4
