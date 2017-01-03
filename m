From: will.deacon@arm.com (Will Deacon)
Date: Tue,  3 Jan 2017 18:10:17 +0000
Subject: [RFC PATCH 00/10] Add support for the ARMv8.2 Statistical Profiling
 Extension
Message-ID: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This RFC series adds support for the ARMv8.2 Statistical Profiling
Extension (SPE) to Linux in the form of a perf PMU driver. There aren't
any userspace patches for perf tool yet, but Kim (on CC) is working on
those and I thought posting the kernel side as an RFC was still worth it
in the meantime.

The series is structured as:

  1-2: Tweak arm64 CPU feature detection to support heterogeneous
       configurations where CPUs have differ in debug and profiling
       capabilities.

  3-4: Add EL2 SPE support (KVM world switch and initialisation)

  5-6: Export some functions to modules, so this driver can be built as
       a loadable module.

  7-8: Introduce PERF_AUX_FLAG_COLLISION

  9-10: Add the actual PMU driver and devicetree binding

Like intel-pt, the interface to the PMU is via the perf AUX area and the
profiling hardware writes directly to the pages mapped by userspace. The
hardware capabilities (caps/) and config field encodings (format/) are
advertised via sysfs.

Patches based on v4.10-rc2 and tested on an ARM FastModel.

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
 drivers/perf/arm_spe_pmu.c                        | 1247 +++++++++++++++++++++
 include/linux/perf_event.h                        |    4 +-
 include/uapi/linux/perf_event.h                   |    1 +
 kernel/events/ring_buffer.c                       |   16 +-
 kernel/irq/irqdesc.c                              |    1 +
 19 files changed, 1416 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spe-pmu.txt
 create mode 100644 drivers/perf/arm_spe_pmu.c

-- 
2.1.4
