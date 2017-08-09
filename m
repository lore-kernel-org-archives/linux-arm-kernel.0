From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 9 Aug 2017 17:18:00 +0800
Subject: [PATCH 4/4] phy: tegra: use of_device_get_match_data()
In-Reply-To: <1502270280-13792-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1502270280-13792-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1502270280-13792-4-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

reduce the boilerplate code to get the specific data

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/tegra/xusb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index 3cbcb25..25cdfb1 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -848,7 +848,6 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	struct device_node *np = of_node_get(pdev->dev.of_node);
 	const struct tegra_xusb_padctl_soc *soc;
 	struct tegra_xusb_padctl *padctl;
-	const struct of_device_id *match;
 	struct resource *res;
 	int err;
 
@@ -861,8 +860,9 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 
 	of_node_put(np);
 
-	match = of_match_node(tegra_xusb_padctl_of_match, pdev->dev.of_node);
-	soc = match->data;
+	soc = of_device_get_match_data(&pdev->dev);
+	if (!soc)
+		return -EINVAL;
 
 	padctl = soc->ops->probe(&pdev->dev, soc);
 	if (IS_ERR(padctl))
-- 
1.7.9.5
