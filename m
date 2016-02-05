From: james.morse@arm.com (James Morse)
Date: Fri,  5 Feb 2016 14:58:45 +0000
Subject: [PATCH v2 0/5] arm64: kernel: Add support for User Access Override
Message-ID: <1454684330-892-1-git-send-email-james.morse@arm.com>
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
git://linux-arm.org/linux-jm.git -b uao/v2

Comments welcome,

James

Since v1:
 * Moved id register definition into the boiler-plate patch.
 * Moved cpu_enable_uao() into mm/fault.c


[0] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution
[v1] https://lwn.net/Articles/674445/

James Morse (5):
  arm64: cpufeature: Change read_cpuid() to use sysreg's mrs_s macro
  arm64: add ARMv8.2 id_aa64mmfr2 boiler plate
  arm64: kernel: Add support for User Access Override
  arm64: cpufeature: Test 'matches' pointer to find the end of the list
  arm64: kernel: Don't toggle PAN on systems with UAO

 arch/arm64/Kconfig                   |  21 +++++++
 arch/arm64/include/asm/alternative.h |  72 +++++++++++++++++++++++
 arch/arm64/include/asm/cpu.h         |   1 +
 arch/arm64/include/asm/cpufeature.h  |   6 +-
 arch/arm64/include/asm/cputype.h     |  20 ++++---
 arch/arm64/include/asm/processor.h   |   1 +
 arch/arm64/include/asm/sysreg.h      |   7 +++
 arch/arm64/include/asm/thread_info.h |   6 ++
 arch/arm64/include/asm/uaccess.h     |  52 +++++++++++------
 arch/arm64/include/uapi/asm/ptrace.h |   1 +
 arch/arm64/kernel/cpufeature.c       | 107 +++++++++++++++++++++++------------
 arch/arm64/kernel/cpuinfo.c          |  55 +++++++++---------
 arch/arm64/kernel/process.c          |  20 +++++++
 arch/arm64/lib/clear_user.S          |  12 ++--
 arch/arm64/lib/copy_from_user.S      |  12 ++--
 arch/arm64/lib/copy_in_user.S        |  20 +++----
 arch/arm64/lib/copy_to_user.S        |  12 ++--
 arch/arm64/mm/context.c              |   2 +-
 arch/arm64/mm/fault.c                |  34 +++++++++--
 19 files changed, 337 insertions(+), 124 deletions(-)

-- 
2.6.2
