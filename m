From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 20 Jul 2016 18:04:20 +0100
Subject: [PATCH v7 00/15] kvmtool: arm: ITS emulation and GSI routing support
Message-ID: <20160720170435.28090-1-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series teaches kvmtool how to support KVM's ITS emulation. Also
(as this is somewhat related and has been co-developed) it enables GSI
routing for ARM/ARM64, which allows IRQFDs to be used, for instance
to use vhost_net. At the moment this is dependent on the guest
using the ITS emulation, but GICv2M support may be added at later time.

The first 5 patches are generic fixes and refactoring to pave the
road for the rest of the patches. Most importantly patch 3/15 pulls
the GSI routing code from x86 into generic code.
The following 6 patches add ITS emulation support. They reserve and
register the required ITS register frame and populate a DT node with
the necessary data. Also the patches add the device ID to the
KVM_SIGNAL_MSI ioctl.
Patches 12/15 and 13/15 enable IRQ GSI routing for ARM/ARM64.
This is needed to use IRQFDs, which is a prerequisite for vhost
functionality, for instance. The code sets up the (dummy) SPI
routing table and adds the device ID to the routing entry.
Patch 14/15 enables the guest ITS support by extending the existing
--irqchip= parameter to allow "--irqchip=gicv3-its".
The final patch adds a workaround the avoid breaking ARM(32)
compilation, which lacks some symbol defines now used in the (shared)
ARM GIC handling code.

The ITS part relates to the latest kernel ITS emulation series, the
IRQ routing code to Eric's respective series [1].
This code can also be found in my kvmtool git repository [2].

Cheers,
Andre.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-July/020950.html
[2] git://linux-arm.org/kvmtool.git (branch: its/v7)
    http://www.linux-arm.org/git?p=kvmtool.git;a=log;h=refs/heads/its/v7

Andre Przywara (15):
  FDT: introduce global phandle allocation
  arm: use new phandle allocation functions
  irq: move IRQ routing into irq.c
  MSI-X: update GSI routing after changed MSI-X configuration
  virtio: fix endianness check for vhost support
  PCI: Only allocate IRQ routing entry when available
  TEMPORARY: update public headers for GICv3 ITS emulation
  arm: allow creation of an MSI register frame region
  arm: FDT: create MSI controller DT node
  add kvm__check_vm_capability
  PCI: inject PCI device ID on MSI injection
  arm: setup SPI IRQ routing tables
  extend GSI IRQ routing to take a device ID
  arm64: enable GICv3-ITS emulation
  arm: gic: allow 32-bit compilation

 Makefile                                 |   5 +-
 arm/aarch32/arm-cpu.c                    |   4 +-
 arm/aarch64/arm-cpu.c                    |   5 +-
 arm/aarch64/include/asm/kvm.h            |   2 +
 arm/fdt.c                                |   8 +-
 arm/gic.c                                | 132 +++++++++++++++++++++++++++++-
 arm/include/arm-common/gic.h             |   3 +-
 arm/include/arm-common/kvm-config-arch.h |   2 +-
 arm/include/arm-common/kvm-cpu-arch.h    |   3 +-
 arm/include/arm-common/pci.h             |   2 +-
 arm/irq.c                                |   9 ---
 arm/pci.c                                |  13 ++-
 hw/pci-shmem.c                           |   5 +-
 include/kvm/fdt.h                        |  10 +--
 include/kvm/irq.h                        |   8 +-
 include/kvm/kvm.h                        |   1 +
 include/kvm/virtio.h                     |   9 ++-
 include/linux/kvm.h                      |  13 ++-
 irq.c                                    | 134 +++++++++++++++++++++++++++++++
 kvm-fdt.c                                |  26 ++++++
 kvm.c                                    |  28 +++++++
 mips/irq.c                               |  10 ---
 powerpc/irq.c                            |  31 -------
 virtio/net.c                             |   2 +-
 virtio/pci.c                             |  87 +++++++++++++++++---
 x86/include/asm/kvm.h                    |   6 +-
 x86/irq.c                                |  45 ++---------
 27 files changed, 466 insertions(+), 137 deletions(-)
 delete mode 100644 arm/irq.c
 create mode 100644 kvm-fdt.c
 delete mode 100644 mips/irq.c
 delete mode 100644 powerpc/irq.c

-- 
2.9.0
