From: honghui.zhang@mediatek.com (honghui.zhang at mediatek.com)
Date: Mon, 15 Oct 2018 16:08:58 +0800
Subject: [PATCH v8 7/9] PCI: mediatek: Add system PM support for MT2712 and
 MT7622
In-Reply-To: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
References: <1539590940-13355-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <1539590940-13355-8-git-send-email-honghui.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

In order to reduce the PCIe power consuming while system suspend,
the physical layer should be gated. And the PCIe link should be
re-established and the related control register values should be
re-initialized after system resume.

Register suspend_noirq & resume_noirq callback functions to allow
PCIe to come up after resume from RAM.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index d3f4694..42cf2a4 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1168,6 +1168,55 @@ static int mtk_pcie_probe(struct platform_device *pdev)
 	return err;
 }
 
+static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	struct mtk_pcie_port *port;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	list_for_each_entry(port, &pcie->ports, list) {
+		clk_disable_unprepare(port->pipe_ck);
+		clk_disable_unprepare(port->obff_ck);
+		clk_disable_unprepare(port->axi_ck);
+		clk_disable_unprepare(port->aux_ck);
+		clk_disable_unprepare(port->ahb_ck);
+		clk_disable_unprepare(port->sys_ck);
+		phy_power_off(port->phy);
+		phy_exit(port->phy);
+	}
+
+	clk_disable_unprepare(pcie->free_ck);
+
+	return 0;
+}
+
+static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
+{
+	struct mtk_pcie *pcie = dev_get_drvdata(dev);
+	struct mtk_pcie_port *port, *tmp;
+
+	if (list_empty(&pcie->ports))
+		return 0;
+
+	clk_prepare_enable(pcie->free_ck);
+
+	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
+		mtk_pcie_enable_port(port);
+
+	/* In case of EP was removed while system suspend. */
+	if (list_empty(&pcie->ports))
+		clk_disable_unprepare(pcie->free_ck);
+
+	return 0;
+}
+
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
+				      mtk_pcie_resume_noirq)
+};
+
 static const struct mtk_pcie_soc mtk_pcie_soc_v1 = {
 	.ops = &mtk_pcie_ops,
 	.startup = mtk_pcie_startup_port,
@@ -1200,6 +1249,7 @@ static struct platform_driver mtk_pcie_driver = {
 		.name = "mtk-pcie",
 		.of_match_table = mtk_pcie_ids,
 		.suppress_bind_attrs = true,
+		.pm = &mtk_pcie_pm_ops,
 	},
 };
 builtin_platform_driver(mtk_pcie_driver);
-- 
2.6.4
