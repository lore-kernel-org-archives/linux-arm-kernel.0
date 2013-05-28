From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 27 May 2013 19:15:28 -0700
Subject: [PATCH v3 6/7] ARM: KVM: get rid of S2_PGD_SIZE
In-Reply-To: <1368529900-22572-7-git-send-email-marc.zyngier@arm.com>
References: <1368529900-22572-1-git-send-email-marc.zyngier@arm.com>
 <1368529900-22572-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20130528021528.GG16071@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 12:11:39PM +0100, Marc Zyngier wrote:
> S2_PGD_SIZE defines the number of pages used by a stage-2 PGD
> and is unused, except for a VM_BUG_ON check that missuses the
> define.
> 
> As the check is very unlikely to ever triggered except in
> circumstances where KVM is the least of our worries, just kill
> both the define and the VM_BUG_ON check.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/kvm_arm.h | 1 -
>  arch/arm/kvm/mmu.c             | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> index 124623e..64e9696 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -135,7 +135,6 @@
>  #define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1ULL)
>  #define PTRS_PER_S2_PGD	(1ULL << (KVM_PHYS_SHIFT - 30))
>  #define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
> -#define S2_PGD_SIZE	(1 << S2_PGD_ORDER)
>  
>  /* Virtualization Translation Control Register (VTCR) bits */
>  #define VTCR_SH0	(3 << 12)
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 451bad3..693d16c 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -382,9 +382,6 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
>  	if (!pgd)
>  		return -ENOMEM;
>  
> -	/* stage-2 pgd must be aligned to its size */
> -	VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));
> -
>  	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
>  	kvm_clean_pgd(pgd);
>  	kvm->arch.pgd = pgd;
> -- 
> 1.8.2.3
> 
> 
Thanks for spotting this, applied.

-Christoffer
