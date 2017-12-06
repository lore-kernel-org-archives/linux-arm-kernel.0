From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 6 Dec 2017 14:23:38 +0000
Subject: 4.15-rc1 crash on Midway in teardown_hyp_mode()
In-Reply-To: <45e72322-52dd-4fdb-2e51-176524fb56a8@arm.com>
References: <45e72322-52dd-4fdb-2e51-176524fb56a8@arm.com>
Message-ID: <b54e7124-daba-1cea-7f9c-584b0d8ad46e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/17 14:11, Andre Przywara wrote:
> Hi,
> 
> while trying to boot 4.15-rc1 on my Calxeda Midway I observed a crash
> (see below). I can't look further into this today, but wanted to report
> this anyway.
> 
> Digging around a bit this is due to the VGIC not initializing properly
> due to GICC being advertised as just 4K, not 8K.
> This can be worked around by adjusting the DT or using
> irqchip.gicv2_force_probe. However this still raises some questions:
> 1) Even if the VGIC fails to register, we should certainly not crash.
> The chain of events seems to be:
> virt/kvm/arm/arm.c:init_subsystems():
>   - kvm_vgic_hyp_init() returns -ENODEV, this leads to vgic_present
>     being set to false, but "err" being reset to 0 (meaning: carry on).
>     However this seems now to miss some initialization.
>   - kvm_timer_hyp_init() now fails on calling irq_set_vcpu_affinity(),
>     because this returns -ENOSYS. This leads to it returning this error,
>     init_subsystems() failing and subsequently tearing down KVM.
>   - This seems to have some bug and leads to the kernel crash.
> 
> Even with the VGIC not being usable, we should be able to cleanly tear
> down KVM (or HYP?).
> 
> 2) Is it intended that an unusable VGIC now denies KVM entirely? I
> believe in the past we could live with that (no arch timer
> virtualization, no in-kernel GIC emulation) and rely on userland
> emulation (for instance in QEMU). This seemed to have changed now?
> 3) Wouldn't it be smarter to fix up the GICC range by default, if we
> have enough evidence that the GICC is actually 8K? Shouldn't this be
> true for every architecture compliant GICv2, actually? So whenever we
> see "arm,cortex-a15-gic", for instance, we force GICC to 8K?
> Or do we know of GICs which have only 4K, but advertise themselves
> wrongly? Otherwise this could just go as some firmware quirk, based on a
> compatible string, for instance, or some ID registers.

I'm certainly not willing to blindly apply some range extension to the
the GIC registers without the user telling me that it is safe to do so.
There is too much quirky HW out there to do otherwise. How can you prove
that because you see "arm,cortex-a15-gic", you can safely extend the
range to 8K?

The rational is: you don't describe the HW correctly, you don't get a
working kernel. I don't think that's something new.

> The reason I am asking is that the Midway loads the DT from firmware
> flash, and this one hasn't changed in years (for obvious reasons). So
> while *I* am able to update the DT in the SPI flash, I guess many users
> just won't do so, so they are left with a crashing kernel (or loosing
> KVM), starting from 4.15. All the previous kernels booted and ran KVM
> guests fine in the past with the existing DT.

Which is why these people now get a kernel option that says "my firmware
is busted, do as I say".

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
