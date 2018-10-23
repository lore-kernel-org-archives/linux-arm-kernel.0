From: broonie@kernel.org (Mark Brown)
Date: Tue, 23 Oct 2018 11:53:55 +0200 (CEST)
Subject: Applied "ASoC: stm32: sai: fix master clock naming" to the asoc tree
In-Reply-To: <1540221046-11812-3-git-send-email-olivier.moysan@st.com>
Message-ID: <20181023095356.02CB9440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: stm32: sai: fix master clock naming

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

>From 6be0f96d799f487f05eb412d362d5a1747d665c2 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 22 Oct 2018 17:10:46 +0200
Subject: [PATCH] ASoC: stm32: sai: fix master clock naming

Fixes: 8307b2afd386 ("ASoC: stm32: sai: set sai as mclk clock provider")

Fix warning issued by strncat when bound equals to source length.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 31d22abd3204..ea05cc91aa05 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -404,12 +404,11 @@ static int stm32_sai_add_mclk_provider(struct stm32_sai_sub_data *sai)
 	 * String after "_" char is stripped in parent name.
 	 */
 	p = mclk_name;
-	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 6))) {
+	while (*s && *s != '_' && (i < (SAI_MCLK_NAME_LEN - 7))) {
 		*p++ = *s++;
 		i++;
 	}
-	STM_SAI_IS_SUB_A(sai) ?
-		strncat(p, "a_mclk", 6) : strncat(p, "b_mclk", 6);
+	STM_SAI_IS_SUB_A(sai) ? strcat(p, "a_mclk") : strcat(p, "b_mclk");
 
 	mclk->hw.init = CLK_HW_INIT(mclk_name, pname, &mclk_ops, 0);
 	mclk->sai_data = sai;
-- 
2.19.0
