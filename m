From: guohanjun@huawei.com (Hanjun Guo)
Date: Sat, 23 Jan 2016 17:39:15 +0800
Subject: [PATCH v3 00/12] ACPI NUMA support for ARM64
Message-ID: <1453541967-3744-1-git-send-email-guohanjun@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hanjun Guo <hanjun.guo@linaro.org>

Based on Ganapat's v9 dt based NUMA patch set [1] for ARM64, this
patch set introduce the ACPI based configuration to provide
NUMA information.

ACPI 5.1 already introduced NUMA support for ARM64, which can
get the NUMA domain information from SRAT and SLIT table, so
parse those two tables to get mappings from cpu/mem to numa
node configration and system locality.

v3 updates:
 - Deep investigation about the ACPI_DEBUG_PRINT() and remvoe
   that for acpi/numa.c (patch 2/12)

 - Remove the duplicate NULL check for table print (patch 3/12)

 - Introduce CONFIG_ACPI_HAS_NUMA_ARCH_FIXUP to remove duplicate
   dummy function for acpi_numa_arch_fixup()

 - Solve the problem that the mapping from logical cpu to numa node
   is wrong which spotted out by Lorenzo

 - cleanups for x86 and move acpi_numa_slit_init() and some other
   functions to common place, then reduce the duplicate of x86
   and arm64 (patch 7-12/12).

 - rebased on top of 4.4 and Ganapat's v9 patch set.

This patch set was tested By Ganapat on Cavium Thunder-X, it works
fine.

[1]: http://lwn.net/Articles/672329/

Thanks
Hanjun

Hanjun Guo (12):
  acpi, numa: Use pr_fmt() instead of printk
  acpi, numa: Replace ACPI_DEBUG_PRINT() with pr_debug()
  acpi, numa: remove duplicate NULL check
  acpi, numa: introduce ACPI_HAS_NUMA_ARCH_FIXUP
  arm64, acpi, numa: NUMA support based on SRAT and SLIT
  acpi, numa: Enable ACPI based NUMA on ARM64
  acpi, numa: move acpi_numa_slit_init() to common place
  arm64, numa: rework numa_add_memblk()
  x86, acpi, numa: cleanup acpi_numa_processor_affinity_init()
  acpi, numa: move bad_srat() and srat_disabled() to common place
  acpi, numa: remove unneeded acpi_numa=1
  acpi, numa: reuse acpi_numa_memory_affinity_init()

 arch/arm64/include/asm/acpi.h |   8 ++
 arch/arm64/include/asm/numa.h |   3 +
 arch/arm64/kernel/Makefile    |   1 +
 arch/arm64/kernel/acpi_numa.c | 149 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/of_numa.c   |   2 +-
 arch/arm64/kernel/smp.c       |   3 +
 arch/arm64/mm/numa.c          |  17 ++--
 arch/ia64/Kconfig             |   1 +
 arch/x86/include/asm/acpi.h   |   1 -
 arch/x86/mm/numa.c            |   2 +-
 arch/x86/mm/srat.c            | 113 +----------------------
 drivers/acpi/Kconfig          |   5 +-
 drivers/acpi/numa.c           | 202 +++++++++++++++++++++++++++++++-----------
 include/acpi/acpi_numa.h      |  12 +++
 include/linux/acpi.h          |  22 ++++-
 15 files changed, 365 insertions(+), 176 deletions(-)
 create mode 100644 arch/arm64/kernel/acpi_numa.c

-- 
1.9.1
