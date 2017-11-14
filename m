From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 14 Nov 2017 08:52:49 +0100
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
References: <20171113131000.GA10546@hc>
 <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com>
 <20171113173552.GA13282@hc>
 <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
Message-ID: <20171114075249.GB16731@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 06:11:19PM +0000, Marc Zyngier wrote:
> On 13/11/17 17:35, Jan Glauber wrote:

[...]

> >>> numbers don't look good, see waittime-max:
> >>>
> >>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> >>>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> >>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> >>>
> >>>                 &(&kvm->mmu_lock)->rlock:      99346764       99406604           0.14  1321260806.59 710654434972.0        7148.97      154228320      225122857           0.13   917688890.60  3705916481.39          16.46
> >>>                 ------------------------
> >>>                 &(&kvm->mmu_lock)->rlock       99365598          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
> >>>                 &(&kvm->mmu_lock)->rlock          25164          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
> >>>                 &(&kvm->mmu_lock)->rlock          14934          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
> >>>                 &(&kvm->mmu_lock)->rlock            908          [<ffff00000810a1f0>] __cond_resched_lock+0x68/0xb8
> >>>                 ------------------------
> >>>                 &(&kvm->mmu_lock)->rlock              3          [<ffff0000080b34c8>] stage2_flush_vm+0x60/0xd8
> >>>                 &(&kvm->mmu_lock)->rlock       99186296          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
> >>>                 &(&kvm->mmu_lock)->rlock         179238          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
> >>>                 &(&kvm->mmu_lock)->rlock          19181          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
> >>>
> >>> .............................................................................................................................................................................................................................
> >> [slots of stuff]
> >>
> >> Well, the mmu_lock is clearly contended. Is the box in a state where you
> >> are swapping? There seem to be as many faults as contentions, which is a
> >> bit surprising...
> > 
> > I don't think it is swapping but need to double check.
> 
> It is the number of aborts that is staggering. And each one of them
> leads to the mmu_lock being contended. So something seems to be taking
> its sweet time holding the damned lock.

Can you elaborate on the aborts, I'm not familiar with KVM but from a
first look I thought kvm_handle_guest_abort() is in the normal path
when a vcpu is stopped. Is that wrong?

--Jan
