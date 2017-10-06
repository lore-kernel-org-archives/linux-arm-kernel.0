From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri,  6 Oct 2017 14:33:31 +0800
Subject: [PATCH 0/2] Add a regmap to Allwinner R40 CCU to export GMAC register
Message-ID: <20171006063333.12345-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the CCU of the Allwinner R40 SoC, there's a GMAC configuration register,
which is intended to be accessed by the dwmac-sun8i driver. On SoCs already
supported by the driver the register is placed in the syscon rather than
the CCU.

As CCU is a critical part of the SoC, so write to it should be strictly
limited. A regmap with restricted write permission is created by the R40
CCU driver, and can be get with dev_get_regmap. In order to tie the regmap
to the CCU device, the R40 CCU is now a platform driver, so a platform
device is created for it (and then tied with the regmap).

The first patch does the conversion of the driver to a platform driver,
and the second patch adds the regmap.

Icenowy Zheng (2):
  clk: sunxi-ng: r40: rewrite init code to a platform driver
  clk: sunxi-ng: r40: export a regmap to access the GMAC register

 drivers/clk/sunxi-ng/ccu-sun8i-r40.c | 69 ++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

-- 
2.13.6
