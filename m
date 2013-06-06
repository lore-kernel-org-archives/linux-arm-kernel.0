From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu,  6 Jun 2013 18:27:08 +0200
Subject: [PATCH 0/6] Marvell Orion SoC irqchip and clocksource
Message-ID: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces DT-aware irqchip and clocksource drivers for
Marvell Orion SoCs (Kirkwood, Dove, Orion5x, MV78x00) and corresponding
patches for Dove and Kirkwood to enable them for DT-boards.

The irqchip driver, of course, depends on Thomas Gleixner's work on
irqdomain support for generic chip (tip irq/core).

The ARM part of this patch set has a quite ridiculuous dependency havoc
of mv643xx_eth DT support (current net-next) that will add to both irqchip
and clocksource branches respectively. Therefore, I suggest that irq
and clocksource maintainers take in the mere drivers (Patches 1+2) and
Jason Cooper handles the remaining patches when all three drivers have
surfaced on mainline linux.

I prepared a branch for anyone to test on Kirkwood and Dove which takes
care of the above dependencies based on v3.10-rc4 plus tip irq/core,
net-next, and arm-soc for-next (I know it is unstable but contains latest
mvebu related patches already). When Thomas, John, and Jason agree the
dependencies will vanish and only Jason has to take care of ARM patches
for enabling DT-based mv643xx_eth, irqchip, and clocksource.

The branch can be found at

git://github.com/shesselba/linux-dove.git orion-irqchip-for-v3.11

and has been tested on Dove/CuBox and compile tested for Kirkwood.

Sebastian Hesselbarth (6):
  irqchip: add support for Marvell Orion SoCs
  clocksource: add Marvell Orion SoC timer
  ARM: dove: move device tree nodes to DT irqchip and clocksource
  ARM: kirkwood: move device tree nodes to DT irqchip and clocksource
  ARM: dove: convert to DT irqchip and clocksource
  ARM: kirkwood: convert to DT irqchip and clocksource

 .../interrupt-controller/marvell,orion-intc.txt    |   48 +++++
 .../bindings/timer/marvell,orion-timer.txt         |   17 ++
 arch/arm/boot/dts/dove.dtsi                        |   21 ++-
 arch/arm/boot/dts/kirkwood.dtsi                    |   35 +++-
 arch/arm/mach-dove/Kconfig                         |    2 +
 arch/arm/mach-dove/Makefile                        |    4 +-
 arch/arm/mach-dove/board-dt.c                      |   23 ++-
 arch/arm/mach-kirkwood/Kconfig                     |   24 +++
 arch/arm/mach-kirkwood/Makefile                    |    4 +-
 arch/arm/mach-kirkwood/board-dt.c                  |   28 ++-
 drivers/clocksource/Kconfig                        |    5 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/time-orion.c                   |  143 +++++++++++++++
 drivers/irqchip/Kconfig                            |    5 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-orion.c                        |  193 ++++++++++++++++++++
 16 files changed, 522 insertions(+), 32 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,orion-intc.txt
 create mode 100644 Documentation/devicetree/bindings/timer/marvell,orion-timer.txt
 create mode 100644 drivers/clocksource/time-orion.c
 create mode 100644 drivers/irqchip/irq-orion.c
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.7.2.5
