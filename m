From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 19:03:36 +0000
Subject: [PATCH v2 1/2] arm64: don't make early_*map() calls post
 paging_init()
In-Reply-To: <20150107133109.GM3827@bivouac.eciton.net>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
 <1420551673-31416-2-git-send-email-leif.lindholm@linaro.org>
 <1420576522.16211.30.camel@t520.localdomain>
 <20150107105841.GE7485@arm.com>
 <CAKv+Gu9NRRFZG0S6oFJqPG1+1O2-SZah4wqoi0YPofL33X3nJw@mail.gmail.com>
 <20150107133109.GM3827@bivouac.eciton.net>
Message-ID: <20150107190335.GX7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 01:31:09PM +0000, Leif Lindholm wrote:
> On Wed, Jan 07, 2015 at 01:13:06PM +0000, Ard Biesheuvel wrote:
> > >> > -void __init efi_idmap_init(void)
> > >> > +void __init efi_memmap_init(void)
> > >> >  {
> > >> > +   u64 mapsize;
> > >> > +
> > >> >     if (!efi_enabled(EFI_BOOT))
> > >> >             return;
> > >> >
> > >> > +   /* replace early memmap mapping with permanent mapping */
> > >> > +   mapsize = memmap.map_end - memmap.map;
> > >> > +   memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
> > >> > +                                              mapsize);
> > >>
> > >> ioremap_cache() could potententially fail here if the phys_map address
> > >> doesn't have a valid pfn (not in the kernel linear ram mapping) because
> > >> some of the underlying vm support hasn't been initialized yet.
> > >
> > > Can you be more specific about the case you have in mind, please? pfn_valid
> > > uses the memblocks on arm64, and that should all have been sorted out in
> > > paging_init(). What's the issue that you're anticipating?
> > 
> > I think Mark's concern is that it is too early to call
> > __get_free_page(), which is what happens if ioremap_cache() finds that
> > the requested address is not covered by the existing linear mapping.
> > Currently, UEFI reserved RAM regions are covered by the linear
> > mapping, but that is something we intend to change in the future.
> 
> Which shouldn't be a problem, right? Since this function will be going
> away with your "stable mappings" set, and the remap call bumped down
> to an early initcall in arm64_enter_virtual_mode() (or potential
> future name for that function).

Sounds reasonable to me... Ard?

However, I'd certainly like something in the commit log and/or a comment
in the code with our reasoning.

Will
