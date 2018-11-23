From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:24 +0100
Subject: [PATCH 05/12] PCI: aardvark: add suspend to RAM support
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add suspend and resume callbacks. The priority of these are
"_noirq()", to workaround early access to the registers done by the
PCI core through the ->read()/->write() callbacks at resume time.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 108b3f15c410..7ecf1ac4036b 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1108,6 +1108,55 @@ static int advk_pcie_setup_clk(struct advk_pcie *pcie)
 	return ret;
 }
 
+static int __maybe_unused advk_pcie_suspend(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+
+	advk_pcie_disable_phy(pcie);
+
+	clk_disable_unprepare(pcie->clk);
+
+	return 0;
+}
+
+static int __maybe_unused advk_pcie_resume(struct device *dev)
+{
+	struct advk_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(pcie->clk);
+	if (ret)
+		return ret;
+
+	/*
+	 * Empirical delay needed after enabling the clock and before
+	 * accessing any register.
+	 */
+	msleep(10);
+
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		return ret;
+
+	advk_pcie_hard_reset(pcie);
+
+	advk_pcie_setup_hw(pcie);
+
+	advk_sw_pci_bridge_init(pcie);
+
+	return 0;
+}
+
+/*
+ * The PCI core will try to reconfigure the bus quite early in the resume path.
+ * We must use the _noirq() alternatives to ensure the controller is ready when
+ * the core uses the ->read()/->write() callbacks.
+ */
+static const struct dev_pm_ops advk_pcie_dev_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(advk_pcie_suspend,
+				      advk_pcie_resume)
+};
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1188,6 +1237,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dev_set_drvdata(dev, pcie);
+
 	return 0;
 }
 
@@ -1200,6 +1251,7 @@ static struct platform_driver advk_pcie_driver = {
 	.driver = {
 		.name = "advk-pcie",
 		.of_match_table = advk_pcie_of_match_table,
+		.pm = &advk_pcie_dev_pm_ops,
 		/* Driver unloading/unbinding currently not supported */
 		.suppress_bind_attrs = true,
 	},
-- 
2.19.1
