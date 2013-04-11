From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 11 Apr 2013 15:47:58 +0100
Subject: [RFC PATCH] ARM CCI support
Message-ID: <1365691679-28674-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM multi-cluster systems rely on the cache coherent interconnect (CCI) to
support inter-cluster cache coherency and distributed virtual memory (DVM)
messaging.

CCI kernel driver requires tweaks to the kernel and device tree
bindings in order to link specific resources to groups of logical CPUs
so that resources can be associated to specific cpu sets (slave ports can
be associated with a set of CPUs which are part of a cluster).

ARM DT topology bindings [1] allow one to describe the hierarchy of CPUs in the
system. Cache Coherent Interconnect CCI is by definition a consumer of
topology bindings in that CCI slave ports must be associated with specific
bus masters in the system so that whenever a CCI operation is requested for
a specific master (ie disable its CCI slave port, read its PMU counters) the
association can be carried out dynamically in the OS through dynamically
built data structures.

The CCI driver provides an example of how to use the newly introduced bindings
and is meant to kickstart discussion on the best way to deploy them on
forthcoming ARM systems.

The current CCI DT bindings define the CCI address space as the same one
as the root device tree node, which means that the CCI bus can address the
entire address space visible to CPUs.

CCI driver code relies on patches 1 and 2 of the series [1] to define
topology bindings and ARM kernel core layer to parse them.

This code is meant to supersede the previous CCI driver posted to LAKML:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-February/147482.html

upon review completion.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162457.html

Thank you very much,
Lorenzo

Lorenzo Pieralisi (1):
  drivers: bus: add ARM CCI support

 Documentation/devicetree/bindings/arm/cci.txt | 184 ++++++++++++++
 drivers/bus/Kconfig                           |   7 +
 drivers/bus/Makefile                          |   2 +
 drivers/bus/arm-cci.c                         | 344 ++++++++++++++++++++++++++
 include/linux/arm-cci.h                       |  44 ++++
 5 files changed, 581 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cci.txt
 create mode 100644 drivers/bus/arm-cci.c
 create mode 100644 include/linux/arm-cci.h

-- 
1.7.12
