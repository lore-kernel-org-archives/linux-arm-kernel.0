From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 16 Oct 2012 14:21:44 +0100
Subject: [RFC PATCH 0/4] ARM: multi-cluster aware boot protocol
Message-ID: <1350393709-23546-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an updated version of a previous posting available here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/080868.html

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
current MPIDR range check; this will be done as soon as the bindings and
code for the multi-cluster boot protocol will be reviewed and accepted.

The patchset has been tested on:

- TC2 testchip

to boot a 5-core dual-cluster system on every possible CPU.

Lorenzo Pieralisi (3):
  ARM: kernel: add device tree init map function
  ARM: kernel: add cpu logical map DT init in setup_arch
  ARM: kernel: add logical mappings look-up

Nicolas Pitre (1):
  ARM: gic: use a private mapping for CPU target interfaces

 Documentation/devicetree/bindings/arm/cpus.txt | 42 +++++++++++++++++++++++
 arch/arm/common/gic.c                          | 42 ++++++++++++++++++-----
 arch/arm/include/asm/prom.h                    |  2 ++
 arch/arm/include/asm/smp_plat.h                | 17 ++++++++++
 arch/arm/kernel/devtree.c                      | 47 ++++++++++++++++++++++++++
 arch/arm/kernel/setup.c                        |  1 +
 6 files changed, 143 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/cpus.txt

-- 
1.7.12
