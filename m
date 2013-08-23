From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 23 Aug 2013 10:34:02 +0800
Subject: [PATCH v2 4/4] pinctrl: mvebu: Convert to use devm_ioremap_resource
In-Reply-To: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
References: <1377225242-5854-1-git-send-email-jszhang@marvell.com>
Message-ID: <1377225242-5854-5-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/pinctrl/mvebu/pinctrl-mvebu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mvebu/pinctrl-mvebu.c b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
index bb7ddb1..1caa45f 100644
--- a/drivers/pinctrl/mvebu/pinctrl-mvebu.c
+++ b/drivers/pinctrl/mvebu/pinctrl-mvebu.c
@@ -579,7 +579,7 @@ static int mvebu_pinctrl_build_functions(struct platform_device *pdev,
 int mvebu_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mvebu_pinctrl_soc_info *soc = dev_get_platdata(&pdev->dev);
-	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
 	struct mvebu_pinctrl *pctl;
 	void __iomem *base;
 	struct pinctrl_pin_desc *pdesc;
@@ -591,11 +591,10 @@ int mvebu_pinctrl_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	base = of_iomap(np, 0);
-	if (!base) {
-		dev_err(&pdev->dev, "unable to get base address\n");
-		return -ENODEV;
-	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	pctl = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pinctrl),
 			GFP_KERNEL);
-- 
1.8.4.rc3
