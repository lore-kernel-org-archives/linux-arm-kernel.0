From: broonie@kernel.org (Mark Brown)
Date: Thu, 08 Feb 2018 15:41:57 +0000
Subject: Applied "regulator: stm32-vrefbuf: fix check on ready flag" to the
 regulator tree
In-Reply-To: <1518097385-7449-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <E1ejoKj-00006C-SN@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   regulator: stm32-vrefbuf: fix check on ready flag

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

>From f63248fac563125fd5a2f0bc780ce7a299872cab Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@st.com>
Date: Thu, 8 Feb 2018 14:43:05 +0100
Subject: [PATCH] regulator: stm32-vrefbuf: fix check on ready flag

stm32_vrefbuf_enable() wrongly checks VRR bit: 0 stands for not ready,
1 for ready. It currently checks the opposite.
This makes enable routine to exit immediately without waiting for ready
flag.

Fixes: 0cdbf481e927 ("regulator: Add support for stm32-vrefbuf")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable at vger.kernel.org
---
 drivers/regulator/stm32-vrefbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm32-vrefbuf.c
index 72c8b3e1022b..e0a9c445ed67 100644
--- a/drivers/regulator/stm32-vrefbuf.c
+++ b/drivers/regulator/stm32-vrefbuf.c
@@ -51,7 +51,7 @@ static int stm32_vrefbuf_enable(struct regulator_dev *rdev)
 	 * arbitrary timeout.
 	 */
 	ret = readl_poll_timeout(priv->base + STM32_VREFBUF_CSR, val,
-				 !(val & STM32_VRR), 650, 10000);
+				 val & STM32_VRR, 650, 10000);
 	if (ret) {
 		dev_err(&rdev->dev, "stm32 vrefbuf timed out!\n");
 		val = readl_relaxed(priv->base + STM32_VREFBUF_CSR);
-- 
2.15.1
