From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 29 Jan 2013 02:50:55 -0500
Subject: [PATCH v3 00/15] multi-cluster power management
Message-ID: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 3 of the patch series required to safely power up
and down CPUs in a cluster as can be found in b.L systems.  Also
included are the needed patches to allow CPU hotplug on RTSM configured
for big.LITTLE.

This is now called "Multi-Cluster Power Management", or mcpm for short.
At least that makes for a prefix which is not already used in the kernel
and therefore is unlikely to be ambiguous.  Despite the name, this can be
used on single cluster systems as well if appropriate.

Please refer to http://article.gmane.org/gmane.linux.ports.arm.kernel/208625
for the initial series and particularly the cover page blurb for this work.

Thanks to those who provided review comments.

Changes from v2:

- The bL_ prefix has been changed into mcpm_ and surroundings adjusted
  accordingly.
- Documentation moved up one level in Documentation/arm/.
- Clarifications in commit log for patch #1 about future work.
- The debug macro in mcpm_head.S now displays CPU and cluster numbers.
- Patch improving mcpm_cpu_die() folded into the original patch that
  created it.
- Return -EADDRNOTAVAIL on ioremap failure.
- The auxcr patch moved down in the series to better identify dependencies.

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

- The CCI and DCSCB device tree binding descriptions.

Diffstat:

 Documentation/arm/cluster-pm-race-avoidance.txt | 498 ++++++++++++++++++
 Documentation/arm/vlocks.txt                    | 211 ++++++++
 arch/arm/Kconfig                                |   8 +
 arch/arm/common/Makefile                        |   1 +
 arch/arm/common/mcpm_entry.c                    | 314 +++++++++++
 arch/arm/common/mcpm_head.S                     | 219 ++++++++
 arch/arm/common/mcpm_platsmp.c                  |  85 +++
 arch/arm/common/vlock.S                         | 108 ++++
 arch/arm/common/vlock.h                         |  29 +
 arch/arm/include/asm/cp15.h                     |  14 +
 arch/arm/include/asm/mach/arch.h                |   3 +
 arch/arm/include/asm/mcpm_entry.h               | 190 +++++++
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
 25 files changed, 2199 insertions(+), 16 deletions(-)

Nicolas
