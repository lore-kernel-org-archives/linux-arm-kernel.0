From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Nov 2015 17:21:48 +0000
Subject: [RFC PATCH] arm64: use non-global mappings for UEFI runtime
 regions
In-Reply-To: <CAKv+Gu-L+YKonkzE2fyH9AzXcBERjMREMrHRXFu=xy2f+4gwpw@mail.gmail.com>
References: <1447750411-6424-1-git-send-email-ard.biesheuvel@linaro.org>
 <20151117170816.GI30101@arm.com>
 <CAKv+Gu-L+YKonkzE2fyH9AzXcBERjMREMrHRXFu=xy2f+4gwpw@mail.gmail.com>
Message-ID: <20151117172107.GK30101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 06:11:56PM +0100, Ard Biesheuvel wrote:
> On 17 November 2015 at 18:08, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Nov 17, 2015 at 09:53:31AM +0100, Ard Biesheuvel wrote:
> >> As pointed out by Russell King in response to the proposed ARM version
> >> of this code, the sequence to switch between the UEFI runtime mapping
> >> and current's actual userland mapping (and vice versa) is potentially
> >> unsafe, since it leaves a time window between the switch to the new
> >> page tables and the TLB flush where speculative accesses may hit on
> >> stale global TLB entries.
> >>
> >> So instead, use non-global mappings, and perform the switch via the
> >> ordinary ASID-aware context switch routines.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  arch/arm64/include/asm/mmu_context.h |  2 +-
> >>  arch/arm64/kernel/efi.c              | 14 +++++---------
> >>  2 files changed, 6 insertions(+), 10 deletions(-)
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> >
> > Please do *not* tag this for stable! ;)
> >
> 
> OK, thanks for clarifying.
> 
> So for stable, should we keep the global mappings and do something
> like this instead?
> 
> """
>        cpu_set_reserved_ttbr0();
> 
>        local_flush_tlb_all();
>        if (icache_is_aivivt())
>                __local_flush_icache_all();
> 
>        if (mm != &init_mm)
>                cpu_switch_mm(mm->pgd, mm);
> """

That looks good to me, but I think we'd want to give it a good testing
given that we're solving a problem that has been spotted by code inspection
as opposed to real failures on hardware. There's even an argument that
it's not worth doing anything for -stable.

Will
