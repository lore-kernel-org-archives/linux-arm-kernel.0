From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 20 Dec 2010 00:33:36 +0200
Subject: [PATCH] omap: pandora: fix wifi support
Message-ID: <1292798016-11098-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit ed919b0 "mmc: sdio: fix runtime PM anomalies by introducing
MMC_CAP_POWER_OFF_CARD" it is required to specify MMC_CAP_POWER_OFF_CARD
to have runtime PM support. As the wl1251 driver expects card to be
powered down when it's not used, wifi will no longer work after interface
is brought down at least once without functioning runtime PM.

Fix this by declaring MMC_CAP_POWER_OFF_CARD for MMC3.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
this is a fix but can go for 2.6.38 as wl1251 runtime PM support
is only queued for .38 .

 arch/arm/mach-omap2/board-omap3pandora.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 89ed1be..12c0bbb 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -293,7 +293,7 @@ static struct omap2_hsmmc_info omap3pandora_mmc[] = {
 	},
 	{
 		.mmc		= 3,
-		.caps		= MMC_CAP_4_BIT_DATA,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 		.init_card	= pandora_wl1251_init_card,
-- 
1.6.3.3
