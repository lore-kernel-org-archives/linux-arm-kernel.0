From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:19 +0000
Subject: [PATCH 00/11] arm64: Introduce Allwinner A64 and Pine64 support
Message-ID: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series provides initial support for the Allwinner A64 SoC,
which is based on four ARM Cortex-A53 cores implementing the ARMv8
64-bit architecture.
On top of this there is also initial support for the Pine64 board,
for which you can find more information and links in the linux-sunxi
Wiki [1].
The resulting kernel boots fine on my development samples I have
here, though the actual boot process is a bit involved at the moment.
You can find more information and a ready-to-flash image here [2].

The first three patches fix warnings that appear when compiling some
existing Allwinner drivers for arm64.
Patch 4/11 enables the Allwinner/sunxi platform for the arm64
architecture, so one can select the required drivers during
configuration.
Patch 5/11 adds the (currently) inevitable pinctrl driver, this
addresses the comments I got from an earlier post and also fixes
the IRQ banking which I got wrong before.
Patch 6-9 pimp the sunxi clocks drivers to deal with the A64. It adds
a new generic driver for the bus clock gates which relies on DT for
providing the parent relationship. That makes adding new SoCs much
easier, since there should be no more kernel code changes necessary.
Also the sunxi mux clocks learns about the critical-clocks property,
again this moves a previously hard-coded information into the DT.
The final two patches eventually add the A64 .dtsi and the actual
dts files for the two Pine64 board variants.

In the moment we support the basic peripherals like GIC, timer, clocks,
GPIO and UART. The MMC support seems to fail to find the regulator at
the moment, I will send a follow up patch once this is fixed.
Meanwhile you can use an initrd to get to a prompt.

Please have a look and comment on the patches. We might want to split
the series if some patches seem too controversial for being merged
soonish, please let me know if this is the case and I am happy to
rearrange the series.

The patches are based on mripard/sunxi/for-next[3] as of yesterday
and can be found in the repo over here[4].

Cheers,
Andre

[1] http://linux-sunxi.org/Pine64
[2] https://github.com/apritzel/pine64
[3] https://git.kernel.org/cgit/linux/kernel/git/mripard/linux.git/log/?h=sunxi/for-next
[4] https://github.com/apritzel/linux/commits/a64-v1

Andre Przywara (11):
  irqchip: sun4i: fix compilation outside of arch/arm
  crypto: sunxi-ss: prevent compilation on 64-bit
  drivers: rtc: allow compilation of sun6i RTC for all sunxi SoCs
  arm64: Introduce Allwinner SoC config option
  drivers: pinctrl: add driver for Allwinner A64 SoC
  clk: sunxi: add generic multi-parent bus clock gates driver
  clk: sunxi: add generic allwinner,sunxi name
  clk: sunxi: improve error reporting for the mux clock
  clk: sunxi: add critical-clocks property to mux clocks
  arm64: dts: add Allwinner A64 SoC .dtsi
  arm64: dts: add Pine64 support

 Documentation/devicetree/bindings/arm/sunxi.txt    |   5 +
 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/Kconfig.platforms                       |   7 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   5 +
 arch/arm64/boot/dts/allwinner/a64.dtsi             | 583 ++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/pine64.dts           |  58 ++
 arch/arm64/boot/dts/allwinner/pine64_common.dtsi   |  76 +++
 arch/arm64/boot/dts/allwinner/pine64_plus.dts      |  59 ++
 drivers/clk/sunxi/Makefile                         |   1 +
 drivers/clk/sunxi/clk-multi-gates.c                | 105 ++++
 drivers/clk/sunxi/clk-sunxi.c                      |  43 +-
 drivers/crypto/Kconfig                             |   2 +-
 drivers/irqchip/irq-sun4i.c                        |   1 -
 drivers/pinctrl/sunxi/Kconfig                      |   4 +
 drivers/pinctrl/sunxi/Makefile                     |   1 +
 drivers/pinctrl/sunxi/pinctrl-a64.c                | 606 +++++++++++++++++++++
 drivers/rtc/Kconfig                                |   7 +-
 20 files changed, 1550 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/a64.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64_common.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64_plus.dts
 create mode 100644 drivers/clk/sunxi/clk-multi-gates.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-a64.c

-- 
2.6.4
