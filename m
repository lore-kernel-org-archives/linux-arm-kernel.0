From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Mar 2014 08:19:28 +0000
Subject: [RFC 11/47] mtd: nand: stm_nand_bch: add Power Management
In-Reply-To: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
References: <1395735604-26706-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395735604-26706-12-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Populate the standard PM call-backs for; suspend, resume and restore.

Signed-off-by: Lee Jones <lee.jones@linaro.org>

q
---
 drivers/mtd/nand/stm_nand_bch.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/mtd/nand/stm_nand_bch.c b/drivers/mtd/nand/stm_nand_bch.c
index 8ab8e7b..e1ebf92 100644
--- a/drivers/mtd/nand/stm_nand_bch.c
+++ b/drivers/mtd/nand/stm_nand_bch.c
@@ -415,12 +415,51 @@ static int stm_nand_bch_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int stm_nand_bch_suspend(struct device *dev)
+{
+	struct nandi_controller *nandi = dev_get_drvdata(dev);
+
+	nandi_clk_disable(nandi);
+
+	return 0;
+}
+static int stm_nand_bch_resume(struct device *dev)
+{
+	struct nandi_controller *nandi = dev_get_drvdata(dev);
+
+	nandi_clk_enable(nandi);
+
+	return 0;
+}
+
+static int stm_nand_bch_restore(struct device *dev)
+{
+	struct nandi_controller *nandi = dev_get_drvdata(dev);
+	struct stm_plat_nand_bch_data *pdata = dev->platform_data;
+	struct stm_nand_bank_data *bank = pdata->bank;
+
+	nandi_init_controller(nandi, bank->csn);
+
+	return 0;
+}
+
+static const struct dev_pm_ops stm_nand_bch_pm_ops = {
+	.suspend = stm_nand_bch_suspend,
+	.resume = stm_nand_bch_resume,
+	.restore = stm_nand_bch_restore,
+};
+#else
+static const struct dev_pm_ops stm_nand_bch_pm_ops;
+#endif
+
 static struct platform_driver stm_nand_bch_driver = {
 	.probe	= stm_nand_bch_probe ,
 	.remove	= stm_nand_bch_remove,
 	.driver	= {
 		.name	= "stm-nand-bch",
 		.owner	= THIS_MODULE,
+		.pm	= &stm_nand_bch_pm_ops,
 	},
 };
 module_platform_driver(stm_nand_bch_driver);
-- 
1.8.3.2
