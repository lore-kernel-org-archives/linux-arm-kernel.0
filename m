From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 16:28:38 +0800
Subject: [PATCH v3 1/4] PCI: rockchip: Fix error handlings
In-Reply-To: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
References: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818082841.22335-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix error handlings in probe & resume.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 drivers/pci/host/pcie-rockchip.c | 103 ++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 7bb9870f6d8c..e9867bcff1ff 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -546,25 +546,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_assert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "assert core_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_assert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "assert pipe_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	udelay(10);
@@ -572,19 +572,19 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->pm_rst);
 	if (err) {
 		dev_err(dev, "deassert pm_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->aclk_rst);
 	if (err) {
 		dev_err(dev, "deassert aclk_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pclk_rst);
 	if (err) {
 		dev_err(dev, "deassert pclk_rst err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	if (rockchip->link_gen == 2)
@@ -605,7 +605,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = phy_power_on(rockchip->phy);
 	if (err) {
 		dev_err(dev, "fail to power on phy, err %d\n", err);
-		return err;
+		goto err_exit_phy;
 	}
 
 	/*
@@ -615,25 +615,25 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->core_rst);
 	if (err) {
 		dev_err(dev, "deassert core_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->mgmt_rst);
 	if (err) {
 		dev_err(dev, "deassert mgmt_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	err = reset_control_deassert(rockchip->pipe_rst);
 	if (err) {
 		dev_err(dev, "deassert pipe_rst err %d\n", err);
-		return err;
+		goto err_power_off_phy;
 	}
 
 	/* Fix the transmitted FTS count desired to exit from L0s. */
@@ -666,7 +666,7 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 				 500 * USEC_PER_MSEC);
 	if (err) {
 		dev_err(dev, "PCIe link training gen1 timeout!\n");
-		return -ETIMEDOUT;
+		goto err_power_off_phy;
 	}
 
 	if (rockchip->link_gen == 2) {
@@ -715,6 +715,11 @@ static int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
 
 	return 0;
+err_power_off_phy:
+	phy_power_off(rockchip->phy);
+err_exit_phy:
+	phy_exit(rockchip->phy);
+	return err;
 }
 
 static irqreturn_t rockchip_pcie_subsys_irq_handler(int irq, void *arg)
@@ -1051,7 +1056,7 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 		err = regulator_enable(rockchip->vpcie3v3);
 		if (err) {
 			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
-			goto err_out;
+			return err;
 		}
 	}
 
@@ -1072,14 +1077,12 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
 	}
 
 	return 0;
-
 err_disable_1v8:
 	if (!IS_ERR(rockchip->vpcie1v8))
 		regulator_disable(rockchip->vpcie1v8);
 err_disable_3v3:
 	if (!IS_ERR(rockchip->vpcie3v3))
 		regulator_disable(rockchip->vpcie3v3);
-err_out:
 	return err;
 }
 
@@ -1315,43 +1318,47 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 
 	err = clk_prepare_enable(rockchip->clk_pcie_pm);
 	if (err)
-		goto err_pcie_pm;
+		goto err_disable_0v9;
 
 	err = clk_prepare_enable(rockchip->hclk_pcie);
 	if (err)
-		goto err_hclk_pcie;
+		goto err_disable_clk_pcie_pm;
 
 	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
 	if (err)
-		goto err_aclk_perf_pcie;
+		goto err_disable_hclk_pcie;
 
 	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err)
-		goto err_aclk_pcie;
+		goto err_disable_aclk_perf_pcie;
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
-		goto err_pcie_resume;
+		goto err_disable_aclk_pcie;
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_pcie_resume;
+		goto err_deinit_port;
 
 	/* Need this to enter L1 again */
 	rockchip_pcie_update_txcredit_mui(rockchip);
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	return 0;
-
-err_pcie_resume:
+err_deinit_port:
+	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
+err_disable_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
+err_disable_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
+err_disable_hclk_pcie:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
+err_disable_clk_pcie_pm:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
+err_disable_0v9:
+	if (!IS_ERR(rockchip->vpcie0v9))
+		regulator_disable(rockchip->vpcie0v9);
 	return err;
 }
 
@@ -1388,47 +1395,47 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	err = clk_prepare_enable(rockchip->aclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_pcie clock\n");
-		goto err_aclk_pcie;
+		return err;
 	}
 
 	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
-		goto err_aclk_perf_pcie;
+		goto err_disable_aclk_pcie;
 	}
 
 	err = clk_prepare_enable(rockchip->hclk_pcie);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_hclk_pcie;
+		goto err_disable_aclk_perf_pcie;
 	}
 
 	err = clk_prepare_enable(rockchip->clk_pcie_pm);
 	if (err) {
 		dev_err(dev, "unable to enable hclk_pcie clock\n");
-		goto err_pcie_pm;
+		goto err_disable_hclk_pcie;
 	}
 
 	err = rockchip_pcie_set_vpcie(rockchip);
 	if (err) {
 		dev_err(dev, "failed to set vpcie regulator\n");
-		goto err_set_vpcie;
+		goto err_disable_clk_pcie_pm;
 	}
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
-		goto err_vpcie;
+		goto err_disable_vpcie;
 
 	rockchip_pcie_enable_interrupts(rockchip);
 
 	err = rockchip_pcie_init_irq_domain(rockchip);
 	if (err < 0)
-		goto err_vpcie;
+		goto err_deinit_port;
 
 	err = of_pci_get_host_bridge_resources(dev->of_node, 0, 0xff,
 					       &res, &io_base);
 	if (err)
-		goto err_vpcie;
+		goto err_remove_irq_domain;
 
 	err = devm_request_pci_bus_resources(dev, &res);
 	if (err)
@@ -1466,12 +1473,12 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	err = rockchip_pcie_cfg_atu(rockchip);
 	if (err)
-		goto err_free_res;
+		goto err_unmap_iospace;
 
 	rockchip->msg_region = devm_ioremap(dev, rockchip->msg_bus_addr, SZ_1M);
 	if (!rockchip->msg_region) {
 		err = -ENOMEM;
-		goto err_free_res;
+		goto err_unmap_iospace;
 	}
 
 	list_splice_init(&res, &bridge->windows);
@@ -1496,26 +1503,32 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
-	return 0;
 
+	return 0;
+err_unmap_iospace:
+	pci_unmap_iospace(rockchip->io);
 err_free_res:
 	pci_free_resource_list(&res);
-err_vpcie:
+err_remove_irq_domain:
+	irq_domain_remove(rockchip->irq_domain);
+err_deinit_port:
+	phy_power_off(rockchip->phy);
+	phy_exit(rockchip->phy);
+err_disable_vpcie:
 	if (!IS_ERR(rockchip->vpcie3v3))
 		regulator_disable(rockchip->vpcie3v3);
 	if (!IS_ERR(rockchip->vpcie1v8))
 		regulator_disable(rockchip->vpcie1v8);
 	if (!IS_ERR(rockchip->vpcie0v9))
 		regulator_disable(rockchip->vpcie0v9);
-err_set_vpcie:
+err_disable_clk_pcie_pm:
 	clk_disable_unprepare(rockchip->clk_pcie_pm);
-err_pcie_pm:
+err_disable_hclk_pcie:
 	clk_disable_unprepare(rockchip->hclk_pcie);
-err_hclk_pcie:
+err_disable_aclk_perf_pcie:
 	clk_disable_unprepare(rockchip->aclk_perf_pcie);
-err_aclk_perf_pcie:
+err_disable_aclk_pcie:
 	clk_disable_unprepare(rockchip->aclk_pcie);
-err_aclk_pcie:
 	return err;
 }
 
-- 
2.11.0
