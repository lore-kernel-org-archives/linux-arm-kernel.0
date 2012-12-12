From: steve.capper@arm.com (Steve Capper)
Date: Wed, 12 Dec 2012 17:40:46 +0000
Subject: [RFC PATCH 0/3] NUMA support for ARM.
Message-ID: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This RFC adds support for NUMA.

Where possible NUMA should be run with a sparse memory model. If a
sparse memory model is not available; one can use the supplied
discontiguous memory model.

At the moment, the number of nodes has to be specified on the
commandline. One can also, optionally, specify the memory size of
each node. (Otherwise the memory range is split roughly equally
between nodes).

CPUs can be striped across nodes (cpu number modulo the number of
nodes), or assigned to a node based on their
topology_physical_package_id. So for instance on a TC2, the A7
cores can be grouped together in one node and the A15s grouped
together in another node.

I've kept the code as minimal as possible to allow future NUMA
systems to be supported with a minimum of hacking.

These patches have been tested on a Realview PBX (for sparsemem), a
Versatile Express with TC2 tile (running both non-LPAE and LPAE with
discontiguous memory) and an Arndale board (Exynos 5250, running 
sparse memory with LPAE and non-LPAE).

Any comments or feedback would be appreciated greatly.

Thanks,
-- 
Steve

Steve Capper (3):
  ARM: mm: Add discontiguous memory support.
  ARM: mm: Add NUMA support.
  ARM: syscall: wire up sys_migrate_pages.

 arch/arm/Kconfig                   |   41 ++++++
 arch/arm/include/asm/mmzone.h      |   49 +++++++
 arch/arm/include/asm/topology.h    |   15 ++
 arch/arm/include/uapi/asm/unistd.h |    1 +
 arch/arm/kernel/calls.S            |    1 +
 arch/arm/kernel/setup.c            |    6 +
 arch/arm/mm/Makefile               |    2 +
 arch/arm/mm/init.c                 |   62 +++-----
 arch/arm/mm/numa.c                 |  278 ++++++++++++++++++++++++++++++++++++
 9 files changed, 416 insertions(+), 39 deletions(-)
 create mode 100644 arch/arm/include/asm/mmzone.h
 create mode 100644 arch/arm/mm/numa.c

-- 
1.7.9.5
