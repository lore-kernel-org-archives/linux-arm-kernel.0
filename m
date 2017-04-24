From: zhongjiang@huawei.com (zhong jiang)
Date: Mon, 24 Apr 2017 21:28:48 +0800
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <20170424104456.GA4343@leverpostej>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
 <20170424104456.GA4343@leverpostej>
Message-ID: <58FDFD90.8050300@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/4/24 18:44, Mark Rutland wrote:
> Hi,
>
> Thanks for reporting the problematic usage of is_vmalloc_addr() and
> vmalloc_to_page() here. That is a real problem that we need to address.
>
> On Mon, Apr 24, 2017 at 05:22:09PM +0800, zhongjiang wrote:
>> From: zhong jiang <zhongjiang@huawei.com>
>>
>> Recently, xiaojun report the following issue.
>>
>> [ 4544.984139] Unable to handle kernel paging request at virtual address ffff804392800000
>> [ 4544.991995] pgd = ffff80096745f000
>> [ 4544.995369] [ffff804392800000] *pgd=0000000000000000
>> [ 4545.425416] fc00: ffff0000081fdfd0 0000ffffa9c87440
>> [ 4545.430248] [<ffff0000083a1000>] __memcpy+0x100/0x180
>> [ 4545.435253] [<ffff000008270f64>] read_kcore+0x21c/0x3b0
>> [ 4545.440429] [<ffff00000826340c>] proc_reg_read+0x64/0x90
>> [ 4545.445691] [<ffff0000081fb83c>] __vfs_read+0x1c/0x108
>> [ 4545.450779] [<ffff0000081fcb28>] vfs_read+0x80/0x130
>> [ 4545.455696] [<ffff0000081fe014>] SyS_read+0x44/0xa0
>> [ 4545.460528] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
>> [ 4545.465790] Code: d503201f d503201f d503201f d503201f (a8c12027)
>> [ 4545.471852] ---[ end trace 4d1897f94759f461 ]---
>> [ 4545.476435] note: cat[8976] exited with preempt_count 2
>>
>> I find the issue is introduced when applying commit f9040773b7bb
>> ("arm64: move kernel image to base of vmalloc area"). This patch
>> make the kernel image overlap with vmalloc area. It will result in
>> vmalloc area have the huge page table. but the vmalloc_to_page is
>> not realize the change. and the function is public to any arch.
> So the issue is that we have the callchain below for a kernel image
> address:
>
> read_kcore()
> ->is_vmalloc_or_module_addr() // returns true
> ->vread()
> -->aligned_vread()
> --->vmalloc_to_page()
>
> In is_vmalloc{,or_module}_addr() we just check the addr against
> VMALLOC_START and VMALLOC_END, so they will return true for a kernel
> image address.
>
> Then, we call vmalloc_to_page(). While this only handles mappings made
> at page granularity, the kernel image mapping may have used sections. So
> this tries a bogus walk to the pte level.
>
> Evidently, we assume that any memory in the vmalloc area (or module
> areas) is mapped at page granularity. Is that always the case?
  I do not see a vmalloc area mapped in huge page table so far. 
> AFAICT, memremap'd memory isn't necessarily, but vread() should skip
> that due to the VM_IOREMAP flag on the vma. The KASAN region should be
> below MODULES_VADDR on arm64. I'm not sure if there's anything else.
> Does it make sense to teach vmalloc_to_page() about section mappings?
   I do not know it has any limitation. if it is ok , it is worthy to try.
> Should we special-case kernel image handling, e.g. with new
> is_kernel_image_addr() / kernel_image_to_page() helpers?
  yes ,  it seems to the best way to implents it  without performance back.
> Do we need to shuffle things around such that the kernel image is not
> between VMALLOC_START and VMALLOC_END?
>
>> I fix it by change the init mapping to make it keep the accordance
>> with vmalloc area mapping.
>>
>> Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
>> Reported-by: tan xiaojun <tanxiaojun@huawei.com>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/arm64/mm/mmu.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 17243e4..2d8b34d 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -185,7 +185,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>>
>>               /* try section mapping first */
>>               if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
>> -                   !page_mappings_only) {
>> +                   !page_mappings_only && !is_vmalloc_addr((void *)addr)) {
>>                       /*
>>                        * Set the contiguous bit for the subsequent group of
>>                        * PMDs if its size and alignment are appropriate.
>> @@ -256,7 +256,8 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
>>               /*
>>                * For 4K granule only, attempt to put down a 1GB block
>>                */
>> -             if (use_1G_block(addr, next, phys) && !page_mappings_only) {
>> +             if (use_1G_block(addr, next, phys) && !page_mappings_only &&
>> +                                     !is_vmalloc_addr((void *)addr)) {
>>                       pud_set_huge(pud, phys, prot);
>>
> This will force the kernel image mappings to use page granularity, which
> will come at a significant TLB pressure cost, and would be incredibly
> unfortunate.
  you are right.  it seems to so.  The simplest way to add is_kernel_image_addr helper.
> I would rather we solved this through other means.
>
> Thanks,
> Mark.
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>
 > The following patch is the implment. Any thought?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>

  diff --git a/include/linux/mm.h b/include/linux/mm.h
index b84615b..851ac35 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -475,6 +475,15 @@ static inline bool is_vmalloc_addr(const void *x)
        return false;
 #endif
 }
+
+static inline bool is_kernel_image_addr(const void *x)
+{
+       unsigned long addr = (unsigned long)x;
+
+       return addr >= (unsigned long)_stext && addr < (unsigned long)_end;
+
+}
+
 #ifdef CONFIG_MMU
 extern int is_vmalloc_or_module_addr(const void *x);
 #else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3ca82d4..9a9ef65 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -229,6 +229,42 @@ int is_vmalloc_or_module_addr(const void *x)
        return is_vmalloc_addr(x);
 }

+static struct page *kernel_image_to_page(const void *kernel_addr, pgd_t *pgd)
+{
+       unsigned long addr = (unsigned long)kernel_addr;
+       struct page *page = NULL;
+       pud_t *pud;
+       pmd_t *pmd;
+       pte_t *pte;
+
+       if (pgd_none(*pgd))
+               goto out;
+
+       pud = pud_offset(pgd, addr);
+       if (pud_none(*pud))
+               goto out;
+
+       if (pud_sect(*pud))
+               return pud_page(*pud);
+
+       pmd = pmd_offset(*pmd, addr);
+       if (pmd_none(*pmd))
+               goto out;
+
+       if (pmd_sect(*pmd))
+               return pmd_page(*pmd);
+
+       pte = pte_offset_kernel(pmd, addr);
+       if (pte_none(*pte))
+               goto out;
+
+       page = pte_page(*pte);
+
+out:
+       return page;
+
+}
+
 /*
   * Walk a vmap address to the struct page it maps.
   */
@@ -244,6 +280,9 @@ struct page *vmalloc_to_page(const void *vmalloc_addr)
         */
        VIRTUAL_BUG_ON(!is_vmalloc_or_module_addr(vmalloc_addr));

+       if (is_kernel_image_addr(vmalloc_addr))
+               return kernel_image_to_page(vmalloc_addr, pgd);
+
        if (!pgd_none(*pgd)) {
                pud_t *pud = pud_offset(pgd, addr);
                if (!pud_none(*pud)) {


 
