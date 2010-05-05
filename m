From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 05 May 2010 17:07:53 +0100
Subject: [PATCH 1/8] ARM: Improve the L2 cache performance when PL310
	is used
In-Reply-To: <w2zd91d07041005041002jfdc91901r97d01fc3b9a420d7@mail.gmail.com>
References: <20100504163823.26355.58568.stgit@e102109-lin.cambridge.arm.com>
	<20100504164421.26355.9656.stgit@e102109-lin.cambridge.arm.com>
	<w2zd91d07041005041002jfdc91901r97d01fc3b9a420d7@mail.gmail.com>
Message-ID: <1273075673.27058.1.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-05-04 at 18:02 +0100, Jason McMullan wrote:
> On Tue, May 4, 2010 at 12:44 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > With this L2 cache controller, the cache maintenance by PA and sync
> > operations are atomic and do not require a "wait" loop or spinlocks.
> > This patch conditionally defines the cache_wait() function and locking
> > primitives (rather than duplicating the functions or file).
> >
> > Since L2x0 cache controllers do not work with ARMv7 CPUs, the patch
> > automatically enables CACHE_PL310 when CPU_V7 is defined.
> >
> > [snip snip snip]
> >  static inline void l2x0_inv_all(void)
> > @@ -107,11 +134,11 @@ static inline void l2x0_inv_all(void)
> >        unsigned long flags;
> >
> >        /* invalidate all ways */
> > -       spin_lock_irqsave(&l2x0_lock, flags);
> > +       _l2x0_lock(&l2x0_lock, flags);
> >        writel(0xff, l2x0_base + L2X0_INV_WAY);
> > -       cache_wait(l2x0_base + L2X0_INV_WAY, 0xff);
> > +       cache_wait_always(l2x0_base + L2X0_INV_WAY, 0xff);
> >        cache_sync();
> > -       spin_unlock_irqrestore(&l2x0_lock, flags);
> > +       _l2x0_unlock(&l2x0_lock, flags);
> >  }
> 
> So, ah, shouldn't you be using a mask of 0xffff for 16-way PL310s?
> 
> And I think we have a potential patch collision in the near future.
> 
> Could you integrate in my [arm l2x0] patch I posted today on the list?
> 
> It supports 16-way PL310s, and PL210s with fewer than 7 ways.

I think the best way is to just go ahead and push your patch to
Russell's patch system, I'll update my patch based on yours once I get
some feedback on this list.

-- 
Catalin
