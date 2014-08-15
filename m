From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:40:12 +0100
Subject: [PATCH 5/9] phy: phy-spear1310-miphy: Remove unncessary site specific
 OOM messages
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1408106416-19044-6-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The site specific OOM messages are unncessary, because they duplicate
messages from the memory subsystem which include dump_stack().

Removing these superflous messages makes the kernel smaller. A discussion
here http://patchwork.ozlabs.org/patch/324158/ found that all error paths
from kzalloc will print a error message, and that any error path which maybe
found which doesn't would be considered a bug in kzalloc.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/phy-spear1310-miphy.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/phy/phy-spear1310-miphy.c b/drivers/phy/phy-spear1310-miphy.c
index 6dcbfcd..911d25b 100644
--- a/drivers/phy/phy-spear1310-miphy.c
+++ b/drivers/phy/phy-spear1310-miphy.c
@@ -212,10 +212,8 @@ static int spear1310_miphy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(dev, "can't alloc spear1310_miphy private date memory\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->misc =
 		syscon_regmap_lookup_by_phandle(dev->of_node, "misc");
-- 
1.9.1
