From: james.morse@arm.com (James Morse)
Date: Fri, 14 Sep 2018 09:38:38 +0100
Subject: [RESEND PATCH v4 5/6] arm64/mm: Populate the swapper_pg_dir by
 fixmap.
In-Reply-To: <20180913105021.GA25870@toy>
References: <20180822095432.12125-1-yaojun8558363@gmail.com>
 <20180822095432.12125-6-yaojun8558363@gmail.com>
 <2bf9b9d1-271c-f85e-5a98-0eb74f2fedd9@arm.com> <20180913105021.GA25870@toy>
Message-ID: <c5831e37-d199-b533-c57c-b801d0de61f9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jun,

On 13/09/18 11:50, Jun Yao wrote:
> On Fri, Sep 07, 2018 at 10:58:22AM +0100, James Morse wrote:
>> On 22/08/18 10:54, Jun Yao wrote:
>>>  	WRITE_ONCE(*pmdp, pmd);
>>>  	dsb(ishst);
>>>  }
>>> @@ -480,6 +511,19 @@ static inline phys_addr_t pmd_page_paddr(pmd_t pmd)
>>>  
>>>  static inline void set_pud(pud_t *pudp, pud_t pud)
>>>  {
>>> +#ifdef __PAGETABLE_PUD_FOLDED
>>> +	if (in_swapper_pgdir(pudp)) {
>>> +		pud_t *fixmap_pudp;
>>> +
>>> +		spin_lock(&swapper_pgdir_lock);
>>> +		fixmap_pudp = (pud_t *)pgd_set_fixmap(__pa(pudp));
>>
>> I see this called 68 times during boot on a 64K/42bit-VA, 65 of which appear to
>> be during paging_init(). What do you think to keeping paging_init()s use of the
>> pgd fixmap for swapper_pg_dir, deliberately to skip the in_swapper_pgdir() test
>> during paging_init()?
> 
> I find that the __create_pgd_mapping() is used to set up the page table
> during paging_init(). And there are six functions calling it with
> different pgdps:
> 
> update_mapping_prot()		init_mm.pgd(swapper_pg_dir)
> create_mapping_noalloc()	init_mm.pgd(swapper_pg_dir)
> __map_memblock()		pgdp(swapper_pg_dir)
> map_kernel_segment()		pgdp(swapper_pg_dir)
> create_pgd_mapping()		!(init_mm.pgd)
> map_entry_trampoline()		tramp_pg_dir
> 
> In order to skip the in_swapper_pgdir() test during paging_init(), We
> need a way to determine if we are currently in paging_init().

We don't need to know paging_init() is the caller, we just want to fool
in_swapper_pgdir() into not matching the address. Using pgd_set_fixmap() in
paging_init(), as we do today would do this, as the value passed to
map_kernel()/map_mem() would never match swapper_pg_dir().

(this is just to stop unnecessary tlbi for every write to swapper_pg_dir, as we
don't need to do that during early boot when it isn't loaded)


> The way I
> can think of is to create a function similar to __create_pgd_mapping().
> And it is used to create the page table during paging_init(). It differs
> from the __create_pgd_mapping() only in that it calls
> p?d_populate_without_test(). However, in this way, I'm worried that I am
> reinventing the wheel.

I agree duplicating the code doesn't sound good.

Something like this? (barely tested):
----------------%<----------------
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 691a05bbf87b..64ba422482cc 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -644,8 +690,12 @@ void __init set_init_mm_pgd(pgd_t *pgd)
  */
 void __init paging_init(void)
 {
-       map_kernel(swapper_pg_dir);
-       map_mem(swapper_pg_dir);
+       pgd_t *pgdp = pgd_set_fixmap(__pa_symbol(swapper_pg_dir));
+
+       map_kernel(pgdp);
+       map_mem(pgdp);
+       pgd_clear_fixmap();
+
        cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
        set_init_mm_pgd(swapper_pg_dir);
 }
----------------%<----------------


This reduced the pgd-fixmap setup/teardown calls during boot from 68 to 2...


Thanks,

James
