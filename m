From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sun, 19 Nov 2017 09:45:02 +0530
Subject: [PATCH 3/5 v4] ASoC: nuc900: Fix platform_get_irq's error checking
In-Reply-To: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
References: <082d4479211d425219f4ab275ecc12e1011eca2f.1511062844.git.arvind.yadav.cs@gmail.com>
Message-ID: <ff6af1a5db5ee3cb9b8f5846573d0f578950d6a8.1511062844.git.arvind.yadav.cs@gmail.com>
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
              Return -ENODEV insted of irq.
 sound/soc/nuc900/nuc900-ac97.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..893ccf2 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -345,11 +345,12 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 		goto out;
 	}
 
-	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret <= 0) {
 		ret = -EBUSY;
 		goto out;
 	}
+	nuc900_audio->irq_num = ret;
 
 	nuc900_ac97_data = nuc900_audio;
 
-- 
2.7.4
