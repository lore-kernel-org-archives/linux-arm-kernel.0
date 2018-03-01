From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 01 Mar 2018 21:10:56 +0000
Subject: [PATCH] KVM: arm/arm64: drop pr_info() of IDMAP page
In-Reply-To: <20180301191406.18083-1-ard.biesheuvel@linaro.org>
References: <20180301191406.18083-1-ard.biesheuvel@linaro.org>
Message-ID: <86sh9j33j3.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 01 Mar 2018 19:14:06 +0000,
Ard Biesheuvel wrote:
> 
> The KVM IDMAP is a mapping of a statically allocated kernel structure,
> and so printing its physical address leaks the physical placement of
> the kernel when physical KASLR is in effect. Just remove it, nobody
> except Marc needs this anyway.

Bah, even I don't really need it anymore...

> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> CC -stable?

In this day and age, probably.

> 
>  virt/kvm/arm/mmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ec62d1cccab7..c07f88cb6dcf 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1810,7 +1810,6 @@ int kvm_mmu_init(void)
>  	 */
>  	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>  
> -	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
>  	kvm_info("HYP VA range: %lx:%lx\n",
>  		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));

Instead of removing this particular line, how about turning all these
kvm_info into kvm_debug (see [1])?

Thanks,

	M.

[1] https://www.spinics.net/lists/arm-kernel/msg637920.html

-- 
Jazz is not dead, it just smell funny.
