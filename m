From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Apr 2017 17:18:10 +0100
Subject: [PATCH v2 0/6] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1491495496-1524-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the fourth posting of the patches previously posted here:

  rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
  rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
     v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html

Changes since v1 include:

  * Rebased onto new perf_aux_output_flag API (in -next via -tip and included here)
  * Fixed allocation of COLLISION flag
  * Fixed buffer draining in IRQ handler
  * Rebased onto v4.11-rc5

The architecture documentation is now available here:

  https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a

and there's a high-level overview on this official ARM blog:

  https://community.arm.com/processors/b/blog/posts/statistical-profiling-extension-for-armv8-a

All comments welcome,

Will

--->8

Will Deacon (6):
  perf/core: Keep AUX flags in the output handle
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
  dt-bindings: Document devicetree binding for ARM SPE

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 arch/x86/events/intel/bts.c                       |   16 +-
 arch/x86/events/intel/pt.c                        |   17 +-
 arch/x86/events/intel/pt.h                        |    1 -
 drivers/hwtracing/coresight/coresight-etb10.c     |    9 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c  |    9 +-
 drivers/hwtracing/coresight/coresight-priv.h      |    2 -
 drivers/hwtracing/coresight/coresight-tmc-etf.c   |    7 +-
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1253 +++++++++++++++++++++
 include/linux/coresight.h                         |    2 +-
 include/linux/perf_event.h                        |    8 +-
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |   38 +-
 kernel/irq/irqdesc.c                              |    1 +
 16 files changed, 1344 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
