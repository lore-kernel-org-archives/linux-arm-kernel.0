From: romain.izard.pro@gmail.com (Romain Izard)
Date: Tue,  5 Sep 2017 13:36:05 +0200
Subject: [PATCH] clocksource: tcb_clksrc: Fix clock speed message
Message-ID: <20170905113605.24191-1-romain.izard.pro@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock speed displayed at boot in an information message was 500 kHz
too high compared to its real value. As the value is not used anywhere,
there is no functional impact.

Fix the rounding formula to display the correct value.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/clocksource/tcb_clksrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 59e8aee0ec16..8fb4bea14f16 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -383,7 +383,7 @@ static int __init tcb_clksrc_init(void)
 
 	printk(bootinfo, clksrc.name, CONFIG_ATMEL_TCB_CLKSRC_BLOCK,
 			divided_rate / 1000000,
-			((divided_rate + 500000) % 1000000) / 1000);
+			((divided_rate % 1000000) + 500) / 1000);
 
 	if (tc->tcb_config && tc->tcb_config->counter_width == 32) {
 		/* use apropriate function to read 32 bit counter */
-- 
2.11.0
