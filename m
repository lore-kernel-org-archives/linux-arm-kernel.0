From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 15:43:57 +0100
Subject: [PATCH 06/12] KVM: mark kvm->buses as empty once they were
 destroyed
In-Reply-To: <1426263012-22935-7-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-7-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314144357.GL10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:06PM +0000, Andre Przywara wrote:
> In kvm_destroy_vm() we call kvm_io_bus_destroy() pretty early,
> especially before calling kvm_arch_destroy_vm(). To avoid
> unregistering devices from the already destroyed bus, let's mark
> the bus with NULL to let other users know it has been destroyed
> already.
> This avoids a crash on a VM shutdown with the VGIC using the
> kvm_io_bus later (the unregistering is in there to be able to roll
> back a faulting init).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  virt/kvm/kvm_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8c7ab0b..6f164eb 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -604,8 +604,10 @@ static void kvm_destroy_vm(struct kvm *kvm)
>  	list_del(&kvm->vm_list);
>  	spin_unlock(&kvm_lock);
>  	kvm_free_irq_routing(kvm);
> -	for (i = 0; i < KVM_NR_BUSES; i++)
> +	for (i = 0; i < KVM_NR_BUSES; i++) {
>  		kvm_io_bus_destroy(kvm->buses[i]);
> +		kvm->buses[i] = NULL;
> +	}
>  	kvm_coalesced_mmio_free(kvm);
>  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
>  	mmu_notifier_unregister(&kvm->mmu_notifier, kvm->mm);

this smells a bit like papering over an ordering issue with the
teardown, is there no other way to fix it?

-Christoffer
