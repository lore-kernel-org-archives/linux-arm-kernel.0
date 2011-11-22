From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 22 Nov 2011 09:48:53 +0800
Subject: [RFC PATCH 0/3] Convert imx6 clock to device tree
Message-ID: <1321926536-671-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As I promised to Arnd, I will convert imx6 clock code to common clock
framework and in turn device tree at the earliest time.  Here it is.

It's based on Mike's common-clk pre-v3 and Grant's clock device tree
binding series.

Along with the conversion to device tree, I feel it's a great idea to
introduce '#clock-cells'.  With adopting it, I'm using 70 nodes to
describe 110 clocks (~35% nodes reduced).  However, the current design
of '#clock-cells' makes the user a little difficult.  For example, when
a consumer node references to provider node which is a blob of 4 clocks,
it has to fill 4 parameters into the phandle.

usdhc at 02198000 { /* uSDHC3 */
       compatible = "fsl,imx6q-usdhc";
       reg = <0x02198000 0x4000>;
       interrupts = <0 24 0x04>;
       clock-input = <&usdhc_clk 2 0 0 0>; <--
       clock-input-name = "usdhc3";
};

But we actually need to pass only one parameter to point out the index
of the clock in the blob.  It's a little silly to put a number of
meaningless 0 there to fill the length of the phandle parameters.  Can
we rework the dt core code to make the following one work?

usdhc@02198000 { /* uSDHC3 */
       compatible = "fsl,imx6q-usdhc";
       reg = <0x02198000 0x4000>;
       interrupts = <0 24 0x04>;
       clock-input = <&usdhc_clk 2>; <--
       clock-input-name = "usdhc3";
};

Regards,
Shawn

Shawn Guo (3):
      arm/imx6: describe clocks in device tree source
      arm/imx: add a generic clock implementation for imx
      arm/imx6: convert clock to device tree

 .../devicetree/bindings/clock/clock-imx.txt        |  124 ++
 arch/arm/boot/dts/imx6q.dtsi                       |  943 +++++++++-
 arch/arm/mach-imx/Kconfig                          |    5 +
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/clock-imx6q.c                    | 2135 ++++----------------
 arch/arm/mach-imx/clock.c                          |  222 ++
 arch/arm/mach-imx/clock.h                          |   64 +
 7 files changed, 1734 insertions(+), 1760 deletions(-)
