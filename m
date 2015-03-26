From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 26 Mar 2015 15:34:42 +0100
Subject: [PATCH v1] arm64:mm: enable the kernel execute attribute for
 HEAD_TEXT segment
In-Reply-To: <1427378028-126465-1-git-send-email-yuanzhichang@hisilicon.com>
References: <1427378028-126465-1-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <CAKv+Gu9GXy4LtUsFv3vHxoQAdVGcRNGc18=gNbkkDXGk4JmZ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 14:53, Zhichang Yuan <yuanzhichang@hisilicon.com> wrote:
> From: yuanzhichang <yuanzhichang@hisilicon.com>
>
> In the patch whose title is "add better page protections to arm64"
> (commit da141706aea52c1a9fbd28cb8d289b78819f5436), The direct mapping
> page table entries for HEAD_TEXT segment were configured as PAGE_KERNEL,
> without the executable attribute. But when the secondary CPUs are booting
> based on spin-table mechanism, some functions in head.S are needed to run.

Which function is that exactly? If the secondaries need to execute it,
you should probably move it out of .head.text into the normal .text
section instead of changing the protections here

> Only PAGE_KERNEL dosen't work for this case.
> This patch will configure the page attributes as PAGE_KERNEL_EXEC for
> HEAD_TEXT segment.
>
> Signed-off-by: Zhichang Yuan <yuanzhichang@hisilicon.com>
> ---
>  arch/arm64/mm/mmu.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c6daaf6..ad08dfd 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -305,8 +305,8 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>          * for now. This will get more fine grained later once all memory
>          * is mapped
>          */
> -       unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
> -       unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
> +       phys_addr_t kernel_x_start = round_down(__pa(_text), SECTION_SIZE);
> +       phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
>
>         if (end < kernel_x_start) {
>                 create_mapping(start, __phys_to_virt(start),
> @@ -315,6 +315,18 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
>                 create_mapping(start, __phys_to_virt(start),
>                         end - start, PAGE_KERNEL);
>         } else {
> +       /*
> +        * At this moment, the text segment must reside in valid physical
> +        * memory section range to make sure the text are totally mapped.
> +        * If mapping from non-section aligned address is support, then
> +        * _text can be used here directly in replace to kernel_x_start.
> +        */
> +               phys_addr_t max_left, min_right;
> +
> +               max_left = max(kernel_x_start, start);
> +               min_right = min(kernel_x_end, end);
> +               BUG_ON(max_left != kernel_x_start || min_right != kernel_x_end);
> +
>                 if (start < kernel_x_start)
>                         create_mapping(start, __phys_to_virt(start),
>                                 kernel_x_start - start,
> @@ -394,12 +406,12 @@ void __init fixup_executable(void)
>  {
>  #ifdef CONFIG_DEBUG_RODATA
>         /* now that we are actually fully mapped, make the start/end more fine grained */
> -       if (!IS_ALIGNED((unsigned long)_stext, SECTION_SIZE)) {
> -               unsigned long aligned_start = round_down(__pa(_stext),
> +       if (!IS_ALIGNED((unsigned long)_text, SECTION_SIZE)) {
> +               unsigned long aligned_start = round_down(__pa(_text),
>                                                         SECTION_SIZE);
>
>                 create_mapping(aligned_start, __phys_to_virt(aligned_start),
> -                               __pa(_stext) - aligned_start,
> +                               __pa(_text) - aligned_start,
>                                 PAGE_KERNEL);
>         }
>
> @@ -418,7 +430,7 @@ void mark_rodata_ro(void)
>  {
>         create_mapping_late(__pa(_stext), (unsigned long)_stext,
>                                 (unsigned long)_etext - (unsigned long)_stext,
> -                               PAGE_KERNEL_EXEC | PTE_RDONLY);
> +                               (PAGE_KERNEL_EXEC | PTE_RDONLY) & ~PTE_WRITE);
>
>  }
>  #endif
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
