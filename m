From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Jul 2017 15:16:49 +0100
Subject: Applied "ASoC: sun4i-spdif: Handle return value of
 clk_prepare_enable." to the asoc tree
In-Reply-To: <1500977718-28010-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <E1daN7J-0003SG-Kd@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3643e9172649f97f2e6301582890202abcc0f97e Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 25 Jul 2017 15:45:18 +0530
Subject: [PATCH] ASoC: sun4i-spdif: Handle return value of clk_prepare_enable.

clk_prepare_enable() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-spdif.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-spdif.c b/sound/soc/sunxi/sun4i-spdif.c
index c49f3757b686..b4af4aabead1 100644
--- a/sound/soc/sunxi/sun4i-spdif.c
+++ b/sound/soc/sunxi/sun4i-spdif.c
@@ -458,11 +458,16 @@ static int sun4i_spdif_runtime_suspend(struct device *dev)
 static int sun4i_spdif_runtime_resume(struct device *dev)
 {
 	struct sun4i_spdif_dev *host  = dev_get_drvdata(dev);
+	int ret;
 
-	clk_prepare_enable(host->spdif_clk);
-	clk_prepare_enable(host->apb_clk);
+	ret = clk_prepare_enable(host->spdif_clk);
+	if (ret)
+		return ret;
+	ret = clk_prepare_enable(host->apb_clk);
+	if (ret)
+		clk_disable_unprepare(host->spdif_clk);
 
-	return 0;
+	return ret;
 }
 
 static int sun4i_spdif_probe(struct platform_device *pdev)
-- 
2.13.2
