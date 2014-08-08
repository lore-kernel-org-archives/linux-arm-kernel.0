From: olof@lixom.net (Olof Johansson)
Date: Fri,  8 Aug 2014 09:47:58 -0700
Subject: [GIT PATCH 6/7] phy: fix up for devm_phy_create api change
In-Reply-To: <1407516479-1251-1-git-send-email-olof@lixom.net>
References: <1407516479-1251-1-git-send-email-olof@lixom.net>
Message-ID: <1407516479-1251-7-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

This is needed due to the devm changes going in through Greg's tree at
the same time as a new driver was added through ours.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
[olof: Write patch description]
Signed-off-by: Olof Johansson <olof@lixom.net>
---

I'm sending this inline with the merge requests to keep things as
bisectable as possible. This is a patch that Stephen was carrying for
us in -next, you can also squash it into the merge commit if you prefer.


-Olof

 drivers/phy/phy-spear1310-miphy.c    | 2 +-
 drivers/phy/phy-spear1340-miphy.c    | 2 +-
 drivers/pinctrl/pinctrl-tegra-xusb.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-spear1310-miphy.c b/drivers/phy/phy-spear1310-miphy.c
index c58c869d57e0..6dcbfcddb372 100644
--- a/drivers/phy/phy-spear1310-miphy.c
+++ b/drivers/phy/phy-spear1310-miphy.c
@@ -229,7 +229,7 @@ static int spear1310_miphy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	priv->phy = devm_phy_create(dev, &spear1310_miphy_ops, NULL);
+	priv->phy = devm_phy_create(dev, NULL, &spear1310_miphy_ops, NULL);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create SATA PCIe PHY\n");
 		return PTR_ERR(priv->phy);
diff --git a/drivers/phy/phy-spear1340-miphy.c b/drivers/phy/phy-spear1340-miphy.c
index 8de98adf21c3..7135ba2603b6 100644
--- a/drivers/phy/phy-spear1340-miphy.c
+++ b/drivers/phy/phy-spear1340-miphy.c
@@ -261,7 +261,7 @@ static int spear1340_miphy_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->misc);
 	}
 
-	priv->phy = devm_phy_create(dev, &spear1340_miphy_ops, NULL);
+	priv->phy = devm_phy_create(dev, NULL, &spear1340_miphy_ops, NULL);
 	if (IS_ERR(priv->phy)) {
 		dev_err(dev, "failed to create SATA PCIe PHY\n");
 		return PTR_ERR(priv->phy);
diff --git a/drivers/pinctrl/pinctrl-tegra-xusb.c b/drivers/pinctrl/pinctrl-tegra-xusb.c
index 4a7daf577b49..a06620474845 100644
--- a/drivers/pinctrl/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/pinctrl-tegra-xusb.c
@@ -910,7 +910,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 		goto reset;
 	}
 
-	phy = devm_phy_create(&pdev->dev, &pcie_phy_ops, NULL);
+	phy = devm_phy_create(&pdev->dev, NULL, &pcie_phy_ops, NULL);
 	if (IS_ERR(phy)) {
 		err = PTR_ERR(phy);
 		goto unregister;
@@ -919,7 +919,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	padctl->phys[TEGRA_XUSB_PADCTL_PCIE] = phy;
 	phy_set_drvdata(phy, padctl);
 
-	phy = devm_phy_create(&pdev->dev, &sata_phy_ops, NULL);
+	phy = devm_phy_create(&pdev->dev, NULL, &sata_phy_ops, NULL);
 	if (IS_ERR(phy)) {
 		err = PTR_ERR(phy);
 		goto unregister;
-- 
2.0.1.473.gc4d58ca
