From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri,  9 Nov 2012 14:34:09 +0000
Subject: [PATCH v2 0/5] ARM: multi-cluster aware boot protocol
Message-ID: <1352471654-20207-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is v2, referred to this previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-October/125878.html

Changes in v2:

- Reworded and added compatible property to cpus.txt
- Replaced while loop in arm_dt_init_cpu_maps() with a combination of
  of_find_node_by_path and for_each_child_of_node
- Replaced of_get_property with of_property_read_u32
- Added further checks for DT /cpu nodes and implemented stashed array
  to avoid overwriting the cpu_logical_map if DT contains errors
- Added GIC CPU IF define in the GIC probing code
- Removed printk for boot CPU MPIDR and added a patch that prints the full
  extent of MPIDR in smp_setup_processor_id()
- Updated smp_setup_processor_id() so that it uses nr_cpu_ids
- Dropped RFC tag

The introduction of multi-cluster ARM systems in SoC designs requires the
kernel to become cluster aware, so that it can be booted on every CPU in the
system and it can build an appropriate HW-to-logical cpu map.

Current code in the kernel, in particular the boot sequence, hinges upon a
sequential mapping of MPIDR values for cpus and related interrupt controller
CPU interfaces to logical cpu indexing.
This hypothesis is not valid when the concept of cluster is introduced since
the MPIDR cannot be represented as a single index and interrupt controller
CPU interfaces can be wired with a numbering scheme following per-SoC
design parameters which can be only detected through probing or device
tree representation.

Through the device tree and "cpu" nodes bindings, the kernel is provided
with HW values for MPIDR registers that allow the kernel to identify the
HW CPU ids that are present in the platform.

The GIC code has been extended to allow automatic detection of GIC CPU IF ids
at boot. IPIs are broadcast to all possible CPUs, and every time a secondary
CPU is booted, it initializes its own mask and clears itself from the mask of
all other logical CPUs.

The device tree bindings and GIC probing allow to boot the Linux kernel on any
CPU of a multi-cluster system without relying on a platform specific hook to
identify the number of CPUs and hypothesis on the sequential pattern of MPIDRs
and relative GIC CPU IF ids.

Pen release code for all converted platforms will need patching to extend the
current MPIDR range check; this will take place as soon as the bindings and
code for the multi-cluster boot protocol will be reviewed and accepted.

The patchset has been tested on:

- TC2 testchip

to boot a 5-core dual-cluster system on every possible CPU.

Lorenzo Pieralisi (4):
  ARM: kernel: smp_setup_processor_id() updates
  ARM: kernel: add device tree init map function
  ARM: kernel: add cpu logical map DT init in setup_arch
  ARM: kernel: add logical mappings look-up

Nicolas Pitre (1):
  ARM: gic: use a private mapping for CPU target interfaces

 Documentation/devicetree/bindings/arm/cpus.txt | 84 ++++++++++++++++++++++++++
 arch/arm/common/gic.c                          | 45 +++++++++++---
 arch/arm/include/asm/prom.h                    |  2 +
 arch/arm/include/asm/smp_plat.h                | 17 ++++++
 arch/arm/kernel/devtree.c                      | 76 +++++++++++++++++++++++
 arch/arm/kernel/setup.c                        |  8 ++-
 6 files changed, 220 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.txt

-- 
1.7.12
