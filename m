From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 21 Jul 2013 08:30:11 +0400
Subject: [PATCH 06/10] ARM: clps711x: Add CLPS711X clocksource driver
In-Reply-To: <51EB05AE.2050105@linaro.org>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-7-git-send-email-shc_work@mail.ru>
 <51E94F7E.4030404@linaro.org>
 <20130720074441.9882b71183e5eadd535da6c1@mail.ru>
 <51EB05AE.2050105@linaro.org>
Message-ID: <20130721083011.7988b08426c022d03269c223@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 20 Jul 2013 23:48:30 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 07/20/2013 05:44 AM, Alexander Shiyan wrote:
> > On Fri, 19 Jul 2013 16:38:54 +0200
> > Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >> (Added Thomas and John in Cc in case they want to review the patch).
> >>
> >> On 07/18/2013 08:34 PM, Alexander Shiyan wrote:
> >>> This adds the clocksource driver for Cirrus Logic CLPS711X series SoCs.
> >>> Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> >>> for this as the "OF" and "not-OF" calls implemented.
[...]
> >>> +static struct irqaction clps711x_timer_irq = {
> >>> +	.name		= "clps711x-timer",
> >>> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
> >>
> >> Why do you need IRQF_IRQPOOL ?
> > 
> > linux/interrupt.h:
> >  * IRQF_IRQPOLL - Interrupt is used for polling (only the interrupt that is
> >  *                registered first in an shared interrupt is considered for
> >  *                performance reasons)
> > 
> > I do not see need this flag, but in fact, this flag is traditionally used
> > in almost all subsystems of this type.
> 
> So IIUC, IRQPOLL is to switch to polling mode when a lot of interrupts
> occur, right ?

I'm also not an expert on these flags, but realized appointment just like you.

> >>> +	tmp = readl(syscon1);
> >>> +	/* TC1 in free running mode */
> >>> +	tmp &= ~SYSCON1_TC1M;
> >>> +	/* TC2 in prescale mode */
> >>> +	tmp |= SYSCON1_TC2M;
> >>> +	writel(tmp, syscon1);
> >>
> >> Could you encapsulate these calls inside a static inline function with a
> >> more detailed comment please ?
> > 
> > Why static inline?
> > There is a comment line for each bit, You think this is not enough?
> 
> I prefer to encapsulate readl/writel calls inside a small function with
> an explicit name, comments are still welcome.

Ok.

[...]

-- 
Alexander Shiyan <shc_work@mail.ru>
