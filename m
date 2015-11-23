From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Nov 2015 09:40:55 +0100
Subject: [PATCH 1/2] arm64: mm: detect bad __create_mapping uses
In-Reply-To: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
References: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu_JuVUtD_-GrtO7fs=nW4PVNWv5A+mXkTqfc90szGRdhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2015 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
> If a caller of __create_mapping provides a PA and VA which have
> different sub-page offsets, it is not clear which offset they expect to
> apply to the mapping, and is indicative of a bad caller.
>
> Disallow calls with differing sub-page offsets, and WARN when they are
> encountered, so that we can detect and fix such cases.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <caralin.marinas@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e3f563c..3b06afa 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -300,6 +300,13 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
>  {
>         unsigned long addr, length, end, next;
>
> +       /*
> +        * If the virtual and physical address don't have the same offset
> +        * within a page, we cannot map the region as the caller expects.
> +        */
> +       if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
> +               return;
> +
>         addr = virt & PAGE_MASK;
>         length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
>
> --
> 1.9.1
>
