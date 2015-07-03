From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jul 2015 13:55:49 +0200
Subject: [PATCH v3 0/4] Add standby support for the recent mvebu SoCs
Message-ID: <1435924553-22428-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Until now only few mvebu v7 based board supported suspend to ram. This
suspend to ram mode was unusual because it involved shutting down the
SoC and relied on a PIC to wake up the system.

However, most of the recent mvebu SoCs can support the standby
mode. Unlike for the suspend to ram, nothing special have to be done
for these SoCs. In this mode the SoCs go in idle mode (but they remain
powered up) and the devices enter in suspend mode. The support itself
was added in the patch 2.

In order to wake-up the interrupt controller driver have been
updated. As in standby mode the interrupt controller is not shutdown,
any interrupt can be a wake-up source. So the GIC (patch 3) now used
the flags IRQCHIP_SKIP_SET_WAKE and IRQCHIP_MASK_ON_SUSPEND.

A wake up source is supposed to work in suspend _and_ in standby mode
but for the mvebu SoCs, no interrupt can wake up the system. The last
patch warns the user about it.

The first patch is a clean-up found while working on this series

This series was applied on top of Thomas' series "ARM: mvebu: add
suspend to RAM support for Armada 38x":
http://thread.gmane.org/gmane.linux.ports.arm.kernel/420458

It has been either using rtcwake or by setting the serial line as a
wake-up source through the sysfs interface.

Changelog:

v1 -> v2:

 - Rebased on top of Thomas' series "ARM: mvebu: add suspend to RAM
support for Armada 38x"

v2 -> v3:

- Fix typos reported by Thomas in commit logs
- Added Reviewed-by tag from Thomas on 1st patch
- Applied the gic flags depending of the presence of the cortex-a9-gic
  node instead of a list of SoCs as suggest by Thomas
- Simplified the support of the suspend to mem specific to the
  board. Used device_initcall_sync instead of arch_initcall_sync to
  achieve this.
- Made the warning message about wakup sources less confusing for the
  users. Suggested by Thomas.

Thanks,

Gregory

Gregory CLEMENT (4):
  ARM: mvebu: Use __init for the PM initialization functions
  ARM: mvebu: Add standby support
  ARM: mvebu: Allow using the GIC for wakeup in standby mode
  ARM: mvebu: Warn about the wake-up sources not taken into account in
    suspend

 arch/arm/mach-mvebu/board-v7.c |  9 +++++++
 arch/arm/mach-mvebu/common.h   |  4 ++--
 arch/arm/mach-mvebu/pm-board.c | 14 ++++++++---
 arch/arm/mach-mvebu/pm.c       | 53 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.1.0
