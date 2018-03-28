From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 28 Mar 2018 17:50:33 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <20180328153135.GG13942@piout.net>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <9761072.pX2B0LJlSJ@ada>
 <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
 <4073350.0MmxRoANOi@ada>
 <6d43177a-bbea-6a01-5fa5-1c7891e18412@linaro.org>
 <20180328141645.GF13942@piout.net>
 <75e5917b-a9ba-c67e-e964-3f002681f9bb@linaro.org>
 <20180328153135.GG13942@piout.net>
Message-ID: <20180328155033.GH13942@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/2018 at 17:31:35 +0200, Alexandre Belloni wrote:
> > Do you have an explanation of why the rate is much higher ?
> > 
> 
> The core is giving deltas of 31 clocks instead of much more than that, I
> guess I messed up the initialization somewhere.
> 

I did mess up.

Alexander, can you test that:

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
index 7fde9cfbf203..bbbacf8c46b0 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -222,7 +222,7 @@ static int __init tc_clkevt_register(struct device_node *node,
 		goto err_slow;
 	clk_disable(tce.clk);
 
-	clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
+	clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
 
 	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
 			  tce.clkevt.name, &tce);

This will behave exactly the same as before on 16bits TCB and will have
much less interrupts on 32 bits platforms.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
