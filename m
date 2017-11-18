From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 15:26:47 +0530
Subject: [PATCH 3/3 v3] ASoC: nuc900: Fix platform_get_irq's error checking
In-Reply-To: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
References: <874375c0dca41790e47b60ce30f88ab353f97b38.1510997839.git.arvind.yadav.cs@gmail.com>
Message-ID: <19f8c64a4720118a6d6c4fedd5f8defa6938d1db.1510997840.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
               irq was unsigned. so using signed variable ret.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 sound/soc/nuc900/nuc900-ac97.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..71fce7c 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -345,11 +345,10 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 		goto out;
 	}
 
-	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
-		ret = -EBUSY;
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0)
 		goto out;
-	}
+	nuc900_audio->irq_num = ret;
 
 	nuc900_ac97_data = nuc900_audio;
 
-- 
2.7.4
