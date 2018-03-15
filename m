From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 15 Mar 2018 11:14:11 +0100
Subject: [PATCH] Revert "mm/page_alloc: fix memmap_init_zone pageblock
 alignment"
In-Reply-To: <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
References: <20180314134431.13241-1-ard.biesheuvel@linaro.org>
 <20180314141323.GD23100@dhcp22.suse.cz>
 <CAKv+Gu9hrZnX6pmiCaT=S30KQ11tY4kv=qvdSPPZ2nYDC7P7eQ@mail.gmail.com>
 <20180314145450.GI23100@dhcp22.suse.cz>
 <CAKv+Gu8qguR0tFWZxecQDTPS3_Eyt_E6_YA1ivyAAqNuaaR9-g@mail.gmail.com>
Message-ID: <20180315101411.GA23100@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 14-03-18 15:54:16, Ard Biesheuvel wrote:
> On 14 March 2018 at 14:54, Michal Hocko <mhocko@kernel.org> wrote:
> > On Wed 14-03-18 14:35:12, Ard Biesheuvel wrote:
> >> On 14 March 2018 at 14:13, Michal Hocko <mhocko@kernel.org> wrote:
> >> > Does http://lkml.kernel.org/r/20180313224240.25295-1-neelx at redhat.com
> >> > fix your issue? From the debugging info you provided it should because
> >> > the patch prevents jumping backwards.
> >> >
> >>
> >> The patch does fix the boot hang.
> >>
> >> But I am concerned that we are papering over a fundamental flaw in
> >> memblock_next_valid_pfn().
> >
> > It seems that memblock_next_valid_pfn is doing the right thing here. It
> > is the alignment which moves the pfn back AFAICS. I am not really
> > impressed about the original patch either, to be completely honest.
> > It just looks awfully tricky. I still didn't manage to wrap my head
> > around the original issue though so I do not have much better ideas to
> > be honest.
> 
> So first of all, memblock_next_valid_pfn() never refers to its max_pfn
> argument, which is odd nut easily fixed.

There is a patch to remove that parameter sitting in the mmotm tree.

> Then, the whole idea of substracting one so that the pfn++ will
> produce the expected value is rather hacky,

Absolutely agreed!

> But the real problem is that rounding down pfn for the next iteration
> is dodgy, because early_pfn_valid() isn't guaranteed to return true
> for the rounded down value. I know it is probably fine in reality, but
> dodgy as hell.

Yes, that is what I meant when saying I was not impressed... I am always
nervous when a loop makes jumps back and forth. I _think_ the main
problem here is that we try to initialize a partial pageblock even
though a part of it is invalid. We should simply ignore struct pages
for those pfns. We don't do that and that is mostly because of the
disconnect between what the page allocator and early init code refers to
as a unit of memory to care about. I do not remember exactly why but I
strongly suspect this is mostly a performance optimization on the page
allocator side so that we do not have to check each and every pfn. Maybe
we should signal partial pageblocks from an early code and drop the
optimization in the page allocator init code.

> The same applies to the call to early_pfn_in_nid() btw

Why?
-- 
Michal Hocko
SUSE Labs
