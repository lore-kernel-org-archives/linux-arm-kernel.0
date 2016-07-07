From: ttnguyen@apm.com (Tai Nguyen)
Date: Wed,  6 Jul 2016 17:07:21 -0700
Subject: [PATCH v7 0/4] perf: Add APM X-Gene SoC Performance Monitoring Unit
 driver
Message-ID: <1467850045-10584-1-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the X-Gene ARM CPU performance monitoring unit (PMU), there
are PMU for the SoC system devices such as L3 cache(s), I/O bridge(s),
memory controller bridges and memory. These PMU devices are loosely
architected to follow the same model as the PMU for ARM cores.

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---

v7:
 * Remove const from the definition of xgene_pmu_cpumask_attrs
 * Validate the event group as a whole, disallow creating groups containing
   mixed PMUs
 * Implement pmu::pmu_enable() and pmu::pmu_disable() to let the perf core
   starts and stops the counters properly
 * Using list_for_each_entry() instead of list_for_each_entry_safe() to iterate
   over the list of pmu sub-devices
 * Fix resource leak issue in case of registering perf devices fails
 * Pass on returned error if acpi_walk_namespace() fails
 * Remove unused xgene_pmu_data::data
 * Move enable interrupt after probing pmu sub-devices

v6:
 * Add IRQF_NOBALANCING and IRQF_NO_THREAD flags to the PMU overflow interrupt
   Exclude the interrupt from irq balancing and prevent the context from being
   threaded

v5:
 * Remove hw_perf_event::extra_reg field use
   Change GET_CNTR to use hw_perf_event::idx
   Change GET_AGENTID/GET_AGEN1ID to use hw_perf_event::config_base
 * Use compound literal structure defines for format and event attribute groups
   to statically define them at compile time
 * Bitwise invert the meaning of agent mask in config1 field.
 * Fix update pmu_counter_event pointer before starting event
 * Add reset of pmu_dev->pmu_counter_event to NULL in xgene_perf_del
 * Use exactly half of max period to fix the overflow counter issue and account
   for the possiblity of extreme interrupt latency
 * Use spin lock instead of interrupt masking in overflow interrupt handler
 * Remove unnecessary update of hw_perf_event::period_left

v4:
 * Alphabetically sorting header files
 * Remove dynamic allocation for PMU format and event attribute groups
   Create shared constant attribute groups per each class
 * Remove perf_sample_data as this perf driver doesn't support sampling
 * Consistently use the PCP_PMU_V{1,2} defines
 * Set affinity to make sure the overflow interrupt is handled by the
   same assigned CPU

v3:
 * Remove index property use in PMU device sub nodes

v2:
 * Use bitmask for event asignned counter mask pmu_dev->cntr_assign_mask
 * Remove unnecessary spinlocks in perf add/del operations
 * Remove unnecessary condition checks
 * Enforce CPU assignment to one CPU for perf operarations
 * Set the task_ctx_nr to perf_invalid_context for perf driver
 * Remove irrelevant pt_rregs
 * Change perf sysfs attributes to be fixed instead of dynamic
 * Fix checking for an ACPI companion device instead of EFI enable
 * Add documentation for config/config1 fields format and perf tool example

---

Tai Nguyen (4):
  MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
  Documentation: Add documentation for APM X-Gene SoC PMU DTS binding
  perf: xgene: Add APM X-Gene SoC Performance Monitoring Unit driver
  arm64: dts: apm: Add APM X-Gene SoC PMU DTS entries

 .../devicetree/bindings/perf/apm-xgene-pmu.txt     |  112 ++
 Documentation/perf/xgene-pmu.txt                   |   48 +
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   58 +
 drivers/perf/Kconfig                               |    7 +
 drivers/perf/Makefile                              |    1 +
 drivers/perf/xgene_pmu.c                           | 1398 ++++++++++++++++++++
 7 files changed, 1632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 create mode 100644 Documentation/perf/xgene-pmu.txt
 create mode 100644 drivers/perf/xgene_pmu.c

-- 
1.9.1
