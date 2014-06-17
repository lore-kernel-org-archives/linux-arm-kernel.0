From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Jun 2014 18:04:30 +0100
Subject: [PATCHv2 0/4] arm64: handle heterogeneous system register values
Message-ID: <1403024674-25108-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the arm64 kernel assumes CPUs are homogeneous, which is a source of
several potential problems as this is not always true. This series is an
attempt to ameliorate the situation. The first posting [1] was titled as
"arm64: extend/fix /proc/cpuinfo + runtime sanity checks", but with the
addition of the I-cache policy fix this title was either going to become
unwieldy or misleading.

Since v1 [1]:
* Add fix for differing I-cache policies
* Make read_cpuid_part_number and read_cpu_implementor return extracted fields.

This series adds infrastructure to record various system registers upon the
booting of each CPU into a new per-CPU struct cpuinfo_arm64. This data can then
be used to solve various problems:

* On arm64 /proc/cpuinfo only contains information regarding the current CPU
  (i.e. that which issued the read), due to use of read_cpuid_id() within
  c_show. This isn't fantastic as it doesn't match arm and x86 (which print
  information per-cpu), and on big.LITTLE AArch64 systems it will mean we don't
  get accurate information regarding each CPU. Using the newly recorded
  information, we can print correct information per-CPU in /proc/cpuinfo.

* Level 1 instruction cache policy can differ across CPU micro-architectures in
  big.LITTLE configurations, which can lead to a subset of cores reporting
  aliasing I-caches in CTR_EL0.L1Ip. If any CPUs in the system have VIPT or
  AIVIVT I-caches, the appropriate maintenance must be performed even from those
  CPUs whose caches are non-aliasing. We can use the newly recorded information
  to detect when this is the case.

* Sometimes CPUs are erroneously configured differently by firmware such that a
  feature is only enabled on a subset of CPUs. Even in the presence of
  big.LITTLE systems we do not generally expect this, and such problems can be
  difficult to detect. To enable early detection of mismatched capabilities in
  SMP systems, we can use the newly recorded information to compare CPUs
  feature-wise and identify potential issues.

The series is based on v3.16-rc1, and can be found in my
arm64/heterogeneous-sysreg branch [2,3].

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/255389.html
[2] http://linux-arm.org/git?p=linux-mr.git;a=shortlog;h=refs/heads/arm64/heterogeneous-sysreg
[3] git://linux-arm.org/linux-mr.git arm64/heterogeneous-sysreg

Mark Rutland (4):
  arm64: add MIDR_EL1 field accessors
  arm64: cpuinfo: print info for all CPUs
  arm64: cachetype: report weakest cache policy
  arm64: add runtime system sanity checks

 arch/arm64/include/asm/cachetype.h |  16 ++--
 arch/arm64/include/asm/cpu.h       |  48 ++++++++++++
 arch/arm64/include/asm/cputype.h   |  33 ++++++--
 arch/arm64/kernel/Makefile         |   3 +-
 arch/arm64/kernel/cpuinfo.c        | 149 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c          |  46 ++++++------
 arch/arm64/kernel/smp.c            |   6 ++
 7 files changed, 265 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/include/asm/cpu.h
 create mode 100644 arch/arm64/kernel/cpuinfo.c

-- 
1.9.1
