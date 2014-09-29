From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 15:02:18 +0200
Subject: [PATCH 1/6] arm/arm64: KVM: use __GFP_ZERO not memset() to get
 zeroed pages
In-Reply-To: <1410990981-665-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140929130218.GC25697@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:56:16PM -0700, Ard Biesheuvel wrote:
> Pass __GFP_ZERO to __get_free_pages() instead of calling memset()
> explicitly.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/kvm/mmu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index c68ec28f17c3..152e0f896e63 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -528,11 +528,10 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  		return -EINVAL;
>  	}
>  
> -	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
> +	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, S2_PGD_ORDER);
>  	if (!pgd)
>  		return -ENOMEM;
>  
> -	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
>  	kvm_clean_pgd(pgd);
>  	kvm->arch.pgd = pgd;
>  

So I think the point here was that if you use concatenated first-level
page tables, your MMU would only ever look in the first few entries of
the first-level page table, and we didn't want to zero-out more memory
than necessary.

However, there's something to be said for the fact that for sanity, we
should probably be clearing out the entire pgd anyhow.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks,
-Christoffer
