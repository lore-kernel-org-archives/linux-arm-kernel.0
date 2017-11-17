From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Sat, 18 Nov 2017 01:03:26 +0530
Subject: [PATCH 3/5] ASoC: nuc900: Fix platform_get_irq's error checking
In-Reply-To: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1510947208-17134-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <1510947208-17134-4-git-send-email-arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615af..383627d 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -346,8 +346,8 @@ static int nuc900_ac97_drvprobe(struct platform_device *pdev)
 	}
 
 	nuc900_audio->irq_num = platform_get_irq(pdev, 0);
-	if (!nuc900_audio->irq_num) {
-		ret = -EBUSY;
+	if (nuc900_audio->irq_num < 0) {
+		ret = nuc900_audio->irq_num;
 		goto out;
 	}
 
-- 
2.7.4
