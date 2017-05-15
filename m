From: cdall@linaro.org (Christoffer Dall)
Date: Mon, 15 May 2017 12:00:17 +0200
Subject: [PATCH 2/2] kvm: arm/arm64: Fix use after free of stage2 page
 table
In-Reply-To: <1493821072-29713-3-git-send-email-suzuki.poulose@arm.com>
References: <1493821072-29713-1-git-send-email-suzuki.poulose@arm.com>
 <1493821072-29713-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170515100017.GJ9309@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Wed, May 03, 2017 at 03:17:52PM +0100, Suzuki K Poulose wrote:
> We yield the kvm->mmu_lock occassionaly while performing an operation
> (e.g, unmap or permission changes) on a large area of stage2 mappings.
> However this could possibly cause another thread to clear and free up
> the stage2 page tables while we were waiting for regaining the lock and
> thus the original thread could end up in accessing memory that was
> freed. This patch fixes the problem by making sure that the stage2
> pagetable is still valid after we regain the lock. The fact that
> mmu_notifer->release() could be called twice (via __mmu_notifier_release
> and mmu_notifier_unregsister) enhances the possibility of hitting
> this race where there are two threads trying to unmap the entire guest
> shadow pages.
> 
> While at it, cleanup the redudant checks around cond_resched_lock in
> stage2_wp_range(), as cond_resched_lock already does the same checks.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> Cc: andreyknvl at google.com
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/kvm/mmu.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 909a1a7..5b3e0db 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -301,9 +301,14 @@ static void unmap_stage2_range(struct kvm *kvm, phys_addr_t start, u64 size)
>  		/*
>  		 * If the range is too large, release the kvm->mmu_lock
>  		 * to prevent starvation and lockup detector warnings.
> +		 * Make sure the page table is still active when we regain
> +		 * the lock.
>  		 */
> -		if (next != end)
> +		if (next != end) {
>  			cond_resched_lock(&kvm->mmu_lock);
> +			if (!READ_ONCE(kvm->arch.pgd))
> +				break;
> +		}

So I don't think this change is wrong, but I wonder if it's sufficient.
For example, I can see that this function is called from

stage2_unmsp_vm
 -> stage2_unmap_memslot
   -> unmap_stage2_range

and

kvm_arch_flush_shadow_memslot
 -> unmap_stage2_range

which never check if the pgd pointer is valid, and finally
kvm_free_stage2_pgd also checks the pgd pointer outside of holding the
kvm->mmu_lock so why is this not racy?

>  	} while (pgd++, addr = next, addr != end);
>  }
>  
> @@ -1170,11 +1175,13 @@ static void stage2_wp_range(struct kvm *kvm, phys_addr_t addr, phys_addr_t end)
>  		 * large. Otherwise, we may see kernel panics with
>  		 * CONFIG_DETECT_HUNG_TASK, CONFIG_LOCKUP_DETECTOR,
>  		 * CONFIG_LOCKDEP. Additionally, holding the lock too long
> -		 * will also starve other vCPUs.
> +		 * will also starve other vCPUs. We have to also make sure
> +		 * that the page tables are not freed while we released
> +		 * the lock.
>  		 */
> -		if (need_resched() || spin_needbreak(&kvm->mmu_lock))
> -			cond_resched_lock(&kvm->mmu_lock);
> -
> +		cond_resched_lock(&kvm->mmu_lock);
> +		if (!READ_ONCE(kvm->arch.pgd))
> +			break;

Here I suppose you don't have the issue becase you check the pgd pointer
before derefencing it in all cases.

Thanks,
-Christoffer

>  		next = stage2_pgd_addr_end(addr, end);
>  		if (stage2_pgd_present(*pgd))
>  			stage2_wp_puds(pgd, addr, next);
> -- 
> 2.7.4
> 
