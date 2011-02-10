From: ccross@android.com (Colin Cross)
Date: Thu, 10 Feb 2011 13:31:24 -0800
Subject: [RFC PATCH 0/3] CPU PM notifiers
Message-ID: <1297373487-23902-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set tries to address Russell's concerns with platform
pm code calling into the driver for every block in the Cortex A9s
during idle, hotplug, and suspend.  The first patch adds cpu pm
notifiers that can be called by platform code, the second uses
the notifier to save and restore the GIC state, and the third
saves the VFP state.

The notifiers are used for two types of events, CPU PM events and
CPU complex PM events.  CPU PM events are used to save per-cpu
context when a single CPU is preparing to enter or has just exited
a low power state.  For example, the VFP saves the last thread
context, and the GIC saves banked CPU registers.

CPU complex events are used after all the CPUs in a power domain
have been prepared for the low power state.  The GIC uses these
events to save global register state.

What is not included:
   * Multiple power states - it is assumed that if the platform
     code calls cpu_pm_enter(), every listener needs to save
     its context.
   * L2 cache - The L2 cache will need very different behavior
     depending on the HW implementation and power mode being
     entered.

Both problems could be solved be defining a set of power states
shared by all platforms, if an agreeable set exists.  For example:
   * CPU reset (TWD, GIC, VFP), L1 retention, L2 untouched
   * CPU reset + L1 lost, L2 retention
   * CPU reset, L1 + L2 lost

Santosh previously mentioned that the GIC is not reset in the first
two states on OMAP, which starts to make the list complicated.  Does
disabling the GIC cause a problem in these states?

An alternate solution is to pass a set of flags instead of a power state:
CPU_PM_LOCALTIMERS_RESET
CPU_PM_INTERRUPTS_RESET
CPU_PM_L1_RETENTION
CPU_PM_L1_RESET
CPU_PM_L2_RETENTION
CPU_PM_L2_RESET

 arch/arm/common/gic.c         |  204 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/cpu_pm.h |  123 +++++++++++++++++++++++++
 arch/arm/kernel/Makefile      |    1 +
 arch/arm/kernel/cpu_pm.c      |  116 +++++++++++++++++++++++
 arch/arm/vfp/vfpmodule.c      |   24 +++++
 5 files changed, 468 insertions(+), 0 deletions(-)
