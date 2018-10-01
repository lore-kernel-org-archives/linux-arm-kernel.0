From: james.morse@arm.com (James Morse)
Date: Mon, 1 Oct 2018 11:41:37 +0100
Subject: [PATCH v5 5/6] arm64/mm: Populate the swapper_pg_dir by fixmap.
In-Reply-To: <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
References: <20180917044333.30051-1-yaojun8558363@gmail.com>
 <20180917044333.30051-6-yaojun8558363@gmail.com>
 <20180924163619.rx7bae67i5isq2fy@lakrids.cambridge.arm.com>
Message-ID: <24c91d6c-85c8-afb4-74d1-202e4d780ab6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 24/09/18 17:36, Mark Rutland wrote:
> On Mon, Sep 17, 2018 at 12:43:32PM +0800, Jun Yao wrote:
>> Since we will move the swapper_pg_dir to rodata section, we need a
>> way to update it. The fixmap can handle it. When the swapper_pg_dir
>> needs to be updated, we map it dynamically. The map will be
>> canceled after the update is complete. In this way, we can defend
>> against KSMA(Kernel Space Mirror Attack).

>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 71532bcd76c1..a8a60927f716 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -67,6 +67,24 @@ static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
>>  static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
>>  static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
>>  
>> +static DEFINE_SPINLOCK(swapper_pgdir_lock);
>> +
>> +void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
>> +{
>> +	pgd_t *fixmap_pgdp;
>> +
>> +	spin_lock(&swapper_pgdir_lock);
>> +	fixmap_pgdp = pgd_set_fixmap(__pa(pgdp));
>> +	WRITE_ONCE(*fixmap_pgdp, pgd);
>> +	/*
>> +	 * We need dsb(ishst) here to ensure the page-table-walker sees
>> +	 * our new entry before set_p?d() returns. The fixmap's
>> +	 * flush_tlb_kernel_range() via clear_fixmap() does this for us.
>> +	 */
>> +	pgd_clear_fixmap();
>> +	spin_unlock(&swapper_pgdir_lock);
>> +}
> 
> I'm rather worried that we could deadlock here.

We can use the irqsave versions if you're worried, but I think any code doing
this is already broken.

(I'd like to eventually depend on the init_mm.page_table_lock for this, but it
isn't held when the vmemmap is being populated.)


> Are we certain we never poke the kernel page tables in IRQ context?

The RAS code was doing this, but was deemed unsafe, and changed to use the
fixmap: https://lkml.org/lkml/2017/10/30/500
The fixmap only ever touches the last level, so can't hit this.

x86 can't do its IPI tlb-maintenance from IRQ context, so anything trying to
unmap from irq context is already broken: https://lkml.org/lkml/2018/9/6/324

vunmap()/vfree() is allowed from irq context, but it defers its work.

I can't find any way to pass GFP_ATOMIC into ioremap(),
I didn't think vmalloc() could either, ...  but now I spot __vmalloc() does...

This __vmalloc() path is used by the percpu allocator, which starting from
pcpu_alloc() can be passed something other than GFP_KERNEL, and uses
spin_lock_irqsave(), so it is expecting to be called in irq context.

... so yes it looks like this can happen.

I'll post a fix


Thanks!

James
