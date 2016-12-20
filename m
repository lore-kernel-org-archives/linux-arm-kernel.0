From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Tue, 20 Dec 2016 06:40:43 +0100
Subject: [PATCH 1/2] pinctrl: sirf: atlas7: Add missing 'of_node_put()'
Message-ID: <20161220054043.25417-1-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference to 'sys2pci_np' should be dropped in all cases here, not only in
error handling path.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/pinctrl/sirf/pinctrl-atlas7.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas7.c b/drivers/pinctrl/sirf/pinctrl-atlas7.c
index 7f3041697813..f714f67c4b64 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas7.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas7.c
@@ -5420,14 +5420,15 @@ static int atlas7_pinmux_probe(struct platform_device *pdev)
 	sys2pci_np = of_find_node_by_name(NULL, "sys2pci");
 	if (!sys2pci_np)
 		return -EINVAL;
+
 	ret = of_address_to_resource(sys2pci_np, 0, &res);
+	of_node_put(sys2pci_np);
 	if (ret)
 		return ret;
+
 	pmx->sys2pci_base = devm_ioremap_resource(&pdev->dev, &res);
-	if (IS_ERR(pmx->sys2pci_base)) {
-		of_node_put(sys2pci_np);
+	if (IS_ERR(pmx->sys2pci_base))
 		return -ENOMEM;
-	}
 
 	pmx->dev = &pdev->dev;
 
-- 
2.9.3
