From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed, 29 Nov 2017 21:47:12 +0530
Subject: [PATCH 3/5 v5] ASoC: nuc900: Fix platform_get_irq's error checking
In-Reply-To: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
References: <4ce907b8389af30eb0677e70cf543a2b795cca12.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <0703b0d6d8ba826a42f244eec6bce71514edd563.1511970158.git.arvind.yadav.cs@gmail.com>
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
changes in v4 :
              Return -EBUSY insted of irq.
changes in v5 :
              Add separate error for irq == 0 and irq < 0.

 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..5e4fbd2 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -346,8 +346,8 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	}
 
 	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
-		ret = -EBUSY;
+	if (nuc900_audio->irq_num <= 0) {
+		ret = nuc900_audio->irq_num < 0 ? nuc900_audio->irq_num : -EBUSY;
 		goto out;
 	}
 
-- 
2.7.4
