From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 14:20:49 +0530
Subject: [PATCH 3/3 v2] mfd: sun4i-gpadc: Handle return value of
 platform_get_irq
In-Reply-To: <4f12b680d2f0d7554e6a1812f15037185a5a9a2a.1510994294.git.arvind.yadav.cs@gmail.com>
References: <4f12b680d2f0d7554e6a1812f15037185a5a9a2a.1510994294.git.arvind.yadav.cs@gmail.com>
Message-ID: <e00bb795db4113ef1d62665a805e3de33b5254e1.1510994295.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. If IRQ0 is not valid.

 drivers/mfd/sun4i-gpadc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/sun4i-gpadc.c b/drivers/mfd/sun4i-gpadc.c
index 9cfc881..1c89235 100644
--- a/drivers/mfd/sun4i-gpadc.c
+++ b/drivers/mfd/sun4i-gpadc.c
@@ -100,8 +100,8 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	struct resource *mem;
 	const struct of_device_id *of_id;
 	const struct mfd_cell *cells;
-	unsigned int irq, size;
-	int ret;
+	unsigned int size;
+	int ret, irq;
 
 	of_id = of_match_node(sun4i_gpadc_of_match, pdev->dev.of_node);
 	if (!of_id)
@@ -148,6 +148,9 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 	regmap_write(dev->regmap, SUN4I_GPADC_INT_FIFOC, 0);
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
 	ret = devm_regmap_add_irq_chip(&pdev->dev, dev->regmap, irq,
 				       IRQF_ONESHOT, 0,
 				       &sun4i_gpadc_regmap_irq_chip,
-- 
2.7.4
