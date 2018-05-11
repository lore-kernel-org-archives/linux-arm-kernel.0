From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 11 May 2018 18:57:55 -0500
Subject: [PATCH v9 00/12] Support PPTT for ARM64
Message-ID: <20180511235807.30834-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topology. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology and CPU topology.
When we enable ACPI/PPTT for arm64 we map the package_id to the
PPTT node flagged as the physical package by the firmware.
This results in topologies that match what the remainder of the
system expects. Finally, we update the scheduler MC domain so that
it generally reflects the LLC unless the LLC is too large for the
NUMA domain (or package).

For example on juno:
[root at mammon-juno-rh topology]# lstopo-no-graphics
  Package L#0
    L2 L#0 (1024KB)
      L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
      L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
      L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
      L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
    L2 L#1 (2048KB)
      L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
      L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCIBridge
          PCI 1095:3132
            Block(Disk) L#0 "sda"
        PCIBridge
          PCI 1002:68f9
            GPU L#1 "renderD128"
            GPU L#2 "card0"
            GPU L#3 "controlD64"
        PCIBridge
          PCI 11ab:4380
            Net L#4 "enp8s0"

Git tree at:
http://linux-arm.org/git?p=linux-jlinton.git
branch: pptt_v9

v8->v9:
 Add further ack/tested by's (thanks everyone)
 kerneldoc, general comment and patch description tweaks.
 Squash the pptt.c module (#5 & #13) back together.
 remove a redundant () in an if, and rename a variable.

v7->v8:
 Modify the logic used to select the MC domain (the change
   shouldn't modify the sched domains on any existing machines
   compared to v7, only how they are built)
 Reduce the severity of some parsing messages.
 Fix s390 link problem.
 Further checks to deal with broken PPTT tables.
 Various style tweaks, SPDX license addition, etc.

(see previous cover letters for further changes)


Jeremy Linton (12):
  drivers: base: cacheinfo: move cache_setup_of_node()
  drivers: base: cacheinfo: setup DT cache properties early
  cacheinfo: rename of_node to fw_token
  arm64/acpi: Create arch specific cpu to acpi id helper
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  ACPI: Enable PPTT support on ARM64
  drivers: base cacheinfo: Add support for ACPI based firmware tables
  arm64: Add support for ACPI based firmware tables
  arm64: topology: rename cluster_id
  arm64: topology: enable ACPI/PPTT based CPU topology
  ACPI: Add PPTT to injectable table list
  arm64: topology: divorce MC scheduling domain from core_siblings

 arch/arm64/Kconfig                |   1 +
 arch/arm64/include/asm/acpi.h     |   4 +
 arch/arm64/include/asm/topology.h |   6 +-
 arch/arm64/kernel/cacheinfo.c     |  15 +-
 arch/arm64/kernel/topology.c      | 107 ++++++-
 arch/riscv/kernel/cacheinfo.c     |   1 -
 drivers/acpi/Kconfig              |   3 +
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/pptt.c               | 655 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c             |   2 +-
 drivers/base/cacheinfo.c          | 157 ++++-----
 include/linux/acpi.h              |   4 +
 include/linux/cacheinfo.h         |  25 +-
 13 files changed, 874 insertions(+), 107 deletions(-)
 create mode 100644 drivers/acpi/pptt.c

-- 
2.13.6
