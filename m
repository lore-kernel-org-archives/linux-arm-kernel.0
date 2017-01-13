From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 16:03:39 +0000
Subject: [RFC PATCH v2 00/10] Add support for the ARMv8.2 Statistical
 Profiling Extension
Message-ID: <1484323429-15231-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is RFCv2 of the patches originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-January/476450.html

Changes since RFCv1 include:

  * Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL
  * Remove unused CPP macro
  * Added tags for the first couple of patches (which are now queued in arm64)
  * Added a brief overview of SPE to the commit log for the perf driver

All feedback welcome,

Will

--->8

Will Deacon (10):
  arm64: cpufeature: allow for version discrepancy in PMU
    implementations
  arm64: cpufeature: Don't enforce system-wide SPE capability
  arm64: KVM: Save/restore the host SPE state when entering/leaving a VM
  arm64: head.S: Enable EL1 (host) access to SPE when entered at EL2
  genirq: export irq_get_percpu_devid_partition to modules
  perf/core: Export AUX buffer helpers to modules
  perf: Directly pass PERF_AUX_* flags to perf_aux_output_end
  perf/core: Add PERF_AUX_FLAG_COLLISION to report colliding samples
  drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension
  dt-bindings: Document devicetree binding for ARM SPE

 Documentation/devicetree/bindings/arm/spe-pmu.txt |   20 +
 arch/arm64/include/asm/kvm_arm.h                  |    3 +
 arch/arm64/include/asm/kvm_host.h                 |    7 +-
 arch/arm64/include/asm/sysreg.h                   |    1 +
 arch/arm64/kernel/cpufeature.c                    |    9 +-
 arch/arm64/kernel/head.S                          |   14 +-
 arch/arm64/kvm/debug.c                            |    6 +
 arch/arm64/kvm/hyp/debug-sr.c                     |   66 +-
 arch/arm64/kvm/hyp/switch.c                       |   13 +-
 arch/x86/events/intel/bts.c                       |   11 +-
 arch/x86/events/intel/pt.c                        |   11 +-
 drivers/hwtracing/coresight/coresight-etm-perf.c  |    5 +-
 drivers/perf/Kconfig                              |    8 +
 drivers/perf/Makefile                             |    1 +
 drivers/perf/arm_spe_pmu.c                        | 1244 +++++++++++++++++++++
 include/linux/perf_event.h                        |    4 +-
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |   16 +-
 kernel/irq/irqdesc.c                              |    1 +
 19 files changed, 1413 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
