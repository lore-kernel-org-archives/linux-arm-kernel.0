From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:26:45 +0530
Subject: [PATCH 1/3 v3] ASoC: ep93xx-ac97: Fix platform_get_irq's error
 checking
Message-ID: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               irq was unsigned. so changed it to signed.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 sound/soc/cirrus/ep93xx-ac97.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index bbf7a92..b86b83b 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -365,7 +365,7 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 {
 	struct ep93xx_ac97_info *info;
 	struct resource *res;
-	unsigned int irq;
+	int irq;
 	int ret;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -378,8 +378,8 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -ENODEV;
+	if (irq <= 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, ep93xx_ac97_interrupt,
 			       IRQF_TRIGGER_HIGH, pdev->name, info);
-- 
2.7.4
