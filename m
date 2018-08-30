From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:16:00 +0100
Subject: [PATCH 0/6] Add support for PSTATE.SSBS to mitigate Spectre-v4
Message-ID: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Armv8.5 introduces a new PSTATE bit, SSBS, which can be used to mitigate
Spectre-v4 dynamically without trapping to EL3 firmware.

This patch hooks up support for this bit into the existing SSBD framework
on CPUs that support it. The code is a maze of double-negatives but appears
to work on the FastModel.

Cheers,

Will

--->8

Will Deacon (7):
  arm64: Fix silly typo in comment
  arm64: cpufeature: Detect SSBS and advertise to userspace
  arm64: ssbd: Drop #ifdefs for PR_SPEC_STORE_BYPASS
  arm64: entry: Allow handling of undefined instructions from EL1
  arm64: ssbd: Add support for PSTATE.SSBS rather than trapping to EL3
  KVM: arm64: Set SCTLR_EL2.DSSBS if SSBD is forcefully disabled and
    !vhe
  arm64: cpu: Move errata and feature enable callbacks closer to callers

 arch/arm64/include/asm/cpucaps.h     |  3 +-
 arch/arm64/include/asm/cpufeature.h  |  2 +-
 arch/arm64/include/asm/kvm_host.h    | 11 +++++
 arch/arm64/include/asm/processor.h   | 11 +++--
 arch/arm64/include/asm/ptrace.h      |  1 +
 arch/arm64/include/asm/sysreg.h      | 19 ++++++--
 arch/arm64/include/uapi/asm/hwcap.h  |  1 +
 arch/arm64/include/uapi/asm/ptrace.h |  1 +
 arch/arm64/kernel/cpu_errata.c       | 32 ++++++++++++-
 arch/arm64/kernel/cpufeature.c       | 92 ++++++++++++++++++++++++++++++++----
 arch/arm64/kernel/cpuinfo.c          |  1 +
 arch/arm64/kernel/entry.S            |  2 +-
 arch/arm64/kernel/process.c          |  4 ++
 arch/arm64/kernel/ssbd.c             | 24 ++++++++--
 arch/arm64/kernel/traps.c            | 16 +++----
 arch/arm64/kvm/hyp/sysreg-sr.c       | 11 +++++
 arch/arm64/mm/fault.c                | 14 ------
 17 files changed, 198 insertions(+), 47 deletions(-)

-- 
2.1.4
