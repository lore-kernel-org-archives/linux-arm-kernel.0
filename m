From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 May 2011 13:16:26 +0100
Subject: [PATCH] ARM: sparsemem: allow pfn_valid to be overridden when
	using SPARSEMEM
In-Reply-To: <20110519092333.GU5279@suse.de>
References: <1305734639-6561-1-git-send-email-will.deacon@arm.com>
	<20110518165910.GS5279@suse.de>
	<1305795317.29560.9.camel@e102144-lin.cambridge.arm.com>
	<20110519092333.GU5279@suse.de>
Message-ID: <1305807386.763.4.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-19 at 10:23 +0100, Mel Gorman wrote:
> > > If this problem is exclusive to
> > > reading /proc/pagetypeinfo, you might want to consider only using
> > > memblock_is_memory in that case. Otherwise, functionally it looks like
> > > it should work.
> >
> > I initially thought it was exclusive to that operation, but it turns out
> > the problem is more far-reaching as pfn_valid is used by things like the
> > ioremap code to ensure that we don't remap normal memory.
> >
> 
> That would justify it. Might want to stick that into the changelog
> because we'll forget it and someone will "fix" it :)

Good thinking, the last thing we want is having this optimised away!
I've added a statement mentioning ioremap.

> > > > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > > > index e56f835..72225dd 100644
> > > > --- a/include/linux/mmzone.h
> > > > +++ b/include/linux/mmzone.h
> > > > @@ -1053,12 +1053,14 @@ static inline struct mem_section *__pfn_to_section(unsigned long pfn)
> > > >       return __nr_to_section(pfn_to_section_nr(pfn));
> > > >  }
> > > >
> > > > +#ifndef CONFIG_ARCH_PROVIDES_PFN_VALID
> > > >  static inline int pfn_valid(unsigned long pfn)
> > > >  {
> > > >       if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
> > > >               return 0;
> > > >       return valid_section(__nr_to_section(pfn_to_section_nr(pfn)));
> > > >  }
> > > > +#endif
> > > >
> > > >  static inline int pfn_present(unsigned long pfn)
> > > >  {
> >
> > Can I add your Ack for the changes to mmzone.h please?
> >
> 
> Minor nit on the name but it'd be nice if it was simile to
> CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID as they are both related to the
> memory model. Whether you do it or not in a v2, I'll ack the mmzone.h
> change;

Sure, I didn't notice the other CONFIG option.
CONFIG_HAVE_ARCH_PFN_VALID it is.

> Acked-by: Mel Gorman <mgorman@suse.de>

Cracking, thanks for that. I won't bother with a v2 as the changes are
trivial and I plan to merge this via Russell anyway.

Will
