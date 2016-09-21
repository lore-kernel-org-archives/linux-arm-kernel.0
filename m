From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 Sep 2016 12:23:26 +0200
Subject: [PATCH] KVM: arm/arm64: timer: Fix hw sync for user space
 irqchip path
In-Reply-To: <57E171AF.1080903@arm.com>
References: <1474002971-31434-1-git-send-email-agraf@suse.de>
 <57E171AF.1080903@arm.com>
Message-ID: <20160921102326.GA9101@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 06:28:15PM +0100, Marc Zyngier wrote:
> Alex,
> 
> On 16/09/16 06:16, Alexander Graf wrote:
> > While adding the new vgic implementation, apparently nobody tested
> > the non-vgic path where user space controls the vgic, so two functions
> > slipped through the cracks that get called in generic code but don't
> > check whether hardware support is enabled.
> > 
> > This patch guards them with proper checks to ensure we only try to
> > use vgic data structures if they are available. Without this, I get
> > a stack trace:
> > 
> > [   74.363037] Unable to handle kernel paging request at virtual address ffffffffffffffe8
> > [...]
> > [   74.929654] [<ffff000008824bcc>] _raw_spin_lock+0x1c/0x58
> > [   74.935133] [<ffff0000080b7f20>] kvm_vgic_flush_hwstate+0x88/0x288
> > [   74.941406] [<ffff0000080ab0b4>] kvm_arch_vcpu_ioctl_run+0xfc/0x630
> > [   74.947766] [<ffff0000080a15bc>] kvm_vcpu_ioctl+0x2f4/0x710
> > [   74.953420] [<ffff0000082788a8>] do_vfs_ioctl+0xb0/0x728
> > [   74.958807] [<ffff000008278fb4>] SyS_ioctl+0x94/0xa8
> > [   74.963844] [<ffff000008083744>] el0_svc_naked+0x38/0x3c
> > 
> > Fixes: 0919e84c0
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Alexander Graf <agraf@suse.de>
> > ---
> >  virt/kvm/arm/vgic/vgic.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
> > index e83b7fe..9f312ba 100644
> > --- a/virt/kvm/arm/vgic/vgic.c
> > +++ b/virt/kvm/arm/vgic/vgic.c
> > @@ -645,6 +645,9 @@ next:
> >  /* Sync back the hardware VGIC state into our emulation after a guest's run. */
> >  void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
> >  {
> > +	if (!vcpu->kvm->arch.vgic.enabled)
> > +		return;
> > +
> >  	vgic_process_maintenance_interrupt(vcpu);
> >  	vgic_fold_lr_state(vcpu);
> >  	vgic_prune_ap_list(vcpu);
> > @@ -653,6 +656,9 @@ void kvm_vgic_sync_hwstate(struct kvm_vcpu *vcpu)
> >  /* Flush our emulation state into the GIC hardware before entering the guest. */
> >  void kvm_vgic_flush_hwstate(struct kvm_vcpu *vcpu)
> >  {
> > +	if (!vcpu->kvm->arch.vgic.enabled)
> > +		return;
> > +

this is not correct, because it checks if the distributor is enabled,
not if the vgic as a thing in KVM is enabled.  (The distributor can be
disabled, but a VCPU should still be able to EOI an active interrupt,
for example).

So this check should be
    if (!vgic_initialized(vcpu->kvm))
        return;


> >  	spin_lock(&vcpu->arch.vgic_cpu.ap_list_lock);
> >  	vgic_flush_lr_state(vcpu);
> >  	spin_unlock(&vcpu->arch.vgic_cpu.ap_list_lock);
> > 
> 
> I hate that fix, because it papers over the fact that we have uninitialized
> structures all over the shop, and that's not exactly great.

I'm not completely convinced about this, because we have
vgic_initialized() checks in the arch timer code as well, and I can't
easily figure out if initializing all data structures etc. to a shim
would work for all vgic interactions.

Basically, I think we have a choice between

(1) locate *all* entry points to the gic code, and make sure they're
guarded with vgic_initialized(), or

(2) do something like you suggest and still go through all interactions
between the vgic and the rest of the system and ensure that whatever
shim/empty data structures we've allocated, actually end up doing the
right thing.

My gut feeling is to lean towards (1), but I don't feel overly strongly
about that.

FWIW: A few comments on the patch below:

> 
> How about the following instead:
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index c94b90d..0961128 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -472,6 +472,9 @@ static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
>  			return ret;
>  	}
>  
> +	if (unlikely(!irqchip_in_kernel(kvm)))
> +		kvm_no_vgic_init(kvm);
> +
>  	/*
>  	 * Enable the arch timers only if we have an in-kernel VGIC
>  	 * and it has been properly initialized, since we cannot handle
> diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
> index bb46c03..1b70b1e 100644
> --- a/include/kvm/arm_vgic.h
> +++ b/include/kvm/arm_vgic.h
> @@ -327,4 +327,6 @@ int kvm_send_userspace_msi(struct kvm *kvm, struct kvm_msi *msi);
>   */
>  int kvm_vgic_setup_default_irq_routing(struct kvm *kvm);
>  
> +void kvm_no_vgic_init(struct kvm *kvm);
> +
>  #endif /* __KVM_ARM_VGIC_H */
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 83777c1..7b8f12b 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -151,9 +151,11 @@ static int kvm_vgic_dist_init(struct kvm *kvm, unsigned int nr_spis)
>  	INIT_LIST_HEAD(&dist->lpi_list_head);
>  	spin_lock_init(&dist->lpi_list_lock);
>  
> -	dist->spis = kcalloc(nr_spis, sizeof(struct vgic_irq), GFP_KERNEL);
> -	if (!dist->spis)
> -		return  -ENOMEM;
> +	if (nr_spis) {
> +		dist->spis = kcalloc(nr_spis, sizeof(struct vgic_irq), GFP_KERNEL);
> +		if (!dist->spis)
> +			return  -ENOMEM;
> +	}

Don't we still end up with dist->spis pointing to nothing if there
hasn't been an init and nr_spis == 0 ?

Perhaps that's not a problem, but I don't easily understand which parts
of the vgic structure we must initialize and which we don't.


>  
>  	/*
>  	 * In the following code we do not take the irq struct lock since
> @@ -325,6 +327,21 @@ int vgic_lazy_init(struct kvm *kvm)
>  	return ret;
>  }
>  
> +void kvm_no_vgic_init(struct kvm *kvm)
> +{
> +	mutex_lock(&kvm->lock);
> +	if (unlikely(!vgic_initialized(kvm))) {
> +		struct kvm_vcpu *vcpu;
> +		int i;
> +
> +		kvm_vgic_dist_init(kvm, 0);

I think you need to check the return value here, unless the rationale is
that when passing 0 as the second argument, it cannot fail.  That's a
pretty brittle construct though, IMHO.

> +		kvm_for_each_vcpu(i, vcpu, kvm)
> +			kvm_vgic_vcpu_init(vcpu);
> +		kvm->arch.vgic.initialized = true;
> +	}
> +	mutex_unlock(&kvm->lock);
> +}
> +
>  /* RESOURCE MAPPING */
>  
>  /**
> 

Thanks,
-Christoffer
