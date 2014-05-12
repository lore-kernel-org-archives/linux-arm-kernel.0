From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 May 2014 15:37:47 +0100
Subject: [PATCH 0/3] arm64: extend/fix /proc/cpuinfo + runtime sanity checks
Message-ID: <1399905470-26500-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64 /proc/cpuinfo only contains information regarding the current
CPU (i.e. that which issued the read), due to use of read_cpuid_id()
within c_show.  This isn't fantastic as it doesn't match arm and x86
(which print information per-cpu), and on big.LITTLE AArch64 systems it
will mean we don't get accurate information regarding each CPU.

This series adds code to record the relevant system registers upon the
booting of each CPU, and uses this information to output correct
information per-CPU in /proc/cpuinfo. I have not seen this cause issues
so far with a 64-bit filesystem, but would appreciate any testing people
are willing to perform.

I've built some run-time sanity/consistency checking atop of the
cpuinfo_arm64 infrastructure, which hopefully should help to identify
when a system's CPUs vary in ways we do not expect and/or cannot
support.

The series is based on the arm64 for-next/core branch [1] due to reading
of the cache registers in sanity checks code, but patches 1 and 2 should
apply to v3.15-rc5.

Cheers,
Mark.


[1] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

Mark Rutland (3):
  arm64: add MIDR_EL1 field accessors
  arm64: cpuinfo: print info for all CPUs
  arm64: add runtime system sanity checks

 arch/arm64/include/asm/cpu.h     |  49 +++++++++++++++
 arch/arm64/include/asm/cputype.h |  27 ++++++++-
 arch/arm64/kernel/Makefile       |   2 +-
 arch/arm64/kernel/cpuinfo.c      | 125 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c        |  46 +++++++-------
 arch/arm64/kernel/smp.c          |   6 ++
 6 files changed, 230 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpu.h
 create mode 100644 arch/arm64/kernel/cpuinfo.c

-- 
1.8.1.1
