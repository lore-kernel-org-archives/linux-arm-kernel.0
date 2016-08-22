From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 21 Aug 2016 21:23:13 -0700
Subject: [v13 PATCH 0/5] Rockchip Type-C and DisplayPort driver
Message-ID: <1471839798-14729-1-git-send-email-zyw@rock-chips.com>
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
put the firmware file[0] rockchip/dptx.bin to
/lib/firmware/rockchip/dptx.bin. The uCPU in charge of aux communication
and link training, the host use mailbox to communicate with the ucpu.

The DP contoller has register a notification with extcon API, to get the
alt mode from PD, the PD driver need call the devm_extcon_dev_allocate
to create a extcon device and use extcon_set_state to notify DP
controller. And call extcon_set_cable_property to set orientation.

About the DP audio, cdn-dp registered 2 DAIs: 0 is I2S, 1 is SPDIF.
We can reference them in simple-card.

This series is based on Mark Yao's branch[1] and Chanwoo Choi's
extcon-next branch[2], and Guenter's patch about
EXTCON_PROP_USB_SUPERSPEED[3], and Heiko's clk patch[4].

I test this patches on the rk3399-evb board, with a fusb302 driver,
this branch has no rk3399.dtsi, so the patch about dts is not included
in this series.

>From V9, the Type-C PHY is split into two PHYs: DP and USB3. The PHY
will be init, no matter which PHY be power_on. The DP module will
enter A2 mode (standby mode) after phy_init, if DP PHY is powered on,
the DP module will enter to A0 mode(running mode). Then if DP PHY is
powered off, DP module will back to A2 mode. If everything is
un-plugged, phy will be deinit.

[0]
kernel/git/firmware/linux-firmware.git
[1]
https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23
[2]
https://git.kernel.org/cgit/linux/kernel/git/chanwoo/extcon.git extcon-next
[3]
https://patchwork.kernel.org/patch/9280955/
[4]
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git
/commit/?h=v4.9-clk/next&id=54479449c801e46ee2b6ba08e2f19cd810f74f94
https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git
/commit/?h=v4.8-clk/fixes&id=a3f457d9636b3f5ae4fc6502cb0c95f60f5e342b


Changes in v13:
- do not return err if nothing connected with Type-C, when usb phy power on,
  since the USB core driver will call phy power without USB3 device connected.
- add dptx and apb reset
- support suspend/resume
- switch power domain dynamically
- re-training when hpd signal is triggered

Changes in v12:
- enable DP+USB3 mode, only when EXTCON_PROP_USB_SUPERSPEED equal 1
  and DP is attached
- use EXTCON_PROP_USB_SUPERSPEED to replace EXTCON_USB_HOST

Changes in v11:
- make a clearer emarcation between usb phy and dp phy
- make a clearer demarcation between usb phy and dp phy.
- split the dp-phy and usb3-phy to 2 child-node
- refer dp phy
- add best_encoder back, since it required by drm_atomic_helper_check

Changes in v10:
- remove rockchip,uphy-dp-sel property
- do not control dp select and hpd config in phy driver
- remove rockchip,uphy-dp-sel property
- add pclk_vio_grf clock
- remove best_encoder ops
- support read sink count from DPCD
- control the grf_clk in DP

Changes in v9:
- change #phy-cells to 1
- the new_mode should be int not u8
- move mutex_lock(&tcphy->lock); to earlier place. in
  rockchip_usb3_phy_power_off
- better mutex lock for phy mode and flip
- split the Type-C PHY into two PHYs: USB3 and DP
- change #phy-cells to 1
- modify the reference phy = <&tcphy0 0>, <&tcphy1 0>;
- do not need reset the phy before power_on
- add a orientation information for set_capability
- retry to read dpcd in 10 seconds

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

Chris Zhong (5):
  Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
  phy: Add USB Type-C PHY driver for rk3399
  arm64: dts: rockchip: add Type-C phy for RK3399
  Documentation: bindings: add dt documentation for cdn DP controller
  drm/rockchip: cdn-dp: add cdn DP support for rk3399

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  |   75 ++
 .../devicetree/bindings/phy/phy-rockchip-typec.txt |  101 ++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   56 ++
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 1052 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |  106 ++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |  959 ++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              |  482 +++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    9 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |    2 +
 drivers/phy/Kconfig                                |    9 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-rockchip-typec.c                   |  977 ++++++++++++++++++
 15 files changed, 3850 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
 create mode 100644 drivers/phy/phy-rockchip-typec.c

-- 
1.9.1
