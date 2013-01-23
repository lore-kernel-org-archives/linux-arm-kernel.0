From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:37:49 +0100
Subject: [PATCH v3 6/8] ARM: shmobile: use GPIO SD-card detection on
 armadillo800eva
In-Reply-To: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
References: <1358959071-2873-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <1358959071-2873-7-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch SDHI0 and SDHI1 SD-card interfaces on armadillo800eva to using GPIO
card detection, which provides maximum power saving and automatically
selects IRQ or polling mode, depending on the CD GPIO capability.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e657a7a..1cf1157 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -580,10 +580,10 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] =
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
@@ -624,7 +624,9 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
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
1.7.2.5
