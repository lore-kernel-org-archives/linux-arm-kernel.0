From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Nov 2010 13:38:23 +0000
Subject: [PATCH v2 11/20] ARM: LPAE: Add fault handling support
In-Reply-To: <20101122133216.GI31227@n2100.arm.linux.org.uk>
References: <1289584840-18097-1-git-send-email-catalin.marinas@arm.com>
	<1289584840-18097-12-git-send-email-catalin.marinas@arm.com>
	<20101122131546.GG31227@n2100.arm.linux.org.uk>
	<1290431967.29754.11.camel@e102109-lin.cambridge.arm.com>
	<20101122133216.GI31227@n2100.arm.linux.org.uk>
Message-ID: <1290433103.29754.21.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-22 at 13:32 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 22, 2010 at 01:19:27PM +0000, Catalin Marinas wrote:
> > On Mon, 2010-11-22 at 13:15 +0000, Russell King - ARM Linux wrote:
> > > On Fri, Nov 12, 2010 at 06:00:31PM +0000, Catalin Marinas wrote:
> > > > @@ -108,7 +113,9 @@ void show_pte(struct mm_struct *mm, unsigned long addr)
> > > >
> > > >               pte = pte_offset_map(pmd, addr);
> > > >               printk(", *pte=%08lx", pte_val(*pte));
> > > > +#ifndef CONFIG_ARM_LPAE
> > > >               printk(", *ppte=%08lx", pte_val(pte[-LINUX_PTE_OFFSET]));
> > > > +#endif
> > >
> > > This is an unrelated change - should it be in a different patch?
> >
> > It was intended to be in this patch as I couldn't find a better place.
> > This patch sorts out the fault handling (and error reporting) for LPAE
> > and we don't need the additional printk here.
> 
> It doesn't sort the fault error reporting actually.  With pte_val()
> returning u64 constants on LPAE, all the above printk's using %08lx will
> issue warnings.
> 
> Also, as one of your previous patches changed the non-LPAE stuff to use
> u32, which is 'unsigned int', %08lx is wrong for them too, and will cause
> the compiler to spit out warnings.

This has been fixed in a subsequent version of the series with the
conversion to %08llx and long long.

> I can only assume this patch hasn't been build-tested, or maybe it has
> but the warnings ignored?

Probably the latter. I run the resulting kernels both on VE (with A9)
and a model supporting A15.

-- 
Catalin
