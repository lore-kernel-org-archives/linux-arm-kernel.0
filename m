From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 10 Mar 2016 07:50:56 +0000
Subject: [PATCH] arm64: kasan: Use actual memory node when populating the
 kernel image shadow
In-Reply-To: <CAKv+Gu_sJ5N9DinfVWC5k1dbuX_=3w97u8FGnK2w_JtRrF4JDA@mail.gmail.com>
References: <1457636243-17382-1-git-send-email-catalin.marinas@arm.com>
 <CAKv+Gu_sJ5N9DinfVWC5k1dbuX_=3w97u8FGnK2w_JtRrF4JDA@mail.gmail.com>
Message-ID: <20160310075054.GA29979@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 09:31:02AM +0700, Ard Biesheuvel wrote:
> On 11 March 2016 at 01:57, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > With the 16KB or 64KB page configurations, the generic
> > vmemmap_populate() implementation warns on potential offnode
> > page_structs via vmemmap_verify() because the arm64 kasan_init() passes
> > NUMA_NO_NODE instead of the actual node for the kernel image memory.
> >
> > Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: James Morse <james.morse@arm.com>
> 
> I still think using vmemmap_populate() is somewhat of a hack here, and
> the fact that we have different versions for 4k pages and !4k pages,
> while perhaps justified for the actual real purpose of allocating
> struct page arrays, makes this code more fragile than it needs to be.

One of the things I had hoped to look into was having a common p?d block
mapping aware vmemmap_populate that we could use in all cases, so we could
minimise TLB pressure for vmemmap regardless of SWAPPER_USES_SECTION_MAPS (when
we can allocate sufficiently aligned physical memory).

[...]

> Regardless,
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Likewise:

Acked-by: Mark Rutland <mark.rutland@arm.com>

> 
> > ---
> >  arch/arm64/mm/kasan_init.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> > index 56e19d150c21..a164183f3481 100644
> > --- a/arch/arm64/mm/kasan_init.c
> > +++ b/arch/arm64/mm/kasan_init.c
> > @@ -152,7 +152,8 @@ void __init kasan_init(void)
> >
> >         clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
> >
> > -       vmemmap_populate(kimg_shadow_start, kimg_shadow_end, NUMA_NO_NODE);
> > +       vmemmap_populate(kimg_shadow_start, kimg_shadow_end,
> > +                        pfn_to_nid(virt_to_pfn(_text)));
> >
> >         /*
> >          * vmemmap_populate() has populated the shadow region that covers the
> 
