From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Oct 2014 13:00:23 +0100
Subject: [PATCH v7 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <20141030114100.GB32589@arm.com>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
 <1414617220-21493-2-git-send-email-mitchelh@codeaurora.org>
 <20141030114100.GB32589@arm.com>
Message-ID: <2369912.UOLoWKRnHU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 October 2014 11:41:00 Will Deacon wrote:
> > +
> > +#define readl_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(readl, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readl_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(readl, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(readb, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readw_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(readw, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readw_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(readw, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readq_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(readq, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define readq_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)

Sort these by size (b, w, l, q) maybe?

> > +#define ioread32_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(ioread32, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define ioread32_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(ioread32, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define ioread32b3_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(ioread32b3, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define ioread32b3_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(ioread32b3, addr, val, cond, delay_us, timeout_us)

What is ioread32b3?

> > +#define inb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(inb, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define inb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(inb, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define inb_p_poll_timeout(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout(inb_p, addr, val, cond, delay_us, timeout_us)
> > +
> > +#define inb_p_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
> > +	readx_poll_timeout_atomic(inb_p, addr, val, cond, delay_us, timeout_us)

I would leave out the _p variants, they are very rarely used anyway.

Looking at the long list, I wonder if we should really define each variant,
or just expect drivers to call readx_poll_timeout{,_atomic} directly and
pass whichever accessor they want.

	Arnd
