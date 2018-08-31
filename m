From: Anson.Huang@nxp.com (Anson Huang)
Date: Fri, 31 Aug 2018 15:53:12 +0800
Subject: [PATCH 1/7] ARM: imx: add mmdc ipg clock operation for mmdc
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535701998-20443-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX6 SoCs have MMDC ipg clock for registers access, to make
sure MMDC registers access successfully, add optional clock
enable for MMDC driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/mach-imx/mmdc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 04b3bf7..e49e068 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -11,6 +11,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <linux/clk.h>
 #include <linux/hrtimer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -546,7 +547,20 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	void __iomem *mmdc_base, *reg;
+	struct clk *mmdc_ipg_clk;
 	u32 val;
+	int err;
+
+	/* the ipg clock is optional */
+	mmdc_ipg_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mmdc_ipg_clk))
+		mmdc_ipg_clk = NULL;
+
+	err = clk_prepare_enable(mmdc_ipg_clk);
+	if (err) {
+		dev_err(&pdev->dev, "Unable to enable mmdc ipg clock.\n");
+		return err;
+	}
 
 	mmdc_base = of_iomap(np, 0);
 	WARN_ON(!mmdc_base);
-- 
2.7.4
