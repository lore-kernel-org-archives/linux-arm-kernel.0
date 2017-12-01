From: broonie@kernel.org (Mark Brown)
Date: Fri, 01 Dec 2017 13:44:03 +0000
Subject: Applied "ASoC: nuc900: Fix platform_get_irq's error checking" to the
 asoc tree
In-Reply-To: <0703b0d6d8ba826a42f244eec6bce71514edd563.1511970158.git.arvind.yadav.cs@gmail.com>
Message-ID: <E1eKlbn-0001Ip-40@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: nuc900: Fix platform_get_irq's error checking

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From fa8cc38165c2f6f73bf947087b3cdc5dd9b9b560 Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 29 Nov 2017 21:47:12 +0530
Subject: [PATCH] ASoC: nuc900: Fix platform_get_irq's error checking

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/nuc900/nuc900-ac97.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.c
index b6615affe571..5e4fbd2d3479 100644
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
2.15.0
