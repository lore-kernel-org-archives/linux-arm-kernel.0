From: christoffer.dall@arm.com (Christoffer Dall)
Date: Fri, 4 May 2018 14:47:42 +0200
Subject: Potential deadlock in vgic
In-Reply-To: <20180504110343.GA10968@hc>
References: <20180504110343.GA10968@hc>
Message-ID: <20180504124742.GG10191@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Fri, May 04, 2018 at 01:03:44PM +0200, Jan Glauber wrote:
> Hi all,
> 
> enabling lockdep I see the following reported in the host when I start a kvm guest:
> 
> [12399.954245]        CPU0                    CPU1
> [12399.958762]        ----                    ----
> [12399.963279]   lock(&(&dist->lpi_list_lock)->rlock);
> [12399.968146]                                local_irq_disable();
> [12399.974052]                                lock(&(&vgic_cpu->ap_list_lock)->rlock);
> [12399.981696]                                lock(&(&dist->lpi_list_lock)->rlock);
> [12399.989081]   <Interrupt>
> [12399.991688]     lock(&(&vgic_cpu->ap_list_lock)->rlock);
> [12399.996989]
>                 *** DEADLOCK ***
> 
> [12400.002897] 2 locks held by qemu-system-aar/5597:
> [12400.007587]  #0: 0000000042beb9dc (&vcpu->mutex){+.+.}, at: kvm_vcpu_ioctl+0x7c/0xa68
> [12400.015411]  #1: 00000000c45d644a (&(&vgic_cpu->ap_list_lock)->rlock){-.-.}, at: kvm_vgic_sync_hwstate+0x8c/0x328
> 
> 
> There is nothing unusual in my config or qemu parameters, I can upload these
> if needed. I see this on ThunderX and ThunderX2 and also with older kernels
> (4.13+ distribution kernel).
> 
> I tried making the lpi_list_lock irq safe but that just leads to different
> warnings. The locking here seems to be quite sophisticated and I'm not familiar
> with it.

That's unfortunate.  The problem here is that we end up violating our
locking order, which stipulates that ap_list_lock must be taken before
the lpi_list_lock.

Give that we can take the ap_list_lock from interrupt context (timers
firing), the only solution I can easily think of is to change
lpi_list_lock takers to disable interrupts as well.

Which warnings did you encounter with that approach?

(I'll try to reproduce on my end).

Thanks,
-Christoffer
