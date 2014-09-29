From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 15:05:34 +0200
Subject: [PATCH 4/6] ARM: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <1410990981-665-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140929130534.GD25697@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 02:56:19PM -0700, Ard Biesheuvel wrote:
> Now that we support read-only memslots, we need to make sure that
> pass-through device mappings are not mapped writable if the guest
> has requested them to be read-only. The existing implementation
> already honours this by calling kvm_set_s2pte_writable() on the new
> pte in case of writable mappings, so all we need to do is define
> the default pgprot_t value used for devices to be PTE_S2_RDONLY.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 01baef07cd0c..92b2fbe18868 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -100,7 +100,7 @@ extern pgprot_t		pgprot_s2_device;
>  #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
>  #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
>  #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
> -#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDWR)
> +#define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDONLY)
>  
>  #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY | L_PTE_XN | L_PTE_NONE)
>  #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | L_PTE_XN)
> -- 
> 1.8.3.2
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Russell, unless you object to this one, I will just queue it through the
kvmarm tree?

Thanks,
-Christoffer
