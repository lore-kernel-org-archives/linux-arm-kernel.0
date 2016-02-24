From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:55 +0530
Subject: [PATCH 30/50] pinctrl: tegra-xusb: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-31-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration and clean
the error path.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 2f06029..19f16f4 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -914,7 +914,8 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	padctl->desc.confops = &tegra_xusb_padctl_pinconf_ops;
 	padctl->desc.owner = THIS_MODULE;
 
-	padctl->pinctrl = pinctrl_register(&padctl->desc, &pdev->dev, padctl);
+	padctl->pinctrl = devm_pinctrl_register(&pdev->dev, &padctl->desc,
+						padctl);
 	if (IS_ERR(padctl->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
 		err = PTR_ERR(padctl->pinctrl);
@@ -924,7 +925,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	phy = devm_phy_create(&pdev->dev, NULL, &pcie_phy_ops);
 	if (IS_ERR(phy)) {
 		err = PTR_ERR(phy);
-		goto unregister;
+		goto reset;
 	}
 
 	padctl->phys[TEGRA_XUSB_PADCTL_PCIE] = phy;
@@ -933,7 +934,7 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	phy = devm_phy_create(&pdev->dev, NULL, &sata_phy_ops);
 	if (IS_ERR(phy)) {
 		err = PTR_ERR(phy);
-		goto unregister;
+		goto reset;
 	}
 
 	padctl->phys[TEGRA_XUSB_PADCTL_SATA] = phy;
@@ -944,13 +945,11 @@ static int tegra_xusb_padctl_probe(struct platform_device *pdev)
 	if (IS_ERR(padctl->provider)) {
 		err = PTR_ERR(padctl->provider);
 		dev_err(&pdev->dev, "failed to register PHYs: %d\n", err);
-		goto unregister;
+		goto reset;
 	}
 
 	return 0;
 
-unregister:
-	pinctrl_unregister(padctl->pinctrl);
 reset:
 	reset_control_assert(padctl->rst);
 	return err;
@@ -961,8 +960,6 @@ static int tegra_xusb_padctl_remove(struct platform_device *pdev)
 	struct tegra_xusb_padctl *padctl = platform_get_drvdata(pdev);
 	int err;
 
-	pinctrl_unregister(padctl->pinctrl);
-
 	err = reset_control_assert(padctl->rst);
 	if (err < 0)
 		dev_err(&pdev->dev, "failed to assert reset: %d\n", err);
-- 
2.1.4
