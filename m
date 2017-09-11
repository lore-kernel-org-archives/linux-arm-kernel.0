From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 11 Sep 2017 23:10:27 +0800
Subject: [PATCH v5 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
References: <20170911151029.25185-1-jeffy.chen@rock-chips.com>
Message-ID: <20170911151029.25185-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for PCIE_WAKE pin in rockchip pcie driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5:
Rebase

Changes in v3:
Fix error handling

Changes in v2:
Use dev_pm_set_dedicated_wake_irq
        -- Suggested by Brian Norris <briannorris@chromium.com>

 drivers/pci/host/pcie-rockchip.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 9051c6c8fea4..a8b7272597a7 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -37,6 +37,7 @@
 #include <linux/pci_ids.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
@@ -995,6 +996,15 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 		return err;
 	}
 
+	/* Must init wakeup before setting dedicated wakeup irq. */
+	device_init_wakeup(dev, true);
+	irq = platform_get_irq_byname(pdev, "wakeup");
+	if (irq >= 0) {
+		err = dev_pm_set_dedicated_wake_irq(dev, irq);
+		if (err)
+			dev_err(dev, "failed to setup PCIe wakeup IRQ\n");
+	}
+
 	return 0;
 }
 
@@ -1542,11 +1552,11 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_parse_dt(rockchip);
 	if (err)
-		return err;
+		goto err_disable_wake;
 
 	err = rockchip_pcie_enable_clocks(rockchip);
 	if (err)
-		return err;
+		goto err_disable_wake;
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
@@ -1656,6 +1666,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		regulator_disable(rockchip->vpcie0v9);
 err_set_vpcie:
 	rockchip_pcie_disable_clocks(rockchip);
+err_disable_wake:
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	return err;
 }
 
@@ -1682,6 +1695,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
 
+	dev_pm_clear_wake_irq(dev);
+	device_init_wakeup(dev, false);
 	return 0;
 }
 
-- 
2.11.0
