From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon,  5 Sep 2011 00:30:15 +0200
Subject: [PATCH 1/2] s3c24xx_gpiolib_init: only register available gpio banks
Message-ID: <1315175415-11608-1-git-send-email-jacmet@sunsite.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only register gpio banks provided by SoC instead of the maximum possible
to lessen confusion, get rid of a warning from gpiolib and stop it from
eating into the extra gpios for configs with S3C24XX_GPIO_EXTRA != 0.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/plat-s3c24xx/gpiolib.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/gpiolib.c b/arch/arm/plat-s3c24xx/gpiolib.c
index 243b641..6360ae7 100644
--- a/arch/arm/plat-s3c24xx/gpiolib.c
+++ b/arch/arm/plat-s3c24xx/gpiolib.c
@@ -217,6 +217,9 @@ static __init int s3c24xx_gpiolib_init(void)
 	int gpn;
 
 	for (gpn = 0; gpn < ARRAY_SIZE(s3c24xx_gpios); gpn++, chip++) {
+		if (chip->chip.base >= S3C_GPIO_END)
+			break;
+
 		if (!chip->config)
 			chip->config = &s3c24xx_gpiocfg_default;
 
-- 
1.7.5.4
