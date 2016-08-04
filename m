From: nleeder@codeaurora.org (Neil Leeder)
Date: Thu,  4 Aug 2016 17:11:09 -0400
Subject: [PATCH v2 0/2] qcom: add l2 cache perf events driver
Message-ID: <1470345071-9455-1-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new dynamic PMU to the perf events framework to program
and control the L2 cache PMUs in some Qualcomm Technologies SOCs.

The driver exports formatting and event information to sysfs so it
can be used by the perf user space tools with the syntax:
perf stat -a -e l2cache_0/event=0x42/

Qualcomm Technologies PMUs have events arranged in a matrix of rows and columns.
Only one event can be enabled from each column at once. This is enforced
by the filter_match callback.

changes from v1:

Add the l2-accessors patch to this patchset, previously posted separately.
Remove sampling and per-task functionality for this uncore PMU.
Use cpumask to replace code which filtered events to one cpu per slice.
Replace manual event filtering with filter_match callback.
Use a separate used_mask for event groups.
Add hotplug notifier for CPU and irq migration.
Remove extraneous synchronisation instructions.
Other miscellaneous cleanup.

Neil Leeder (2):
  soc: qcom: provide mechanism for drivers to access L2 registers
  soc: qcom: add l2 cache perf events driver

 drivers/soc/qcom/Kconfig               |  19 +
 drivers/soc/qcom/Makefile              |   2 +
 drivers/soc/qcom/l2-accessors.c        |  66 +++
 drivers/soc/qcom/perf_event_l2.c       | 839 +++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/l2-accessors.h  |  20 +
 include/linux/soc/qcom/perf_event_l2.h |  81 ++++
 6 files changed, 1027 insertions(+)
 create mode 100644 drivers/soc/qcom/l2-accessors.c
 create mode 100644 drivers/soc/qcom/perf_event_l2.c
 create mode 100644 include/linux/soc/qcom/l2-accessors.h
 create mode 100644 include/linux/soc/qcom/perf_event_l2.h

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
