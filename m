From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:43 +0100
Subject: [PATCH 04/20] clocksource/drivers/tcb_clksrc: Fix clock speed message
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-4-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Romain Izard <romain.izard.pro@gmail.com>

The clock speed displayed at boot in an information message was 500 kHz
too high compared to its real value. As the value is not used anywhere,
there is no functional impact.

Fix the rounding formula to display the correct value.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tcb_clksrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 9de47d4..43f4d5c 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -384,7 +384,7 @@ static int __init tcb_clksrc_init(void)
 
 	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
 			divided_rate / 1000000,
-			((divided_rate + 500000) % 1000000) / 1000);
+			((divided_rate % 1000000) + 500) / 1000);
 
 	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
 		/* use apropriate function to read 32 bit counter */
-- 
2.7.4
