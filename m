From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 20 Mar 2017 19:09:11 +0000
Subject: [PATCH 1/2] arm: Fix cache inconsistency when using fixmap
In-Reply-To: <CAKv+Gu8hLcfT6t90qbMT2qxzTMoJHiPxaCvHirQEVmKjYDvqBw@mail.gmail.com>
References: <20170316132958.22227-1-tixy@linaro.org>
 <20170317115321.GB21222@n2100.armlinux.org.uk>
 <1489767002.3063.10.camel@linaro.org>
 <CAKv+Gu8hLcfT6t90qbMT2qxzTMoJHiPxaCvHirQEVmKjYDvqBw@mail.gmail.com>
Message-ID: <1490036951.2945.8.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-03-17 at 16:18 +0000, Ard Biesheuvel wrote:
> On 17 March 2017 at 16:10, Jon Medhurst (Tixy) <tixy@linaro.org> wrote:
> > 
[...]
> > It looks to me that build_mem_type_table doesn't have much in the way of
> > dependencies so can probably be just called earlier. So, is the correct
> > solution to
> > 
> > a) call build_mem_type_table from setup_arch before early_fixmap_init
> > b) move call to build_mem_type_table into early_fixmap_init
> > c) call build_mem_type_table from early_fixmap_init as well as
> > paging_init and have a test in build_mem_type_table so it only exectutes
> > once
> > d) something else
> > 
> > a) seems simplest, b) seems wrong, c) seems over the top
> > 
> > Anyway, below is an alternative to $subject patch that works for my
> > kprobes test cases. Note, the removal of FIXMAP_PAGE_{NORMAL,RO} means
> > the generic fixmap code will define these from PAGE_KERNEL{,_RO}.
> > 
> > Not knowing how early fixmap is used, I hope Stefan and/or Ard have
> > testcases they could run.
> > 
> 
> The early UEFI boot code maps firmware tables using early_ioremap(),
> which is layered on top of early_fixmap(). This code executes after
> early_ioremap_init(), so moving build_mem_type_table() before that
> sounds like the obvious fix to me. The other use case is earlycon,
> which uses early_fixmap() directly, but afaict, the same applies there
> as well.

So is that 'code should work, no need to test'? Guess it should be safe
to skip if those use cases use FIXMAP_PAGE_NOCACHE and FIXMAP_PAGE_IO
and we don't change those defines.

> In terms of code changes, there is a d) option where the call sequence
> build_mem_type/early_fixmap_init/early_ioremap_init is grouped into a
> new function in mm/mmu.c, which you can call from setup_arch(). That
> would be the cleanest approach imo.

Any suggestion on a name for that function?

> 
> > I'm also wondering if the existing definition of FIXMAP_PAGE_IO is
> > correc
> > t and should not also be based on some platform specific value
> > calculated
> >  in build_mem_type_table?

Answering myself.?FIXMAP_PAGE_IO is defined with the same values as 
mem_types[MT_DEVICE].prot_pte which doesn't get modified at runtime, so
should be correct... Unless the device being mapped needs Non-shareable
Device memory (MT_DEVICE_NONSHARED) in which case we're onto dodgy
ground. I can't see how we can detect that in code or help someone using
the API to avoid that. I certainly don't intend trying to redesign the
API and implementation of early_ioremap to fix these limitations.

-- 
Tixy
