From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 15 Jan 2018 16:54:59 +0100
Subject: [PATCH v4 11/19] KVM: arm/arm64: Demote HYP VA range display to
 being a debug feature
In-Reply-To: <20180104184334.16571-12-marc.zyngier@arm.com>
References: <20180104184334.16571-1-marc.zyngier@arm.com>
 <20180104184334.16571-12-marc.zyngier@arm.com>
Message-ID: <20180115155459.GM21403@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 04, 2018 at 06:43:26PM +0000, Marc Zyngier wrote:
> Displaying the HYP VA information is slightly counterproductive when
> using VA randomization. Turn it into a debug feature only, and adjust
> the last displayed value to reflect the top of RAM instead of ~0.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

> ---
>  virt/kvm/arm/mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index b4b69c2d1012..84d09f1a44d4 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1760,9 +1760,10 @@ int kvm_mmu_init(void)
>  	 */
>  	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>  
> -	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
> -	kvm_info("HYP VA range: %lx:%lx\n",
> -		 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
> +	kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
> +	kvm_debug("HYP VA range: %lx:%lx\n",
> +		  kern_hyp_va(PAGE_OFFSET),
> +		  kern_hyp_va((unsigned long)high_memory - 1));
>  
>  	if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
>  	    hyp_idmap_start <  kern_hyp_va(~0UL) &&
> -- 
> 2.14.2
> 
