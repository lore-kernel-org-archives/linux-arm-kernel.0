From: broonie@kernel.org (Mark Brown)
Date: Fri, 16 Jun 2017 18:49:55 +0100
Subject: Applied "ASoC: stm32: sai: fix clock management" to the asoc tree
In-Reply-To: <1497615334-7156-7-git-send-email-olivier.moysan@st.com>
Message-ID: <E1dLvNb-0005cn-L3@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: fix clock management

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

>From 77dc2255f4859b814d4d8713a91ab41114996d4e Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Fri, 16 Jun 2017 14:15:33 +0200
Subject: [PATCH] ASoC: stm32: sai: fix clock management

Allow peripheral clock enable/disable on regmap accesses.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 97b69a3ab46e..2466af0343db 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -766,8 +766,8 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 		return PTR_ERR(base);
 
 	sai->phys_addr = res->start;
-	sai->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &stm32_sai_sub_regmap_config);
+	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "sai_ck", base,
+						&stm32_sai_sub_regmap_config);
 
 	/* Get direction property */
 	if (of_property_match_string(np, "dma-names", "tx") >= 0) {
-- 
2.11.0
