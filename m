From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 10 Oct 2017 11:32:55 +0100
Subject: [PATCH v8 0/8] perf: Support for ARM DynamIQ Shared Unit
Message-ID: <20171010103303.32436-1-suzuki.poulose@arm.com>
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

Series applies on v4.14-rc4 and is also available at:

  git://linux-arm.org/linux-skp.git 4.14/dsu-v8

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
 - Added Reviewed-by tags from Jonathan
Changes since V5:
 - Pickedup ack from Rob
 - Address comments on V5 by Mark.
 - Use IRQ_NOBALANCING for IRQ handler
 - Don't expose events which could be unimplemented.
 - Get rid of dsu_pmu_event_supported and allow raw event
   code to be used without validating whether it is supported.
 - Rename "supported_cpus" mask to "associated_cpus"
 - Add Documentation for the PMU driver
 - Don't disable IRQ for dsu_pmu_{enable/disable}_counters
 - Use consistent return codes for validate_event/group calls.
 - Check PERF_ATTACH_TASK flag in event_init.
 - Allow missing CPUs in dsu_pmu_dt_get_cpus, to handle cases
   where kernel could have capped nr_cpus.
 - Cleanup sanity checking for the CPU before accessing DSU
 - Reject events with counting CPU not associated with DSU

Changes since V4:
 - Fix regressions introduced by v4, with the rename of generic
   helper.
 - Added reviewed-by tag from Rob

Changes since V3:
 - Rename the of generic helper to of_cpu_node_to_id(), and return
   -ENODEV upon failure than nr_cpus_id
 - Fix node name in device tree node example.
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
 arch/arm64/include/asm/arm_dsu_pmu.h               | 124 ++++
 arch/arm64/kernel/topology.c                       |  16 +-
 drivers/hwtracing/coresight/of_coresight.c         |  15 +-
 drivers/irqchip/irq-gic-v3.c                       |  29 +-
 drivers/of/base.c                                  |  26 +
 drivers/perf/Kconfig                               |   9 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm_dsu_pmu.c                         | 826 +++++++++++++++++++++
 drivers/perf/arm_pmu_platform.c                    |  15 +-
 include/linux/of.h                                 |   7 +
 kernel/events/core.c                               |   1 +
 13 files changed, 1063 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
 create mode 100644 Documentation/perf/arm_dsu_pmu.txt
 create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
 create mode 100644 drivers/perf/arm_dsu_pmu.c

-- 
2.13.6
