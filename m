From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jan 2018 11:23:54 +0000
Subject: Applied "spi: a3700: Set frequency limits at startup" to the spi tree
In-Reply-To: <1516205728-3256-3-git-send-email-maxime.chevallier@smile.fr>
Message-ID: <E1ec8IU-0003uU-1h@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: a3700: Set frequency limits at startup

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

>From abf3a49e50967bd67cff67f289690f76436f461f Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@smile.fr>
Date: Wed, 17 Jan 2018 17:15:26 +0100
Subject: [PATCH] spi: a3700: Set frequency limits at startup

Armada 3700 SPI controller has an internal clock divider which can
divide the parent clock frequency by up to 30.

This patch sets the limits in the spi_controller fields so that we can
detect when a non-supported frequency is requested by a device for a
transfer.

Signed-off-by: Maxime Chevallier <maxime.chevallier@smile.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-armada-3700.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 4857b0119556..07f227e3c834 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -27,6 +27,8 @@
 
 #define DRIVER_NAME			"armada_3700_spi"
 
+#define A3700_SPI_MAX_SPEED_HZ		100000000
+#define A3700_SPI_MAX_PRESCALE		30
 #define A3700_SPI_TIMEOUT		10
 
 /* SPI Register Offest */
@@ -815,6 +817,11 @@ static int a3700_spi_probe(struct platform_device *pdev)
 		goto error;
 	}
 
+	master->max_speed_hz = min_t(unsigned long, A3700_SPI_MAX_SPEED_HZ,
+					clk_get_rate(spi->clk));
+	master->min_speed_hz = DIV_ROUND_UP(clk_get_rate(spi->clk),
+						A3700_SPI_MAX_PRESCALE);
+
 	ret = a3700_spi_init(spi);
 	if (ret)
 		goto error_clk;
-- 
2.15.1
