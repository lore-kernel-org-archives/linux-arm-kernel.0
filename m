From: pprakash@codeaurora.org (Prashanth Prakash)
Date: Tue,  7 Nov 2017 10:35:31 -0700
Subject: [PATCH 0/2] Avoid calling cpu_pm functions for retention idle states
Message-ID: <1510076133-18139-1-git-send-email-pprakash@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CPU_PM_CPU_IDLE_ENTER() treats all idle states whose idx != 0 as a
state that loses some context, but we can have deeper idle states that
doesn't lose any software context. If a CPU is entering such a low power
idle state where it retains the context, then there is no need to call
cpu_pm_enter()/cpu_pm_exit().

Add a new macro(CPU_PM_CPU_IDLE_ENTER_RETENTION) to be used by cpuidle
drivers when they are entering retention state. By not calling cpu_pm_enter
and cpu_pm_exit we reduce the latency involved in entering and exiting
the retention states.

On ARM64 based Qualcomm server platform we measured below overhead for
for calling cpu_pm_enter and cpu_pm_exit for retention states.

workload: stress --hdd #CPUs --hdd-bytes 32M  -t 30
Overhead of cpu_pm_enter - 1.2us(Average), 6.5us(Max)
Overhead of cpu_pm_exit  - 3.1us(Average), 11.1us(Max)

Listed below are 5 functions that were notified on ENTER/EXIT on the
test platform:
      gic_cpu_pm_notifier
      arch_timer_cpu_pm_notify
      cpu_pm_pmu_notify
      hyp_init_cpu_pm_notifier
      fpsimd_cpu_pm_notifier

Prashanth Prakash (2):
  cpuidle: Add new macro to enter a retention idle state
  ARM64 / cpuidle: Use new cpuidle macro for entering retention state

 arch/arm64/kernel/cpuidle.c |  8 +++++++-
 include/linux/cpuidle.h     | 38 +++++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 16 deletions(-)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
