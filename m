From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 May 2014 11:39:24 +0100
Subject: [PATCH] arm: mm: fix lowmem virtual address range check
In-Reply-To: <5373444C.3010805@huawei.com>
References: <1400047439-23961-1-git-send-email-wangnan0@huawei.com>
 <20140514101137.GC10145@arm.com> <5373444C.3010805@huawei.com>
Message-ID: <20140514103924.GD10145@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 11:24:12AM +0100, Wang Nan wrote:
> On 2014/5/14 18:11, Will Deacon wrote:
> > On Wed, May 14, 2014 at 07:03:59AM +0100, Wang Nan wrote:
> >> This patch makes sure the argument of __phys_to_virt is a valid physical
> >> address when clear lowmem memory maps.
> >>
> >> The last few lines prepare_page_table() clear page mapping in the gap
> >> between largest low physical memory and the upper bound of lowmem. It
> >> uses __phys_to_virt(end) to calculate virtual address from where the
> >> clearing start.
> >>
> >> However, if the platform uses private nonliner __phys_to_virt(), 'end'
> >> may goes into another mapping region.
> >>
> >> This patch uses __phys_to_virt(end - 1) + 1 for insurance purposes.
> >>
> >> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> >> Cc: Geng Hui <hui.geng@huawei.com>
> >> Cc: Will Deacon <will.deacon@arm.com>
> >> ---
> >>  arch/arm/mm/mmu.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> >> index b68c6b2..87340ee 100644
> >> --- a/arch/arm/mm/mmu.c
> >> +++ b/arch/arm/mm/mmu.c
> >> @@ -1217,7 +1217,7 @@ static inline void prepare_page_table(void)
> >>  	 * Clear out all the kernel space mappings, except for the first
> >>  	 * memory bank, up to the vmalloc region.
> >>  	 */
> >> -	for (addr = __phys_to_virt(end);
> >> +	for (addr = __phys_to_virt(end - 1) + 1;
> >>  	     addr < VMALLOC_START; addr += PMD_SIZE)
> >>  		pmd_clear(pmd_off_k(addr));
> > 
> > This looks correct to me, but I'd be interested to know which platform this
> > is falling over on. Only realview seems to override __phys_to_virt and I
> > don't think we want to add more of that if we can help it.
> > 
> > Will
> > 
> 
> I'm working on realview code now, trying to make it support CONFIG_ARM_PATCH_PHYS_VIRT,
> and found this problem when working on its private __phys_to_virt. Realview is the only
> in-kernel arm board which uses sparse memory. I think it is a good example when testing
> sparse memory support of tools such as kexec-tools, kdump and crash.

Ok, but there's been recent talk of getting rid of that by the looks of it:

  http://www.spinics.net/lists/arm-kernel/msg318362.html

So, whilst I still think your fix is valid, we should probably discourage
any new users from overriding these macros.

Will
