From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Dec 2015 11:01:35 +0000
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon> <5666D28C.4090305@linaro.org>
 <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
 <20151208140720.GA2395@red-moon>
 <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
 <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
Message-ID: <20151210110135.GC21134@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Boris, as he might know how this works]

On Thu, Dec 10, 2015 at 10:02:39AM +0800, Fu Wei wrote:
> On 9 December 2015 at 11:25, Fu Wei <fu.wei@linaro.org> wrote:
> > On 8 December 2015 at 22:07, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> >> Side note: I wonder if there is a way to make the TLB flushing API common
> >> across architectures therefore avoiding this arch_apei_flush_tlb* churn.
> >
> > yes, make sense, I will think about this today , thanks for your suggestion.
> 
> I do some investigation on this "tlb" problem(actually not just tlb,
> but also "get_mem_attribute") today,
> I think we need to
> (1)have a common API in tlbflush.h (at least for flushing one page)
> across architectures(at least in x86 and arm64)

It's not about flushing one page, flush_tlb_kernel_range (which is called
by unmap_kernel_range) already takes care of that. The problem is that
the unmap is called from irq/nmi context, so the IPIs required for
broadcasting the TLB maintenance on x86 cannot be safely executed.

So, if you're going to introduce anything in the way of TLB API, then it
should be a generic form of the local_flush_tlb_* functions that we already
have on ARM, imo. That sounds like a lot of work for this one problem.

You could call flush_tlb_page with a fake vma/mm, but it's pretty ugly.

> (2)use this API in drivers/acpi/apei/gest.c instead of arch_apei_flush_tlb_one
> (3)delete the old function from arm64 and x86

Ideally, I think the ghes code would just use unmap_kernel_range unless
the architecture specifically says that doesn't work in irq context. In
that case, we don't need to implement the arch_apei_flush_tlb_one callback
on arm64.

One thing I don't fully grok about the code: since the page is mapped
using ioremap_page_range, doesn't that allow other CPUs to speculatively
fill their TLB with entries corresponding to the page mapped by the IRQ
handler on another core? If the core with the speculative entries then
takes an APEI exception, what guarantees do we have that it's looking at
the right page? I think, for x86, we need a local invalidation on map,
too.

Will
