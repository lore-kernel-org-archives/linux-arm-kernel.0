From: jan.glauber@caviumnetworks.com (Jan Glauber)
Date: Tue, 14 Nov 2017 08:49:54 +0100
Subject: RCU stall with high number of KVM vcpus
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83845C7B4@FRAEML521-MBX.china.huawei.com>
References: <20171113131000.GA10546@hc>
 <2832f775-3cbe-d984-fe4f-e018642b6f1d@arm.com>
 <20171113173552.GA13282@hc>
 <5FC3163CFD30C246ABAA99954A238FA83845C7B4@FRAEML521-MBX.china.huawei.com>
Message-ID: <20171114074954.GA16731@hc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 13, 2017 at 06:13:08PM +0000, Shameerali Kolothum Thodi wrote:

[...]

> > > > numbers don't look good, see waittime-max:
> > > >
> > > > ---------------------------------------------------------------------------------------------------
> > -------------------------------------------------------------------------------------------------------
> > -------------------
> > > >                               class name    con-bounces    contentions   waittime-min
> > waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions
> > holdtime-min   holdtime-max holdtime-total   holdtime-avg
> > > > ---------------------------------------------------------------------------------------------------
> > -------------------------------------------------------------------------------------------------------
> > -------------------
> > > >
> > > >                 &(&kvm->mmu_lock)->rlock:      99346764       99406604
> > 0.14  1321260806.59 710654434972.0        7148.97      154228320
> > 225122857           0.13   917688890.60  3705916481.39          16.46
> > > >                 ------------------------
> > > >                 &(&kvm->mmu_lock)->rlock       99365598
> > [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
> > > >                 &(&kvm->mmu_lock)->rlock          25164
> > [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
> > > >                 &(&kvm->mmu_lock)->rlock          14934
> > [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
> > > >                 &(&kvm->mmu_lock)->rlock            908
> > [<ffff00000810a1f0>] __cond_resched_lock+0x68/0xb8
> > > >                 ------------------------
> > > >                 &(&kvm->mmu_lock)->rlock              3          [<ffff0000080b34c8>]
> > stage2_flush_vm+0x60/0xd8
> > > >                 &(&kvm->mmu_lock)->rlock       99186296
> > [<ffff0000080b43b8>] kvm_handle_guest_abort+0x4c0/0x950
> > > >                 &(&kvm->mmu_lock)->rlock         179238
> > [<ffff0000080a4e30>] kvm_mmu_notifier_invalidate_range_start+0x70/0xe8
> > > >                 &(&kvm->mmu_lock)->rlock          19181
> > [<ffff0000080a7eec>] kvm_mmu_notifier_invalidate_range_end+0x24/0x68
> 
> That looks like something similar we had on our hip07 platform when multiple VMs
> were launched.  The issue was tracked down to CONFIG_NUMA set with memory_less
> nodes. This results in lot of individual 4K pages and unmap_stage2_ptes() takes a good
> amount of time coupled with some HW cache flush latencies. I am not sure you are
> seeing the same thing, but may be worth checking.

Hi Shameer,

thanks for the tip. We don't have memory-less nodes but it might me
related to NUMA. I've tried putting the guest onto one node but that did
not help.

PID                               Node 0          Node 1           Total
-----------------------  --------------- --------------- ---------------
56753 (qemu-nbd)                    4.48           11.16           15.64
56813 (qemu-system-aar)             2.02         1685.72         1687.75
-----------------------  --------------- --------------- ---------------
Total                               6.51         1696.88         1703.39

I'll try switching to 64K pages in the host next.

thanks,
Jan
