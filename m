From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 4 Jul 2011 11:43:29 +0100
Subject: Unnecessary cache-line flush on page table updates ?
In-Reply-To: <20110704100221.GB8286@n2100.arm.linux.org.uk>
References: <BANLkTin7aJXjpEH_WzJi5zaAtH8kFcTZeg@mail.gmail.com>
	<20110701101019.GA1723@e102109-lin.cambridge.arm.com>
	<BANLkTi=KVnzBKcd83c9T3P20VAv-ggqR4g@mail.gmail.com>
	<20110704094531.GB19117@e102109-lin.cambridge.arm.com>
	<20110704100221.GB8286@n2100.arm.linux.org.uk>
Message-ID: <20110704104329.GD19117@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 11:02:21AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 04, 2011 at 10:45:32AM +0100, Catalin Marinas wrote:
> > Given these results, I think it's worth merging the patch. Can I add
> > your Tested-by?
> 
> If we're going to make this change to use the coherent information,
> let's address all the places in one go, which are:
> 
>         clean_pmd_entry
>         flush_pmd_entry
>         clean_pte_table
> 
> These require a little more thought as we aren't guaranteed to have
> ID_MMFR3 in place - maybe they should be callbacks into the per-CPU
> code.

For the first two, can we not clear the TLB_DCLEAN bit in
__cpu_tlb_flags (only a single check at boot time?).

For the last one, we could add a tlb_flags() check.

> It would also be a good idea to change the comment from "flush_pte"
> to "Clean data cache to PoU".

OK.

> > I think there can be a few other optimisations in the TLB area but it
> > needs some digging.
> 
> The single-TLB model works fairly well, but as I thought the lack of
> mcr%? processing by GCC makes the asm/tlbflush.h code fairly disgusting
> even for a v6+v7 kernel.  Luckily, we can play some tricks and sort
> some of that out.  The patch below is not complete (and can result in
> some rules of the architecture being violated - namely the requirement
> for an ISB after the BTB flush without a branch between) but it
> illustrates the idea:

I'm not sure about this rule, I can ask for some clarification (we are
not changing the memory map of the branch we execute).

According to the ARM ARM, the TLB invalidation sequence should be:

STR rx, [Translation table entry]          ; write new entry to the translation table
Clean cache line [Translation table entry] ; This operation is not required with the
                                           ; Multiprocessing Extensions.
DSB            ; ensures visibility of the data cleaned from the D Cache
Invalidate TLB entry by MVA (and ASID if non-global) [page address]
Invalidate BTC
DSB            ; ensure completion of the Invalidate TLB operation
ISB            ; ensure table changes visible to instruction fetch

So we have a DSB and ISB (when we don't return to user) unconditionally.

Starting with Cortex-A8 (well, unless you enable some errata
workarounds), the BTB is a no-op anyway, so maybe we could have the BTB
unconditionally as well (for ARMv6/v7). The only problem is the inner
shareable if we are on SMP - maybe we can do some run-time code patching
for it.

> diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
> index d2005de..252874c 100644
> --- a/arch/arm/include/asm/tlbflush.h
> +++ b/arch/arm/include/asm/tlbflush.h
> @@ -34,15 +34,15 @@
>  #define TLB_V6_D_ASID  (1 << 17)
>  #define TLB_V6_I_ASID  (1 << 18)
> 
> -#define TLB_BTB                (1 << 28)
> -
>  /* Unified Inner Shareable TLB operations (ARMv7 MP extensions) */
>  #define TLB_V7_UIS_PAGE        (1 << 19)
>  #define TLB_V7_UIS_FULL (1 << 20)
>  #define TLB_V7_UIS_ASID (1 << 21)
> 
>  /* Inner Shareable BTB operation (ARMv7 MP extensions) */
> -#define TLB_V7_IS_BTB  (1 << 22)
> +#define TLB_V7_IS_BTB  (1 << 26)
> +#define TLB_BTB                (1 << 27)
> +#define TLB_BTB_BARRIER        (1 << 28)

I won't comment on the BTB changes until we clarify the conditionality
of barriers and BTB.

-- 
Catalin
