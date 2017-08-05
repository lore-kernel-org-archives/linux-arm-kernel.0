From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri,  4 Aug 2017 19:11:55 -0500
Subject: [RFC 0/4] Parse ACPI/PPTT for cache information
Message-ID: <20170805001159.12769-1-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to describe the processor and cache topologies. Ideally it is
used to extend/override information provided by the hardware, but
right now ARM64 is entirely dependent on firmware provided tables.

This patch parses the table for the cache topology only. Its quite
trivial to add processor/cluster/???/socket level parsing as well,
but that information isn't as useful as the already provided NUMA
SRAT/SLIT information which provides relative distances. The one
useful thing, is the number of physical sockets but due to the
way arm64 considers "clusters" to be sockets, a larger discussion
is required here.

An example of lstopo with this patch:

[root at mammon-juno-rh ~]# lstopo-no-graphics
Machine (8072MB)
  Package L#0 + L2 L#0 (1024KB)
    L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
    L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
    L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
    L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
  Package L#1 + L2 L#1 (2048KB)
    L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
    L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
  HostBridge L#0
    PCIBridge
      PCIBridge
        PCIBridge
          PCI 1095:3132
            Block(Disk) L#0 "sda"
        PCIBridge
          PCI 11ab:4380
            Net L#1 "enp8s0"

Jeremy Linton (4):
  drivers: base: cacheinfo: Add support for ACPI based firmware tables
  arm64: cacheinfo: Add support for ACPI/PPTT generated topology
  ACPI/PPTT: Add Processor Properties Topology Table parsing
  ACPI: Enable PPTT support on ARM64

 arch/arm64/kernel/cacheinfo.c |  23 ++-
 drivers/acpi/arm64/Kconfig    |   3 +
 drivers/acpi/arm64/Makefile   |   1 +
 drivers/acpi/arm64/pptt.c     | 389 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/cacheinfo.c      |  15 +-
 include/linux/cacheinfo.h     |   1 +
 6 files changed, 422 insertions(+), 10 deletions(-)
 create mode 100644 drivers/acpi/arm64/pptt.c

-- 
2.9.4
