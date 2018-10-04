From: broonie@kernel.org (Mark Brown)
Date: Thu,  4 Oct 2018 15:51:04 +0100 (BST)
Subject: Applied "spi: pxa2xx: Rewrite switch code block in
 interrupt_transfer" to the spi tree
In-Reply-To: <20181003155522.GA31045@embeddedor.com>
Message-ID: <20181004145104.6F63E1121C82@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: pxa2xx: Rewrite switch code block in interrupt_transfer

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 2c1833767bd8d906489a91cbbcb151fe3b818b61 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 3 Oct 2018 17:55:22 +0200
Subject: [PATCH] spi: pxa2xx: Rewrite switch code block in interrupt_transfer

Rewrite switch code block to directly do the expected number
of shifts in each case and have break statements.

Addresses-Coverity-ID: 1056539 ("Missing break in switch")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc9aac214239..d68f511a9ef1 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -665,9 +665,11 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 			bytes_left = drv_data->rx_end - drv_data->rx;
 			switch (drv_data->n_bytes) {
 			case 4:
-				bytes_left >>= 1;
+				bytes_left >>= 2;
+				break;
 			case 2:
 				bytes_left >>= 1;
+				break;
 			}
 
 			rx_thre = pxa2xx_spi_get_rx_default_thre(drv_data);
-- 
2.19.0.rc2
