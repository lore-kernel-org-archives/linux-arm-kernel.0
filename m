From: nleeder@codeaurora.org (Neil Leeder)
Date: Fri,  3 Jun 2016 17:03:30 -0400
Subject: [PATCH 0/2] qcom: add l2 cache perf events driver
Message-ID: <1464987812-14360-1-git-send-email-nleeder@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new dynamic PMU to the Perf Events framework to program
and control the L2 cache PMUs in some Qualcomm Technologies SOCs.

The driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntax:
perf stat -e l2cache/event=0x42/

One point to note is that there are certain combinations of events
which are invalid, and which are detected in event_add(). Simply having
event_add() fail would result in event_sched_in() making it Inactive,
treating it as over-allocation of counters, leading to
repeated attempts to allocate the events and ending up with a
statistical count.  A solution for this situation is to turn the
conflicting event off in event_add(). This allows a single error
message to be generated, and no recurring attempts to re-add
the invalid event. In order for this to work, event_sched_in()
needs to detect that event_add() changed the state, and not override it
and force it to Inactive.

This patchset requires:
[PATCH] soc: qcom: provide mechanism for drivers to access L2 registers

Neil Leeder (2):
  perf: allow add to change event state
  soc: qcom: add l2 cache perf events driver

 drivers/soc/qcom/Kconfig               |  10 +
 drivers/soc/qcom/Makefile              |   1 +
 drivers/soc/qcom/perf_event_l2.c       | 917 +++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/perf_event_l2.h |  82 +++
 kernel/events/core.c                   |   3 +-
 5 files changed, 1012 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/qcom/perf_event_l2.c
 create mode 100644 include/linux/soc/qcom/perf_event_l2.h

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
