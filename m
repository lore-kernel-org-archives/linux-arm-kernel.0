From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  6 Jun 2016 18:56:29 +0100
Subject: [PATCH v3 0/2] arm/arm64: Fix architected timer interrupt trigger
Message-ID: <1465235791-7064-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've noticed a while ago that we had a pretty creative approach to the
arch timer trigger, with some platform describing as edge-triggered
something that is architecturally a level interrupt.

This short patch series tries to address it in two ways:

- Enforce the level aspect of the interrupt in the timer driver (and
  shout at the user if the firmware describes it as edge)
- Repaint all the in-tree platforms that are obviously doing the wrong
  thing.

Hopefully, this will stop DTs that are wrong from being blindly
copy/pasted.

Thanks,

	M.

- From v2: Fix all in-tree device-trees.

Marc Zyngier (2):
  clocksource/arm_arch_timer: Force per-CPU interrupt to be
    level-triggered
  arm64: dts: Fix broken architected timer interrupt trigger

 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  8 +++----
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |  8 +++----
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |  8 +++----
 arch/arm64/boot/dts/broadcom/ns2.dtsi              |  8 +++----
 arch/arm64/boot/dts/cavium/thunder-88xx.dtsi       |  8 +++----
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  8 +++----
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  8 +++----
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  8 +++----
 .../boot/dts/socionext/uniphier-ph1-ld20.dtsi      |  8 +++----
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  8 +++----
 drivers/clocksource/arm_arch_timer.c               | 27 +++++++++++++++++++---
 11 files changed, 64 insertions(+), 43 deletions(-)

-- 
2.1.4
