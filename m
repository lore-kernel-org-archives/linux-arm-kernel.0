From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 6 Feb 2014 19:51:07 -0800
Subject: [PATCH] ARM: KVM: fix warning in mmu.c
In-Reply-To: <1391630305-8056-1-git-send-email-marc.zyngier@arm.com>
References: <1391630305-8056-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140207035107.GM9157@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:58:25PM +0000, Marc Zyngier wrote:
> Compiling with THP enabled leads to the following warning:
> 
> arch/arm/kvm/mmu.c: In function ?unmap_range?:
> arch/arm/kvm/mmu.c:177:39: warning: ?pte? may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (kvm_pmd_huge(*pmd) || page_empty(pte)) {
>                                         ^
> Code inspection reveals that these two cases are mutually exclusive,
> so GCC is a bit overzealous here. But silence it anyway by setting
> pte to NULL if kvm_pmd_huge(*pmd) is true.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/mmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index ea21b6a..3020221 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -169,12 +169,14 @@ static void unmap_range(struct kvm *kvm, pgd_t *pgdp,
>  			pte = pte_offset_kernel(pmd, addr);
>  			clear_pte_entry(kvm, pte, addr);
>  			next = addr + PAGE_SIZE;
> +		} else {
> +			pte = NULL;
>  		}

If it's just for the compiler, how about just setting pte = NULL when
pte is declared in the top of the function as to not interrupt the flow?

-Christoffer
