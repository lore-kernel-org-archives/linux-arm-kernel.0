From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 8 Sep 2011 18:23:46 +0100
Subject: [PATCH v2 3/3] ARM: pxa/pj4: Port problematic pj4 support code
	to v7/Thumb-2
In-Reply-To: <201109081844.21371.arnd@arndb.de>
References: <1315497854-13311-1-git-send-email-dave.martin@linaro.org>
	<1315497854-13311-4-git-send-email-dave.martin@linaro.org>
	<201109081844.21371.arnd@arndb.de>
Message-ID: <20110908172346.GH2070@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 06:44:21PM +0200, Arnd Bergmann wrote:
> On Thursday 08 September 2011, Dave Martin wrote:
> >         __asm__ __volatile__ (
> >                 "mcr    p15, 0, %1, c1, c0, 2\n\t"
> > +#ifdef __LINUX_ARM_ARCH__ >= 7
> > +               "isb\n\t"
> > +#else
> >                 "mrc    p15, 0, %0, c1, c0, 2\n\t"
> >                 "mov    %0, %0\n\t"
> >                 "sub    pc, pc, #4\n\t"
> > +#endif
> >                 : "=r" (temp) : "r" (value));
> >  }
> 
> I thought we had concluded that we don't actually need the #else
> path because there is no pre-v7 support for pj4 any more.
> 

Ah, OK -- I somewhat missed the point, the was focusing on the other
patches (I notice I didn't fix #ifdef to #if either...)

Anyway, this patch can be drastically simplified -- i.e.,
the #if conditional should just go away, along with the
xscale-style code (which really doesn't make sense for a v7-only
file).

So we'd end up with something like:

        __asm__ __volatile__ (
                "mcr    p15, 0, %0, c1, c0, 2\n\t"
                "isb"
                : "r" (value));

Better?

Cheers
---Dave
