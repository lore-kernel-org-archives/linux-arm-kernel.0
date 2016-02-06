From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Sat,  6 Feb 2016 22:24:19 +0800
Subject: [PATCH] MIPS: pci-mt7620: Fix return value check in mt7620_pci_probe()
Message-ID: <1454768659-32720-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_ioremap_resource() returns
ERR_PTR() and never returns NULL. The NULL test in the return
value check should be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 arch/mips/pci/pci-mt7620.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/pci/pci-mt7620.c b/arch/mips/pci/pci-mt7620.c
index a009ee4..044c1cd 100644
--- a/arch/mips/pci/pci-mt7620.c
+++ b/arch/mips/pci/pci-mt7620.c
@@ -297,12 +297,12 @@ static int mt7620_pci_probe(struct platform_device *pdev)
 		return PTR_ERR(rstpcie0);
 
 	bridge_base = devm_ioremap_resource(&pdev->dev, bridge_res);
-	if (!bridge_base)
-		return -ENOMEM;
+	if (IS_ERR(bridge_base))
+		return PTR_ERR(bridge_base);
 
 	pcie_base = devm_ioremap_resource(&pdev->dev, pcie_res);
-	if (!pcie_base)
-		return -ENOMEM;
+	if (IS_ERR(pcie_base))
+		return PTR_ERR(pcie_base);
 
 	iomem_resource.start = 0;
 	iomem_resource.end = ~0;
