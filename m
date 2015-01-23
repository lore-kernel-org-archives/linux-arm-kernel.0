From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 23 Jan 2015 11:02:29 +0100
Subject: [GIT PULL 00/36] KVM/ARM changes for 3.20
Message-ID: <1422007385-14730-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Please pull from kvmarm/next for changes adding GICv3 emulation, dirty
page logging, added trace symbols, and adding an explicit VGIC init
device control IOCTL.

The following changes since commit bab5bb398273bb37547a185f7b344b37c700d0b9:

  kvm: x86: Remove kvm_make_request from lapic.c (2015-01-08 22:48:08 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.20

for you to fetch changes up to 4b990589952f0e30aa860184ac6c76219a74632e:

  KVM: Remove unused config symbol (2015-01-23 10:52:03 +0100)

Thanks,
-Christoffer

---

Andre Przywara (21):
      ARM: KVM: extend WFI tracepoint to differentiate between wfi and wfe
      arm/arm64: KVM: rework MPIDR assignment and add accessors
      arm/arm64: KVM: pass down user space provided GIC type into vGIC code
      arm/arm64: KVM: refactor vgic_handle_mmio() function
      arm/arm64: KVM: wrap 64 bit MMIO accesses with two 32 bit ones
      arm/arm64: KVM: introduce per-VM ops
      arm/arm64: KVM: move kvm_register_device_ops() into vGIC probing
      arm/arm64: KVM: dont rely on a valid GICH base address
      arm/arm64: KVM: make the maximum number of vCPUs a per-VM value
      arm/arm64: KVM: make the value of ICC_SRE_EL1 a per-VM variable
      arm/arm64: KVM: refactor MMIO accessors
      arm/arm64: KVM: refactor/wrap vgic_set/get_attr()
      arm/arm64: KVM: add vgic.h header file
      arm/arm64: KVM: split GICv2 specific emulation code from vgic.c
      arm/arm64: KVM: add opaque private pointer to MMIO data
      arm/arm64: KVM: add virtual GICv3 distributor emulation
      arm64: GICv3: introduce symbolic names for GICv3 ICC_SGI1R_EL1 fields
      arm64: KVM: add SGI generation register emulation
      arm/arm64: KVM: enable kernel side of GICv3 emulation
      arm/arm64: KVM: allow userland to request a virtual GICv3
      arm/arm64: KVM: force alignment of VGIC dist/CPU/redist addresses

Christoffer Dall (2):
      arm/arm64: KVM: Fixup incorrect config symbol in comment
      KVM: Remove unused config symbol

Eric Auger (2):
      KVM: arm/arm64: vgic: vgic_init returns -ENODEV when no online vcpu
      KVM: arm/arm64: vgic: add init entry to VGIC KVM device

Mario Smarduch (9):
      KVM: Add architecture-defined TLB flush support
      KVM: Add generic support for dirty page logging
      KVM: arm: Add ARMv7 API to flush TLBs
      KVM: arm: Add initial dirty page locking support
      KVM: arm: dirty logging write protect support
      KVM: arm: page logging 2nd stage fault handling
      KVM: arm64: ARMv8 header changes for page logging
      KVM: arm64: Add HYP interface to flush VM Stage 1/2 TLB entries
      KVM: arm/arm64: Enable Dirty Page logging for ARMv8

Paolo Bonzini (1):
      KVM: x86: switch to kvm_get_dirty_log_protect

Wei Huang (1):
      arm/arm64: KVM: add tracing support for arm64 exit handler

 Documentation/virtual/kvm/api.txt              |   13 +-
 Documentation/virtual/kvm/devices/arm-vgic.txt |   37 +-
 arch/arm/include/asm/kvm_asm.h                 |    1 +
 arch/arm/include/asm/kvm_emulate.h             |    5 +-
 arch/arm/include/asm/kvm_host.h                |    5 +
 arch/arm/include/asm/kvm_mmio.h                |    1 +
 arch/arm/include/asm/kvm_mmu.h                 |   21 +
 arch/arm/include/asm/pgtable-3level.h          |    1 +
 arch/arm/include/uapi/asm/kvm.h                |    2 +
 arch/arm/kvm/Kconfig                           |    2 +
 arch/arm/kvm/Makefile                          |    1 +
 arch/arm/kvm/arm.c                             |   55 +-
 arch/arm/kvm/handle_exit.c                     |    8 +-
 arch/arm/kvm/interrupts.S                      |   11 +
 arch/arm/kvm/mmu.c                             |  257 +++++-
 arch/arm/kvm/psci.c                            |   17 +-
 arch/arm/kvm/trace.h                           |   11 +-
 arch/arm64/include/asm/kvm_arm.h               |    2 +
 arch/arm64/include/asm/kvm_asm.h               |    1 +
 arch/arm64/include/asm/kvm_emulate.h           |   10 +-
 arch/arm64/include/asm/kvm_host.h              |    6 +
 arch/arm64/include/asm/kvm_mmio.h              |    1 +
 arch/arm64/include/asm/kvm_mmu.h               |   21 +
 arch/arm64/include/asm/pgtable-hwdef.h         |    1 +
 arch/arm64/include/uapi/asm/kvm.h              |    9 +
 arch/arm64/kernel/asm-offsets.c                |    1 +
 arch/arm64/kvm/Kconfig                         |    2 +
 arch/arm64/kvm/Makefile                        |    2 +
 arch/arm64/kvm/handle_exit.c                   |   13 +-
 arch/arm64/kvm/hyp.S                           |   22 +
 arch/arm64/kvm/sys_regs.c                      |   40 +-
 arch/arm64/kvm/trace.h                         |   55 ++
 arch/arm64/kvm/vgic-v3-switch.S                |   14 +-
 arch/x86/include/asm/kvm_host.h                |    3 -
 arch/x86/kvm/Kconfig                           |    1 +
 arch/x86/kvm/mmu.c                             |    4 +-
 arch/x86/kvm/x86.c                             |   72 +-
 drivers/irqchip/irq-gic-v3.c                   |   14 +-
 include/kvm/arm_vgic.h                         |   43 +-
 include/linux/irqchip/arm-gic-v3.h             |   44 +
 include/linux/kvm_host.h                       |   11 +
 include/uapi/linux/kvm.h                       |    2 +
 virt/kvm/Kconfig                               |    6 +
 virt/kvm/arm/vgic-v2-emul.c                    |  847 ++++++++++++++++++
 virt/kvm/arm/vgic-v2.c                         |    4 +
 virt/kvm/arm/vgic-v3-emul.c                    | 1036 ++++++++++++++++++++++
 virt/kvm/arm/vgic-v3.c                         |   82 +-
 virt/kvm/arm/vgic.c                            | 1127 ++++++------------------
 virt/kvm/arm/vgic.h                            |  123 +++
 virt/kvm/kvm_main.c                            |   82 ++
 50 files changed, 3153 insertions(+), 996 deletions(-)
 create mode 100644 arch/arm64/kvm/trace.h
 create mode 100644 virt/kvm/arm/vgic-v2-emul.c
 create mode 100644 virt/kvm/arm/vgic-v3-emul.c
 create mode 100644 virt/kvm/arm/vgic.h
