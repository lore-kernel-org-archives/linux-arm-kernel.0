From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Mar 2018 14:25:39 +0100
Subject: [PATCH 0/3] drm/rockchip: VOP interrupt fixes
In-Reply-To: <20180220130120.5254-1-marc.zyngier@arm.com>
References: <20180220130120.5254-1-marc.zyngier@arm.com>
Message-ID: <9337520.8DqYEZO4hX@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 20. Februar 2018, 14:01:17 CET schrieb Marc Zyngier:
> This small series fixes a number of issues that I found while trying
> to get kexec working on the Chromebook Plus (aka rk3399-gru-kevin) in
> order to use it as some sort of interactive bootloader.
> 
> The main issue is that the vop driver expects the interrupts to be
> cleared and disabled when booting. Nothing could be more wrong. The
> device should be expected to be alive and screaming, and it is the
> driver's job to put it back into a sane state.
> 
> This is what the first patch does, making sure the interrupt is
> requested only when the device has been put back into a known
> state. Given that this is an observable bug that has been around for a
> while, I've tagged it with a Cc: stable.
> 
> The two following patches are less important: Using memcpy on MMIO
> ranges is plain wrong, and using spin_lock_irqsave in irq context is
> slightly pointless.
> 
> With these patches in, I'm able to get kexec to work. There is still
> some funny issues at the iommu level, but that's for another day.
> 
> Patches on top of 4.16-rc2.
> 
> Marc Zyngier (3):
>   drm/rockchip: Clear all interrupts before requesting the IRQ
>   drm/rockchip: Do not use memcpy for MMIO addresses
>   drm/rockchip: Don't use spin_lock_irqsave in interrupt context

Tested on rk3036 (hdmi), rk3288 (hdmi+edp) and rk3399 (edp) and
applied to drm-misc-next after slightly fixing patch1 for a recent change
to the code around the old request_irq position, so it applies.


Thanks
Heiko
