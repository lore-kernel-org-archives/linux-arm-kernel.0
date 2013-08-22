From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 22 Aug 2013 17:47:47 +0100
Subject: [PATCH 0/3] ARM: PCI: versatile: fix irqs, I/O
Message-ID: <1377190070-7305-1-git-send-email-peter.maydell@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix a number of issues with the PCI controller
code for mach-versatile:

(1) The irq mapping matched neither hardware nor QEMU; we correct
it to match the hardware, which means it will also work on recent
(1.5 or later) QEMU.

(2) The code was confused between the PCI I/O window (at 0x43000000)
and the first PCI memory window (at 0x44000000), which meant that
PCI devices using PCI PIO rather than MMIO didn't work. This is
fixed (and some variables/labels are renamed to avoid further
confusion in future).

(3) The SMAP register offsets were all off-by-four, though by
fluke this didn't actually have any ill effects.

All these changes have been tested on real hardware (PB926
plus the PCI backplane), as well as on QEMU. I have confirmed
that IRQs and PCI PIO and MMIO work OK. 

PCI bus-master DMA doesn't seem to work on h/w -- as far as I can
tell the device is correctly managing to DMA to the right places
in memory, but every other 32 bit word is corrupt (at least judging
from rtl8139 debug dumps of the frames it's receiving). I'm not
sure what's going on here, but since this is disjoint from
the irq and I/O issues I don't think that applying the
patches that fix those should be stalled on trying to debug
DMA problems. (DMA works fine on QEMU, incidentally.)

Patches based on mainline master.

Peter Maydell (3):
  ARM: PCI: versatile: Fix map_irq function to match hardware
  ARM: PCI: versatile: Fix PCI I/O
  ARM: PCI: versatile: Fix SMAP register offsets

 arch/arm/mach-versatile/include/mach/platform.h |    2 +
 arch/arm/mach-versatile/pci.c                   |   47 +++++++++++++++--------
 2 files changed, 32 insertions(+), 17 deletions(-)

-- 
1.7.9.5
