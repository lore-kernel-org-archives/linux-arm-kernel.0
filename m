From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Nov 2015 09:43:02 +0100
Subject: [PATCH 2/2] arm64: mm: allow sections for unaligned bases
In-Reply-To: <1448033724-13846-2-git-send-email-mark.rutland@arm.com>
References: <1448033724-13846-1-git-send-email-mark.rutland@arm.com>
 <1448033724-13846-2-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu9Xk1oxh9xn-urDLXqbw209HuM+uao7EQjupuEooY5irA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2015 at 16:35, Mark Rutland <mark.rutland@arm.com> wrote:
> Callees of __create_mapping may decide to create section mappings if
> sufficient low bits of the physical and virtual addresses they were
> passed are zero. While __create_mapping rounds the virtual base address
> down, it does not similarly round the phyiscal base address down, and
> hence non-zero bits in the physical address can prevent use of a section
> mapping, even where a whole next-level table would be used instead.
>
> Round down the physical base address in __create_mapping to enable all
> callees to always create section mappings when such a mapping is
> possible.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Laura Abbott <labbott@fedoraproject.org>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 3b06afa..6467d57 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -307,6 +307,7 @@ static void  __create_mapping(struct mm_struct *mm, pgd_t *pgd,
>         if (WARN_ON((phys ^ virt) & ~PAGE_MASK))
>                 return;
>
> +       phys &= PAGE_MASK;
>         addr = virt & PAGE_MASK;
>         length = PAGE_ALIGN(size + (virt & ~PAGE_MASK));
>
> --
> 1.9.1
>
