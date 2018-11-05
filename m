From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  5 Nov 2018 14:36:12 +0000
Subject: [PATCH 0/4] Workaround for Cortex-A76 erratum 1165522
Message-ID: <20181105143617.120602-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early Cortex-A76 suffer from an erratum that can result in invalid
TLBs when the CPU speculatively executes an AT instruction in the
middle of a guest world switch, while the guest virtual memory
configuration is in an inconsistent state.

We handle this issue by mandating the use of VHE and making sure that
the guest context is fully installed before switching HCR_EL2.TGE to
zero. This ensures that a speculated AT instruction is either executed
on the host context (TGE set) or the guest context (TGE clear), and
that there is no intermediate state.

Marc Zyngier (4):
  KVM: arm64: Rework detection of SVE, !VHE systems
  KVM: arm64: Allow implementations to be confined to using VHE
  arm64: KVM: Install stage-2 translation before enabling traps on VHE
  arm64: KVM: Implement workaround for Cortex-A76 erratum 1165522

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm/include/asm/kvm_host.h        |  3 ++-
 arch/arm64/Kconfig                     | 12 ++++++++++++
 arch/arm64/include/asm/cpucaps.h       |  3 ++-
 arch/arm64/include/asm/kvm_host.h      | 14 ++++++++++----
 arch/arm64/include/asm/kvm_hyp.h       |  6 ++++++
 arch/arm64/kernel/cpu_errata.c         |  8 ++++++++
 arch/arm64/kvm/hyp/switch.c            | 16 +++++++++++++++-
 virt/kvm/arm/arm.c                     | 17 ++++++++++++-----
 9 files changed, 68 insertions(+), 12 deletions(-)

-- 
2.19.1
