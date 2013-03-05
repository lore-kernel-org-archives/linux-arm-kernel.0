From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  5 Mar 2013 02:42:54 +0000
Subject: [PATCH 00/29] ARM: KVM: pre-arm64 KVM/arm rework
Message-ID: <1362451403-23460-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is reworking KVM/arm in order to prepare the code
to be shared with the upcoming KVM/arm64.

Nothing major here, just a lot of accessors, small cleanups and fixes
to make the code useable on arm64.

This code has been tested on VE-TC2 and arm64 models. As always,
comments are most welcome.

Marc Zyngier (29):
  ARM: KVM: convert GP registers from u32 to unsigned long
  ARM: KVM: abstract fault register accesses
  ARM: KVM: abstract HSR_ISV away
  ARM: KVM: abstract HSR_WNR away
  ARM: KVM: abstract HSR_SSE away
  ARM: KVM: abstract HSR_SRT_{MASK,SHIFT} away
  ARM: KVM: abstract external abort detection away
  ARM: KVM: abstract S1TW abort detection away
  ARM: KVM: abstract SAS decoding away
  ARM: KVM: abstract IL decoding away
  ARM: KVM: abstract exception class decoding away
  ARM: KVM: abstract fault decoding away
  ARM: KVM: abstract HSR_EC_IABT away
  ARM: KVM: move kvm_condition_valid to emulate.c
  ARM: KVM: move exit handler selection to a separate file
  ARM: KVM: move kvm_handle_wfi to handle_exit.c
  ARM: KVM: abstract most MMU operations
  ARM: KVM: remove superfluous include from kvm_vgic.h
  ARM: KVM: move hyp init to kvm_host.h
  ARM: KVM: use kvm_kernel_vfp_t as an abstract type for VFP containers
  ARM: KVM: allow HYP mappings to be at an offset from kernel mappings
  ARM: KVM: fix address validation for HYP mappings
  ARM: KVM: sanitize freeing of HYP page tables
  ARM: KVM: move kvm_target_cpu to guest.c
  ARM: KVM: fix fault_ipa computing
  ARM: KVM: vgic: decouple alignment restriction from page size
  ARM: KVM: move include of asm/idmap.h to kvm_mmu.h
  ARM: KVM: change kvm_tlb_flush_vmid to kvm_tlb_flush_vmid_ipa
  ARM: KVM: Fix length of mmio access

 arch/arm/include/asm/kvm_asm.h     |   2 +-
 arch/arm/include/asm/kvm_emulate.h | 101 +++++++++++++++++--
 arch/arm/include/asm/kvm_host.h    |  42 ++++++--
 arch/arm/include/asm/kvm_mmu.h     |  67 +++++++++++++
 arch/arm/include/asm/kvm_vgic.h    |   1 -
 arch/arm/include/uapi/asm/kvm.h    |  12 +--
 arch/arm/kernel/asm-offsets.c      |   8 +-
 arch/arm/kvm/Makefile              |   2 +-
 arch/arm/kvm/arm.c                 | 194 +------------------------------------
 arch/arm/kvm/coproc.c              |  28 +++---
 arch/arm/kvm/coproc.h              |   4 +-
 arch/arm/kvm/emulate.c             |  75 +++++++++-----
 arch/arm/kvm/guest.c               |  17 ++++
 arch/arm/kvm/handle_exit.c         | 159 ++++++++++++++++++++++++++++++
 arch/arm/kvm/interrupts.S          |   9 +-
 arch/arm/kvm/mmio.c                |  46 ++++-----
 arch/arm/kvm/mmu.c                 | 184 +++++++++++++++++------------------
 arch/arm/kvm/vgic.c                |   2 +-
 18 files changed, 568 insertions(+), 385 deletions(-)
 create mode 100644 arch/arm/kvm/handle_exit.c

-- 
1.7.12.4
