From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Jul 2018 08:46:21 +0200
Subject: [RFC PATCH] arm64: mm: Export __sync_icache_dcache() for
 xen-privcmd
In-Reply-To: <20180727132243.GA28549@arm.com>
References: <20180711231822.GG14131@decadent.org.uk>
 <20180727120633.bjpfqswuxcy2ibqu@armageddon.cambridge.arm.com>
 <20180727132243.GA28549@arm.com>
Message-ID: <CAMuHMdVZHiqi9Wex05v6fLcndfN7oDuJK3ft7O=itEM4DwfP2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 3:23 PM Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Jul 27, 2018 at 01:06:33PM +0100, Catalin Marinas wrote:
> > On Thu, Jul 12, 2018 at 12:18:22AM +0100, Ben Hutchings wrote:
> > > The xen-privcmd driver, which can be modular, calls set_pte_at()
> > > which in turn may call __sync_icache_dcache().
> > >
> > > The call to __sync_icache_dcache() may be optimised out because it is
> > > conditional on !pte_special(), and xen-privcmd calls pte_mkspecial().
> > > But it seems unwise to rely on this optimisation.
> > >
> > > Fixes: 3ad0876554ca ("xen/privcmd: add IOCTL_PRIVCMD_MMAP_RESOURCE")
> > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > ---
> > > This is an RFC since I haven't found an actual build failure.  Using
> > > Debian's gcc 7.3 with either CC_OPTIMIZE_FOR_PERFORMANCE or
> > > CC_OPTIMIZE_FOR_SIZE, the call *is* optimised away.
> >
> > Since apply_to_page_range() is EXPORT_SYMBOL_GPL() and a
> > pte_fn_t function would likely use set_pte_at(), I'm fine with this
> > patch for consistency.
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Okey doke, I'll pick this up for 4.19.

Note that this is a build regression in v4.18-rc4 and later:
http://kisskb.ellerman.id.au/kisskb/buildresult/13450058/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
