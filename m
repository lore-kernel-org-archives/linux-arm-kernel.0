From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Sep 2017 15:09:44 +0100
Subject: [PATCH v5 0/7] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is the seventh posting of the patches previously posted here:

  rfcv1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html
  rfcv2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/479387.html
     v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/483684.html
     v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/499938.html
     v3: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/507132.html
     v4: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/510799.html

There have been many changes since v4, mainly thanks to useful review
comments from Mark Rutland:

  * Require CAP_SYS_ADMIN for sampling physical addresses, the physical
    counter and context information (ASID/VMID)
  * Handle AUX buffer allocations when cpu == -1
  * Fix PERF_IDX2OFF for non-power-of-2 pages buffer sizes
  * Use %016llx when printing PMBSR
  * Fix masking of PMSIRR_EL1.INTERVAL
  * Don't reject events based on sample period (for consistency with
    PERF_EVENT_IOC_PERIOD)
  * Consolidate isb() usage
  * Add of_device_id table sentinel to avoid overrunning ID table
  * Complete rewrite of __arm_spe_pmu_next_off, based on wakeup changes in core
  * Rename cnt_width to counter_sz
  * Ensure PMBPTR is aligned to record size when profiling is active
  * Complete rewrite of exception handling
  * Move register definitions into asm/sysreg.h
  * Now tested on FPGA (as opposed to just on the FastModel)!

The architecture documentation is available here:

  https://developer.arm.com/products/architecture/a-profile/docs/ddi0586/latest/arm-architecture-reference-manual-supplement-statistical-profiling-extension-for-armv8-a

and there's a high-level overview on this official ARM blog:

  https://community.arm.com/processors/b/blog/posts/statistical-profiling-extension-for-armv8-a

All comments welcome,

Will

--->8

Will Deacon (7):
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  arm64: sysreg: Move SPE registers and PSB into common header files
  arm64: head: Init PMSCR_EL2.{PA,PCT} when entered at EL2 without VHE
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
  dt-bindings: Document devicetree binding for ARM SPE

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 arch/arm64/include/asm/barrier.h                  |    2 +
 arch/arm64/include/asm/sysreg.h                   |   93 ++
 arch/arm64/kernel/head.S                          |   17 +-
 arch/arm64/kvm/hyp/debug-sr.c                     |   24 +-
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1246 +++++++++++++++++++++
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |    4 +
 kernel/irq/irqdesc.c                              |    1 +
 11 files changed, 1395 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
