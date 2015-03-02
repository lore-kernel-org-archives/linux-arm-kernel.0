From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Mar 2015 15:09:28 +0000
Subject: [RFC PATCH] arm64: use fixmap region for permanent FDT mapping
In-Reply-To: <CAKv+Gu8TkDRfYmf+V==m7EJyVGC-ZiCSnTtvmHtHgQtbJJo5Sw@mail.gmail.com>
References: <1425048823-25206-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150302144036.GE16779@leverpostej>
 <CAKv+Gu8TkDRfYmf+V==m7EJyVGC-ZiCSnTtvmHtHgQtbJJo5Sw@mail.gmail.com>
Message-ID: <20150302150928.GH16779@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 02:47:41PM +0000, Ard Biesheuvel wrote:
> On 2 March 2015 at 14:40, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Fri, Feb 27, 2015 at 02:53:43PM +0000, Ard Biesheuvel wrote:
> >> Currently, the FDT blob needs to be in the same naturally aligned
> >> 512 MB region as the kernel, so that it can be mapped into the
> >> kernel virtual memory space very early on using a minimal set of
> >> statically allocated translation tables.
> >>
> >> Now that we have early fixmap support, we can relax this restriction,
> >> by moving the permanent FDT mapping to the fixmap region instead.
> >> This way, the FDT blob may be anywhere in memory.
> >
> > Neat! I was hoping we'd have the chance to do this at some point.
> >
> > [...]
> >
> >> +     /*
> >> +      * Reserve 2 MB of virtual space for the FDT at the top of the fixmap
> >> +      * region. Keep this at the top so it remains 2 MB aligned.
> >> +      */
> >> +#define FIX_FDT_SIZE         SZ_2M
> >> +     FIX_FDT_END,
> >> +     FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
> >
> > Doesn't the presence of the FIX_HOLE entry mean that this isn't 2MB
> > aligned?
> >
> 
> Well, the fixmap is a bit odd in this respect: FIXADDR_TOP is
> exclusive, so FIX_HOLE is only there as a placeholder.

Ah, I see.

Given that, shouldn't the test in __set_fixmap be something like:

BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);

[...]

> > Otherwise this looks good!
> >
> 
> Actually, there is a bit of a snag:
> early_init_fdt_scan_reserved_mem() reserves the FDT region, but does
> so by using __pa() to retrieve the physical offset, which doesn't work
> now the FDT is not accessed through the linear mapping.

Ouch.

> I will try and figure out what the best way is to work around this.
> Any and all suggestions appreciated.

We can do the reservation in the arm64 code and move the core part
behind a config option, but that's somewhat ugly. Passing the PA into
early_init_fdt_scan_reserved_mem also feels weird.

I'll have a think too.

Mark.
