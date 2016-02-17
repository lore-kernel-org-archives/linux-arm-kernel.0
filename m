From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Feb 2016 11:43:52 +0000
Subject: [PATCH v2 0/8] arm64: Introduce Allwinner A64 and Pine64 support
Message-ID: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this is an updated version of the Allwinner A64 / Pine64 support series.
It fixes several issues we saw and addresses most ;-) of the comments
I got. Several fixes have found their way into -next already, so I omit
them here. Many thanks to the diligent maintainers!
For a changelog see below.

This series provides initial support for the Allwinner A64 SoC,
which is based on four ARM Cortex-A53 cores implementing the ARMv8
64-bit architecture.
On top of this there is also initial support for the Pine64 board,
for which you can find more information and links in the linux-sunxi
Wiki [1].
The resulting kernel boots fine on my development samples I have
here, though the actual boot process is a bit involved at the moment.
You can find more information and a ready-to-flash image here [2].

Patch 1/8 enables the Allwinner/sunxi platform for the arm64
architecture, so one can select the required drivers during
configuration.
Patch 2/8 adds the pinctrl driver, which has been on the list before.
Patch 3 and 4 add a new generic driver for the bus clock gates which
relies on DT for providing the parent relationship. That makes adding
new SoCs much easier, since there should be no more kernel code
changes necessary.
Patch 5-7 add the new vendor name and the device tree files, the former
for the SoC itself, the latter for the Pine64 boards.
The final patch 8 updates defconfig, so that the generic arm64 kernel
supports the basic SoC drivers out of the box.

In the moment we support the basic peripherals like GIC, timer, clocks,
GPIOs, UARTs and (new in v2) I2C.
The MMC IP block has changed a bit compared to previous SoCs, so the
existing driver is not 100% compatible. However the default delays seem
to work fine for the SD cards, so I included all the necessary bits in
here, since working MMC makes this series indefinitely more usable.
We can fix both the MMC driver and the DT in a compatible way later.

Please have a look and comment on the patches. We might want to split
the series if some patches seem too controversial for being merged
soonish, please let me know if this is the case and I am happy to
rearrange the series.

The patches are based on next-20160217, which has some issues atm.
A working repo can be found over here[3].

Cheers,
Andre

Changelog v1 .. v2:
- Change the naming of DT nodes, identifiers and file names to include
  the wonderful Allwinner architecture prefix everywhere. You asked
  for it, you got it, enjoy!
- Drop SUNXI_MMC to be selected automatically, instead put it in the
  defconfig.
- Add a binding documentation for the new multi-bus-gates driver.
- Add a defconfig update patch.
- Lots of changes in the DTs, see the respective patches for details.

[1] http://linux-sunxi.org/Pine64
[2] https://github.com/apritzel/pine64
[3] https://github.com/apritzel/linux/commits/a64-v2beta

Andre Przywara (8):
  arm64: Introduce Allwinner SoC config option
  drivers: pinctrl: add driver for Allwinner A64 SoC
  DT: clk: sunxi: add binding doc for the multi-bus-gates clock
  clk: sunxi: add generic multi-parent bus clock gates driver
  arm64: dts: add Allwinner A64 SoC .dtsi
  of: add vendor prefix for Pine64
  arm64: dts: add Pine64 support
  arm64: add defconfig options for Allwinner SoCs

 Documentation/devicetree/bindings/arm/sunxi.txt    |   1 +
 Documentation/devicetree/bindings/clock/sunxi.txt  |   7 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/Kconfig.platforms                       |   6 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 .../dts/allwinner/sun50i-a64-pine64-common.dtsi    |  80 +++
 .../boot/dts/allwinner/sun50i-a64-pine64-plus.dts  |  59 ++
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |  58 ++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 642 +++++++++++++++++++++
 arch/arm64/configs/defconfig                       |   7 +
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-multi-gates.c                | 105 ++++
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         | 606 +++++++++++++++++++
 17 files changed, 1585 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-common.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
 create mode 100644 drivers/clk/sunxi/clk-multi-gates.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c

-- 
2.6.4
