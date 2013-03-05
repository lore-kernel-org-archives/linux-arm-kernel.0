From: ian.campbell@citrix.com (Ian Campbell)
Date: Tue, 5 Mar 2013 03:56:41 +0000
Subject: [PATCH LINUX v5] xen: event channel arrays are xen_ulong_t and
 not unsigned long
In-Reply-To: <51340ACD.70904@gmail.com>
References: <1361285327.1051.115.camel@zakaz.uk.xensource.com>
 <1361360886-2956-1-git-send-email-ian.campbell@citrix.com>
 <51340ACD.70904@gmail.com>
Message-ID: <1362455801.8941.24.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
> > index 94b4e90..5c27696 100644
> > --- a/arch/arm/include/asm/xen/events.h
> > +++ b/arch/arm/include/asm/xen/events.h
> > @@ -15,4 +15,26 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
> >  	return raw_irqs_disabled_flags(regs->ARM_cpsr);
> >  }
> >  
> > +/*
> > + * We cannot use xchg because it does not support 8-byte
> > + * values. However it is safe to use {ldr,dtd}exd directly because all
> > + * platforms which Xen can run on support those instructions.
> 
> Why does atomic64_cmpxchg not work here?

Just that we don't want/need the cmp aspect, we don't mind if an extra
bit gets set as we read the value, so long as we atomically read and set
to zero.

> > + */
> > +static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
> > +{
> > +	xen_ulong_t oldval;
> > +	unsigned int tmp;
> > +
> > +	wmb();
> 
> Based on atomic64_cmpxchg implementation, you could use smp_mb here
> which avoids an outer cache flush.

Good point.

> > +	asm volatile("@ xchg_xen_ulong\n"
> > +		"1:     ldrexd  %0, %H0, [%3]\n"
> > +		"       strexd  %1, %2, %H2, [%3]\n"
> > +		"       teq     %1, #0\n"
> > +		"       bne     1b"
> > +		: "=&r" (oldval), "=&r" (tmp)
> > +		: "r" (val), "r" (ptr)
> > +		: "memory", "cc");
> 
> And a smp_mb is needed here.

I think for the specific caller which we have here it isn't strictly
necessary, but for generic correctness I think you are right.

Thanks for reviewing.

Konrad, IIRC you have already picked this up (and sent to Linus?) so an
incremental fix is required? See below.

Ian.

8<------------------------------------

>From 4ed928274dad4c3ed610e769b2ae11eb2d1ea433 Mon Sep 17 00:00:00 2001
From: Ian Campbell <ijc@hellion.org.uk>
Date: Tue, 5 Mar 2013 03:37:23 +0000
Subject: [PATCH] arm: xen: correct barriers in xchg_xen_ulong

We can use an smp_wmb rather than a wmb here and we also need one after the
exchange. Spotted by Rob Herring.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 arch/arm/include/asm/xen/events.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 5c27696..0e1f59e 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -25,7 +25,7 @@ static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
 	xen_ulong_t oldval;
 	unsigned int tmp;
 
-	wmb();
+	smp_wmb();
 	asm volatile("@ xchg_xen_ulong\n"
 		"1:     ldrexd  %0, %H0, [%3]\n"
 		"       strexd  %1, %2, %H2, [%3]\n"
@@ -34,6 +34,7 @@ static inline xen_ulong_t xchg_xen_ulong(xen_ulong_t *ptr, xen_ulong_t val)
 		: "=&r" (oldval), "=&r" (tmp)
 		: "r" (val), "r" (ptr)
 		: "memory", "cc");
+	smp_wmb();
 	return oldval;
 }
 
-- 
1.7.10.4
