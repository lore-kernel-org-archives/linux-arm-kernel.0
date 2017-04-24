From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Apr 2017 11:44:56 +0100
Subject: [PATCH] arm64: fix the overlap between the kernel image and
 vmalloc address
In-Reply-To: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
References: <1493025729-21505-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <20170424104456.GA4343@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for reporting the problematic usage of is_vmalloc_addr() and
vmalloc_to_page() here. That is a real problem that we need to address.

On Mon, Apr 24, 2017 at 05:22:09PM +0800, zhongjiang wrote:
> From: zhong jiang <zhongjiang@huawei.com>
>
> Recently, xiaojun report the following issue.
>
> [ 4544.984139] Unable to handle kernel paging request at virtual address ffff804392800000
> [ 4544.991995] pgd = ffff80096745f000
> [ 4544.995369] [ffff804392800000] *pgd=0000000000000000

> [ 4545.425416] fc00: ffff0000081fdfd0 0000ffffa9c87440
> [ 4545.430248] [<ffff0000083a1000>] __memcpy+0x100/0x180
> [ 4545.435253] [<ffff000008270f64>] read_kcore+0x21c/0x3b0
> [ 4545.440429] [<ffff00000826340c>] proc_reg_read+0x64/0x90
> [ 4545.445691] [<ffff0000081fb83c>] __vfs_read+0x1c/0x108
> [ 4545.450779] [<ffff0000081fcb28>] vfs_read+0x80/0x130
> [ 4545.455696] [<ffff0000081fe014>] SyS_read+0x44/0xa0
> [ 4545.460528] [<ffff000008082f30>] el0_svc_naked+0x24/0x28
> [ 4545.465790] Code: d503201f d503201f d503201f d503201f (a8c12027)
> [ 4545.471852] ---[ end trace 4d1897f94759f461 ]---
> [ 4545.476435] note: cat[8976] exited with preempt_count 2
>
> I find the issue is introduced when applying commit f9040773b7bb
> ("arm64: move kernel image to base of vmalloc area"). This patch
> make the kernel image overlap with vmalloc area. It will result in
> vmalloc area have the huge page table. but the vmalloc_to_page is
> not realize the change. and the function is public to any arch.

So the issue is that we have the callchain below for a kernel image
address:

read_kcore()
->is_vmalloc_or_module_addr() // returns true
->vread()
-->aligned_vread()
--->vmalloc_to_page()

In is_vmalloc{,or_module}_addr() we just check the addr against
VMALLOC_START and VMALLOC_END, so they will return true for a kernel
image address.

Then, we call vmalloc_to_page(). While this only handles mappings made
at page granularity, the kernel image mapping may have used sections. So
this tries a bogus walk to the pte level.

Evidently, we assume that any memory in the vmalloc area (or module
areas) is mapped at page granularity. Is that always the case?

AFAICT, memremap'd memory isn't necessarily, but vread() should skip
that due to the VM_IOREMAP flag on the vma. The KASAN region should be
below MODULES_VADDR on arm64. I'm not sure if there's anything else.

Does it make sense to teach vmalloc_to_page() about section mappings?

Should we special-case kernel image handling, e.g. with new
is_kernel_image_addr() / kernel_image_to_page() helpers?

Do we need to shuffle things around such that the kernel image is not
between VMALLOC_START and VMALLOC_END?

> I fix it by change the init mapping to make it keep the accordance
> with vmalloc area mapping.
>
> Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
> Reported-by: tan xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  arch/arm64/mm/mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 17243e4..2d8b34d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -185,7 +185,7 @@ static void alloc_init_pmd(pud_t *pud, unsigned long addr, unsigned long end,
>
>               /* try section mapping first */
>               if (((addr | next | phys) & ~SECTION_MASK) == 0 &&
> -                   !page_mappings_only) {
> +                   !page_mappings_only && !is_vmalloc_addr((void *)addr)) {
>                       /*
>                        * Set the contiguous bit for the subsequent group of
>                        * PMDs if its size and alignment are appropriate.
> @@ -256,7 +256,8 @@ static void alloc_init_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
>               /*
>                * For 4K granule only, attempt to put down a 1GB block
>                */
> -             if (use_1G_block(addr, next, phys) && !page_mappings_only) {
> +             if (use_1G_block(addr, next, phys) && !page_mappings_only &&
> +                                     !is_vmalloc_addr((void *)addr)) {
>                       pud_set_huge(pud, phys, prot);
>

This will force the kernel image mappings to use page granularity, which
will come at a significant TLB pressure cost, and would be incredibly
unfortunate.

I would rather we solved this through other means.

Thanks,
Mark.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
