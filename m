From: chanho.min@lge.com (Chanho Min)
Date: Wed, 17 Sep 2014 11:58:04 +0900
Subject: [PATCH] ARM: timer-sp: ensure interrupt is cleared at
 sp804_clockevents_init
In-Reply-To: <20140917010923.GB10233@codeaurora.org>
References: <1410914571-8388-1-git-send-email-chanho.min@lge.com>
 <20140917010923.GB10233@codeaurora.org>
Message-ID: <021401cfd223$337d9430$9a78bc90$@min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +	/* Ensure interrupt is cleared */
> > +	writel(1, clkevt_base + TIMER_INTCLR);
> >  	setup_irq(irq, &sp804_timer_irq);
> >  	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
> 
> Or just flip the order of clockevents_config_and_register() and
> setup_irq()? We've done this in other clockevents drivers.
It won't fix this issue. clockevents_config_and_register will do nothing
if the higher rated device is registered. if pending interrupt is existed,
interrupt will be triggered as soon as setup_irq is done.
