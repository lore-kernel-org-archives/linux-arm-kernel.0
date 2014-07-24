From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 24 Jul 2014 17:07:55 +1000
Subject: linux-next: build failure after merge of the usb tree
Message-ID: <20140724170755.035cea1c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/phy/phy-spear1310-miphy.c: In function 'spear1310_miphy_probe':
drivers/phy/phy-spear1310-miphy.c:232:14: warning: passing argument 2 of 'devm_phy_create' from incompatible pointer type
  priv->phy = devm_phy_create(dev, &spear1310_miphy_ops, NULL);
              ^
In file included from drivers/phy/phy-spear1310-miphy.c:21:0:
include/linux/phy/phy.h:164:13: note: expected 'struct device_node *' but argument is of type 'struct phy_ops *'
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/phy/phy-spear1310-miphy.c:232:14: error: too few arguments to function 'devm_phy_create'
  priv->phy = devm_phy_create(dev, &spear1310_miphy_ops, NULL);
              ^
In file included from drivers/phy/phy-spear1310-miphy.c:21:0:
include/linux/phy/phy.h:164:13: note: declared here
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/phy/phy-spear1340-miphy.c: In function 'spear1340_miphy_probe':
drivers/phy/phy-spear1340-miphy.c:264:14: warning: passing argument 2 of 'devm_phy_create' from incompatible pointer type
  priv->phy = devm_phy_create(dev, &spear1340_miphy_ops, NULL);
              ^
In file included from drivers/phy/phy-spear1340-miphy.c:21:0:
include/linux/phy/phy.h:164:13: note: expected 'struct device_node *' but argument is of type 'struct phy_ops *'
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/phy/phy-spear1340-miphy.c:264:14: error: too few arguments to function 'devm_phy_create'
  priv->phy = devm_phy_create(dev, &spear1340_miphy_ops, NULL);
              ^
In file included from drivers/phy/phy-spear1340-miphy.c:21:0:
include/linux/phy/phy.h:164:13: note: declared here
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^

Caused by commit f0ed817638b5 ("phy: core: Let node ptr of PHY point to
PHY and not of PHY provider") interacting with commit 64562e99477f
("phy: Add drivers for PCIe and SATA phy on SPEAr13xx") from the
arm-soc tree.

I fixed that up and then got:

drivers/pinctrl/pinctrl-tegra-xusb.c: In function 'tegra_xusb_padctl_probe':
drivers/pinctrl/pinctrl-tegra-xusb.c:913:8: warning: passing argument 2 of 'devm_phy_create' from incompatible pointer type
  phy = devm_phy_create(&pdev->dev, &pcie_phy_ops, NULL);
        ^
In file included from drivers/pinctrl/pinctrl-tegra-xusb.c:18:0:
include/linux/phy/phy.h:164:13: note: expected 'struct device_node *' but argument is of type 'const struct phy_ops *'
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/pinctrl/pinctrl-tegra-xusb.c:913:8: error: too few arguments to function 'devm_phy_create'
  phy = devm_phy_create(&pdev->dev, &pcie_phy_ops, NULL);
        ^
In file included from drivers/pinctrl/pinctrl-tegra-xusb.c:18:0:
include/linux/phy/phy.h:164:13: note: declared here
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/pinctrl/pinctrl-tegra-xusb.c:922:8: warning: passing argument 2 of 'devm_phy_create' from incompatible pointer type
  phy = devm_phy_create(&pdev->dev, &sata_phy_ops, NULL);
        ^
In file included from drivers/pinctrl/pinctrl-tegra-xusb.c:18:0:
include/linux/phy/phy.h:164:13: note: expected 'struct device_node *' but argument is of type 'const struct phy_ops *'
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^
drivers/pinctrl/pinctrl-tegra-xusb.c:922:8: error: too few arguments to function 'devm_phy_create'
  phy = devm_phy_create(&pdev->dev, &sata_phy_ops, NULL);
        ^
In file included from drivers/pinctrl/pinctrl-tegra-xusb.c:18:0:
include/linux/phy/phy.h:164:13: note: declared here
 struct phy *devm_phy_create(struct device *dev, struct device_node *node,
             ^

>From an interaction with commit dc0a39386687 ("pinctrl: Add NVIDIA
Tegra XUSB pad controller support") from the arm-soc tree.

Final merge fix patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 24 Jul 2014 16:55:16 +1000
Subject: [PATCH] phy: fix up for devm_phy_create api change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
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
2.0.1

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/8c977cb0/attachment.sig>
