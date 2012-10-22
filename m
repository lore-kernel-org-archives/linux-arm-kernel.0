From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 22 Oct 2012 02:51:11 -0400
Subject: [PATCH v3 00/13] KVM/ARM vGIC support
Message-ID: <20121022065104.18672.52989.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for the virtual generic
interrupt controller architecture for KVM/ARM.

Changes since v2:
 - Get rid of hardcoded guest cpu and distributor physical addresses
   and instead provide the address through the KVM_SET_DEVICE_ADDRESS
   ioctl.
 - Fix level/edge bugs
 - Fix reboot bug: retire queued, disabled interrupts

This patch series can also be pulled from:
    git://github.com/virtualopensystems/linux-kvm-arm.git
            branch: kvm-arm-v13-vgic


---

Christoffer Dall (2):
      KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
      ARM: KVM: VGIC accept vcpu and dist base addresses from user space

Marc Zyngier (11):
      ARM: KVM: Keep track of currently running vcpus
      ARM: KVM: Initial VGIC infrastructure support
      ARM: KVM: Initial VGIC MMIO support code
      ARM: KVM: VGIC distributor handling
      ARM: KVM: VGIC virtual CPU interface management
      ARM: KVM: vgic: retire queued, disabled interrupts
      ARM: KVM: VGIC interrupt injection
      ARM: KVM: VGIC control interface world switch
      ARM: KVM: VGIC initialisation code
      ARM: KVM: vgic: reduce the number of vcpu kick
      ARM: KVM: Add VGIC configuration option


 Documentation/virtual/kvm/api.txt |   37 +
 arch/arm/include/asm/kvm_arm.h    |   12 
 arch/arm/include/asm/kvm_host.h   |   17 +
 arch/arm/include/asm/kvm_mmu.h    |    2 
 arch/arm/include/asm/kvm_vgic.h   |  320 +++++++++
 arch/arm/include/uapi/asm/kvm.h   |   13 
 arch/arm/kernel/asm-offsets.c     |   12 
 arch/arm/kvm/Kconfig              |    7 
 arch/arm/kvm/Makefile             |    1 
 arch/arm/kvm/arm.c                |  138 ++++
 arch/arm/kvm/interrupts.S         |    4 
 arch/arm/kvm/interrupts_head.S    |   68 ++
 arch/arm/kvm/mmio.c               |    3 
 arch/arm/kvm/vgic.c               | 1251 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |    8 
 virt/kvm/kvm_main.c               |    5 
 16 files changed, 1893 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/kvm/vgic.c

-- 
