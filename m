From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 30 Mar 2015 16:04:33 +0200
Subject: [PATCH 0/5] Add standby support for the recent mvebu SoCs
Message-ID: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Until now only one Armada XP based board supported suspend to
ram. This suspend to ram mode was unusual because it involved shutting
down the SoC and relied on a PIC to wake up the system.

However, most of the recent mvebu SoCs can support the standby
mode. Unlike for the suspend to ram, nothing special have to be done
for these SoCs. In this mode the SoCs go in idle mode (but they remain
powered up) and the devices enter in suspend mode. The support itself
was added in the patch 2.

In order to wake-up the interrupt controller driver have been
updated. As in standby mode the interrupt controller is not shutdown,
any interrupt can be a wake-up source. So the MPIC (patch 4) and the
GIC (patch 3) now used the flags IRQCHIP_SKIP_SET_WAKE and
IRQCHIP_MASK_ON_SUSPEND.

A wake up source is supposed to work in suspend _and_ in standby mode
but for the mvebu SoCs, no interrupt can wake up the system. The last
patch warns the user about it.

The first patch is a clean-up found while working on this series

All the patch are independents either for building or for running.

Thanks,

Gregory


Gregory CLEMENT (5):
  ARM: mvebu: Use __init for the PM initialization functions
  ARM: mvebu: Add standby support
  ARM: mvebu: Allow using the GIC for wakeup in standby mode
  irqchip: armada-370-xp: Allow using wakeup source
  ARM: mvebu: Warn about the wake-ups sources not taken into account in
    suspend

 arch/arm/mach-mvebu/board-v7.c      |  7 +++++
 arch/arm/mach-mvebu/common.h        |  5 ++--
 arch/arm/mach-mvebu/pm-board.c      | 15 ++++++----
 arch/arm/mach-mvebu/pm.c            | 57 ++++++++++++++++++++++++++++++++-----
 drivers/irqchip/irq-armada-370-xp.c |  1 +
 5 files changed, 70 insertions(+), 15 deletions(-)

-- 
2.1.0
