From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  8 Jan 2018 14:28:50 +0100
Subject: [PATCH 11/20] clocksource/drivers/stm32: Fix kernel panic with
 multiple timers
In-Reply-To: <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
References: <1bbaef2e-4080-3f54-7db3-a8989acfd691@free.fr>
 <1515418139-23276-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1515418139-23276-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code hides a couple of bugs.

 - The global variable 'clock_event_ddata' is overwritten each time the
   init function is invoked.

This is fixed with a kmemdup instead of assigning the global variable. That
prevents a memory corruption when several timers are defined in the DT.

 - The clockevent's event_handler is NULL if the time framework does
   not select the clockevent when registering it, this is fine but the init
   code generates in any case an interrupt leading to dereference this
   NULL pointer.

The stm32 timer works with shadow registers, a mechanism to cache the
registers. When a change is done in one buffered register, we need to
artificially generate an event to force the timer to copy the content
of the register to the shadowed register.

The auto-reload register (ARR) is one of the shadowed register as well as
the prescaler register (PSC), so in order to force the copy, we issue an
event which in turn leads to an interrupt and the NULL dereference.

This is fixed by inverting two lines where we clear the status register
before enabling the update event interrupt.

As this kernel crash is resulting from the combination of these two bugs,
the fixes are grouped into a single patch.

Cc: stable at vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/clocksource/timer-stm32.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-stm32.c
index 8f24237..4bfeb99 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -106,6 +106,10 @@ static int __init stm32_clockevent_init(struct device_node *np)
 	unsigned long rate, max_delta;
 	int irq, ret, bits, prescaler = 1;
 
+	data = kmemdup(&clock_event_ddata, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
@@ -156,8 +160,8 @@ static int __init stm32_clockevent_init(struct device_node *np)
 
 	writel_relaxed(prescaler - 1, data->base + TIM_PSC);
 	writel_relaxed(TIM_EGR_UG, data->base + TIM_EGR);
-	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 	writel_relaxed(0, data->base + TIM_SR);
+	writel_relaxed(TIM_DIER_UIE, data->base + TIM_DIER);
 
 	data->periodic_top = DIV_ROUND_CLOSEST(rate, prescaler * HZ);
 
@@ -184,6 +188,7 @@ static int __init stm32_clockevent_init(struct device_node *np)
 err_clk_enable:
 	clk_put(clk);
 err_clk_get:
+	kfree(data);
 	return ret;
 }
 
-- 
2.7.4
