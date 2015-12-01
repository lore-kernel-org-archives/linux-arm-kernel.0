From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue,  1 Dec 2015 15:12:05 +0000
Subject: [PATCH v2 0/6] arm64: cpufeature: Add sanity check for ASIDBits
Message-ID: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for verifying some of the cpufeatures
that are decided early in the boot process based on the boot
CPU and cannot be delayed (e.g, ASIDBits and may be VHE?). It also
adds one of the users of this early hook, check for ASIDBits.

The mm_context id is based on the ASIDBits width supported by the
boot CPU and is used early in the initialisation. So we need to make
sure that all the secondary CPUs supports the width reported by the
booting CPU, failing which the CPU will be prevented from turning
online.

Patches 1-4 : Rearranges the cpufeature infrastructure to add hooks
to perform checks for CPUfeatures that were used based on the boot
CPU values

Patch 5: Adds a helper to extract the ASID width on the current CPU
Patch 6: Adds the check to verify ASIDBits of a secondary CPU is compatible
with the boot CPU.

Changes since V1:
  - Split the series from handling of unsigned/signed bits, which were
    merged.
  - Move the checks to verify_local_cpu_capabilities(), making a way for
    further checks to be added (VHE ?) (Patch 1-4)
  - Added a kill_cpu_early() helper to smp.c
  - Added Patch 5.
  - Compare the represented ASIDBits value than the feature value.

Suzuki K. Poulose (6):
  arm64: Introduce kill_cpu_early
  arm64: Move kill_cpu_early to smp.c
  arm64: Enable CPU capability verification for !CONFIG_HOTPLUG_CPU
  arm64: Add hook for checking early CPU features
  arm64: Add helper for extracting ASIDBits
  arm64: Ensure the secondary CPUs have safe ASIDBits size

 arch/arm64/include/asm/cpufeature.h  |    6 ----
 arch/arm64/include/asm/mmu_context.h |    2 ++
 arch/arm64/include/asm/smp.h         |    1 +
 arch/arm64/kernel/cpufeature.c       |   48 ++++++++++++--------------------
 arch/arm64/kernel/smp.c              |   25 +++++++++++++++++
 arch/arm64/mm/context.c              |   50 +++++++++++++++++++++++++---------
 6 files changed, 82 insertions(+), 50 deletions(-)

-- 
1.7.9.5
