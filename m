From: zyw@rock-chips.com (Chris Zhong)
Date: Fri,  9 Sep 2016 19:15:43 -0700
Subject: [PATCH v15 0/5] Rockchip Type-C DisplayPort driver
Message-ID: <1473473748-22331-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all

This series patch is for rockchip Type-C DisplayPort controller driver.

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
We can reference them in rk3399-gru machine driver. It base on the
hdmi-notify patches[1], they are both in reviewing.

This series is based on Mark Yao's branch[2], the extcon API backport
from linux-next[3].

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
https://patchwork.kernel.org/patch/8887261/
https://patchwork.kernel.org/patch/8887251/
[2]
https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23
[3]
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master


Changes in v15:
Chris Zhong's changes:
- fix disable phy unbalance
- support Apple Dock hot-plug in HDMI port
- retraining when Apple Dock hpd irq coming
Sean Paul's changes:
- Restructured the worker
- Synchronized between worker & drm hooks
- Properly implemented enable/disable
- Added error checking
- Use devm variant of extcon
- Use DRM_DEV_* logging
- Refactored code to (hopefully) be more clear

Changes in v14:
- Modify some grammatical errors
- remove the mutex around cdn_dp_audio_get_eld
- power on the power domain after clk_enable
- retry to read edid
- change super speed property name to EXTCON_PROP_USB_SS
- do a correct mode_valid check when bpc is 0

Changes in v13:
- add dptx and apb reset
- support suspend/resume
- switch power domain dynamically
- re-training when hpd signal is triggered

Changes in v12:
- use EXTCON_PROP_USB_SUPERSPEED to replace EXTCON_USB_HOST

Changes in v11:
- refer dp phy
- add best_encoder back, since it required by drm_atomic_helper_check

Changes in v10:
- add pclk_vio_grf clock
- remove best_encoder ops
- support read sink count from DPCD
- control the grf_clk in DP

Changes in v9:
- modify the reference phy = <&tcphy0 0>, <&tcphy1 0>;
- do not need reset the phy before power_on
- add a orientation information for set_capability
- retry to read dpcd in 10 seconds

Changes in v8:
- optimization the err log

Changes in v7:
- support firmware standby when no dptx connection
- optimization the calculation of tu size and valid symbol

Changes in v6:
- add assigned-clocks and assigned-clock-rates
- add power-domains
- add a port struct
- select SND_SOC_HDMI_CODEC
- force reset the phy when hpd detected

Changes in v5:
- alphabetical order
- do not use long, use u32 or u64
- return MODE_CLOCK_HIGH when requested > actual
- Optimized Coding Style
- add a formula to get better tu size and symbol value.
- modify according to Sean Paul's comments
- fixed the fw_wait always 0

Changes in v4:
- add a reset node
- support 2 phys
- use phy framework to control DP phy
- support 2 phys

Changes in v3:
- add SoC specific compatible string
- remove reg = <1>;
- use EXTCON_DISP_DP and EXTCON_DISP_DP_ALT cable to get dp port state.
- reset spdif before config it
- modify the firmware clk to 100Mhz
- retry load firmware if fw file is requested too early
- change spdif to i2s2

Changes in v2:
- Alphabetic order
- remove excess error message
- use define clk_rate
- check all return value
- remove dev_set_name(dp->dev, "cdn-dp");
- use schedule_delayed_work
- remove never-called functions
- remove some unnecessary ()
- correct the commit message

Changes in v1:
- add extcon node description
- add #sound-dai-cells description
- use extcon API
- use hdmi-codec for the DP Asoc
- do not initialize the "ret"
- printk a err log when drm_of_encoder_active_endpoint_id
- modify the dclk pin_pol to a single line

Chris Zhong (5):
  extcon: Introduce EXTCON_PROP_DISP_HPD property
  Documentation: bindings: add dt documentation for cdn DP controller
  drm/rockchip: cdn-dp: add cdn DP support for rk3399
  drm/rockchip: cdn-dp: support audio hot-plug
  ASoC: rockchip: Add DP dai-links to the rk3399-gru machine driver

 .../bindings/display/rockchip/cdn-dp-rockchip.txt  |   75 ++
 .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   11 +-
 drivers/gpu/drm/rockchip/Kconfig                   |   10 +
 drivers/gpu/drm/rockchip/Makefile                  |    1 +
 drivers/gpu/drm/rockchip/cdn-dp-core.c             | 1165 ++++++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-core.h             |  108 ++
 drivers/gpu/drm/rockchip/cdn-dp-reg.c              |  956 ++++++++++++++++
 drivers/gpu/drm/rockchip/cdn-dp-reg.h              |  482 ++++++++
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |    9 +
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |    2 +
 include/linux/extcon.h                             |   14 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   93 ++
 13 files changed, 2930 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
 create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h

-- 
1.9.1
