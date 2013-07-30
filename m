From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:49:29 +0200
Subject: [PATCHv2 00/10] ARM: sunxi: Add support for the Allwinner A31 SoC
Message-ID: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset add support in Linux for the Allwinner A31 SoC. This SoC is the
current high-end Allwinner SoC, and is powered by 4 Cortex-A7.

SMP support is not there yet, but should come eventually, so does the clock
support.

As usual, since we don't have any storage device driver yet, it only boots from
an initramfs.

Finally, something worth mentionning is that with the current bootloader,
you'll encounter 2 ~6s hangs during the boot. This is because the SMP bit of
the Cortex-A7 doesn't appear to be set, leading to the CPU caches being
disabled. This can partially be addressed by selecting CONFIG_SMP, that will
remove the second hang, because the SMP bit is set after kernel decompression.

Obviously, this won't remove the first hang that happens during decompression,
but it's better than nothing. A proper fix would be to fix the bootloader.

Thanks,
Maxime

Changes from v1:
  - Used the GIC bindings for the virtualization extensions available in the Cortex-A7
  - Cosmetic changes on the interrupts definitions
  - Removed the reg property in the soc bus
  - Fixed a bug squashing issue when adding the A31 dtsi
  - Added the A31 watchdog compatible to the binding documentation
  - Used the BIT macro in the restart code
  - Fix a few errors/typos in the commit logs

Emilio L?pez (1):
  clk: sunxi: fix initialization of basic clocks

Maxime Ripard (9):
  irqchip: GIC: Add Cortex-A7 compatible string
  ARM: sunxi: Add the Allwinner A31 compatible to the machine definition
  ARM: sun6i: Add restart code for the A31
  ARM: sunxi: Add Allwinner A31 DTSI
  ARM: sun6i: Add WITS Colombus A31 evaluation kit support
  pinctrl: sunxi: Add Allwinner A31 pins set
  ARM: sunxi: dt: Add PIO controller to A31 DTSI
  ARM: sun6i: Add UART0 muxing options
  ARM: sun6i: colombus: Add uart0 muxing

 .../devicetree/bindings/watchdog/sun4i-wdt.txt     |  13 -
 .../devicetree/bindings/watchdog/sunxi-wdt.txt     |  14 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts           |  32 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 175 +++++
 arch/arm/mach-sunxi/Kconfig                        |   2 +
 arch/arm/mach-sunxi/sunxi.c                        |  44 +-
 drivers/clk/sunxi/clk-sunxi.c                      |  11 +-
 drivers/irqchip/irq-gic.c                          |   1 +
 drivers/pinctrl/pinctrl-sunxi-pins.h               | 820 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-sunxi.c                    |   1 +
 11 files changed, 1091 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sun4i-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
 create mode 100644 arch/arm/boot/dts/sun6i-a31-colombus.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31.dtsi

-- 
1.8.3.4
