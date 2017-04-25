From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 25 Apr 2017 17:37:06 +0200
Subject: [PATCH 1/2] kvm: Fix mmu_notifier release race
In-Reply-To: <1493028624-29837-2-git-send-email-suzuki.poulose@arm.com>
References: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
 <1493028624-29837-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170425153706.GK4104@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 11:10:23AM +0100, Suzuki K Poulose wrote:
> The KVM uses mmu_notifier (wherever available) to keep track
> of the changes to the mm of the guest. The guest shadow page
> tables are released when the VM exits via mmu_notifier->ops.release().
> There is a rare chance that the mmu_notifier->release could be
> called more than once via two different paths, which could end
> up in use-after-free of kvm instance (such as [0]).
> 
> e.g:
> 
> thread A                                        thread B
> -------                                         --------------
> 
>  get_signal->                                   kvm_destroy_vm()->
>  do_exit->                                        mmu_notifier_unregister->
>  exit_mm->                                        kvm_arch_flush_shadow_all()->
>  exit_mmap->                                      spin_lock(&kvm->mmu_lock)
>  mmu_notifier_release->                           ....
>   kvm_arch_flush_shadow_all()->                   .....
>   ... spin_lock(&kvm->mmu_lock)                   .....
>                                                   spin_unlock(&kvm->mmu_lock)
>                                                 kvm_arch_free_kvm()
>    *** use after free of kvm ***
> 
> This patch attempts to solve the problem by holding a reference to the KVM
> for the mmu_notifier, which is dropped only from notifier->ops.release().
> This will ensure that the KVM struct is available till we reach the
> kvm_mmu_notifier_release, and the kvm_destroy_vm is called only from/after
> it. So, we can unregister the notifier with no_release option and hence
> avoiding the race above. However, we need to make sure that the KVM is
> freed only after the mmu_notifier has finished processing the notifier due to
> the following possible path of execution :
> 
> mmu_notifier_release -> kvm_mmu_notifier_release -> kvm_put_kvm ->
>   kvm_destroy_vm -> kvm_arch_free_kvm
> 
> [0] http://lkml.kernel.org/r/CAAeHK+x8udHKq9xa1zkTO6ax5E8Dk32HYWfaT05FMchL2cr48g at mail.gmail.com
> 
> Fixes: commit 85db06e514422 ("KVM: mmu_notifiers release method")
> Reported-by: andreyknvl at google.com
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr?m?? <rkrcmar@redhat.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: andreyknvl at google.com
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

This looks good to me, but we should have some KVM generic experts look
at it as well.

 Reviewed-by: Christoffer Dall <cdall@linaro.org>

> ---
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      | 59 ++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d025074..561e968 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -424,6 +424,7 @@ struct kvm {
>  	struct mmu_notifier mmu_notifier;
>  	unsigned long mmu_notifier_seq;
>  	long mmu_notifier_count;
> +	struct rcu_head mmu_notifier_rcu;
>  #endif
>  	long tlbs_dirty;
>  	struct list_head devices;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 88257b3..2c3fdd4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -471,6 +471,7 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
>  	idx = srcu_read_lock(&kvm->srcu);
>  	kvm_arch_flush_shadow_all(kvm);
>  	srcu_read_unlock(&kvm->srcu, idx);
> +	kvm_put_kvm(kvm);
>  }
>  
>  static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
> @@ -486,8 +487,46 @@ static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
>  
>  static int kvm_init_mmu_notifier(struct kvm *kvm)
>  {
> +	int rc;
>  	kvm->mmu_notifier.ops = &kvm_mmu_notifier_ops;
> -	return mmu_notifier_register(&kvm->mmu_notifier, current->mm);
> +	rc = mmu_notifier_register(&kvm->mmu_notifier, current->mm);
> +	/*
> +	 * We hold a reference to KVM here to make sure that the KVM
> +	 * doesn't get free'd before ops->release() completes.
> +	 */
> +	if (!rc)
> +		kvm_get_kvm(kvm);
> +	return rc;
> +}
> +
> +static void kvm_free_vm_rcu(struct rcu_head *rcu)
> +{
> +	struct kvm *kvm = container_of(rcu, struct kvm, mmu_notifier_rcu);
> +	kvm_arch_free_vm(kvm);
> +}
> +
> +static void kvm_flush_shadow_mmu(struct kvm *kvm)
> +{
> +	/*
> +	 * We hold a reference to kvm instance for mmu_notifier and is
> +	 * only released when ops->release() is called via exit_mmap path.
> +	 * So, when we reach here ops->release() has been called already, which
> +	 * flushes the shadow page tables. Hence there is no need to call the
> +	 * release() again when we unregister the notifier. However, we need
> +	 * to delay freeing up the kvm until the release() completes, since
> +	 * we could reach here via :
> +	 *  kvm_mmu_notifier_release() -> kvm_put_kvm() -> kvm_destroy_vm()
> +	 */
> +	mmu_notifier_unregister_no_release(&kvm->mmu_notifier, kvm->mm);
> +}
> +
> +static void kvm_free_vm(struct kvm *kvm)
> +{
> +	/*
> +	 * Wait until the mmu_notifier has finished the release().
> +	 * See comments above in kvm_flush_shadow_mmu.
> +	 */
> +	mmu_notifier_call_srcu(&kvm->mmu_notifier_rcu, kvm_free_vm_rcu);
>  }
>  
>  #else  /* !(CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER) */
> @@ -497,6 +536,16 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
>  	return 0;
>  }
>  
> +static void kvm_flush_shadow_mmu(struct kvm *kvm)
> +{
> +	kvm_arch_flush_shadow_all(kvm);
> +}
> +
> +static void kvm_free_vm(struct kvm *kvm)
> +{
> +	kvm_arch_free_vm(kvm);
> +}
> +
>  #endif /* CONFIG_MMU_NOTIFIER && KVM_ARCH_WANT_MMU_NOTIFIER */
>  
>  static struct kvm_memslots *kvm_alloc_memslots(void)
> @@ -733,18 +782,14 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  		kvm->buses[i] = NULL;
>  	}
>  	kvm_coalesced_mmio_free(kvm);
> -#if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> -	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);
> -#else
> -	kvm_arch_flush_shadow_all(kvm);
> -#endif
> +	kvm_flush_shadow_mmu(kvm);
>  	kvm_arch_destroy_vm(kvm);
>  	kvm_destroy_devices(kvm);
>  	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++)
>  		kvm_free_memslots(kvm, kvm->memslots[i]);
>  	cleanup_srcu_struct(&kvm->irq_srcu);
>  	cleanup_srcu_struct(&kvm->srcu);
> -	kvm_arch_free_vm(kvm);
> +	kvm_free_vm(kvm);
>  	preempt_notifier_dec();
>  	hardware_disable_all();
>  	mmdrop(mm);
> -- 
> 2.7.4
> 
