From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 15 Jan 2015 04:54:20 +0300
Subject: [PATCH RESEND] pxa_timer: fix session missmatch warning
Message-ID: <1421286860-23296-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warning:

WARNING: drivers/clocksource/built-in.o(.text.unlikely+0x70): Section mismatch in reference from the function pxa_timer_common_init() to the function .init.text:clocksource_mmio_init()
The function pxa_timer_common_init() references
the function __init clocksource_mmio_init().
This is often because pxa_timer_common_init lacks a __init
annotation or the annotation of clocksource_mmio_init is wrong.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/clocksource/pxa_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 941f3f3..d9438af 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -163,7 +163,7 @@ static struct irqaction pxa_ost0_irq = {
 	.dev_id		= &ckevt_pxa_osmr0,
 };
 
-static void pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
+static void __init pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
 {
 	timer_writel(0, OIER);
 	timer_writel(OSSR_M0 | OSSR_M1 | OSSR_M2 | OSSR_M3, OSSR);
-- 
2.1.4
