From: cdall@linaro.org (Christoffer Dall)
Date: Fri, 17 Mar 2017 09:48:34 +0100
Subject: [PATCH] kvm: arm/arm64: Simplify lock relaxation in
 stage2_wp_range
In-Reply-To: <1489688674-17692-1-git-send-email-suzuki.poulose@arm.com>
References: <1489688674-17692-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170317084834.GV1277@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 16, 2017 at 06:24:34PM +0000, Suzuki K Poulose wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> Add checks to make sure that kvm->mmu_lock is held while calling
> stage2_wp_range. Also avoid explicit checks already done by cond_resched_lock().
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> [ Added assert_spin_locked check ]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  arch/arm/kvm/mmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 7628ef1..37e67f5 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -1162,6 +1162,8 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  	pgd_t *pgd;
>  	phys_addr_t next;
>  
> +	assert_spin_locked(&kvm->mmu_lock);
> +
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
>  	do {
>  		/*
> @@ -1171,8 +1173,7 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  		 * CONFIG_LOCKDEP. Additionally, holding the lock too long
>  		 * will also starve other vCPUs.
>  		 */
> -		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
> -			cond_resched_lock(&kvm->mmu_lock);
> +		cond_resched_lock(&kvm->mmu_lock);
>  
>  		next = stage2_pgd_addr_end(addr, end);
>  		if (stage2_pgd_present(*pgd))
> -- 
> 2.7.4
> 
