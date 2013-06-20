From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 20 Jun 2013 17:00:54 +0200
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <51794385.1030308@pengutronix.de>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
 <alpine.LFD.2.02.1304251618590.21884@ionos> <51794385.1030308@pengutronix.de>
Message-ID: <51C31926.3060400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On 04/25/2013 04:53 PM, Marc Kleine-Budde wrote:
> On 04/25/2013 04:21 PM, Thomas Gleixner wrote:
>> On Tue, 23 Apr 2013, Marc Kleine-Budde wrote:
>>> The commit
>>>
>>>     77cc982 clocksource: use clockevents_config_and_register() where possible
>>>
>>> switches from manually calculating min_delta_ns (and others) and
>>> clockevents_register_device() to automatic calculation via
>>> clockevents_config_and_register(). During this conversation the "+ 1" in
>>>
>>>     min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
>>>
>>> was lost. This leads to problems with schedule_delayed_work() with a delay of
>>> "1". Resulting in the work not scheduled in time.
>>
>> Errm. How is schedule_delayed_work() related to this?

Coming back to the this problem after some time.

I'm on at91sam9263 (armv5) using latest linus/master (v3.10-rc6-84-gc069114).
I can illustrate the problem running cyclictest.

Here's the output of unpatched linus/master:

> root at halo22:~ cyclictest -i 10000 -n -t 4
> policy: other/other: loadavg: 0.10 0.19 0.10 2/31 133
> 
> T: 0 (  130) P: 0 I:10000 C:  30767 Min:     57 Act:  165 Avg:909453 Max: 201897444
> T: 1 (  131) P: 0 I:10500 C:  29302 Min:     68 Act:  144 Avg:906651 Max: 204005666
> T: 2 (  132) P: 0 I:11000 C:  27970 Min:     79 Act:  188 Avg:905068 Max: 204008666
> T: 3 (  133) P: 0 I:11500 C:  26754 Min:     52 Act:  132 Avg:904438 Max: 203665111

Cyclictest runs for about two seconds, but then shows no output for
about two seconds, then it runs again, then stops and so on...

With my patch applied, the numbers are back to normal:

> root at halo22:~ cyclictest -i 10000 -n -t 4
> policy: other/other: loadavg: 0.34 0.15 0.06 2/32 109
> 
> T: 0 (  106) P: 0 I:10000 C:    292 Min:    112 Act:  208 Avg:  189 Max:    1715
> T: 1 (  107) P: 0 I:10500 C:    277 Min:    107 Act:  198 Avg:  201 Max:    1464
> T: 2 (  108) P: 0 I:11000 C:    265 Min:    104 Act:  148 Avg:  195 Max:    1530
> T: 3 (  109) P: 0 I:11500 C:    252 Min:    113 Act:  205 Avg:  167 Max:     269

Cyclictest keeps running without 2 second stops.

Is my patch a valid solution to the problem? If so, I'll write more 
specific commit message.

regards,
Marc

---

The commit

    77cc982 clocksource: use clockevents_config_and_register() where possible

switches from manually calculating min_delta_ns (and others) and
clockevents_register_device() to automatic calculation via
clockevents_config_and_register(). During this conversation the "+ 1" in

    min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;

was lost. This leads to problems with schedule_delayed_work() with a delay of
"1". Resulting in the work not scheduled in time.

This patch fixes the problem by increasing the min_delta to "2" ticks.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/clocksource/tcb_clksrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 8a61872..7cf6dc7 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -197,7 +197,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
 
 	clkevt.clkevt.cpumask = cpumask_of(0);
 
-	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+	clockevents_config_and_register(&clkevt.clkevt, 32768, 2, 0xffff);
 
 	setup_irq(irq, &tc_irqaction);
 }
-- 1.8.2.rc2

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130620/f746e3df/attachment.sig>
