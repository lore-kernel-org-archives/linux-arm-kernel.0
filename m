From: ccross@android.com (Colin Cross)
Date: Sun, 12 Jun 2011 17:43:42 -0700
Subject: [PATCH 0/3] CPU PM notifiers
Message-ID: <1307925825-28566-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set tries to address Russell's concerns with platform
pm code calling into the driver for every block in the Cortex A9s
during idle, hotplug, and suspend.  The first patch adds cpu pm
notifiers that can be called by platform code, the second uses
the notifier to save and restore the GIC state, and the third
saves the VFP state.

The notifiers are used for two types of events, CPU PM events and
CPU complex PM events.  CPU PM events are used to save and restore
per-cpu context when a single CPU is preparing to enter or has
just exited a low power state.  For example, the VFP saves the
last thread context, and the GIC saves banked CPU registers.

CPU complex events are used after all the CPUs in a power domain
have been prepared for the low power state.  The GIC uses these
events to save global register state.

Platforms that call the cpu_pm APIs must select
CONFIG_ARCH_USES_CPU_PM

L2 cache is not covered by this patch set, as the determination
of when the L2 is reset and when it is retained is
platform-specific, and most of the APIs necessary are already
present.

 arch/arm/Kconfig              |    7 ++
 arch/arm/common/gic.c         |  212 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/cpu_pm.h |   54 +++++++++++
 arch/arm/kernel/Makefile      |    1 +
 arch/arm/kernel/cpu_pm.c      |  181 +++++++++++++++++++++++++++++++++++
 arch/arm/vfp/vfpmodule.c      |   40 ++++++++
 6 files changed, 495 insertions(+), 0 deletions(-)
