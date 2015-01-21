From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 10:17:36 +0100
Subject: [PATCH 1/5] clocksource: sun5i: Switch to request_irq
In-Reply-To: <54BBFE38.5000204@linaro.org>
References: <1420976410-7826-1-git-send-email-maxime.ripard@free-electrons.com>
 <1420976410-7826-2-git-send-email-maxime.ripard@free-electrons.com>
 <54BBFE38.5000204@linaro.org>
Message-ID: <20150121091736.GE4367@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 18, 2015 at 07:40:56PM +0100, Daniel Lezcano wrote:
> On 01/11/2015 12:40 PM, Maxime Ripard wrote:
> >The current code uses setup_irq, while it could perfectly use the much simpler
> >request_irq. Switch to that.
> >
> >Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >---
> >  drivers/clocksource/timer-sun5i.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> >diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
> >index 02268448dc85..738853873a3b 100644
> >--- a/drivers/clocksource/timer-sun5i.c
> >+++ b/drivers/clocksource/timer-sun5i.c
> >@@ -130,13 +130,6 @@ static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
> >  	return IRQ_HANDLED;
> >  }
> >
> >-static struct irqaction sun5i_timer_irq = {
> >-	.name = "sun5i_timer0",
> >-	.flags = IRQF_TIMER | IRQF_IRQPOLL,
> >-	.handler = sun5i_timer_interrupt,
> >-	.dev_id = &sun5i_clockevent,
> >-};
> >-
> >  static u64 sun5i_timer_sched_read(void)
> >  {
> >  	return ~readl(timer_base + TIMER_CNTVAL_LO_REG(1));
> >@@ -178,7 +171,8 @@ static void __init sun5i_timer_init(struct device_node *node)
> >
> >  	ticks_per_jiffy = DIV_ROUND_UP(rate, HZ);
> >
> >-	ret = setup_irq(irq, &sun5i_timer_irq);
> >+	ret = request_irq(irq, sun5i_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
> >+			  "sun5i_timer", &sun5i_clockevent);
> 
> Is the timer name change done in purpose ?

Hmm, no, it's a mistake. I'll resend a v2.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150121/cd1b5881/attachment.sig>
