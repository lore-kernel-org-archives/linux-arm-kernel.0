From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 15 Mar 2016 14:24:36 +0100
Subject: [PATCH] spi: imx: only do necessary changes to ECSPIx_CONFIGREG
Message-ID: <1458048276-31884-1-git-send-email-dirk.behme@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Knut Wohlrab <knut.wohlrab@de.bosch.com>

If the SPI chip select (CS) for a dedicated channel is done manually by
the used higher device driver, the CS may be active while writing to
ECSPIx_CONFIGREG. To prevent unwanted clock edges when selecting
the clock mode,  only do the necessary changes to the i.MX SPI
configuration register and leave not selected channels untouched.

To prevent unwanted clock edges on first use, an empty dummy
transmission shall be done by the initialization procedure of the device
driver of this channel. This will set the clock mode to the correct state.

Signed-off-by: Knut Wohlrab <knut.wohlrab@de.bosch.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---

This is regarding the discussion in

http://www.spinics.net/lists/arm-kernel/msg489107.html

and the revert

https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/commit/drivers/spi/spi-imx.c?h=for-linus&id=c34de7168cd201ab757b11bfc7899953948d7753

This version is mainly the same like the reverted one, but making sure
that the cfg variable isn't just 0.

This patch is against

https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=for-linus

commit d00de215041f706

 drivers/spi/spi-imx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e7a19be..b79d70d 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -333,8 +333,9 @@ static void __maybe_unused mx51_ecspi_trigger(struct spi_imx_data *spi_imx)
 static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		struct spi_imx_config *config)
 {
-	u32 ctrl = MX51_ECSPI_CTRL_ENABLE, cfg = 0;
+	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
 	u32 clk = config->speed_hz, delay, reg;
+	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/*
 	 * The hardware seems to have a race condition when changing modes. The
@@ -358,13 +359,20 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 
 	if (config->mode & SPI_CPHA)
 		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(config->cs);
 
 	if (config->mode & SPI_CPOL) {
 		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
 		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
+	} else {
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(config->cs);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(config->cs);
 	}
 	if (config->mode & SPI_CS_HIGH)
 		cfg |= MX51_ECSPI_CONFIG_SSBPOL(config->cs);
+	else
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
 	if (spi_imx->usedma)
 		ctrl |= MX51_ECSPI_CTRL_SMC;
-- 
2.5.0
