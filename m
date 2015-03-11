From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Mar 2015 11:56:10 +0000
Subject: [PATCH 2/5] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAKv+Gu-=azueQfe29qhCGCe5f4dL9srOSdiAooUpsZHAgAWz0A@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <1425380630-3684-3-git-send-email-ard.biesheuvel@linaro.org>
 <20150311104342.GB4114@leverpostej>
 <CAKv+Gu-=azueQfe29qhCGCe5f4dL9srOSdiAooUpsZHAgAWz0A@mail.gmail.com>
Message-ID: <20150311115610.GE4114@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>  static void __init setup_machine_fdt(phys_addr_t dt_phys)
> >>  {
> >> -     if (!dt_phys || !early_init_dt_scan(phys_to_virt(dt_phys))) {
> >> +     void *dt_virt = NULL;
> >> +
> >> +     if (dt_phys && (dt_phys & 7) == 0)
> >> +             dt_virt = fixmap_remap_fdt(dt_phys);
> >> +
> >
> > It might be worth checking that dt_phys is sufficiently far from the end
> > of a 2MB boundary that we can read the totalsize field below. Trivially
> > that means 8 bytes below, the header is 40 bytes, and any real DTB will
> > be larger than that.
> >
> 
> Y i kind of cheated by putting the alignment check first: this means
> the first 8 bytes will always be readable

Ah, good point. Given that it could possibly explode in the core DT
verification I guess it's not too big a deal either way.

> > It's a shame the arley DTB verification functions don't take a limit
> > parameter or we could prevent them from making potentially bad accesses.
> >
> >> +     /*
> >> +      * Before passing the dt_virt pointer to early_init_dt_scan(), we have
> >> +      * to ensure that the FDT size as reported in the FDT itself does not
> >> +      * exceed the 2 MB window we just mapped for it.
> >> +      */
> >> +     if (!dt_virt ||
> >> +         fdt_check_header(dt_virt) != 0 ||
> >> +         (dt_phys & (SZ_2M - 1)) + fdt_totalsize(dt_virt) > SZ_2M ||
> >> +         !early_init_dt_scan(dt_virt)) {
> >>               early_print("\n"
> >>                       "Error: invalid device tree blob at physical address 0x%p (virtual address 0x%p)\n"
> >> -                     "The dtb must be 8-byte aligned and passed in the first 512MB of memory\n"
> >> +                     "The dtb must be 8-byte aligned and must not cross a 2 MB alignment boundary\n"
> >>                       "\nPlease check your bootloader.\n",
> >> -                     dt_phys, phys_to_virt(dt_phys));
> >> +                     dt_phys, dt_virt);
> >
> > I'm surprised the toolchain doesn't scream about dt_phys being a
> > phys_addr_t rather than a pointer here, given that's alway been wrong. I
> > guess the early_print wrapper managed to hide that from us -- can we
> > nuke that and use pr_crit here?
> >
> 
> Sure, why not. Nobody is going to be able to read it anyway, I
> suppose, unless you are dumping __log_buf from gdb

I was under the mistaken impression you could get ouptut if you'd
hardcoded earlycon=whatever with CNFIG_CMDLINE, but obviously that's not
the case given we won't have called parse_early_param() yet.

I'd like to nuke early_print regardless.

Thanks.
Mark.
