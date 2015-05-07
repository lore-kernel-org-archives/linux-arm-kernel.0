From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  7 May 2015 18:48:30 +0200
Subject: [PATCH v3 0/7] Add support for NXP LPC18xx family
Message-ID: <1431017317-23740-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds minimal support for the LPC18xx/43xx family of
Cortex-M3/4 MCUs from NXP.

Patch set is based on Linus master v4.1-rc1. I would be great if
these patches could go into 4.1.

To keep the amount of dependencies down the PLL1 clock has been hard
coded in the lpc18xx.dtsi file. The clock system of LPC18xx is quite
advanced for a MCU and requires two clk drivers to work. A patch set
with these drivers and update to the dtsi files will be posted
separately.

Drivers for pinctrl, gpio and reset are already upstream now.

Drivers for ethernet, i2c, rtc and emc (external memories) are also
coming for LPC18xx.  Right now these can found on:
https://github.com/manabian/linux-lpc

Sucessfuly tested on Embedded Artist LPC4357 Developers Kit.

ARM SoC maintainers: How would like to pick this series up?
Could you pick up the patches on the mail list or would you prefer a
pull request?


Changes since v2:
 - use pr_fmt in time-lpc32xx.c
 - use request_irq instead of setup_irq in time-lpc32xx.c
 - remove default on DEBUG_UART_8250 in Kconfig.debug
 - update defconfig slightly

Changes since v1:
 - use generic soc match strings in board-dt
 - remove armv7m reset in board-dt (this wasn't working and a proper
   reset driver is coming)
 - move dt aliases to board files
 - add support for Hitex LPC4350 eval board from Ariel D'Alessandro
 - rename lpc3250-timer to lpc3220-timer to match lpc32xx.dtsi
 - add ea (and hitex) to vendor-prefixes
 - rename lpc4357-ea4357 to lpc4357-ea4357-devkit
 - add lpc32xx_read_sched_clock from Ezequiel Garcia
 - use named clk in lpc3220 clocksource driver
 - rebase on 4.1-rc1

Ariel D'Alessandro (1):
  ARM: dts: Add DT for Hitex LPC4350 Evaluation Board

Joachim Eastwood (6):
  ARM: lpc18xx: add basic support for NXP LPC18xx/43xx SoCs
  clocksource: add lpc32xx timer driver
  doc: dt: add documentation for lpc3220-timer
  ARM: dts: Add base DT for NXP LPC18xx
  ARM: dts: Add DT for Embedded Artists LPC4357 Developers Kit
  ARM: lpc18xx: add kernel config

 .../bindings/timer/nxp,lpc3220-timer.txt           |  26 +++
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 arch/arm/Kconfig                                   |  20 ++
 arch/arm/Kconfig.debug                             |   3 +-
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/lpc18xx.dtsi                     | 114 +++++++++
 arch/arm/boot/dts/lpc4350-hitex-eval.dts           |  45 ++++
 arch/arm/boot/dts/lpc4350.dtsi                     |  39 ++++
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts        |  41 ++++
 arch/arm/boot/dts/lpc4357.dtsi                     |  39 ++++
 arch/arm/configs/lpc18xx_defconfig                 | 151 ++++++++++++
 arch/arm/mach-lpc18xx/Makefile                     |   1 +
 arch/arm/mach-lpc18xx/Makefile.boot                |   3 +
 arch/arm/mach-lpc18xx/board-dt.c                   |  22 ++
 drivers/clocksource/Kconfig                        |  10 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/time-lpc32xx.c                 | 259 +++++++++++++++++++++
 18 files changed, 779 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,lpc3220-timer.txt
 create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4350-hitex-eval.dts
 create mode 100644 arch/arm/boot/dts/lpc4350.dtsi
 create mode 100644 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
 create mode 100644 arch/arm/boot/dts/lpc4357.dtsi
 create mode 100644 arch/arm/configs/lpc18xx_defconfig
 create mode 100644 arch/arm/mach-lpc18xx/Makefile
 create mode 100644 arch/arm/mach-lpc18xx/Makefile.boot
 create mode 100644 arch/arm/mach-lpc18xx/board-dt.c
 create mode 100644 drivers/clocksource/time-lpc32xx.c

-- 
1.8.0
