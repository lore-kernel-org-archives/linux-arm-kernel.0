From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Nov 2012 15:23:49 +0000
Subject: [PATCH] ARM: EXYNOS: use BUG_ON where possible
In-Reply-To: <50A111DD.6080504@gmail.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-5-git-send-email-sasha.levin@oracle.com>
 <50A111DD.6080504@gmail.com>
Message-ID: <20121112152349.GH28327@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 04:12:29PM +0100, Maarten Lankhorst wrote:
> Op 08-11-12 21:23, Sasha Levin schreef:
> > @@ -465,10 +465,8 @@ static void __init combiner_cascade_irq(unsigned int combiner_nr, unsigned int i
> >  	else
> >  		max_nr = EXYNOS4_MAX_COMBINER_NR;
> >  
> > -	if (combiner_nr >= max_nr)
> > -		BUG();
> > -	if (irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0)
> > -		BUG();
> > +	BUG_ON(combiner_nr >= max_nr);
> > +	BUG_ON(irq_set_handler_data(irq, &combiner_data[combiner_nr]) != 0);
>
> Is it really a good idea to put functions that perform work in a BUG_ON?
> I don't know, but for some reason it just feels wrong. I'd expect code to
> compile fine if BUG_ON was a noop, so doing verification calls only, not
> actual work..

Well, it is currently defined as:

include/asm-generic/bug.h:#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while(0)
include/asm-generic/bug.h:#define BUG_ON(condition) do { if (condition) ; } while(0)

but as these can be overridden, I don't think relying on those
implementations is a good idea; to do so would be fragile.  Eg, what if
the BUG_ON() implementation becomes just:

#define BUG_ON(x)

then the function call itself vanishes.  So, only put the actual bug test
inside a BUG_ON(), not the functional part which must always be executed.
