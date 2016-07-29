From: zyw@rock-chips.com (Chris Zhong)
Date: Fri, 29 Jul 2016 15:48:17 +0800
Subject: [v8 PATCH 0/6] Rockchip Type-C and DisplayPort driver
Message-ID: <1469778503-29193-1-git-send-email-zyw@rock-chips.com>
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
put the firmware file[0] to /lib/firmware/rockchip/dptx.bin. The uCPU
in charge of aux communication and link training, the host use mailbox
to communicate with the ucpu.

The DP contoller has register a notification with extcon API, to get the
alt mode from PD, the PD driver need call the devm_extcon_dev_allocate
to create a extcon device and use extcon_set_state to notify DP
controller. And call extcon_set_cable_property to set orientation.

About the DP audio, cdn-dp registered 2 DAIs: 0 is I2S, 1 is SPDIF.
We can reference them in simple-card.

This series is based on Mark Yao's branch[1] and Chanwoo Choi's
extcon-test branch[2]. The extcon patch is base on a test branch, so
please do not review the "1/6 extcon: Add Type-C and DP support".

I test this patches on the rk3399-evb board, with a fusb302 driver,
this branch has no rk3399.dtsi, so the patch about dts is not included
in this series.

[0]
https://patchwork.kernel.org/patch/9249693/
[1]
https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23
[2]
https://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git/log/?h=extcon-test
- extcon: Add the extcon_type to gather each connector into five category
- extcon: Add the support for extcon property according to extcon type
- extcon: Add the support for the capability of each property
- extcon: Rename the extcon_set/get_state() to maintain the function naming
pattern
- extcon: Add the synchronization extcon APIs to support the notification


Changes in v8:
- set the default cable id to EXTCON_USB_HOST
- optimization Error log
- optimization the err log

Changes in v7:
- support new API of extcon
- support firmware standby when no dptx connection
- optimization the calculation of tu size and valid symbol

Changes in v6:
- add assigned-clocks and assigned-clock-rates
- delete the support of PIN_ASSIGN_A/B
- set the default mode to MODE_DFP_USB
- disable DP PLL at USB3 only mode
- add assigned-clocks and assigned-clock-rates
- add power-domains
- add a port struct
- select SND_SOC_HDMI_CODEC
- force reset the phy when hpd detected

Changes in v5:
- support get property from extcon
- remove PIN ASSIGN A/B support
- alphabetical order
- do not use long, use u32 or u64
- return MODE_CLOCK_HIGH when requested > actual
- Optimized Coding Style
- add a formula to get better tu size and symbol value.
- modify according to Sean Paul's comments
- fixed the fw_wait always 0

Changes in v4:
- add a #phy-cells node
- select EXTCON
- use phy framework to control the USB3 and DP function
- rename PIN_MAP_ to PIN_ASSIGN_
- add a reset node
- support 2 phys
- use phy framework to control DP phy
- support 2 phys

Changes in v3:
- use compatible: rockchip,rk3399-typec-phy
- use dashes instead of underscores.
- remove the phy framework(Kishon Vijay Abraham I)
- add parentheses around the macro
- use a single space between type and name
- add spaces after opening and before closing braces.
- use u16 for register value
- remove type-c phy header file
- CodingStyle optimization
- use some cable extcon to get type-c port information
- add a extcon to notify Display Port
- add SoC specific compatible string
- remove reg = <1>;
- use EXTCON_DISP_DP and EXTCON_DISP_DP_ALT cable to get dp port state.
- reset spdif before config it
- modify the firmware clk to 100Mhz
- retry load firmware if fw file is requested too early

Changes in v2:
- add some registers description
- select RESET_CONTROLLER
- alphabetic order
- modify some spelling mistakes
- make mode cleaner
- use bool for enable/disable
- check all of the return value
- return a better err number
- use more readx_poll_timeout()
- clk_disable_unprepare(tcphy->clk_ref);
- remove unuse functions, rockchip_typec_phy_power_on/off
- remove unnecessary typecast from void *
- use dts node to distinguish between phys.
- Alphabetic order
- remove excess error message
- use define clk_rate
- check all return value
- remove dev_set_name(dp->dev, "cdn-dp");
- use schedule_delayed_work
- remove never-called functions
- remove some unnecessary ()

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

Chris Zhong (6):
  extcon: Add EXTCON_DISP_DP and the property for USB Type-C
  Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
  phy: Add USB Type-C PHY driver for rk3399
  arm64: dts: rockchip: add Type-C phy for RK3399
  Documentation: bindings: add dt documentation for cdn DP controller
  drm/rockchip: cdn-dp: add cdn DP support for rk3399

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  |  74 ++
 .../devicetree/bindings/phy/phy-rockchip-typec.txt |  84 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  44 +
 drivers/extcon/extcon.c                            |   5 +
 drivers/gpu/drm/rockchip/Kconfig                   |  10 +
 drivers/gpu/drm/rockchip/Makefile                  |   1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 867 +++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h             | 103 +++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              | 961 +++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              | 482 +++++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   9 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   2 +
 drivers/phy/Kconfig                                |   9 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-rockchip-typec.c                   | 951 ++++++++++++++++++++
 include/linux/extcon.h                             |   8 +-
 17 files changed, 3620 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
 create mode 100644 drivers/phy/phy-rockchip-typec.c

-- 
2.6.3
