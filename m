From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 15:11:10 +0200
Subject: [PATCH 0/2] ARM: dts: mxs: add pinctrl header files to be able to use
 symbolic names in dts
Message-ID: <1375967472-7755-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add header files for the MXS arch to
include/dt-bindings/pinctrl and convert the DTS files to use the pad
definitions from thoose files rather than hardcoding the pinctrl
values.

The conversion from numerical representation to symbolic names has
been done with a perl script that checked the definitions for
consistency of the pin function comments and the numerical values
used.

This revealed an inconsistency in:
arch/arm/boot/dts/imx28-apx4devkit.dts, which pretended to use
MX28_PAD_SSP2_SS0__GPIO_2_19 in the comment (equivalent to 0x2133),
but actually was using MX28_PAD_SSP2_SS0__AUART3_TX by the numerical
value 0x2131.

I decided to use the (probably wrong) assignment
MX28_PAD_SSP2_SS0__AUART3_TX because that is what is actually
configured without this patch.

 arch/arm/boot/dts/imx23-evk.dts           |   10 -
 arch/arm/boot/dts/imx23-olinuxino.dts     |    6 
 arch/arm/boot/dts/imx23-stmp378x_devb.dts |    6 
 arch/arm/boot/dts/imx23.dtsi              |  163 ++++++++--------
 arch/arm/boot/dts/imx28-apf28.dts         |    2 
 arch/arm/boot/dts/imx28-apf28dev.dts      |   24 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts    |   38 +--
 arch/arm/boot/dts/imx28-cfa10036.dts      |    8 
 arch/arm/boot/dts/imx28-cfa10037.dts      |    6 
 arch/arm/boot/dts/imx28-cfa10049.dts      |   84 ++++----
 arch/arm/boot/dts/imx28-cfa10055.dts      |   56 ++---
 arch/arm/boot/dts/imx28-cfa10056.dts      |   20 +-
 arch/arm/boot/dts/imx28-cfa10057.dts      |   48 ++--
 arch/arm/boot/dts/imx28-cfa10058.dts      |   12 -
 arch/arm/boot/dts/imx28-evk.dts           |   32 +--
 arch/arm/boot/dts/imx28-m28evk.dts        |   16 -
 arch/arm/boot/dts/imx28-sps1.dts          |    8 
 arch/arm/boot/dts/imx28-tx28.dts          |   85 ++++----
 arch/arm/boot/dts/imx28.dtsi              |  345 +++++++++++++++++------------------
 include/dt-bindings/pinctrl/mx23.h        |  333 ++++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/mx28.h        |  506 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/pinctrl/mxs.h         |   31 +++
 22 files changed, 1356 insertions(+), 483 deletions(-)
