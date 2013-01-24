From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 24 Jan 2013 01:27:43 -0500
Subject: [PATCH v2 00/16] low-level CPU and cluster power management
Message-ID: <1359008879-9015-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the patch series required to safely power up
and down CPUs in a cluster as can be found in b.L systems.

Please refer to http://article.gmane.org/gmane.linux.ports.arm.kernel/208625
for the initial series and particularly the cover page blurb for this work.

Thanks to those who provided review comments.

Changes from v1:

- Pulled in Rob Herring's auxcr accessor patch and converted this series
  to it.
- VMajor rework of various barriers (some DSBs demoted to DMBs, etc.)
- The sync_mem() macro is now split and enhanced to properly process the
  cache for writers and readers in the cluster critical region helpers.
- BL_NR_CLUSTERS and BL_CPUS_PER_CLUSTER renamed to BL_MAX_CLUSTERS
  and BL_MAX_CPUS_PER_CLUSTER.
- Removed unused C definitions and prototypes for vlocks.
- Simplified the vlock memory allocation.
- The vlock code is GPL v2.
- Replaced MPIDR inline asm by read_cpuid_mpidr().
- Use of MPIDR_AFFINITY_LEVEL() to replace explicit shifts and masks.
- Dropped gic_cpu_if_down().
- Added a DSB before SEV and WFI.
- Fixed power_up_setup helper prototype.
- Nuked smp_wmb() in bL_set_entry_vector().
- Moved the CCI driver to drivers/bus/.
- Dependency on CONFIG_EXPERIMENTAL removed.
- Leftover garbage in Makefile removed.
- Added/clarified various comments in the assembly code.
- Some documentation typos fixed.
- Copyright notices updated to 2013

Still not addressed yet in this series:

- The bL_ rename (will be trivial once I settle on an alternative).
- The CCI and DCSCB device tree binding descriptions.

The new diffstat is:

 .../big.LITTLE/cluster-pm-race-avoidance.txt    | 498 ++++++++++++++++++
 Documentation/arm/big.LITTLE/vlocks.txt         | 211 ++++++++
 arch/arm/Kconfig                                |   6 +
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/bL_entry.c                      | 314 +++++++++++
 arch/arm/common/bL_head.S                       | 214 ++++++++
 arch/arm/common/bL_platsmp.c                    |  84 +++
 arch/arm/common/vlock.S                         | 108 ++++
 arch/arm/common/vlock.h                         |  28 +
 arch/arm/include/asm/bL_entry.h                 | 190 +++++++
 arch/arm/include/asm/cp15.h                     |  14 +
 arch/arm/include/asm/mach/arch.h                |   3 +
 arch/arm/kernel/setup.c                         |   5 +-
 arch/arm/mach-vexpress/Kconfig                  |   9 +
 arch/arm/mach-vexpress/Makefile                 |   1 +
 arch/arm/mach-vexpress/core.h                   |   2 +
 arch/arm/mach-vexpress/dcscb.c                  | 249 +++++++++
 arch/arm/mach-vexpress/dcscb_setup.S            |  80 +++
 arch/arm/mach-vexpress/platsmp.c                |  12 +
 arch/arm/mach-vexpress/v2m.c                    |   2 +-
 drivers/bus/Kconfig                             |   5 +
 drivers/bus/Makefile                            |   2 +
 drivers/bus/arm-cci.c                           | 124 +++++
 drivers/cpuidle/cpuidle-calxeda.c               |  14 -
 include/linux/arm-cci.h                         |  30 ++
 25 files changed, 2190 insertions(+), 16 deletions(-)


Nicolas
