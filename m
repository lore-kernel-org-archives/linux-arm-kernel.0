From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  7 Jul 2017 14:07:43 +0100
Subject: [PATCH 0/5] perf: Support for ARM DynamIQ Shared Unit PMU
Message-ID: <1499432868-18462-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the PMU in ARM DynamIQ Shared Unit (DSU).
The DSU integrates one or more cores with an L3 memory system, control
logic, and external interfaces to form a multicore cluster. The PMU
allows counting the various events related to L3, SCU etc, using 32bit
independent counters along with providing a 64bit cycle counter.

The PMU can only be accessed via CPU system registers, which are common
to the cores connected to the same DSU. The PMU registers follow the
semantics of the ARMv8 PMU, mostly, with the exception that
the counters record the cluster wide events.

Tested on a Fast model with DSU. The driver only supports ARM64 at the
moment. It can be extended to support ARM32 by providing register
accessors like we do in arch/arm64/include/arm_dsu_pmu.h.

The firmware should setup appropriate bits in the ACTLR_EL3/EL2 to
allow EL1 access to the PMU registers.

Series applies on v4.12 and is also available at:

  git://linux-arm.org/linux-skp.git 4.12/dsu-v1

Suzuki K Poulose (5):
  perf: Export perf_event_update_userpage
  of: Add helper for mapping device node to logical CPU number
  irqchip: gic-v3: Use of_device_node_get_cpu helper
  dt-bindings: Document devicetree binding for ARM DSU PMU
  perf: ARM DynamIQ Shared Unit PMU support

 .../devicetree/bindings/arm/arm-dsu-pmu.txt        |  28 +
 arch/arm64/include/asm/arm_dsu_pmu.h               | 126 +++
 drivers/irqchip/irq-gic-v3.c                       |  30 +-
 drivers/of/base.c                                  |  26 +
 drivers/perf/Kconfig                               |   9 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/arm_dsu_pmu.c                         | 879 +++++++++++++++++++++
 include/linux/of_device.h                          |   7 +
 kernel/events/core.c                               |   1 +
 9 files changed, 1080 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm-dsu-pmu.txt
 create mode 100644 arch/arm64/include/asm/arm_dsu_pmu.h
 create mode 100644 drivers/perf/arm_dsu_pmu.c

-- 
2.7.5
