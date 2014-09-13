From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 13 Sep 2014 11:41:35 +0100
Subject: [PATCH 1/2] ARM: kvm: define =?UTF-8?Q?PAGE=5FS=32=5FDEVICE?=
 =?UTF-8?Q?=20as=20read-only=20by=20default?=
In-Reply-To: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On 2014-09-13 11:17, Ard Biesheuvel wrote:
> Now that we support read-only memslots, we need to make sure that
> pass-through device mappings are not mapped writable if the guest
> has requested them to be read-only. The existing implementation
> already honours this by calling kvm_set_s2pte_writable() on the new
> pte in case of writable mappings, so all we need to do is define
> the default pgprot_t value used for devices to be PTE_S2_RDONLY.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I feel very uncomfortable with this change. Why would we map a device 
RO? Is that only for completeness sake?

Note that we also use PAGE_S2_DEVICE for things that are not mapped 
through a memslot, such as the GIC.

Thanks,

         M.

> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/include/asm/pgtable.h 
> b/arch/arm/include/asm/pgtable.h
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
>  #define __PAGE_NONE		__pgprot(_L_PTE_DEFAULT | L_PTE_RDONLY |
> L_PTE_XN | L_PTE_NONE)
>  #define __PAGE_SHARED		__pgprot(_L_PTE_DEFAULT | L_PTE_USER | 
> L_PTE_XN)

-- 
Fast, cheap, reliable. Pick two.
