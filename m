From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Mar 2015 13:59:31 +0000
Subject: [PATCH 0/5] arm64: Patching branches for fun and profit
Message-ID: <1426773576-14062-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current alternative instruction framework is not kind to branches,
potentially leading to all kind of hacks in the code that uses
alternatives. This series expands it to deal with immediate branches
(for a start), and applies it to the VGIC world switch.

Patch #1 adds the required infrastructure to extract the immediate
from an instruction.

Patch #2 allows the use of an immediate b or bl instruction as an
alternative, computing the target branch as the instruction is being
patched in.

Patch #3 defines a feature framework that works exactly like the CPU
errata infrastructure (and shares a lot with it).

Patch #4 adds detection of the system register GICv3 CPU interface.

Patch #5 enables dynamic patching of the KVM code.

This has been tested with GICv3 on a FastModel.

Marc Zyngier (5):
  arm64: insn: Add aarch64_insn_decode_immediate
  arm64: alternative: Allow immediate branch as alternative instruction
  arm64: Extract feature parsing code from cpu_errata.c
  arm64: alternative: Introduce feature for GICv3 CPU interface
  arm64: KVM: Switch vgic save/restore to alternative_insn

 arch/arm/include/asm/kvm_host.h     |  5 ---
 arch/arm64/include/asm/cpufeature.h | 23 ++++++++++-
 arch/arm64/include/asm/insn.h       |  1 +
 arch/arm64/include/asm/kvm_host.h   | 23 -----------
 arch/arm64/kernel/Makefile          |  2 +-
 arch/arm64/kernel/alternative.c     | 55 ++++++++++++++++++++++++-
 arch/arm64/kernel/asm-offsets.c     |  1 -
 arch/arm64/kernel/cpu_errata.c      | 36 ++---------------
 arch/arm64/kernel/cpufeature.c      | 63 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |  1 +
 arch/arm64/kernel/insn.c            | 81 +++++++++++++++++++++++++++++--------
 arch/arm64/kvm/hyp.S                | 18 ++-------
 virt/kvm/arm/vgic.c                 |  3 --
 13 files changed, 214 insertions(+), 98 deletions(-)
 create mode 100644 arch/arm64/kernel/cpufeature.c

-- 
2.1.4
