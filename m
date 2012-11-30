From: will.deacon@arm.com (Will Deacon)
Date: Fri, 30 Nov 2012 15:15:00 +0000
Subject: [PATCH v4 08/14] KVM: ARM: World-switch implementation
In-Reply-To: <CANM98qJFFP=2ueyUpbN6x15XwtWXbgZjkMBaq2jVpqik4kT54Q@mail.gmail.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154306.2836.93473.stgit@chazy-air>
 <20121119145758.GA3205@mudshark.cambridge.arm.com>
 <CANM98qJFFP=2ueyUpbN6x15XwtWXbgZjkMBaq2jVpqik4kT54Q@mail.gmail.com>
Message-ID: <20121130151500.GC26289@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 30, 2012 at 06:37:04AM +0000, Christoffer Dall wrote:
> On Mon, Nov 19, 2012 at 9:57 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > I must be missing something here: how do you ensure that a guest running
> > on multiple CPUs continues to have the same VMID across them after a
> > rollover?
> >
> 
> when a roll over occurs, there's no problem until someone comes along
> that doesn't have a valid vmid (need_new_vmid_gen will return true).

Well a roll-over is triggered by somebody not having a valid VMID and us
failing to allocate a new one from the current generation.

> In this case, to assign a vmid, we need to start a new generation of
> id's to assign one, and must ensure that all old vmid's are no longer
> used. So how do we ensure that?
> 
> Well, we increment the kvm_vmid_gen, causing all other cpus who try to
> run a VM to hit the spin_lock if they exit the VMs. We reserve the
> vmid 1 for the new cpu, and we call on_each_cpu, which causes an ipi
> to all other physical cpus, and waits until the other physical cpus
> actually complete reset_vm_context.
> 
> At this point, once on_each_cpu(reset_vm_context) returns, all other
> physical CPUs have cleared their data structures for occurences of old
> vmids, and the kvm_vmid_gen has been incremented, so no other vcpus
> can come and claim other vmids until we unlock the spinlock, and
> everything starts over.
> 
> Makes sense?

Yes, but I still don't understand how you ensure VMID consistency across
different vcpus of the same vm. Imagine the following scenario:

We have two VMs:

	VM0: VCPU0 on physical CPU0, VCPU1 on physical CPU1
	VM1: VCPU0 on physical CPU2

Also assume that VM0 is happily running and we want to schedule VM1 for
the first time. Finally, also assume that kvm_next_vmid is zero (that is,
the next allocation will trigger a roll-over).

Now, we want to schedule VM1:


	kvm_arch_init_vm
		kvm->arch.vmid_gen = 0;
	kvm_arch_vcpu_ioctl_run
		update_vttbr
			need_new_vmid_gen == true
			lock(kvm_vmid_lock)
			kvm_vmid_gen++;
			kvm_next_vmid = 1;
			on_each_cpu(reset_vm_context);


At this point, the other two (physical) CPUs exit the guest:


	kvm_guest_exit					// Received IRQ from cross-call
	local_irq_enable
		kvm_call_hyp(__kvm_flush_vm_context);	// Invalidate TLB (this is overkill as should be bcast)
	cond_resched;
	update_vttbr
		need_new_vmid_gen == true
		/* spin on kvm_vmid_lock */


I think the __kvm_flush_vm_context is overkill -- you should check
tlb_ops_need_broadcast (which is currently only true for 11MPCore). However,
continuing with this, the other CPU gets its vmid and releases the lock:


			/* receives vmid 1, kvm_next_vmid = 2 */
			unlock(kvm_vmid_lock)
			/* Back to the guest */


Now, let's say that CPU0 takes an interrupt (which it goes off to handle)
and CPU1 grabs the lock:


		lock(kvm_vmid_lock)
		/* CPU1 receives vmid 2, bumps vmid counter */
		unlock(kvm_vmid_lock)
		/* Back to the guest */


At this point, VM1 is running and VM0:VCPU1 is running. VM0:VCPU0 is not
running because physical CPU0 is handling an interrupt. The problem is that
when VCPU0 *is* resumed, it will update the VMID of VM0 and could be
scheduled in parallel with VCPU1 but with a different VMID.

How do you avoid this in the current code?

Will
