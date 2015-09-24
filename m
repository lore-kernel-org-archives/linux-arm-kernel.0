From: aalonso@freescale.com (Adrian Alonso)
Date: Thu, 24 Sep 2015 15:54:01 -0500
Subject: [PATCH v5 5/7] pinctrl: freescale: imx: add shared input select reg
 support
In-Reply-To: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
References: <1443128043-21063-1-git-send-email-aalonso@freescale.com>
Message-ID: <1443128043-21063-5-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Add shared input select register support
- imx7d has two iomux controllers iomuxc and iomuxc-lpsr
  which share select_input register for daisy chain settings

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
Changes for V2: Resend
Changes for V3:
- Use of_parse_phandle instead of of_get_child_by_name to get input select
  base register address
Changes for V4: Resend
Changes for V5:
- Remove SHARE_INPUT_SELECT_REG flag
- Use fsl,input-sel to check if shared input select register support is used

 drivers/pinctrl/freescale/pinctrl-imx.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 23348d8..c7946fa 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -39,6 +40,7 @@ struct imx_pinctrl {
 	struct device *dev;
 	struct pinctrl_dev *pctl;
 	void __iomem *base;
+	void __iomem *input_sel_base;
 	const struct imx_pinctrl_soc_info *info;
 };
 
@@ -254,7 +256,12 @@ static int imx_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 			 * Regular select input register can never be at offset
 			 * 0, and we only print register value for regular case.
 			 */
-			writel(pin->input_val, ipctl->base + pin->input_reg);
+			if (ipctl->input_sel_base)
+				writel(pin->input_val, ipctl->input_sel_base +
+						pin->input_reg);
+			else
+				writel(pin->input_val, ipctl->base +
+						pin->input_reg);
 			dev_dbg(ipctl->dev,
 				"==>select_input: offset 0x%x val 0x%x\n",
 				pin->input_reg, pin->input_val);
@@ -682,6 +689,8 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 int imx_pinctrl_probe(struct platform_device *pdev,
 		      struct imx_pinctrl_soc_info *info)
 {
+	struct device_node *dev_np = pdev->dev.of_node;
+	struct device_node *np;
 	struct imx_pinctrl *ipctl;
 	struct resource *res;
 	int ret, i;
@@ -712,6 +721,23 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 	if (IS_ERR(ipctl->base))
 		return PTR_ERR(ipctl->base);
 
+	if (of_property_read_bool(dev_np, "fsl,input-sel")) {
+		np = of_parse_phandle(dev_np, "fsl,input-sel", 0);
+		if (np) {
+			ipctl->input_sel_base = of_iomap(np, 0);
+			if (IS_ERR(ipctl->input_sel_base)) {
+				of_node_put(np);
+				dev_err(&pdev->dev,
+					"iomuxc input select base address not found\n");
+				return PTR_ERR(ipctl->input_sel_base);
+			}
+		} else {
+			dev_err(&pdev->dev, "iomuxc fsl,input-sel property not found\n");
+			return -EINVAL;
+		}
+		of_node_put(np);
+	}
+
 	imx_pinctrl_desc.name = dev_name(&pdev->dev);
 	imx_pinctrl_desc.pins = info->pins;
 	imx_pinctrl_desc.npins = info->npins;
-- 
2.1.4
