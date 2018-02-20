From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 20 Feb 2018 13:01:17 +0000
Subject: [PATCH 0/3] drm/rockchip: VOP interrupt fixes
Message-ID: <20180220130120.5254-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series fixes a number of issues that I found while trying
to get kexec working on the Chromebook Plus (aka rk3399-gru-kevin) in
order to use it as some sort of interactive bootloader.

The main issue is that the vop driver expects the interrupts to be
cleared and disabled when booting. Nothing could be more wrong. The
device should be expected to be alive and screaming, and it is the
driver's job to put it back into a sane state.

This is what the first patch does, making sure the interrupt is
requested only when the device has been put back into a known
state. Given that this is an observable bug that has been around for a
while, I've tagged it with a Cc: stable.

The two following patches are less important: Using memcpy on MMIO
ranges is plain wrong, and using spin_lock_irqsave in irq context is
slightly pointless.

With these patches in, I'm able to get kexec to work. There is still
some funny issues at the iommu level, but that's for another day.

Patches on top of 4.16-rc2.

Marc Zyngier (3):
  drm/rockchip: Clear all interrupts before requesting the IRQ
  drm/rockchip: Do not use memcpy for MMIO addresses
  drm/rockchip: Don't use spin_lock_irqsave in interrupt context

 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 44 +++++++++++++++--------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.14.2
