From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:03:24 +0530
Subject: [PATCH 1/5] ASoC: ep93xx-ac97: Fix platform_get_irq's error checking
In-Reply-To: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510947208-17134-2-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/cirrus/ep93xx-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/cirrus/ep93xx-ac97.c b/sound/soc/cirrus/ep93xx-ac97.c
index bbf7a92..d66c561 100644
--- a/sound/soc/cirrus/ep93xx-ac97.c
+++ b/sound/soc/cirrus/ep93xx-ac97.c
@@ -378,8 +378,8 @@ static int ep93xx_ac97_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq)
-		return -ENODEV;
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, ep93xx_ac97_interrupt,
 			       IRQF_TRIGGER_HIGH, pdev->name, info);
-- 
2.7.4
