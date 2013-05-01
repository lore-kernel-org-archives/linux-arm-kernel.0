From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed,  1 May 2013 17:18:27 +0100
Subject: [RFC PATCH v2] ARM CCI support
Message-ID: <1367425108-4698-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is an updated of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162539.html

Patch depends on commit:

id: 0c91e7e07ebf08092bf8e28d8cd8d420732fc716

"ARM: cacheflush: add synchronization helpers for mixed cache state accesses"

in RMK tree:

http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git

branch: devel-stable

main changes in v2:
 - Changed way masters are connected to CCI slave ports in DT
   # now every master has to declare a phandle to a CCI control IF
 - Fixed warning split on different lines
 - Added comments to disable function
 - Moved driver to non-hotpluggable API (registration and probing bundled
   together)
 - Upgraded cache flushing API
 - Reworked the driver to use devm primitives
 - Added disable/enable by index API
 - Fixed port enable and added macro for snoops/DVM control

ARM multi-cluster systems rely on the cache coherent interconnect (CCI) to
support inter-cluster cache coherency and distributed virtual memory (DVM)
messaging.

CCI kernel driver requires tweaks to the kernel and device tree
bindings in order to link specific resources to groups of logical CPUs
so that resources can be associated to specific cpu sets (slave ports can
be associated with a set of CPUs which are part of a cluster).

CCI slave ports must be associated with specific bus masters in the system so
that whenever a CCI operation is requested for a specific master (ie disable
its CCI slave port, read its PMU counters) the association can be carried out
dynamically in the OS through dynamically built data structures.
Bus masters in the system connected to CCI ports must define device tree
properties, as described in the documentation contained in the patch, in order
to explicitly connect ports and allow the OS to build up the required data
structures.

The current CCI DT bindings define the CCI address space as the same one
as the root device tree node, which means that the CCI bus can address the
entire address space visible to CPUs.

Lorenzo Pieralisi (1):
  drivers: bus: add ARM CCI support

 Documentation/devicetree/bindings/arm/cci.txt | 161 +++++++++++
 drivers/bus/Kconfig                           |   7 +
 drivers/bus/Makefile                          |   2 +
 drivers/bus/arm-cci.c                         | 372 ++++++++++++++++++++++++++
 include/linux/arm-cci.h                       |  59 ++++
 5 files changed, 601 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cci.txt
 create mode 100644 drivers/bus/arm-cci.c
 create mode 100644 include/linux/arm-cci.h

-- 
1.8.2.2
