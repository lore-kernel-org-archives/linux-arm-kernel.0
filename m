From: rric@kernel.org (Robert Richter)
Date: Tue, 9 Sep 2014 11:12:01 +0200
Subject: [PATCH] GICv3: Fixing 32 bit compatibility
In-Reply-To: <20140909080042.GO23009@pengutronix.de>
References: <1410185480-5153-1-git-send-email-rric@kernel.org>
 <20140909080042.GO23009@pengutronix.de>
Message-ID: <20140909091201.GA4527@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.09.14 10:00:42, Uwe Kleine-K?nig wrote:
> On Mon, Sep 08, 2014 at 04:11:19PM +0200, Robert Richter wrote:

> > @@ -479,7 +479,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >     smp_wmb();
> >  
> >     for_each_cpu_mask(cpu, *mask) {
> > -           u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
> > +           u64 cluster_id = cpu_logical_map(cpu) & ~0xffULL;
> This doesn't change anything, does it?

It does, not in 64 bit but in 32 bit there unsigned long is 32
bit. So, bit masks are broken if you compile a 32 bit kernel.

> I wonder if it would be cleaner to use (u64)0xff here.

No, that's ULL for. This is commonly used in x86 too.

-Robert
