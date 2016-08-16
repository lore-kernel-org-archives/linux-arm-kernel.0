From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 16 Aug 2016 11:46:51 +0100
Subject: [PATCH v2 0/7] ARM: KVM: Support for vgic-v3
Message-ID: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is an attempt to make use vgic-v3 under arch/arm since save-restore
functionality got re-written in C and can be shared between arm/arm64
like it has already been done for vgic-v2 and timer.

With this patches I'm able to get 32 core ARMv7 guest boot:

...
GICv3: CPU31: found redistributor 703 region 0:0x000000003ffd0000
CPU31: thread -1, cpu 3, socket 7, mpidr 80000703
Brought up 32 CPUs
SMP: Total of 32 processors activated (768.00 BogoMIPS).
CPU: All CPU(s) started in SVC mode.
...

Additionally, quite lightweight test based on Self IPI guest test[1]
has been run with up to 255 cpus.

[1] http://www.spinics.net/lists/kvm/msg128974.html

Changelog:

    v1 -> v2
       - rebased on v4.8-rc2
       - introduced guard for ITS code

Thanks!

Vladimir Murzin (7):
  arm64: KVM: Move GIC accessors to arch_gicv3.h
  arm64: KVM: Move vgic-v3 save/restore to virt/kvm/arm/hyp
  KVM: arm: vgic-new: improve compatibility with 32-bit
  ARM: update MPIDR accessors macro
  ARM: move system register accessors to asm/cp15.h
  ARM: KVM: Get ready to use vgic-v3
  ARM: KVM: Unlock vgic-v3 support

 arch/arm/include/asm/arch_gicv3.h                 |   91 +++++++++++++++++----
 arch/arm/include/asm/cp15.h                       |   15 ++++
 arch/arm/include/asm/cputype.h                    |    3 +-
 arch/arm/include/asm/kvm_asm.h                    |    3 +
 arch/arm/include/asm/kvm_host.h                   |    4 +
 arch/arm/include/asm/kvm_hyp.h                    |   20 ++---
 arch/arm/include/uapi/asm/kvm.h                   |    7 ++
 arch/arm/kvm/Makefile                             |    2 +
 arch/arm/kvm/coproc.c                             |   36 ++++++++
 arch/arm/kvm/hyp/Makefile                         |    1 +
 arch/arm/kvm/hyp/switch.c                         |   20 ++++-
 arch/arm64/include/asm/arch_gicv3.h               |   13 +++
 arch/arm64/kvm/Kconfig                            |    4 +-
 arch/arm64/kvm/hyp/Makefile                       |    2 +-
 include/kvm/arm_vgic.h                            |    8 --
 {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c |   13 ---
 virt/kvm/arm/vgic/vgic-kvm-device.c               |   10 +--
 virt/kvm/arm/vgic/vgic-mmio-v3.c                  |    8 +-
 virt/kvm/arm/vgic/vgic-mmio.c                     |    2 -
 virt/kvm/arm/vgic/vgic-mmio.h                     |    5 +-
 virt/kvm/arm/vgic/vgic.h                          |   54 +-----------
 21 files changed, 195 insertions(+), 126 deletions(-)
 rename {arch/arm64/kvm => virt/kvm/arm}/hyp/vgic-v3-sr.c (96%)

-- 
1.7.9.5
