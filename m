From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 22 Jan 2013 17:28:22 -0700
Subject: [PATCH 1/2] usb: host: tegra: don't touch EMC clock
Message-ID: <1358900903-27654-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Clock "emc" is for the External Memory Controller. The USB driver has no
business touching this clock directly. Remove the code that does so.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Greg, Alan, I'd like to take this patch through the Tegra tree to avoid
any merge conflicts with the Tegra USB changes that have  recently
happened there.

Venu, When creating your patch to convert the Tegra USB PHY driver to a
platform driver, can you assume these patches are applied first? Thanks.
I assume that these patches make sense to you; could you ack them if so.
---
 drivers/usb/host/ehci-tegra.c |   17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 1f596fb..b02622a 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -44,7 +44,6 @@ struct tegra_ehci_hcd {
 	struct ehci_hcd *ehci;
 	struct tegra_usb_phy *phy;
 	struct clk *clk;
-	struct clk *emc_clk;
 	struct usb_phy *transceiver;
 	int host_resumed;
 	int port_resuming;
@@ -56,7 +55,6 @@ static void tegra_ehci_power_up(struct usb_hcd *hcd)
 {
 	struct tegra_ehci_hcd *tegra = dev_get_drvdata(hcd->self.controller);
 
-	clk_prepare_enable(tegra->emc_clk);
 	clk_prepare_enable(tegra->clk);
 	usb_phy_set_suspend(&tegra->phy->u_phy, 0);
 	tegra->host_resumed = 1;
@@ -69,7 +67,6 @@ static void tegra_ehci_power_down(struct usb_hcd *hcd)
 	tegra->host_resumed = 0;
 	usb_phy_set_suspend(&tegra->phy->u_phy, 1);
 	clk_disable_unprepare(tegra->clk);
-	clk_disable_unprepare(tegra->emc_clk);
 }
 
 static int tegra_ehci_internal_port_reset(
@@ -694,16 +691,6 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 	if (err)
 		goto fail_clk;
 
-	tegra->emc_clk = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clk)) {
-		dev_err(&pdev->dev, "Can't get emc clock\n");
-		err = PTR_ERR(tegra->emc_clk);
-		goto fail_emc_clk;
-	}
-
-	clk_prepare_enable(tegra->emc_clk);
-	clk_set_rate(tegra->emc_clk, 400000000);
-
 	tegra->needs_double_reset = of_property_read_bool(pdev->dev.of_node,
 		"nvidia,needs-double-reset");
 
@@ -813,8 +800,6 @@ fail:
 #endif
 	usb_phy_shutdown(&tegra->phy->u_phy);
 fail_io:
-	clk_disable_unprepare(tegra->emc_clk);
-fail_emc_clk:
 	clk_disable_unprepare(tegra->clk);
 fail_clk:
 	usb_put_hcd(hcd);
@@ -842,8 +827,6 @@ static int tegra_ehci_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(tegra->clk);
 
-	clk_disable_unprepare(tegra->emc_clk);
-
 	return 0;
 }
 
-- 
1.7.10.4
