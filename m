From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 23 Apr 2013 15:50:37 +0200
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <20130423134448.GG27475@S2101-09.ap.freescale.net>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
 <51768885.4080301@pengutronix.de>
 <20130423134448.GG27475@S2101-09.ap.freescale.net>
Message-ID: <517691AD.304@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2013 03:44 PM, Shawn Guo wrote:
> On Tue, Apr 23, 2013 at 03:11:33PM +0200, Marc Kleine-Budde wrote:
>> On 04/23/2013 03:08 PM, Marc Kleine-Budde wrote:
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
>>>
>>> This patch fixes the problem by increasing the min_delta to "2" ticks.
>>>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>
>> The problem appears on at91sam9263. This patch successfully fixes the
>> problem and applies to current linus/master (post v3.9-rc8).
> 
> Thanks for the fixing, Marc.
> 
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Thanks. The downside of my RFC Patch is, that min_delta_ns is increased
from 30518 to 61035:

good: setup_clkevents: shift=32 mult=140737 min=30518 max=1999976422
bad:  setup_clkevents: shift=32 mult=140737 min=30517 max=1999976422
RFC:  setup_clkevents: shift=32 mult=140737 min=61035 max=1999976422

To keep the original min_delta_ns value of 30518, a rather hackish
option would be this:

diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
index 8a61872..30e0a68 100644
--- a/drivers/clocksource/tcb_clksrc.c
+++ b/drivers/clocksource/tcb_clksrc.c
@@ -198,6 +198,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
        clkevt.clkevt.cpumask = cpumask_of(0);

        clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
+       clkevt.clkevt.min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;

        setup_irq(irq, &tc_irqaction);
 }

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130423/111540f3/attachment-0001.sig>
