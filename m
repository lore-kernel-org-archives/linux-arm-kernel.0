From: james.morse@arm.com (James Morse)
Date: Mon, 1 Oct 2018 14:49:04 +0100
Subject: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
In-Reply-To: <24c91d6c-85c8-afb4-74d1-202e4d780ab6@arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-6-yaojun8558363@gmail.com>
 <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
 <24c91d6c-85c8-afb4-74d1-202e4d780ab6@arm.com>
Message-ID: <5a8ee1d0-67c6-b8ff-562d-ad9fe4ac0423@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 01/10/18 11:41, James Morse wrote:
> On 24/09/18 17:36, Mark Rutland wrote:
>> On Mon, Sep 17, 2018 at 12:43:32PM +0800, Jun Yao wrote:
>>> Since we will move the swapper_pg_dir to rodata section, we need a
>>> way to update it. The fixmap can handle it. When the swapper_pg_dir
>>> needs to be updated, we map it dynamically. The map will be
>>> canceled after the update is complete. In this way, we can defend
>>> against KSMA(Kernel Space Mirror Attack).
> 
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 71532bcd76c1..a8a60927f716 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -67,6 +67,24 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>>>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>>>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>>>  
>>> +static DEFINE_SPINLOCK(swapper_pgdir_lock);
>>> +
>>> +void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>>> +{
>>> +	pgd_t *fixmap_pgdp;
>>> +
>>> +	spin_lock(&swapper_pgdir_lock);
>>> +	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
>>> +	WRITE_ONCE(*fixmap_pgdp, pgd);
>>> +	/*
>>> +	 * We need dsb(ishst) here to ensure the page-table-walker sees
>>> +	 * our new entry before set_p?d() returns. The fixmap's
>>> +	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
>>> +	 */
>>> +	pgd_clear_fixmap();
>>> +	spin_unlock(&swapper_pgdir_lock);
>>> +}

>> Are we certain we never poke the kernel page tables in IRQ context?
> 
> The RAS code was doing this, but was deemed unsafe, and changed to use the
> fixmap: https://lkml.org/lkml/2017/10/30/500
> The fixmap only ever touches the last level, so can't hit this.
> 
> x86 can't do its IPI tlb-maintenance from IRQ context, so anything trying to
> unmap from irq context is already broken: https://lkml.org/lkml/2018/9/6/324
> 
> vunmap()/vfree() is allowed from irq context, but it defers its work.
> 
> I can't find any way to pass GFP_ATOMIC into ioremap(),
> I didn't think vmalloc() could either, ...  but now I spot __vmalloc() does...
> 
> This __vmalloc() path is used by the percpu allocator, which starting from
> pcpu_alloc() can be passed something other than GFP_KERNEL, and uses
> spin_lock_irqsave(), so it is expecting to be called in irq context.
> 
> ... so yes it looks like this can happen.

But! These two things (irq-context and calls-__vmalloc()) can't happen at the
same time. If pcpu_alloc() is passed GFP_ATOMIC, and pcpu_alloc_area() fails,
(so a new chunk needs to be allocated), it will fail instead.

(This explains the scary looking "if (!in_atomic) mutex_lock()", in that code).


If you try it, you hit the "BUG_ON(in_interrupt())", in
__get_vm_area_node(). So even if you do pass GFP_ATOMIC in here, you can't call
it from interrupt context. (sanity prevails!)

I was wrong, it doesn't need fixing.


James
