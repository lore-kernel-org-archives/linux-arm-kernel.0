From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 22 Jul 2016 17:36:55 +0100
Subject: [PATCH 2/5] arm64: efi: always map runtime services code and data
 regions down to pages
In-Reply-To: <CAKv+Gu_62V1Ww5UEJd3KP+TRj_kw3PW+wZaxQDnn-0ookLBBDg@mail.gmail.com>
References: <1467204690-10790-1-git-send-email-ard.biesheuvel@linaro.org>
 <1467204690-10790-3-git-send-email-ard.biesheuvel@linaro.org>
 <64a731b2-1ddb-78f5-fd02-204f19f0a432@arm.com>
 <CAKv+Gu_62V1Ww5UEJd3KP+TRj_kw3PW+wZaxQDnn-0ookLBBDg@mail.gmail.com>
Message-ID: <fa285509-2135-43a9-439b-256d4667be05@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/16 17:27, Ard Biesheuvel wrote:
> On 22 July 2016 at 16:30, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> Hi Ard,
>>
>> On 29/06/16 13:51, Ard Biesheuvel wrote:
>>>
>>> To avoid triggering diagnostics in the MMU code that are finicky about
>>> splitting block mappings into more granular mappings, ensure that regions
>>> that are likely to appear in the Memory Attributes table as well as the
>>> UEFI memory map are always mapped down to pages. This way, we can use
>>> apply_to_page_range() instead of create_pgd_mapping() for the second pass,
>>> which cannot split or merge block entries, and operates strictly on PTEs.
>>>
>>> Note that this aligns the arm64 Memory Attributes table handling code with
>>> the ARM code, which already uses apply_to_page_range() to set the strict
>>> permissions.
>>>
>>
>> This patch is merged in arm64/for-next/core now and when I try that
>> branch with defconfig + CONFIG_PROVE_LOCKING, I get the following splat
>> on boot and it fails to boot further on Juno.
>>
>> I could bisect that to this patch(Commit bd264d046aad ("arm64: efi:
>> always map runtime services code and data regions down to pages") in
>> that branch)
>>
>
> Hi Sudeep,
>
> I can reproduce this on QEMU as well. It appears that
> apply_to_page_range() expects pages containing translation tables to
> have their per-page spinlock initialized if they are not part of
> init_mm.
>
> This
>
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -272,6 +272,7 @@ static phys_addr_t late_pgtable_alloc(void)
>  {
>         void *ptr = (void *)__get_free_page(PGALLOC_GFP);
>         BUG_ON(!ptr);
> +       BUG_ON(!pgtable_page_ctor(virt_to_page(ptr)));
>
>         /* Ensure the zeroed page is visible to the page table walker */
>         dsb(ishst);
>
> makes the problem go away for me (just as a temporary hack) but I will
> try to come up with something more appropriate, and check if ARM has
> the same issue (since it uses apply_to_page_range() as well)
>

Ard,

I took a quick look at it. Looks like we don't initialise the page-table
pages allocated via late_pgtable_alloc. Since we allocate it for an mm != init_mm,
the lock validator comes into picture and finds a lock which is not initialised.
The following patch fixes the issue. But is not a perfect one. May need to polish it
a little bit.

----8>----

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a96a241..d312667 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -270,12 +270,12 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
  
  static phys_addr_t late_pgtable_alloc(void)
  {
-	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
-	BUG_ON(!ptr);
+	struct page *page = pte_alloc_one(NULL, 0);
+	BUG_ON(!page);
  
  	/* Ensure the zeroed page is visible to the page table walker */
  	dsb(ishst);
-	return __pa(ptr);
+	return __pa(page_address(page));
  }



Thanks
Suzuki
