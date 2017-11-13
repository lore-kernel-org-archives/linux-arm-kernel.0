From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Nov 2017 18:11:19 +0000
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <20171113173552.GA13282@hc>
References: <20171113131000.GA10546@hc>
 <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com> <20171113173552.GA13282@hc>
Message-ID: <7dda7be2-f392-8056-d4d3-372bb867729a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/17 17:35, Jan Glauber wrote:
> On Mon, Nov 13, 2017 at 01:47:38PM +0000, Marc Zyngier wrote:
>> On 13/11/17 13:10, Jan Glauber wrote:
>>> I'm seeing RCU stalls in the host with 4.14 when I run KVM on ARM64 (ThunderX2) with a high
>>> number of vcpus (60). I only use one guest that does kernel compiles in
>>
>> Is that only reproducible on 4.14? With or without VHE? Can you
>> reproduce this on another implementation (such as ThunderX-1)?
> 
> I've reproduced it on a distro 4.13 and several vanilla 4.14 rc's and
> tip/locking. VHE is enabled. I've not yet tried to reproduce it with
> older kernels or ThunderX-1. I can check if it happens also on ThunderX-1.

That'd be interesting. Also, what happens if you turn off any form of
multi-threading (as I've been told this system has 4 threads per core)?
Disabling VHE would be interesting too (after all, this is the only box
I know of that has the feature...).

>>> a loop. After some hours (less likely the more debugging options are
>>> enabled, more likely with more vcpus) RCU stalls are happening in both host & guest.
>>>
>>> Both host & guest recover after some time, until the issue is triggered
>>> again. 
>>>
>>> Stack traces in the guest are next to useless, everything is messed up
>>> there. The host seems to stave on kvm->mmu_lock spin lock, the lock_stat
>>
>> Please elaborate. Messed in what way? Corrupted? The guest crashing? Or
>> is that a tooling issue?
> 
> Every vcpu that oopses prints one line in parallel, so I get blocks like:
> [58880.179814] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179834] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179847] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179873] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179893] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179911] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.179917] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180288] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180303] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180336] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180363] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180384] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180415] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> [58880.180461] [<ffff000008084b98>] ret_from_fork+0x10/0x18
> 
> I can send the full log if you want to have a look.

Sure, send that over (maybe not over email though).

> 
>>> numbers don't look good, see waittime-max:
>>>
>>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
>>> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>>>
>>>                 &(&kvm->mmu_lock)->rlock:      99346764       99406604           0.14  1321260806.59 710654434972.0        7148.97      154228320      225122857           0.13   917688890.60  3705916481.39          16.46
>>>                 ------------------------
>>>                 &(&kvm->mmu_lock)->rlock       99365598          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
>>>                 &(&kvm->mmu_lock)->rlock          25164          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
>>>                 &(&kvm->mmu_lock)->rlock          14934          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
>>>                 &(&kvm->mmu_lock)->rlock            908          [<ffff00000810a1f0>] __cond_resched_lock+0x68/0xb8
>>>                 ------------------------
>>>                 &(&kvm->mmu_lock)->rlock              3          [<ffff0000080b34c8>] stage2_flush_vm+0x60/0xd8
>>>                 &(&kvm->mmu_lock)->rlock       99186296          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
>>>                 &(&kvm->mmu_lock)->rlock         179238          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
>>>                 &(&kvm->mmu_lock)->rlock          19181          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
>>>
>>> .............................................................................................................................................................................................................................
>> [slots of stuff]
>>
>> Well, the mmu_lock is clearly contended. Is the box in a state where you
>> are swapping? There seem to be as many faults as contentions, which is a
>> bit surprising...
> 
> I don't think it is swapping but need to double check.

It is the number of aborts that is staggering. And each one of them
leads to the mmu_lock being contended. So something seems to be taking
its sweet time holding the damned lock.

> 
>> Also, we recently moved arm64 to qrwlocks, which may have an impact.
>> Care to give this[1] a go and report the result?
> 
> Sure, I that was my first suspision but I can reproduce the issue with
> and without the qrwlock patches, so these are not to blame. Also, the
> starving lock is a spinlock and not a qrwlock. So maybe the spinlocks
> have fairness issues too?

We use ticket locks, so they should be fine on the host (it is a
different story altogether in a guest).

Can you send me your kernel configuration as well? I wonder if we're not
seeing interactions with things like KSM and the like...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
