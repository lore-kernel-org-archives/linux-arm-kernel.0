From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  3 Jun 2016 23:15:07 +0800
Subject: [v1 PATCH 0/4] Rockchip Type-C and DispplayPort driver
Message-ID: <1464966911-18949-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all

This series patch is for rockchip Type-C phy and DisplayPort controller
driver.

The USB Type-C PHY is designed to support the USB3 and DP applications.
The PHY basically has two main components: USB3 and DisplyPort. USB3
operates in SuperSpeed mode and the DP can operate at RBR, HBR and HBR2
data rates. The Type-C cable orientation detection and Power Delivery
(PD) is accomplished using a PD PHY or a exernal PD chip.

The DP controller is compliant with DisplayPort Specification,
Version 1.3, This IP is compatible with the rockchip type-c PHY IP.
There is a uCPU in DP controller, it need a firmware to work, please
put the firmware file to /lib/firmware/cdn/dptx.bin. The uCPU in charge
of aux communication and link training, the host use mailbox to
communicate with the ucpu.

The PHY driver has register a notification with extcon API, to get the
alt mode from PD, the PD driver need call the devm_extcon_dev_allocate
to create a extcon device and use extcon_set_state to notify PHY and
DP controller.

About the DP audio, cdn-dp registered 2 DAIs: 0 is I2S, 1 is SPDIF.
We can reference them in simple-card.

This series is based on Mark Yao's branch:
https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23

I test this patches on the rk3399-evb board, with a fusb302 driver,
this branch has no rk3399.dtsi, so the patch about dts is not included
in this series.


Changes in v1:
- add extcon node description
- move the registers in phy driver
- remove the suffix of reset
- update the licence note
- init core clock to 50MHz
- use extcon API
- remove unused global
- add some comments for magic num
- change usleep_range(1000, 2000) tousleep_range(1000, 1050)
- remove __func__ from dev_err
- return err number when get clk failed
- remove ADDR_ADJ define
- use devm_clk_get(&pdev->dev, "tcpdcore")
- add extcon node description
- add #sound-dai-cells description
- use extcon API
- use hdmi-codec for the DP Asoc
- do not initialize the "ret"
- printk a err log when drm_of_encoder_active_endpoint_id
- modify the dclk pin_pol to a single line

Chris Zhong (4):
  Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
  phy: Add USB Type-C PHY driver for rk3399
  Documentation: bindings: add dt documentation for cdn DP controller
  drm/rockchip: cdn-dp: add cdn DP support for rk3399

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  |  62 ++
 .../devicetree/bindings/phy/phy-rockchip-typec.txt |  46 +
 drivers/gpu/drm/rockchip/Kconfig                   |   9 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 709 ++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h             | 110 +++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              | 721 ++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              | 404 +++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   6 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   2 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   2 +
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rockchip-typec.c                   | 942 +++++++++++++++++++++
 include/linux/phy/phy-rockchip-typec.h             |  20 +
 15 files changed, 3041 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
 create mode 100644 drivers/phy/phy-rockchip-typec.c
 create mode 100644 include/linux/phy/phy-rockchip-typec.h

-- 
2.6.3
