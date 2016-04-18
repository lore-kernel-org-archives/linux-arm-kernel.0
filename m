From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 18 Apr 2016 10:28:31 +0100
Subject: [PATCH v4 0/6] arm64: Support for systems without AArch32 state
Message-ID: <1460971717-24113-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series add checks to make sure that the AArch32 state is
supported before we process the 32bit ID registers. Also
checks the same for COMPAT binary execution.

Applies on top of 4.6-rc1. The series remains unchanged from V3, except
for :

Changes since V3:
  - s/32bit/32-bit/ for capability name
  - Fold "Add wrapper for personality() syscall" patch to final patch

Changes since V2:
  - Rebased to 4.6-rc1
  - Drop redundant KVM check introduced in V1.

Changes since V1:
  - Prevent changing the personality to PER_LINUX32 by adding
    wrapper for personality() syscall.
  - Add the check to KVM before initialising a AArch32 vcpu
  - Tested on hardware.

Btw, linux32 doesn't complain when the personality() syscall fails to change
to PER_LINUX32. You can verify the personality by running:

 $ cat /proc/cpuinfo
 which would still list the 64bit features for the CPUs.


Suzuki K Poulose (6):
  arm64: hwcaps: Cleanup naming
  arm64: HWCAP: Split COMPAT HWCAP table entries
  arm64: Add helpers for detecting AArch32 support at EL0
  arm64: cpufeature: Check availability of AArch32
  arm64: cpufeature: Track 32bit EL0 support
  arm64: compat: Check for AArch32 state

 arch/arm64/include/asm/cpufeature.h |   15 ++-
 arch/arm64/include/asm/elf.h        |    3 +-
 arch/arm64/include/asm/sysreg.h     |    1 +
 arch/arm64/kernel/cpufeature.c      |  208 ++++++++++++++++++++---------------
 arch/arm64/kernel/cpuinfo.c         |   37 ++++---
 arch/arm64/kernel/sys.c             |   10 ++
 6 files changed, 165 insertions(+), 109 deletions(-)

-- 
1.7.9.5
