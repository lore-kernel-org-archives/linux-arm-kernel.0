From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 13:30:32 +0000
Subject: [PATCH 00/18] arm64: GICv3 support
Message-ID: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GICv3 is the base for a new generation of interrupt controllers
designed to overcome some of the most glaring limitations of GICv2.

Some of the features are:
- Support for more than 8 CPUs (a lot more...)
- System registers for CPU interface access (GICC, GICV, GICH)
- Message based interrupts

This patch series currently support:
- Affinity Routing
- System Registers
- Non-Secure Group-1 interrupts only
- KVM support (GICv3 host, GICv2 guest)

What is *not yet* supported in this series:
- LPI/ITS/MSI (patches are available in the below branch,
  though still in development)
- KVM GICv3 guest support (requires GICv3 distributor emulation)
- Any form of power management
- 32bit systems

To be built, this code requires a fairly recent compiler/binutils
combo. Linaro 13.06 seems to do the trick. This has been tested on the
ARM FVP model, with non-regressions run on a VExpress TC-2.

The code is also available at the following location:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv3

Marc Zyngier (18):
  arm64: initial support for GICv3
  arm64: GICv3 device tree binding documentation
  arm64: boot protocol documentation update for GICv3
  KVM: arm/arm64: vgic: move GICv2 registers to their own structure
  KVM: ARM: vgic: introduce vgic_ops and LR manipulation primitives
  KVM: ARM: vgic: abstract access to the ELRSR bitmap
  KVM: ARM: vgic: abstract EISR bitmap access
  KVM: ARM: vgic: abstract MISR decoding
  KVM: ARM: vgic: move underflow handling to vgic_ops
  KVM: ARM: vgic: abstract VMCR access
  KVM: ARM: vgic: introduce vgic_enable
  KVM: ARM: introduce vgic_params structure
  KVM: ARM: vgic: split GICv2 backend from the main vgic code
  arm64: KVM: remove __kvm_hyp_code_{start,end} from hyp.S
  arm64: KVM: split GICv2 world switch from hyp code
  arm64: KVM: move hcr_el2 setting into vgic-v2-switch.S
  KVM: ARM: vgic: add the GICv3 backend
  arm64: KVM: vgic: add GICv3 world switch

 Documentation/arm64/booting.txt                  |   7 +
 Documentation/devicetree/bindings/arm/gic-v3.txt |  81 +++
 arch/arm/include/asm/kvm_host.h                  |   5 +
 arch/arm/kernel/asm-offsets.c                    |  14 +-
 arch/arm/kvm/Makefile                            |   1 +
 arch/arm/kvm/interrupts_head.S                   |  26 +-
 arch/arm64/Kconfig                               |   1 +
 arch/arm64/include/asm/kvm_asm.h                 |  18 +-
 arch/arm64/include/asm/kvm_host.h                |  21 +
 arch/arm64/include/asm/virt.h                    |   4 +
 arch/arm64/kernel/asm-offsets.c                  |  22 +-
 arch/arm64/kernel/head.S                         |  14 +
 arch/arm64/kernel/hyp-stub.S                     |  41 +-
 arch/arm64/kvm/Makefile                          |   4 +
 arch/arm64/kvm/hyp.S                             | 132 +----
 arch/arm64/kvm/vgic-v2-switch.S                  | 149 +++++
 arch/arm64/kvm/vgic-v3-switch.S                  | 275 ++++++++++
 drivers/irqchip/Kconfig                          |   5 +
 drivers/irqchip/Makefile                         |   1 +
 drivers/irqchip/irq-gic-v3.c                     | 665 +++++++++++++++++++++++
 include/kvm/arm_vgic.h                           | 103 +++-
 include/linux/irqchip/arm-gic-v3.h               | 190 +++++++
 virt/kvm/arm/vgic-v2.c                           | 228 ++++++++
 virt/kvm/arm/vgic-v3.c                           | 220 ++++++++
 virt/kvm/arm/vgic.c                              | 330 ++++++-----
 25 files changed, 2238 insertions(+), 319 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gic-v3.txt
 create mode 100644 arch/arm64/kvm/vgic-v2-switch.S
 create mode 100644 arch/arm64/kvm/vgic-v3-switch.S
 create mode 100644 drivers/irqchip/irq-gic-v3.c
 create mode 100644 include/linux/irqchip/arm-gic-v3.h
 create mode 100644 virt/kvm/arm/vgic-v2.c
 create mode 100644 virt/kvm/arm/vgic-v3.c

-- 
1.8.3.4
