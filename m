From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 05 Mar 2015 10:48:30 -0800
Subject: [PATCH 2/2] arm64: fixmap: check idx is definitely valid
In-Reply-To: <1425475655-22118-2-git-send-email-mark.rutland@arm.com>
References: <1425475655-22118-1-git-send-email-mark.rutland@arm.com>
 <1425475655-22118-2-git-send-email-mark.rutland@arm.com>
Message-ID: <54F8A4FE.3080907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/2015 5:27 AM, Mark Rutland wrote:
> Fixmap indices are in the interval (FIX_HOLE, __end_of_fixed_addresses),
> but in __set_fixmap we only check idx <= __end_of_fixed_addresses, and
> therefore indices <= FIX_HOLE are erroneously accepted. If called with
> such an idx, __set_fixmap may corrupt page tables outside of the fixmap
> region.
>
> This patch ensures that we validate the idx against both endpoints of
> the interval.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Laura Abbott <lauraa@codeaurora.org>

> ---
>   arch/arm64/mm/mmu.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index c6daaf6..c9267ac 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -627,10 +627,7 @@ void __set_fixmap(enum fixed_addresses idx,
>   	unsigned long addr = __fix_to_virt(idx);
>   	pte_t *pte;
>
> -	if (idx >= __end_of_fixed_addresses) {
> -		BUG();
> -		return;
> -	}
> +	BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);
>
>   	pte = fixmap_pte(addr);
>
>


-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
This e-mail address will be inactive after March 20, 2015
Please contact privately for follow up after that date.
