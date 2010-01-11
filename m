From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:18 +0800
Subject: [PATCH 10/16] [ARM] pxa: remove now unnecessary pxa_gpio_mode() calls
	in ac97
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-11-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now most (if not all) PXA platforms have been switched to the new MFP
API, it's rather safe to remove these unnecessary pxa_gpio_mode() calls
in pxa2xx-ac97-lib.c now.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 sound/arm/pxa2xx-ac97-lib.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index ee68728..88eec38 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -22,7 +22,6 @@
 
 #include <asm/irq.h>
 #include <mach/regs-ac97.h>
-#include <mach/pxa2xx-gpio.h>
 #include <mach/audio.h>
 
 static DEFINE_MUTEX(car_mutex);
@@ -338,13 +337,6 @@ int __devinit pxa2xx_ac97_hw_probe(struct platform_device *dev)
 			reset_gpio = 113;
 	}
 
-	if (cpu_is_pxa25x() || cpu_is_pxa27x()) {
-		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
-		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
-		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
-		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
-	}
-
 	if (cpu_is_pxa27x()) {
 		/* Use GPIO 113 as AC97 Reset on Bulverde */
 		pxa27x_assert_ac97reset(reset_gpio, 0);
-- 
1.6.3.3
