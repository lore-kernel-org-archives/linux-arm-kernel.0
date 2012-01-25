From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Jan 2012 11:32:48 +0000
Subject: [PATCH 3/5] ARM: pgtable: consolidate set_pte_ext(TOP_PTE, ...) +
 tlb flush
In-Reply-To: <E1RoBot-0005oa-3W@rmk-PC.arm.linux.org.uk>
References: <20120120103433.GF1068@n2100.arm.linux.org.uk>
 <E1RoBot-0005oa-3W@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk52Zo4psxCjpvzXO7b9HZFS1o-SGsv1WJ11On58By1SBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 10:35, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> A number of places establish a PTE in our top page table and
> immediately flush the TLB. ?Rather than having this at every callsite,
> provide an inline function for this purpose.
...
> +static inline void set_top_pte(unsigned long va, pte_t pte)
> +{
> + ? ? ? set_pte_ext(TOP_PTE(va), pte, 0);
> + ? ? ? local_flush_tlb_kernel_page(va);
> +}

There is a difference with some of the call sites where the
flush_tlb_kernel_page() was used instead of the local variant. The pte
set up via set_top_pte() is indeed accessed on a single CPU and there
are locks around that would prevent migration (with CONFIG_PREEMPT).
So I don't see any problem with this.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
