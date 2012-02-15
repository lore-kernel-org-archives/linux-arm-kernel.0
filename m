From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 14 Feb 2012 16:01:08 -0800
Subject: [PATCH] Optimize multi-CPU tlb flushing a little more
In-Reply-To: <20120214233400.GC29765@n2100.arm.linux.org.uk>
References: <20110823110602.GG19622@n2100.arm.linux.org.uk>
 <CAH+eYFC_mkdObV0NfN5Jtv0L6fM9e0YGOBghTEVSqf=TAFxdXw@mail.gmail.com>
 <20120213162359.GC25655@n2100.arm.linux.org.uk>
 <20120213165926.GA24426@debian>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6A1@HQMAIL01.nvidia.com>
 <20120214222354.GB29765@n2100.arm.linux.org.uk>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB6D7@HQMAIL01.nvidia.com>
 <74CDBE0F657A3D45AFBB94109FB122FF178FACB70B@HQMAIL01.nvidia.com>
 <20120214233400.GC29765@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178FACB726@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Tuesday, February 14, 2012 4:34 PM:
> On Tue, Feb 14, 2012 at 03:21:52PM -0800, Stephen Warren wrote:
> > Russell,
> >
> > One more query about the original patch; in the following chunk:
> >
> > @@ -491,15 +471,11 @@ static inline void clean_pmd_entry(void *pmd)
> >  {
> >         const unsigned int __tlb_flag = __cpu_tlb_flags;
> >
> > -       if (tlb_flag(TLB_DCLEAN))
> > -               asm("mcr        p15, 0, %0, c7, c10, 1  @ flush_pmd"
> > -                       : : "r" (pmd) : "cc");
> > -
> > -       if (tlb_flag(TLB_L2CLEAN_FR))
> > -               asm("mcr        p15, 1, %0, c15, c9, 1  @ L2 flush_pmd"
> > -                       : : "r" (pmd) : "cc");
> > +       tlb_op(TLB_DCLEAN, "c7, c10, 1  @ flush_pmd", pmd);
> > +       tlb_op(TLB_L2CLEAN_FR, "c15, c9, 1  @ L2 flush_pmd", pmd);
> >  }
> >
> > You'll notice that the second mcr instruction is passed "p15, 1, ...".
> > However, the replacement code in tlb_op() always passes "p15, 0, ..."
> > to mcr/mcrne. I assume this is a problem?
> >
> > The same thing applies to flush_pmd_entry() too.
> 
> Damn it.  Well spotted, yes this needs fixing.  Here's an updated patch.
> ...

That looks reasonable to me.

I didn't retest, since I didn't observe any problems due to this issue.

-- 
nvpublic
