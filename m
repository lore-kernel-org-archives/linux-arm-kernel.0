From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 14 Aug 2012 11:19:21 +0200
Subject: [PATCH v2 1/2] ARM: at91: fix system timer irq issue due to sparse
 irq support
In-Reply-To: <1344935962-18871-1-git-send-email-ludovic.desroches@atmel.com>
References: <1344935962-18871-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1344935962-18871-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

AT91_ID_SYS as virq is incorrect because of spare irq support which
introduces NR_IRQS_LEGACY offset.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Tested-by: Joachim Eastwood <joachim.eastwood@jotron.com>
---
 arch/arm/mach-at91/at91rm9200_time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 104ca40..aaa443b 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -197,7 +197,7 @@ void __init at91rm9200_timer_init(void)
 	at91_st_read(AT91_ST_SR);
 
 	/* Make IRQs happen for the system timer */
-	setup_irq(AT91_ID_SYS, &at91rm9200_timer_irq);
+	setup_irq(NR_IRQS_LEGACY + AT91_ID_SYS, &at91rm9200_timer_irq);
 
 	/* The 32KiHz "Slow Clock" (tick every 30517.58 nanoseconds) is used
 	 * directly for the clocksource and all clockevents, after adjusting
-- 
1.7.11.3
