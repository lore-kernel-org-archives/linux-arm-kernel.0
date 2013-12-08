From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun,  8 Dec 2013 15:13:57 +0100
Subject: [PATCH v4 0/9] ARM: Initial support for Marvell Berlin SoCs
In-Reply-To: <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1386512047-874-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hopefully last round of initial support patches for Marvell Berlin SoCs
before I can send the final PR for v3.14.

Compared to last version sent, this patch set has now a Reviewed-by from
Thomas Gleixner for the irqchip driver (Thanks for that!). Also, l2x0
compatibles can now be reordered alphabetically instead of by derivate
thanks to [1].

Marvell Docs have been updated to not mention Armada 1000 which has been
discontinued by Marvell and vanished from their website. The dtsi/dts file
have been renamed to vendor,name.dts[i], which is the preferred new naming
scheme.

Open issues are the never ending dw_apb_timers_of story, which I ignore
for now and hope they get in someday. Also, TWD SMP dependency and
early l2x0_of_init will be addressed at a later date. At the current
feature set of Berlin SoC, I don't see why the above issues should further
stall this patches.

I guess, all patches can go through ARM SoC tree, except Tauros3 patch
which I should submit to Russell's patch tracker?

Sebastian

[1] http://www.kernelhub.org/?msg=372182&p=2

Sebastian Hesselbarth (9):
  irqchip: add DesignWare APB ICTL interrupt controller
  MAINTAINERS: add ARM Marvell Berlin SoC
  ARM: l2x0: add Marvell Tauros3 support
  ARM: add Marvell Berlin SoC familiy to Marvell doc
  ARM: add Marvell Berlin SoCs to multi_v7_defconfig
  ARM: add Marvell Berlin UART0 lowlevel debug
  ARM: add Armada 1500 and Sony NSZ-GS7 device tree files
  ARM: add Armada 1500-mini and Chromecast device tree files
  ARM: add initial support for Marvell Berlin SoCs

 Documentation/arm/Marvell/README                   |  24 +++
 Documentation/devicetree/bindings/arm/l2cc.txt     |  23 ++-
 .../devicetree/bindings/arm/marvell,berlin.txt     |  24 +++
 .../interrupt-controller/snps,dw-apb-ictl.txt      |  32 +++
 MAINTAINERS                                        |   6 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Kconfig.debug                             |  10 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/google,chromecast.dts            |  29 +++
 arch/arm/boot/dts/marvell,berlin2.dtsi             | 227 +++++++++++++++++++++
 arch/arm/boot/dts/marvell,berlin2cd.dtsi           | 210 +++++++++++++++++++
 arch/arm/boot/dts/sony,nsz-gs7.dts                 |  29 +++
 arch/arm/configs/multi_v7_defconfig                |   3 +
 arch/arm/include/asm/hardware/cache-l2x0.h         |   1 +
 arch/arm/mach-berlin/Kconfig                       |  29 +++
 arch/arm/mach-berlin/Makefile                      |   1 +
 arch/arm/mach-berlin/berlin.c                      |  39 ++++
 arch/arm/mm/cache-l2x0.c                           |  48 ++++-
 arch/arm/mm/cache-tauros3.h                        |  41 ++++
 drivers/irqchip/Kconfig                            |   4 +
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-dw-apb-ictl.c                  | 150 ++++++++++++++
 23 files changed, 918 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
 create mode 100644 arch/arm/boot/dts/google,chromecast.dts
 create mode 100644 arch/arm/boot/dts/marvell,berlin2.dtsi
 create mode 100644 arch/arm/boot/dts/marvell,berlin2cd.dtsi
 create mode 100644 arch/arm/boot/dts/sony,nsz-gs7.dts
 create mode 100644 arch/arm/mach-berlin/Kconfig
 create mode 100644 arch/arm/mach-berlin/Makefile
 create mode 100644 arch/arm/mach-berlin/berlin.c
 create mode 100644 arch/arm/mm/cache-tauros3.h
 create mode 100644 drivers/irqchip/irq-dw-apb-ictl.c

---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: devicetree at vger.kernel.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
-- 
1.8.4.rc3
