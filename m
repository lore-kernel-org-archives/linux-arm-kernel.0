From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 11:36:23 -0700
Subject: [PATCH 6/7] net: phy: Add pm support to Broadcom iProc mdio mux driver
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532630184-29450-7-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for suspend and resume to the Broadcom iProc mdio
mux driver.

Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 6b400dd..89c18d6 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -51,13 +51,25 @@
 #define MDIO_OPERATING_FREQUENCY	11000000
 #define MDIO_RATE_ADJ_DIVIDENT		1
 
+#define MDIO_NUM_OF_REGS_TO_RESTORE	2
+
 struct iproc_mdiomux_desc {
 	void *mux_handle;
 	void __iomem *base;
 	struct device *dev;
 	struct mii_bus *mii_bus;
 	struct clk *core_clk;
+#ifdef CONFIG_PM_SLEEP
+	u32 restore_regs[MDIO_NUM_OF_REGS_TO_RESTORE];
+#endif
+};
+
+#ifdef CONFIG_PM_SLEEP
+static const u16 restore_reg_offsets[MDIO_NUM_OF_REGS_TO_RESTORE] = {
+	MDIO_RATE_ADJ_EXT_OFFSET,
+	MDIO_RATE_ADJ_INT_OFFSET,
 };
+#endif
 
 static void mdio_mux_iproc_config_clk(struct iproc_mdiomux_desc *md)
 {
@@ -258,6 +270,35 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mdio_mux_iproc_suspend(struct device *dev)
+{
+	int i;
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
+		md->restore_regs[i] = readl(md->base +
+					    restore_reg_offsets[i]);
+
+	return 0;
+}
+
+static int mdio_mux_iproc_resume(struct device *dev)
+{
+	int i;
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
+
+	for (i = 0; i < MDIO_NUM_OF_REGS_TO_RESTORE; i++)
+		writel(md->restore_regs[i],
+		       md->base + restore_reg_offsets[i]);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mdio_mux_iproc_pm_ops,
+		mdio_mux_iproc_suspend, mdio_mux_iproc_resume);
+
 static const struct of_device_id mdio_mux_iproc_match[] = {
 	{
 		.compatible = "brcm,mdio-mux-iproc",
@@ -270,6 +311,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 	.driver = {
 		.name		= "mdio-mux-iproc",
 		.of_match_table = mdio_mux_iproc_match,
+		.pm		= &mdio_mux_iproc_pm_ops,
 	},
 	.probe		= mdio_mux_iproc_probe,
 	.remove		= mdio_mux_iproc_remove,
-- 
1.9.1
