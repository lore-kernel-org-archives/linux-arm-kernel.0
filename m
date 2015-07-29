From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 29 Jul 2015 13:36:53 +0100
Subject: bug in identity map for 4KB pages?
In-Reply-To: <20150729123002.GH4797@arm.com>
References: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
 <20150729114258.GK15213@leverpostej>
 <CAKv+Gu-0NO5QnK34iXEK2_ATgsSYLMUwiq7u_=iPv5UrNba4kQ@mail.gmail.com>
 <CAKv+Gu8uOO52xt+VX7YR5YHCN-Tan7mBRpR-xCJD33eE=vJcSA@mail.gmail.com>
 <20150729123002.GH4797@arm.com>
Message-ID: <20150729123653.GN15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 01:30:02PM +0100, Will Deacon wrote:
> On Wed, Jul 29, 2015 at 12:58:07PM +0100, Ard Biesheuvel wrote:
> > On 29 July 2015 at 13:49, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > > Wouldn't something like this make more sense?
> > >
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > index 597831bdddf3..64480b65ef17 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -158,6 +158,15 @@ early_param("mem", early_mem);
> > >
> > >  void __init arm64_memblock_init(void)
> > >  {
> > > +       /*
> > > +        * Remove the memory that we will not be able to cover
> > > +        * with the linear mapping.
> > > +        */
> > > +       const s64 linear_region_size = -(s64)PAGE_OFFSET;
> > > +
> > > +       memblock_remove(0, memstart_addr);
> > > +       memblock_remove(memstart_addr + linear_region_size, ULLONG_MAX);
> > > +
> > >         memblock_enforce_memory_limit(memory_limit);
> > >
> > >         /*
> > > """
> > >
> > > (taken from my patch 'arm64: override early_init_dt_add_memory_arch()'
> > > sent to the list a while ago as part of the linear mapping decoupling
> > > series)
> > >
> > 
> > (replying to self) but actually, either solution still means that, of
> > the ~16 GB this platform seems to have installed, only 2 GB is made
> > available.
> > 
> > I suppose there is little we can do about it, since we cannot ignore
> > the lower 2GB if the kernel resides there ...
> 
> Printing a message to the console isn't a bad idea, though.

The logic in early_init_dt_add_memory_arch does that, provided the end
is set up correctly.

We already rely on that for warnings when memory below phys_offset is
cut out, which is why I wanted the logic there.

That said, my patch got the limit wrong, so I'll respin that.

Mark.
