From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 21 Nov 2014 12:42:30 -0500 (EST)
Subject: [PoC PATCH] arm: allow modules outside of bl range
In-Reply-To: <CAKv+Gu9a1EyD3k3zW4=+ahZopGfjy-QdLgd-3U2ORH0Tb+GGOA@mail.gmail.com>
References: <1416503299-17418-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.11.1411201359310.11690@knanqh.ubzr>
 <CAKv+Gu-3Uq0p2u3R=s5U9dHQgWMrJhbS5aytz8jdVEC6JscKvA@mail.gmail.com>
 <CAKv+Gu9a1EyD3k3zW4=+ahZopGfjy-QdLgd-3U2ORH0Tb+GGOA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1411211235580.11690@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Nov 2014, Ard Biesheuvel wrote:

> On 21 November 2014 11:34, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 20 November 2014 20:14, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> >> On Thu, 20 Nov 2014, Ard Biesheuvel wrote:
> >>
> >>> Loading modules far away from the kernel in memory is problematic because
> >>> the 'bl' instruction only has limited reach, and modules are not built
> >>> with PLTs. Instead of using the -mlong-calls option (which affects *all*
> >>> emitted bl instructions), this patch allocates some additional space at
> >>> module load time, and populates it with PLT like entries when encountering
> >>> relocations that are out of reach.
> >>>
> >>> Note that this patch is a proof of concept, and thus removes the implementation
> >>> of module_alloc() so that all modules are relocated using PLT entries.
> >>> Ideally, we would switch into PLT mode and start using the vmalloc area only
> >>> after we have exhausted the ordinary module space.
> >>>
> >>> This should work with all relocation against symbols exported by the kernel,
> >>> including those resulting from GCC generated function calls for ftrace etc.
> >>>
> >>> This is largely based on the ia64 implementation.
> >>> Thumb-2 kernels currently unsupported.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>
> >> Looks on the right track to me.
> >>
> >> BTW it might be necessary to use PLT mode even from the primary module
> >> area if e.g. the kernel gets too big to be reachable (we've seen that
> >> already), or a module from the primary area wants to branch to a symbol
> >> located in a larger module that ended up in the vmalloc area.  So you
> >
> > Indeed.
> >
> >> might need to estimate the worst case for the number of PLTs and end up
> >> not using all of them or even none at all. Would be good to free the
> >> unused pages in that case (only for the non init section obviously).
> >> Looks like the module_finalize() hook might be used for that.
> >>
> >
> > This code already establishes an upper bound for the number of
> > required PLT entries, but allocates the memory unconditionally, which
> > is indeed somewhat of a waste as 'no PLT entries' is obviously the
> > general case as long as the primary module area has not been
> > exhausted.
> >
> > I can easily round up the core PLT section to PAGE_SIZE size and
> > alignment, but I haven't figured out how to punch a hole into an area
> > returned by vmalloc(), and it is desirable to have the PLT region and
> > the module region itself be part of the same allocation to begin with,
> > or the PLT region may end up out of range itself, which kind of
> > defeats the purpose. Or perhaps, some way to at least release the
> > physical pages while retaining the single vmap_area.
> >
> 
> It turns out, looking at the actual numbers (random sample of 46
> modules), that the typical size overhead of the core PLT is about 5%,
> and rarely results in the number of needed pages to increase.

That's what I was thinking too.  If for example a single extra page is 
allocated, that means 4096/8 = 512 unique symbols that can be redirected 
through it.  That's a _lot_ of external symbols for a module.  So maybe 
we shouldn't bother too much.


Nicolas
