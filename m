From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Apr 2015 16:26:36 +0100
Subject: [PATCH v3 04/11] arm64: use fixmap region for permanent FDT
 mapping
In-Reply-To: <CAKv+Gu8AmPU0iPYHsvG6Lbyi+ho_DBD1PG+8sOLYkTiHjF-ZtQ@mail.gmail.com>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
 <1428674035-26603-5-git-send-email-ard.biesheuvel@linaro.org>
 <20150413150203.GF4076@leverpostej>
 <CAKv+Gu8AmPU0iPYHsvG6Lbyi+ho_DBD1PG+8sOLYkTiHjF-ZtQ@mail.gmail.com>
Message-ID: <20150413152636.GH4076@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >> +     /*
> >> +      * Before passing the dt_virt pointer to early_init_dt_scan(), we have
> >> +      * to ensure that the FDT size as reported in the FDT itself does not
> >> +      * exceed the window we just mapped for it.
> >> +      */
> >> +     if (!dt_virt ||
> >> +         fdt_check_header(dt_virt) != 0 ||
> >> +         (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > FIX_FDT_SIZE ||
> >> +         !early_init_dt_scan(dt_virt)) {
> >
> > Doesn't this allow a DTB > 2M (violating the boot protocol's 2M
> > restriction)?
> >
> 
> Yes it does, and I was wondering what to do about it. We could be
> pedantic, and fail here with no user visible feedback about what went
> wrong, or we could be lax here, and add a warning later (similar to
> the x1/x2/x3 check) that the boot protocol was violated if the FDT
> exceeds 2 MB but otherwise proceed normally.
> 
> > Perhaps we want a MAX_FDT_SIZE, and have FIX_FDT_SIZE be MAX_FDT_SIZE +
> > 2M. Then we can check that the DTB <= MAX_FDT_SIZE, and we know we will
> > always be able to map it.
> >
> > Otherwise we could get intermittent failures for DTBs larger than 2MB,
> > depending on where they're loaded. Always failing those for now would
> > give us a consistent early warning that we need to bump MAX_FDT_SIZE.
> >
> 
> Consistent, early, but emitted before we even have a console ...

When I say warning, I mean that boot will consistently fail, rather than
there being a pr_warn.

People seem to wait until their platform is hilariously broken before
reporting bugs...

> >> +void *__init fixmap_remap_fdt(phys_addr_t dt_phys)
> >> +{
> >> +     const u64 dt_virt_base = __fix_to_virt(FIX_FDT);
> >> +     phys_addr_t dt_phys_base = dt_phys & ~(SZ_2M - 1);
> >
> > Do we definitely retain the high bits here? I don't have the C integer
> > promotion rules paged into my head, but the definition in
> > include/linux/sizes.h makes me suspicious, given it should have an int
> > type:
> >
> > #define SZ_2M                           0x00200000
> >
> 
> I will use round_down() instead

Ok.

Mark.
