From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Sep 2017 17:49:57 +0100 (BST)
Subject: Applied "spi: stm32: Fix logical error in stm32_spi_prepare_mbr()" to
 the spi tree
In-Reply-To: <1505051729-22270-1-git-send-email-chris.gekas@gmail.com>
Message-ID: <20170913164958.025E9440014@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: Fix logical error in stm32_spi_prepare_mbr()

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 8b5d729a3a8a07fe273af266e90bc52114dd69a6 Mon Sep 17 00:00:00 2001
From: Christos Gkekas <chris.gekas@gmail.com>
Date: Sun, 10 Sep 2017 14:55:29 +0100
Subject: [PATCH] spi: stm32: Fix logical error in stm32_spi_prepare_mbr()

stm32_spi_prepare_mbr() is returning an error value when div is less
than SPI_MBR_DIV_MIN *and* greater than SPI_MBR_DIV_MAX, which always
evaluates to false. This should change to use *or*.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 680cdf549506..ba9743fa2326 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -263,8 +263,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz)
 	 * no need to check it there.
 	 * However, we need to ensure the following calculations.
 	 */
-	if ((div < SPI_MBR_DIV_MIN) &&
-	    (div > SPI_MBR_DIV_MAX))
+	if (div < SPI_MBR_DIV_MIN ||
+	    div > SPI_MBR_DIV_MAX)
 		return -EINVAL;
 
 	/* Determine the first power of 2 greater than or equal to div */
-- 
2.13.2
