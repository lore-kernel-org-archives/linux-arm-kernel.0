From: Baohua.Song@csr.com (Barry Song)
Date: Thu, 16 May 2013 11:17:09 +0800
Subject: [PATCH] pinctrl: sirf: save the status in suspend and restore after
 resuming
Message-ID: <1368674229-11813-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch saves the status of pinctrl registers and restore them while
resuming. this makes all drivers have coherent status for pinmux after
suspending and resuming.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-sirf.c | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index b4727db..0677e19 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -390,11 +390,67 @@ out_no_rsc_remap:
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sirfsoc_pinmux_suspend_noirq(struct device *dev)
+{
+	int i, j;
+	struct sirfsoc_pmx *spmx = dev_get_drvdata(dev);
+
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
+		for (j = 0; j < SIRFSOC_GPIO_BANK_SIZE; j++) {
+			spmx->gpio_regs[i][j] = readl(spmx->gpio_virtbase +
+				SIRFSOC_GPIO_CTRL(i, j));
+		}
+		spmx->ints_regs[i] = readl(spmx->gpio_virtbase +
+			SIRFSOC_GPIO_INT_STATUS(i));
+		spmx->paden_regs[i] = readl(spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(i));
+	}
+	spmx->dspen_regs = readl(spmx->gpio_virtbase + SIRFSOC_GPIO_DSP_EN0);
+
+	for (i = 0; i < 3; i++)
+		spmx->rsc_regs[i] = readl(spmx->rsc_virtbase + 4 * i);
+
+	return 0;
+}
+
+static int sirfsoc_pinmux_resume_noirq(struct device *dev)
+{
+	int i, j;
+	struct sirfsoc_pmx *spmx = dev_get_drvdata(dev);
+
+	for (i = 0; i < SIRFSOC_GPIO_NO_OF_BANKS; i++) {
+		for (j = 0; j < SIRFSOC_GPIO_BANK_SIZE; j++) {
+			writel(spmx->gpio_regs[i][j], spmx->gpio_virtbase +
+				SIRFSOC_GPIO_CTRL(i, j));
+		}
+		writel(spmx->ints_regs[i], spmx->gpio_virtbase +
+			SIRFSOC_GPIO_INT_STATUS(i));
+		writel(spmx->paden_regs[i], spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(i));
+	}
+	writel(spmx->dspen_regs, spmx->gpio_virtbase + SIRFSOC_GPIO_DSP_EN0);
+
+	for (i = 0; i < 3; i++)
+		writel(spmx->rsc_regs[i], spmx->rsc_virtbase + 4 * i);
+
+	return 0;
+}
+
+static const struct dev_pm_ops sirfsoc_pinmux_pm_ops = {
+	.suspend_noirq = sirfsoc_pinmux_suspend_noirq,
+	.resume_noirq = sirfsoc_pinmux_resume_noirq,
+};
+#endif
+
 static struct platform_driver sirfsoc_pinmux_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
 		.of_match_table = pinmux_ids,
+#ifdef CONFIG_PM_SLEEP
+		.pm = &sirfsoc_pinmux_pm_ops,
+#endif
 	},
 	.probe = sirfsoc_pinmux_probe,
 };
-- 
1.8.2.3



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
