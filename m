From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Thu,  8 Aug 2013 12:38:37 +0200
Subject: [PATCH v3 07/14] ARM: shmobile: ag5evm: Remove SDHI .set_pwr()
 callback
In-Reply-To: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1375958324-29683-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1375958324-29683-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SHDI platform data .set_pwr() callback is used to control the
vmmc/vqmmc power supplies. As the power supplies already register
control GPIOs there's no need to perform the operation manually.
Remove the callback functions.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index c754071..a8e200f 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -476,33 +476,10 @@ static struct platform_device cn4_power = {
 	},
 };
 
-static void ag5evm_sdhi1_set_pwr(struct platform_device *pdev, int state)
-{
-	static int power_gpio = -EINVAL;
-
-	if (power_gpio < 0) {
-		int ret = gpio_request_one(114, GPIOF_OUT_INIT_LOW,
-					   "sdhi1_power");
-		if (!ret)
-			power_gpio = 114;
-	}
-
-	/*
-	 * If requesting the GPIO above failed, it means, that the regulator got
-	 * probed and grabbed the GPIO, but we don't know, whether the sdhi
-	 * driver already uses the regulator. If it doesn't, we have to toggle
-	 * the GPIO ourselves, even though it is now owned by the fixed
-	 * regulator driver. We have to live with the race in case the driver
-	 * gets unloaded and the GPIO freed between these two steps.
-	 */
-	gpio_set_value(114, state);
-}
-
 static struct sh_mobile_sdhi_info sh_sdhi1_info = {
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34,
-	.set_pwr	= ag5evm_sdhi1_set_pwr,
 };
 
 static struct resource sdhi1_resources[] = {
-- 
1.8.1.5
