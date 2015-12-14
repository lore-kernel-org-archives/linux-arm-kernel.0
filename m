From: bp@suse.de (Borislav Petkov)
Date: Mon, 14 Dec 2015 13:39:57 +0100
Subject: [PATCH v4] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <20151214114658.GE6992@arm.com>
References: <1449558183-12259-1-git-send-email-fu.wei@linaro.org>
 <20151208123433.GB404@red-moon> <5666D28C.4090305@linaro.org>
 <CADyBb7tByoke4PGZqcx_jHvgCK0xNTneod8WoVv7VmoSYii+hg@mail.gmail.com>
 <20151208140720.GA2395@red-moon>
 <CADyBb7sLAJdiC=2UzKFsHQ=+Tfuwd6FGi80O9H+1sj70qtCiPg@mail.gmail.com>
 <CADyBb7vVaPsNZeKp=XQ0zwd-qH1mwuECCtCfkpqm0jDyFTzDcg@mail.gmail.com>
 <20151210110135.GC21134@arm.com> <20151214112004.GB11630@pd.tnic>
 <20151214114658.GE6992@arm.com>
Message-ID: <20151214123957.GF11630@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 11:46:59AM +0000, Will Deacon wrote:
> We're in violent agreement. I'm just saying that's *why*
> arch_apei_flush_tlb_one exists, as opposed to calling unmap_kernel_range
> in the driver (which will attempt IPIs). On arm64, unmap_kernel_range
> will actually work correctly, since we don't need IPIs to broadcast TLB
> maintenance.
> 
> The (incorrect) premise earlier in the thread was that
> arch_apei_flush_tlb_one exists because there's no portable API for
> flushing a single page, but that's simply not true.

Right.

> Yikes, I'd not even thought about that. Perhaps its all serialised
> somehow, but I have no idea.

Yeah, didn't see any serialization there...

> Right, imagine the following sequence of events:
> 
>  1. CPU x takes a GHES IRQ
>  2. CPU x then maps the buffer a page at a time in ghes_copy_tofrom_phys.
>     After each unmap, it performs a local TLBI. Let's say that it has
>     the final page of the buffer mapped when...
>  3. ... CPU y is meanwhile happily executing some other kernel code.
>  4. CPU y's page table walker speculatively fills the TLB with a translation
>     for the last buffer page that CPU x has mapped (because its just been
>     mapped with ioremap_page_range and is in the kernel page table).
>  5. CPU x unmaps the last page, performs a *local* TLBI, handles the
>     event and returns from the exception
>  6. CPU y takes a GHES IRQ
>  7. CPU y then maps the first buffer page at the same virtual address
>     that CPU x used to map the last buffer page
>  8. CPU y accesses the page, hits the stale TLB entry and gets junk
> 
> which I think means you need to perform local TLB invalidation on map
> as well as unmap.
> 
> Is there some reason this can't happen on x86? It sounds plausible on
> arm64 if we were to use local invalidation.

Ha, thanks for the detailed example, I see it now!

And I too don't see a reason why that can't happen. And the GHES
IRQ is a GSI, which has "global" in the name but I don't think that
means it interrupts the whole system like an NMI does. Especially
if it is registered/handled like a normal irq: acpi_gsi_to_irq() ..
request_irq()...

Adding Tony.

If anything, we probably should be doing something with irq_work at the
end of ghes_copy_tofrom_phys() so that the invalidation of any possible
speculative mappings happens before we return from the GHES IRQ.

Hmm, currently I'm not even clear whether this'll work: we would
theoretically need to send IPIs from IRQ context, at the end of the GHES
IRQ...

Thanks.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
