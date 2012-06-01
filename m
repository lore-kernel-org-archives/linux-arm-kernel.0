From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Fri, 1 Jun 2012 14:42:43 +0530
Subject: [PATCH 4/9] USB: ehci-tegra: add clk_prepare/clk_unprepare
In-Reply-To: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
References: <1338541968-7961-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1338541968-7961-5-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare/clk_unprepare as required by the generic clk framework.

This patch should go through Tegra tree since other patches to port Tegra
to generic clock framework are dependent on it. Posting here to get ack from
the maintainers.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 drivers/usb/host/ehci-tegra.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 6854823..ab8a3bf 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -46,8 +46,8 @@ static void tegra_ehci_power_up(struct usb_hcd *hcd)
 {
 	struct tegra_ehci_hcd *tegra = dev_get_drvdata(hcd->self.controller);
 
-	clk_enable(tegra->emc_clk);
-	clk_enable(tegra->clk);
+	clk_prepare_enable(tegra->emc_clk);
+	clk_prepare_enable(tegra->clk);
 	tegra_usb_phy_power_on(tegra->phy);
 	tegra->host_resumed = 1;
 }
@@ -58,8 +58,8 @@ static void tegra_ehci_power_down(struct usb_hcd *hcd)
 
 	tegra->host_resumed = 0;
 	tegra_usb_phy_power_off(tegra->phy);
-	clk_disable(tegra->clk);
-	clk_disable(tegra->emc_clk);
+	clk_disable_unprepare(tegra->clk);
+	clk_disable_unprepare(tegra->emc_clk);
 }
 
 static int tegra_ehci_internal_port_reset(
@@ -671,7 +671,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto fail_clk;
 	}
 
-	err = clk_enable(tegra->clk);
+	err = clk_prepare_enable(tegra->clk);
 	if (err)
 		goto fail_clken;
 
@@ -682,7 +682,7 @@ static int tegra_ehci_probe(struct platform_device *pdev)
 		goto fail_emc_clk;
 	}
 
-	clk_enable(tegra->emc_clk);
+	clk_prepare_enable(tegra->emc_clk);
 	clk_set_rate(tegra->emc_clk, 400000000);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -782,10 +782,10 @@ fail:
 fail_phy:
 	iounmap(hcd->regs);
 fail_io:
-	clk_disable(tegra->emc_clk);
+	clk_disable_unprepare(tegra->emc_clk);
 	clk_put(tegra->emc_clk);
 fail_emc_clk:
-	clk_disable(tegra->clk);
+	clk_disable_unprepare(tegra->clk);
 fail_clken:
 	clk_put(tegra->clk);
 fail_clk:
@@ -820,10 +820,10 @@ static int tegra_ehci_remove(struct platform_device *pdev)
 	tegra_usb_phy_close(tegra->phy);
 	iounmap(hcd->regs);
 
-	clk_disable(tegra->clk);
+	clk_disable_unprepare(tegra->clk);
 	clk_put(tegra->clk);
 
-	clk_disable(tegra->emc_clk);
+	clk_disable_unprepare(tegra->emc_clk);
 	clk_put(tegra->emc_clk);
 
 	kfree(tegra);
-- 
1.7.4.1
