From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:17:49 +0900
Subject: [PATCH 01/13] ARM: shmobile: use GPIO SD-card detection on
 armadillo800eva
In-Reply-To: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363659481-5922-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Switch SDHI0 and SDHI1 SD-card interfaces on armadillo800eva to using GPIO
card detection, which provides maximum power saving and automatically
selects IRQ or polling mode, depending on the CD GPIO capability.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 04eff93..60694e8 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -579,10 +579,10 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
-	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |\
-			  MMC_CAP_NEEDS_POLL,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
+	.cd_gpio	= GPIO_PORT167,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -623,7 +623,9 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
-	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
+	/* Port72 cannot generate IRQs, will be used in polling mode. */
+	.cd_gpio	= GPIO_PORT72,
 };
 
 static struct resource sdhi1_resources[] = {
-- 
1.7.10.4
