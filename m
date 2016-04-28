From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 Apr 2016 15:20:45 +0200
Subject: [PATCH 2/5] clocksource/drivers/mtk_timer: Add __init attribute
In-Reply-To: <1461849648-12751-1-git-send-email-daniel.lezcano@linaro.org>
References: <20160428131908.GC5197@linaro.org>
 <1461849648-12751-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1461849648-12751-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Add __init attribute on a function that is only called from other __init
functions and that is not inlined, at least with gcc version 4.8.4 on an
x86 machine with allyesconfig.  Currently, the function is put in the
.text.unlikely segment.  Declaring it as __init will cause it to be put in
the .init.text and to disappear after initialization.

The result of objdump -x on the function before the change is as follows:

0000000000000000 l     F .text.unlikely 000000000000006f mtk_timer_setup.isra.4

And after the change it is as follows:

0000000000000000 l     F .init.text	000000000000006a mtk_timer_setup.isra.4

Done with the help of Coccinelle.  The semantic patch checks for local
static non-init functions that are called from an __init function and are
not called from any other function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/clocksource/mtk_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/mtk_timer.c b/drivers/clocksource/mtk_timer.c
index d67bc35..7e583f8 100644
--- a/drivers/clocksource/mtk_timer.c
+++ b/drivers/clocksource/mtk_timer.c
@@ -152,7 +152,7 @@ static irqreturn_t mtk_timer_interrupt(int irq, void *dev_id)
 }
 
 static void
-mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
+__init mtk_timer_setup(struct mtk_clock_event_device *evt, u8 timer, u8 option)
 {
 	writel(TIMER_CTRL_CLEAR | TIMER_CTRL_DISABLE,
 		evt->gpt_base + TIMER_CTRL_REG(timer));
-- 
1.9.1
