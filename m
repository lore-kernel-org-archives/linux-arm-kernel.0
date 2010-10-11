From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Oct 2010 12:23:07 +0100
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101007192245.GC26435@n2100.arm.linux.org.uk>
	<AANLkTikQKY7pOobD+==uT5Cy0poT=O5wDMKtbVyJVNbO@mail.gmail.com>
	<20101008175308.GA10975@n2100.arm.linux.org.uk>
	<AANLkTi=ERZjVDS=Q7aw1zA23KF68irUP3vvKLZw5meBU@mail.gmail.com>
	<20101008230451.GB10975@n2100.arm.linux.org.uk>
	<20101008232539.GA28697@kroah.com>
	<20101008234448.GD10975@n2100.arm.linux.org.uk>
	<20101009000046.GA30616@kroah.com>
	<20101009002546.GB14675@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010082210150.3107@xanadu.home>
	<1286791544.19739.31.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinMuKDpbL9ka61QhUFJfze_HWWHxjUbAqbz2_vi@mail.gmail.com>
Message-ID: <1286796187.19739.52.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-10-11 at 11:39 +0100, Felipe Contreras wrote:
> On Mon, Oct 11, 2010 at 1:05 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > We could be a bit more flexible as a temporary solution. But that's a
> > hack and doesn't guarantee the attributes that the driver requested. If
> > the driver would use writel/readl, that's not too bad since we pushed
> > explicit barriers in these macros.
> >
> > It would need to be improved to invalidate the corresponding cache lines
> > (using the DMA API?) but it would look even worse.
> >
> >
> > diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> > index 6bdf42c..082bbd0 100644
> > --- a/arch/arm/mm/ioremap.c
> > +++ b/arch/arm/mm/ioremap.c
> > @@ -204,10 +204,13 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
> >  #endif
> >
> >        /*
> > -        * Don't allow RAM to be mapped - this causes problems with ARMv6+
> > +        * Don't allow RAM to be mapped as Device memory - this causes
> > +        * problems with ARMv6+
> >         */
> >        if (WARN_ON(pfn_valid(pfn)))
> > -               return NULL;
> > +               if (__LINUX_ARM_ARCH__ >= 6 &&
> > +                   (mtype != MT_DEVICE_CACHED || mtype != MT_DEVICE_WC))
> > +                       mtype = MT_DEVICE_WC;
> >
> >        type = get_mem_type(mtype);
> >        if (!type)
> 
> I will try that, but from what I can see this might still break some
> drivers, right? 

Probably, it depends on how drivers use the memory returned by ioremap
and the assumptions they make about the memory type (strict ordering,
write buffers, speculation). I think such memory should be used via the
I/O accessors and not directly, so you get the benefit of explicit
memory barriers. If not, you have to cope with the loss of attributes
because of the WC mapping.

But as it has been said (and it's my opinion as well), the drivers are
broken and are misusing the ioremap API.

> Anyway, I'm reading the TRM and I can't find any mention of this.
> Catalin, can you point out where is this mentioned, and also, can you
> confirm if this would affect only the memory that has the double
> mapping, or it can corrupt other memory as well?

That's in the ARM ARM (Architecture Reference Manual), not a TRM.

You never know what "unpredictable" means and this is specific to the
processor implementation, not the ARM ARM. You should not mix different
memory types for the same page.

Back in 2006 there was a discussion for a set of palliative measures in
hardware (initially until the OSes are fixed) and these allow the same
memory type but with different cacheability attributes (e.g. Normal
Non-cacheable vs Normal Cacheable) given that care is taken in software
wrt stale cache lines and speculation (but at least you don't get random
corruption somewhere else). They would need to have the same
shareability attributes though.

With the hack above, MT_DEVICE_WC is actually Normal Non-cacheable
memory. It needs cache flushing but it's not worse than the original
ioremap allowing this. The driver may not work as expected though.

-- 
Catalin
