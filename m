From: lyz@rock-chips.com (Yunzhi Li)
Date: Thu, 11 Dec 2014 17:55:17 +0800
Subject: [PATCH v6 0/5] Patches to add support for Rockchip usb PHYs.
Message-ID: <1418291722-25448-1-git-send-email-lyz@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Patches to add support for Rockchip usb phys.Add a new Rockchip
usb phy driver and modify dwc2 controller driver to make dwc2
platform devices support a generic PHY framework driver. This
patch set has been tested on my rk3288-evb and power off the usb
phys would reduce about 60mW power budget in total during sustem
suspend.

Changes in v6:
- Rename SIDDQ_MSK to SIDDQ_WRITE_ENA.
- Use phandle args to find a phy struct directly.

Changes in v5:
- Adjust entry order of example devicetree node in document.
- reorder the phy dt node to a correct position.

Changes in v4:
- Get number of PHYs from device tree.
- Model each PHY as subnode of the phy provider node.
- Updata description for phy device tree subnode.
- Add phy subnodes.

Changes in v3:
- Use BIT macro instead of bit shift ops.
- Rename the config entry to PHY_ROCKCHIP_USB.
- Fix coding style: both branches of the if() which only one
  branch of the conditional statement is a single statement
  should have braces.
- No need to test dwc2->phy for NULL before calling generic phy
  APIs.

Yunzhi Li (5):
  phy: add a driver for the Rockchip SoC internal USB2.0 PHY
  Documentation: bindings: add dt documentation for Rockchip usb PHY
  usb: dwc2: add generic PHY framework support for dwc2 usb controler
    platform driver.
  ARM: dts: rockchip: add rk3288 usb PHY
  ARM: dts: rockchip: Enable usb PHY on rk3288-evb board

 .../devicetree/bindings/phy/rockchip-usb-phy.txt   |  32 ++++
 arch/arm/boot/dts/rk3288-evb.dtsi                  |   4 +
 arch/arm/boot/dts/rk3288.dtsi                      |  27 +++
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rockchip-usb.c                     | 198 +++++++++++++++++++++
 drivers/usb/dwc2/gadget.c                          |  33 ++--
 drivers/usb/dwc2/platform.c                        |  36 +++-
 8 files changed, 315 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-usb-phy.txt
 create mode 100644 drivers/phy/phy-rockchip-usb.c

-- 
2.0.0
