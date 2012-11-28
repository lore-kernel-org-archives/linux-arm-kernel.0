From: will.deacon@arm.com (Will Deacon)
Date: Wed, 28 Nov 2012 14:13:28 +0000
Subject: [PATCH v4 03/13] ARM: KVM: Initial VGIC infrastructure support
In-Reply-To: <50B60D11.7000904@arm.com>
References: <20121110154358.3061.16338.stgit@chazy-air>
 <20121110154437.3061.76180.stgit@chazy-air>
 <20121128124955.GE21671@mudshark.cambridge.arm.com>
 <50B60D11.7000904@arm.com>
Message-ID: <20121128141328.GI21671@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 01:09:37PM +0000, Marc Zyngier wrote:
> On 28/11/12 12:49, Will Deacon wrote:
> > On Sat, Nov 10, 2012 at 03:44:37PM +0000, Christoffer Dall wrote:
> >> @@ -363,7 +370,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
> >>   */
> >>  int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
> >>  {
> >> -	return !!v->arch.irq_lines;
> >> +	return !!v->arch.irq_lines || kvm_vgic_vcpu_pending_irq(v);
> >>  }
> > 
> > So interrupt injection without the in-kernel GIC updates irq_lines, but the
> > in-kernel GIC has its own separate data structures? Why can't the in-kernel GIC
> > just use irq_lines instead of irq_pending_on_cpu?
> 
> They serve very different purposes:
> - irq_lines directly controls the IRQ and FIQ lines (it is or-ed into
> the HCR register before entering the guest)
> - irq_pending_on_cpu deals with the CPU interface, and only that. Plus,
> it is a kernel only thing. What triggers the interrupt on the guest is
> the presence of list registers with a pending state.
> 
> You signal interrupts one way or the other.

Ok, thanks for the explanation. I suspect that we could use (another)
cosmetic change then. How about cpui_irq_pending and hcr_irq_pending?

> >>  int kvm_arch_vcpu_in_guest_mode(struct kvm_vcpu *v)
> >> @@ -633,6 +640,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >>  
> >>  		update_vttbr(vcpu->kvm);
> >>  
> >> +		kvm_vgic_sync_to_cpu(vcpu);
> >> +
> >>  		local_irq_disable();
> >>  
> >>  		/*
> >> @@ -645,6 +654,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
> >>  
> >>  		if (ret <= 0 || need_new_vmid_gen(vcpu->kvm)) {
> >>  			local_irq_enable();
> >> +			kvm_vgic_sync_from_cpu(vcpu);
> >>  			continue;
> >>  		}
> > 
> > For VFP, we use different terminology (sync and flush). I don't think they're
> > any clearer than what you have, but the consistency would be nice.
> 
> Which one maps to which?

sync:	hardware -> data structure
flush:	data structure -> hardware

> > Given that both these functions are run with interrupts enabled, why doesn't
> > the second require a lock for updating dist->irq_pending_on_cpu? I notice
> > there's a random smp_mb() over there...
> 
> Updating *only* irq_pending_on_cpu doesn't require the lock (set_bit()
> should be safe, and I think the smp_mb() is a leftover of some debugging
> hack). kvm_vgic_to_cpu() does a lot more (it picks interrupt from the
> distributor, hence requires the lock to be taken).

Ok, if the barrier is just a hangover from something else and you don't have
any races with test/clear operations then you should be alright.

Will
