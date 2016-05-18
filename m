From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Wed, 18 May 2016 15:40:24 +0000
Subject: [PATCH-V2 0/6] ARM: memory: bcm: add sdram driver
Message-ID: <1463586030-2778-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add a sdram driver for the bcm2835 SOC.

This is needed (especially) as there are 2 clocks that are needed
by the SDram related HW block, which - right now are not claimed.

Without this driver there is a possibility that one of these
clocks (sdram (for low-voltage modes) or pll_core) or one of their
parents does get disabled when the clocks or PLLs are actually
needed.

In the current form of this driver there is still no absolute
certainty that such a situation can not happen under all
cirumstances, but it reduces the likleyhood that this happens.

To avoid this situation a patch-set will be needed that moves
bcm2835-clk and bcm2835-sdram to earlier stages during the
boot process.

The driver also claims the 3 necessary register ranges
to fully control the sdram (SDRAM, APHY, DPHY).

But for some reasons these registers are not accessible and
read as 0.

It is still unclear if this is a general feature of the SOC
or if this is configured by the binary-blob firmware.

That is why this patchset includes an optional patch
(patch 6: memory: bcm2835: expose register ranges via debugfs)
that exposes these register sets via debugfs.

Martin Sperl (6):
  dt: bindings: add bcm2835-memory-controller documentation
  memory: bcm2835: add bcm2835-memory controller
  ARM: dts: bcm2835: add the bcm2835-sdram-controller to the dt
  ARM: bcm2835_defconfig: add bcm2835-sdram controller
  ARM: multi_v7_defconfig: bcm2835: add bcm2835-sdram driver
  memory: bcm2835: expose register ranges via debugfs

 .../memory-controllers/brcm,bcm2835-sdram.txt      |  30 ++
 arch/arm/boot/dts/bcm283x.dtsi                     |  11 +
 arch/arm/configs/bcm2835_defconfig                 |   1 +
 arch/arm/configs/multi_v7_defconfig                |   1 +
 drivers/memory/Kconfig                             |   7 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/bcm2835-sdram.c                     | 464 +++++++++++++++++++++
 7 files changed, 515 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/brcm,bcm2835-sdram.txt
 create mode 100644 drivers/memory/bcm2835-sdram.c

--
2.1.4
