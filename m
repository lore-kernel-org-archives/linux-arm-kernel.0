From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:40:09 +0100
Subject: [PATCH 2/9] phy: phy-mvebu-sata: Add missing error check for
 devm_kzalloc
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1408106416-19044-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently this driver is missing a check on the return value of devm_kzalloc,
which would cause a NULL pointer dereference in a OOM situation.

This patch adds the aformentioned missing check.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/phy-mvebu-sata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/phy-mvebu-sata.c b/drivers/phy/phy-mvebu-sata.c
index cc3c0e1..10bb8e5 100644
--- a/drivers/phy/phy-mvebu-sata.c
+++ b/drivers/phy/phy-mvebu-sata.c
@@ -89,6 +89,8 @@ static int phy_mvebu_sata_probe(struct platform_device *pdev)
 	struct phy *phy;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->base = devm_ioremap_resource(&pdev->dev, res);
-- 
1.9.1
