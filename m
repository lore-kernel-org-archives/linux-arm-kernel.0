From: juri.lelli@arm.com (Juri Lelli)
Date: Thu,  9 Feb 2017 09:25:16 +0000
Subject: [PATCH v2 0/9] Fix issues and factorize arm/arm64 capacity
 information code
Message-ID: <20170209092525.6654-1-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

arm and arm64 topology.c share a lot of code related to parsing of capacity
information. This is v2 of a solution [1] (based on Will's, Catalin's and
Mark's off-line suggestions) to move such common code in a single place:
drivers/base/arch_topology.c (by creating such file and conditionally compiling
it for arm and arm64 only).

First 5 patches are actually fixes for the current code.

Patch 6 is the actual refactoring.

Patch 7 removes one of the extern symbols by changing a bit the now common
code.

Patch 8 removes the remaining externs (as required by Russell during v1 review)
by creating a new header file include/linux/arch_topology.h and including that
from arm, arm64 and drivers.

Last patch addresses Dietmar's comments to v1 and adds a 'atd_' prefix to
interfaces exported by drivers code and used by arch (and potentially others in
the future).

Changes from v1:

 - rebase on top of 4.10-rc7
 - fix licence issue as pointed out by Russell
 - propose a solution for removing all remaining externs
 - addressed Dietmar's comments regarding better namespaces

The set is based on top of linux/master (4.10-rc7 d5adbfcd5f7b) and it is also
available from:

 git://linux-arm.org/linux-jl.git upstream/default_caps_factorize-v2

Best,

- Juri

[1] v1 - https://marc.info/?l=linux-kernel&m=148483680119355&w=2

Juri Lelli (9):
  Documentation: arm: fix wrong reference number in DT definition
  Documentation/ABI: add information about cpu_capacity
  arm: fix return value of parse_cpu_capacity
  arm: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm64: remove wrong CONFIG_PROC_SYSCTL ifdef
  arm, arm64: factorize common cpu capacity default code
  arm,arm64,drivers: reduce scope of cap_parsing_failed
  arm,arm64,drivers: move externs in a new header file
  arm,arm64,drivers: add a prefix to drivers arch_topology interfaces

 Documentation/ABI/testing/sysfs-devices-system-cpu |   7 +
 Documentation/devicetree/bindings/arm/cpus.txt     |   4 +-
 arch/arm/Kconfig                                   |   1 +
 arch/arm/kernel/topology.c                         | 221 +------------------
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/topology.c                       | 228 +-------------------
 drivers/base/Kconfig                               |   8 +
 drivers/base/Makefile                              |   1 +
 drivers/base/arch_topology.c                       | 238 +++++++++++++++++++++
 include/linux/arch_topology.h                      |  17 ++
 10 files changed, 285 insertions(+), 441 deletions(-)
 create mode 100644 drivers/base/arch_topology.c
 create mode 100644 include/linux/arch_topology.h

-- 
2.10.0
