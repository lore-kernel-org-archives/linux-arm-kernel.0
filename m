From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 13:00:15 -0500
Subject: [PATCH v6 00/13] KVM/ARM vGIC support
Message-ID: <20130116180013.29393.49165.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for the virtual generic
interrupt controller architecture for KVM/ARM.

This patch series can also be pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
            branch: kvm-arm-v16-vgic

Changes since v5:
 - Renamed sync_{to,from} to {flush,sync}_hwstate
 - Fix read/write length for acceses shorter than words
 - Cosmetic fixes

Changes since v4:
 - Large number of commenting and formatting changes
 - Don't rely on the vgic_hcr default value
 - Fix bug in irq_fgx expand/collapse functions
 - Sanitize use of bitmaps
 - Do not use elrsr when queueing an interrupt
 - Deassert SGIs and SPIs that have already been queued
 - Set VMCR to 0 on vcpu init
 - Compute number of list registers once at init time
 - Restructure bytemap/bitmap accessor functions
 - Improve readability by adding accessor functions
 - Define GICH_ constants in gic.h and use these in the vgic code
 - Explain SGI handling in comment
 - Error patch and return value fixes and cleanups
 - Use defines instead of all hardcoded IRQ numbers
 - Refactor level interrupt handling
 - Fix several maintenace-interrupt related bugs
 - Add CPU hotplug notifier

Changes since v3:
 - Change struct kvm_device_addr to use 64 bits for ID field

Changes since v2:
 - Get rid of hardcoded guest cpu and distributor physical addresses
   and instead provide the address through the KVM_SET_DEVICE_ADDRESS
   ioctl.
 - Fix level/edge bugs
 - Fix reboot bug: retire queued, disabled interrupts

---

Christoffer Dall (3):
      ARM: gic: add missing distributor defintions
      KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
      ARM: KVM: VGIC accept vcpu and dist base addresses from user space

Marc Zyngier (10):
      ARM: KVM: Keep track of currently running vcpus
      ARM: gic: define GICH offsets for VGIC support
      ARM: KVM: Initial VGIC infrastructure code
      ARM: KVM: VGIC distributor handling
      ARM: KVM: VGIC virtual CPU interface management
      ARM: KVM: vgic: retire queued, disabled interrupts
      ARM: KVM: VGIC interrupt injection
      ARM: KVM: VGIC control interface world switch
      ARM: KVM: VGIC initialisation code
      ARM: KVM: Add VGIC configuration option


 Documentation/virtual/kvm/api.txt   |   38 +
 arch/arm/include/asm/hardware/gic.h |   29 +
 arch/arm/include/asm/kvm_host.h     |   18 
 arch/arm/include/asm/kvm_vgic.h     |  221 +++++
 arch/arm/include/uapi/asm/kvm.h     |   16 
 arch/arm/kernel/asm-offsets.c       |   12 
 arch/arm/kvm/Kconfig                |    8 
 arch/arm/kvm/Makefile               |    1 
 arch/arm/kvm/arm.c                  |  162 +++-
 arch/arm/kvm/interrupts.S           |    4 
 arch/arm/kvm/interrupts_head.S      |   74 ++
 arch/arm/kvm/mmio.c                 |    3 
 arch/arm/kvm/vgic.c                 | 1504 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |    8 
 14 files changed, 2085 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/kvm/vgic.c

-- 
