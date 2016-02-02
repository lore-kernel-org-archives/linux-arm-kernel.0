From: james.morse@arm.com (James Morse)
Date: Tue,  2 Feb 2016 17:03:26 +0000
Subject: [PATCH v1 0/5] arm64: kernel: Add support for User Access Override
Message-ID: <1454432611-21333-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for User Access Override (UAO; part of the ARMv8.2
Extensions[0]). When enabled, this causes the get_user() accessors to use
the unprivileged load/store instructions. When addr_limit is set to
KERNEL_DS, we set the override bit allowing privileged access.

Because the unprivileged instructions don't trip PAN, the last patch changes
which 'alternative' values are swapped in, allowing PAN to be left enabled
during get_user() and friends.

This series can be retrieved from:
git://linux-arm.org/linux-jm.git -b uao/v1

Comments welcome,

James

[0] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution

James Morse (5):
  kernel: cpufeature: Change read_cpuid() to use sysreg's mrs_s macro
  arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
  arm64: kernel: Add support for User Access Override
  arm64: cpufeature: Test 'matches' pointer to find the end of the list
  arm64: kernel: Don't toggle PAN on systems with UAO

 arch/arm64/Kconfig                   |  21 ++++++
 arch/arm64/include/asm/alternative.h |  72 +++++++++++++++++++++
 arch/arm64/include/asm/cpu.h         |   1 +
 arch/arm64/include/asm/cpufeature.h  |   6 +-
 arch/arm64/include/asm/cputype.h     |  20 +++---
 arch/arm64/include/asm/processor.h   |   1 +
 arch/arm64/include/asm/sysreg.h      |   7 ++
 arch/arm64/include/asm/thread_info.h |   6 ++
 arch/arm64/include/asm/uaccess.h     |  52 ++++++++++-----
 arch/arm64/include/uapi/asm/ptrace.h |   1 +
 arch/arm64/kernel/cpufeature.c       | 120 +++++++++++++++++++++++++----------
 arch/arm64/kernel/cpuinfo.c          |  55 ++++++++--------
 arch/arm64/kernel/process.c          |  20 ++++++
 arch/arm64/lib/clear_user.S          |  12 ++--
 arch/arm64/lib/copy_from_user.S      |  12 ++--
 arch/arm64/lib/copy_in_user.S        |  20 +++---
 arch/arm64/lib/copy_to_user.S        |  12 ++--
 arch/arm64/mm/context.c              |   2 +-
 arch/arm64/mm/fault.c                |  21 ++++--
 19 files changed, 337 insertions(+), 124 deletions(-)

-- 
2.6.2
