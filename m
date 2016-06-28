From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Jun 2016 00:01:01 +0200
Subject: [PATCH 15/15] arm/arm64: KVM: Check that IDMAP doesn't intersect
 with VA range
In-Reply-To: <1465297115-13091-16-git-send-email-marc.zyngier@arm.com>
References: <1465297115-13091-1-git-send-email-marc.zyngier@arm.com>
 <1465297115-13091-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160628220101.GT26498@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 11:58:35AM +0100, Marc Zyngier wrote:
> This is more of a safety measure than anything else: If we end-up
> with an idmap page that intersect with the range picked for the
> the HYP VA space, abort the KVM setup, as it is unsafe to go
> further.
> 
> I cannot imagine it happening on 64bit (we have a mechanism to
> work around it), but could potentially occur on a 32bit system with
> the kernel loaded high enough in memory so that in conflicts with
> the kernel VA.

ah, you had a patch for this...

does this even work for enabling the MMU during kernel boot or how do
they deal with it?

> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/mmu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 46b8604..819517d 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -1708,6 +1708,21 @@ int kvm_mmu_init(void)
>  	 */
>  	BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>  
> +	kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
> +	kvm_info("HYP VA range: %lx:%lx\n",
> +		 KERN_TO_HYP(PAGE_OFFSET), KERN_TO_HYP(~0UL));
> +
> +	if (hyp_idmap_start >= KERN_TO_HYP(PAGE_OFFSET) &&
> +	    hyp_idmap_start <  KERN_TO_HYP(~0UL)) {

why is the second part of this clause necessary?

> +		/*
> +		 * The idmap page is intersecting with the VA space,
> +		 * it is not safe to continue further.
> +		 */
> +		kvm_err("IDMAP intersecting with HYP VA, unable to continue\n");
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, hyp_pgd_order);
>  	if (!hyp_pgd) {
>  		kvm_err("Hyp mode PGD not allocated\n");
> -- 
> 2.1.4
> 

Thanks,
-Christoffer
