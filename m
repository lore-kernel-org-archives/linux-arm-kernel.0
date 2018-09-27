From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 27 Sep 2018 17:15:27 +0100
Subject: [PATCH 0/7] arm64: Workaround for Cortex-A76 erratum 1188873
Message-ID: <20180927161534.247926-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Early revisions of Cortex-A76 suffer from erratum 1188873 which reads
"MRC read following MRRC read of specific Generic Timer in AArch32
might give incorrect result" (see [1], registration required...).

The workaround is to trap all EL0 accesses to the virtual timer (as
well as CNTFRQ_EL0) and emulate it at EL1 (EL2 if running VHE). This
results in some infrastructure for handling AArch32 CP15 traps at EL1,
with all the joy of handling conditional instructions and IT
advance... A lot of that code comes from KVM, and could potentially be
shared. Most of these patches were posted as part of a different
series about a year ago[2]

[1] https://silver.arm.com/download/Documentation/BX500-DA-10008-r0p0-00rel0/Arm_Cortex-A76_MP052_Software_Developer_Errata_Notice_v9.pdf
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-July/520426.html

Marc Zyngier (7):
  arm64: Add decoding macros for CP15_32 and CP15_64 traps
  arm64: compat: Add separate CP15 trapping hook
  arm64: compat: Add condition code checks and IT advance
  arm64: compat: Add cp15_32 and cp15_64 handler arrays
  arm64: compat: Add CNTVCT trap handler
  arm64: compat: Add CNTFRQ trap handler
  arm64: arch_timer: Add workaround for ARM erratum 1188873

 arch/arm64/Kconfig                   |  12 +++
 arch/arm64/include/asm/cpucaps.h     |   3 +-
 arch/arm64/include/asm/cputype.h     |   2 +
 arch/arm64/include/asm/esr.h         |  58 ++++++++++
 arch/arm64/kernel/cpu_errata.c       |   8 ++
 arch/arm64/kernel/entry.S            |  15 ++-
 arch/arm64/kernel/traps.c            | 155 +++++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  15 +++
 8 files changed, 265 insertions(+), 3 deletions(-)

-- 
2.19.0
