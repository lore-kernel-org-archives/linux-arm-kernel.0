From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  2 Jan 2018 11:25:25 +0000
Subject: [PATCH v11 0/8] perf: Support for ARM DynamIQ Shared Unit
Message-ID: <20180102112533.13640-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the PMU in ARM DynamIQ Shared Unit (DSU).
The DSU integrates one or more cores with an L3 memory system, control
logic, and external interfaces to form a multicore cluster. The PMU
allows counting the various events related to L3, SCU etc, using 32bit
independent counters along with a 64bit cycle counter.

The PMU can only be accessed via CPU system registers, which are common
to the cores connected to the same DSU. The PMU registers follow the
semantics of the ARMv8 PMU, mostly, with the exception that
the counters record the cluster wide events.

Tested on a Fast model with DSU. The driver only supports ARM64 at the
moment. It can be extended to support ARM32 by providing register
accessors like we do in arch/arm64/include/arm_dsu_pmu.h.

The firmware should setup appropriate bits in the ACTLR_EL3/EL2 to
allow EL1 access to the PMU registers.

Series applies on v4.15-rc6 and is also available at:

  git://linux-arm.org/linux-skp.git dsu/v11


Changes since V10:
 - Rebased to 4.15-rc6
 - Added Acked-by tag for Patch 1

Changes since V9:
 - Rely on cpuhp callback for probing the PMU.
 - Clear the overflow mask whenever the first CPU is brought up.
 - Remove dsu_pmu_get_online_cpu(), which is not needed anymore.
 - Flip the order of context migration and setting the active CPU.

Changes since V8:
 - Include required header files (Mark Rutland)
 - Remove Kconfig dependency on PERF_EVENTS (Mark Rutland)
 - Fix typo in event name, bus_acesss => bus_access (Mark Rutland)
 - Use find_first_zero_bit instead of find_next_zero_bit (Mark Rutland)
 - Change order of checks in dsu_pmu_event_init (Mark Rutland)
 - Allow lazy initialisation of DSU PMU to handle cases where CPUs
   may be brought up later (e.g, maxcpus=N)- Mark Rutland.
 - Change the CPU check to "associated_cpus" from "active_cpus",
   as when we migrate the perf context we will access the DSU
   from two different CPUs (source and destination).
 - Fill in the "module" field for the PMU to prevent the module unload
   when the PMU is active.

Changes since V7:
 - No changes to the Core DSU PMU code.
 - Rebased to v4.14-rc4
 - Added Tested-by from Leo
 - Convert arm64 CPU topology parsing, ARM PMU irq_affinity parsing
   to use the new helper.

Changes since V6
 - Rebased to v4.14-rc3
 - Use of_cpu_device_node_get() instead of slower of_get_cpu_node(),
   where the former uses per_cpu data when available and falls back to
   former otherwise.


Suzuki K Poulose (8):
  perf: Export perf_event_update_userpage
  of: Add helper for mapping device node to logical CPU number
  coresight: of: Use of_cpu_node_to_id helper
  irqchip: gic-v3: Use of_cpu_node_to_id helper
  arm64: Use of_cpu_node_to_id helper for CPU topology parsing
  arm_pmu: Use of_cpu_node_to_id helper
  dt-bindings: Document devicetree binding for ARM DSU PMU
  perf: ARM DynamIQ Shared Unit PMU support

 .../devicetree/bindings/arm/arm-dsu-pmu.txt        |  27 +
 Documentation/perf/arm_dsu_pmu.txt                 |  28 +
 arch/arm64/include/asm/arm_dsu_pmu.h               | 129 ++++
 arch/arm64/kernel/topology.c                       |  16 +-
 drivers/hwtracing/coresight/of_coresight.c         |  15 +-
 drivers/irqchip/irq-gic-v3.c                       |  29 +-
 drivers/of/base.c                                  |  26 +
 drivers/perf/Kconfig                               |   9 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm_dsu_pmu.c                         | 843 +++++++++++++++++++++
 drivers/perf/arm_pmu_platform.c                    |  15 +-
 include/linux/of.h                                 |   7 +
 kernel/events/core.c                               |   1 +
 13 files changed, 1085 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
 create mode 100644 Documentation/perf/arm_dsu_pmu.txt
 create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
 create mode 100644 drivers/perf/arm_dsu_pmu.c

-- 
2.13.6
