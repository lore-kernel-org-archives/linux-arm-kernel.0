From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Nov 2017 13:47:38 +0000
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <20171113131000.GA10546@hc>
References: <20171113131000.GA10546@hc>
Message-ID: <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/17 13:10, Jan Glauber wrote:
> I'm seeing RCU stalls in the host with 4.14 when I run KVM on ARM64 (ThunderX2) with a high
> number of vcpus (60). I only use one guest that does kernel compiles in

Is that only reproducible on 4.14? With or without VHE? Can you
reproduce this on another implementation (such as ThunderX-1)?

> a loop. After some hours (less likely the more debugging options are
> enabled, more likely with more vcpus) RCU stalls are happening in both host & guest.
> 
> Both host & guest recover after some time, until the issue is triggered
> again. 
> 
> Stack traces in the guest are next to useless, everything is messed up
> there. The host seems to stave on kvm->mmu_lock spin lock, the lock_stat

Please elaborate. Messed in what way? Corrupted? The guest crashing? Or
is that a tooling issue?

> numbers don't look good, see waittime-max:
> 
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                               class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
> -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>                 &(&kvm->mmu_lock)->rlock:      99346764       99406604           0.14  1321260806.59 710654434972.0        7148.97      154228320      225122857           0.13   917688890.60  3705916481.39          16.46
>                 ------------------------
>                 &(&kvm->mmu_lock)->rlock       99365598          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
>                 &(&kvm->mmu_lock)->rlock          25164          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
>                 &(&kvm->mmu_lock)->rlock          14934          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
>                 &(&kvm->mmu_lock)->rlock            908          [<ffff00000810a1f0>] __cond_resched_lock+0x68/0xb8
>                 ------------------------
>                 &(&kvm->mmu_lock)->rlock              3          [<ffff0000080b34c8>] stage2_flush_vm+0x60/0xd8
>                 &(&kvm->mmu_lock)->rlock       99186296          [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
>                 &(&kvm->mmu_lock)->rlock         179238          [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
>                 &(&kvm->mmu_lock)->rlock          19181          [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
> 
> .............................................................................................................................................................................................................................
[slots of stuff]

Well, the mmu_lock is clearly contended. Is the box in a state where you
are swapping? There seem to be as many faults as contentions, which is a
bit surprising...

Also, we recently moved arm64 to qrwlocks, which may have an impact.
Care to give this[1] a go and report the result?

Thanks,

	M.

[1]: https://lkml.org/lkml/2017/10/12/266
-- 
Jazz is not dead. It just smells funny...
