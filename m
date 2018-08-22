From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed, 22 Aug 2018 12:50:30 +0900
Subject: [PATCH v3 0/4] phy: socionext: add new UniPhier USB PHY driver support
Message-ID: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for PHY interface built into USB controller
implemented in Socionext UniPhier SoCs.

The USB3 PHY driver supports High-Speed PHY and Super-Speed PHY included in
the USB3 glue layer, and the USB2 PHY driver supports High-Speed PHY
integrated into system controller.

Changes since v2:
- rewrite a header with style that other phy drivers use
- replace return value of probe functions with PTR_ERR_OR_ZERO()
- fix typo of register offset macros

Changes since v1:
- rewrite a header with C++ comment style
- dt-bindings: separate a document for ssphy and hsphy
- dt-bindings: sort clock-names and reset-names to begin with "phy"
- dt-bindings: use vbus-supply instead of phy-supply, because vbus isn't
  for phy, but vbus is tied to the port that corresponds to each phy [1]
- stop using phy_power and add own .power_on and .power_off functions
  to control clk/reset for phy and vbus regulator
- separate clk_get() and reset_control_get() for each clk/reset
  and remove arrays of clock_names and reset_names
- remove phy-parameters that are the same as power-on values
- remove functions to set phy-parameters for legacy SoCs
- express phy-parameters by using macros including the number of
  the register and its bitfield (msb and lsb)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593279.html

Kunihiko Hayashi (4):
  dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
  phy: socionext: add USB3 PHY driver for UniPhier SoC
  dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
  phy: socionext: add USB2 PHY driver for UniPhier SoC

 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |  45 +++
 .../bindings/phy/uniphier-usb3-hsphy.txt           |  69 ++++
 .../bindings/phy/uniphier-usb3-ssphy.txt           |  57 +++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  25 ++
 drivers/phy/socionext/Makefile                     |   7 +
 drivers/phy/socionext/phy-uniphier-usb2.c          | 244 ++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3hs.c        | 422 +++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c        | 349 +++++++++++++++++
 10 files changed, 1220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

-- 
2.7.4
