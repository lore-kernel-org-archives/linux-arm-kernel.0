From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:17 +0200
Subject: [GIT PULL 00/51] KVM/ARM updates for 3.17
Message-ID: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Gleb,

The following changes since commit 9f6226a762c7ae02f6a23a3d4fc552dafa57ea23:

  arch: x86: kvm: x86.c: Cleaning up variable is set more than once (2014-06-30 16:52:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.17

for you to fetch changes up to dedf97e8ff2c7513b1370e36b56e08b6bd0f0290:

  arm64: KVM: fix 64bit CP15 VM access for 32bit guests (2014-08-01 14:05:06 +0200)

Please note that there are two dependencies for this series:
  021f653 (deps-irqchip-gic-3.17) from Jason Cooper
  72c5839 (Allow GICv3 compilation with older binutils) from Catalin

These should both go in when the arm64 tree lands in Linus' tree.  We
will let you know.

Also note that merging these changes are likely to result in a somewhat
non-trivial merge conflict.  We have provided a conflict resolution
branch here with the correct merge result:
  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git conflict-resolution-for-linus
  commit: 19690a1119a0 (the top one)

Can you pass this on to Linus?


Thanks,
Marc & Christoffer

----------------------------------------------------------------
KVM/ARM New features for 3.17 include:
 - Fixes and code refactoring for stage2 kvm MMU unmap_range
 - Support unmapping IPAs on deleting memslots for arm and arm64
 - Support MMIO mappings in stage2 faults
 - KVM VGIC v2 emulation on GICv3 hardware
 - Big-Endian support for arm/arm64 (guest and host)
 - Debug Architecture support for arm64 (arm32 is on Christoffer's todo list)
 - Detect non page-aligned GICV regions and bail out (plugs guest-can-crash host bug)

Alex Benn?e (2):
  arm64: KVM: export demux regids as KVM_REG_ARM64
  arm64: KVM: allow export and import of generic timer regs

Christoffer Dall (1):
  arm/arm64: KVM: Fix and refactor unmap_range

Eric Auger (1):
  ARM: KVM: Unmap IPA on memslot delete/move

Kim Phillips (1):
  ARM: KVM: user_mem_abort: support stage 2 MMIO page mapping

Li Liu (1):
  ARM: virt: fix wrong HSCTLR.EE bit setting

Marc Zyngier (33):
  irqchip: gic: Move some bits of GICv2 to a library-type file
  irqchip: gic-v3: Initial support for GICv3
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
  KVM: ARM: vgic: revisit implementation of irqchip_in_kernel
  arm64: KVM: remove __kvm_hyp_code_{start,end} from hyp.S
  arm64: KVM: split GICv2 world switch from hyp code
  arm64: KVM: move HCR_EL2.{IMO,FMO} manipulation into the vgic switch
    code
  KVM: ARM: vgic: add the GICv3 backend
  arm64: KVM: vgic: add GICv3 world switch
  arm64: KVM: vgic: enable GICv2 emulation on top on GICv3 hardware
  arm64: KVM: rename pm_fake handler to trap_raz_wi
  arm64: move DBG_MDSCR_* to asm/debug-monitors.h
  arm64: KVM: add trap handlers for AArch64 debug registers
  arm64: KVM: common infrastructure for handling AArch32 CP14/CP15
  arm64: KVM: use separate tables for AArch32 32 and 64bit traps
  arm64: KVM: check ordering of all system register tables
  arm64: KVM: add trap handlers for AArch32 debug registers
  arm64: KVM: implement lazy world switch for debug registers
  arm64: KVM: enable trapping of all debug registers
  arm64: KVM: GICv3: move system register access to msr_s/mrs_s
  KVM: arm64: GICv3: mandate page-aligned GICV region
  arm64: KVM: fix 64bit CP15 VM access for 32bit guests

Victor Kamensky (12):
  ARM: KVM: fix vgic V7 assembler code to work in BE image
  ARM: KVM: handle 64bit values passed to mrcc or from mcrr instructions
    in BE case
  ARM: KVM: __kvm_vcpu_run function return result fix in BE case
  ARM: KVM: vgic mmio should hold data as LE bytes array in BE case
  ARM: KVM: MMIO support BE host running LE code
  ARM: KVM: one_reg coproc set and get BE fixes
  ARM: KVM: enable KVM in Kconfig on big-endian systems
  ARM64: KVM: MMIO support BE host running LE code
  ARM64: KVM: store kvm_vcpu_fault_info est_el2 as word
  ARM64: KVM: fix vgic_bitmap_get_reg function for BE 64bit case
  ARM64: KVM: set and get of sys registers in BE case
  ARM64: KVM: fix big endian issue in access_vm_reg for 32bit guest
