From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 Jan 2015 10:58:41 +0000
Subject: [PATCH v2 1/2] arm64: don't make early_*map() calls post
 paging_init()
In-Reply-To: <1420576522.16211.30.camel@t520.localdomain>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
 <1420551673-31416-2-git-send-email-leif.lindholm@linaro.org>
 <1420576522.16211.30.camel@t520.localdomain>
Message-ID: <20150107105841.GE7485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 08:35:22PM +0000, Mark Salter wrote:
> On Tue, 2015-01-06 at 13:41 +0000, Leif Lindholm wrote:
> > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > index 6fac253..e311066 100644
> > --- a/arch/arm64/kernel/efi.c
> > +++ b/arch/arm64/kernel/efi.c
> > @@ -313,17 +313,26 @@ void __init efi_init(void)
> >  	memmap.desc_size = params.desc_size;
> >  	memmap.desc_version = params.desc_ver;
> >  
> > -	if (uefi_init() < 0)
> > -		return;
> > +	if (uefi_init() >= 0)
> > +		reserve_regions();
> >  
> > -	reserve_regions();
> > +	early_memunmap(memmap.map, params.mmap_size);
> >  }
> >  
> > -void __init efi_idmap_init(void)
> > +void __init efi_memmap_init(void)
> >  {
> > +	u64 mapsize;
> > +
> >  	if (!efi_enabled(EFI_BOOT))
> >  		return;
> >  
> > +	/* replace early memmap mapping with permanent mapping */
> > +	mapsize = memmap.map_end - memmap.map;
> > +	memmap.map = (__force void *)ioremap_cache((phys_addr_t)memmap.phys_map,
> > +						   mapsize);
> 
> ioremap_cache() could potententially fail here if the phys_map address
> doesn't have a valid pfn (not in the kernel linear ram mapping) because
> some of the underlying vm support hasn't been initialized yet.

Can you be more specific about the case you have in mind, please? pfn_valid
uses the memblocks on arm64, and that should all have been sorted out in
paging_init(). What's the issue that you're anticipating?

Will
