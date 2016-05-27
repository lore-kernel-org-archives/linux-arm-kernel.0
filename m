From: kever.yang@rock-chips.com (Kever Yang)
Date: Fri, 27 May 2016 15:38:01 +0800
Subject: [PATCH 0/6] Rockchip Type-C and DispplayPort driver
In-Reply-To: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
References: <1464328939-8073-1-git-send-email-zyw@rock-chips.com>
Message-ID: <5747F959.7010101@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On 05/27/2016 02:02 PM, Chris Zhong wrote:
> Hi all
>
> This series patch is for rockchip Type-C phy and DisplayPort controller
> driver.
>
> The USB Type-C PHY is designed to support the USB3 and DP applications.
> The PHY basically has two main components: USB3 and DisplyPort. USB3
> operates in SuperSpeed mode and the DP can operate at RBR, HBR and HBR2
> data rates. The Type-C cable orientation detection and Power Delivery
> (PD) is accomplished using a PD PHY or a exernal PD chip.
>
> The DP controller is compliant with DisplayPort Specification,
> Version 1.3, This IP is compatible with the rockchip type-c PHY IP.
> There is a uCPU in DP controller, it need a firmware to work, please
> put the firmware file to /lib/firmware/cdn/dptx.bin. The uCPU in charge
> of aux communication and link training, the host use mailbox to
> communicate with the ucpu.
>
> The PHY driver has register a notification, to get the alt mode from PD,
> the PD driver need call the tcphy_notifier_call_chain to notify PHY and
> DP controller.
For the notification for the port status change from PD, I think we can
use the extcon class, pls reference the code in drivers/extcon/ for usage.

Thanks,
- Kever
>
> This series is based on Mark Yao's branch:
> https://github.com/markyzq/kernel-drm-rockchip/tree/drm-rockchip-next-2016-05-23
>
> I test this patches on the rk3399-evb board, with a fusb302 driver,
> this branch has no rk3399.dtsi, so the patch about dts is not included
> in this series.
>
>
>
> Chris Zhong (6):
>    phy: Add USB Type-C PHY driver for rk3399
>    Documentation: bindings: add dt doc for Rockchip USB Type-C PHY
>    drm/rockchip: vop: add cdn DP support for rk3399
>    Documentation: bindings: add dt documentation for cdn DP controller
>    ASoC: cdn-dp: Add cdn DP codec driver
>    ASoC: rockchip: Add machine driver for cdn dp codec
>
>   .../bindings/display/rockchip/cdn-dp-rockchip.txt  |  57 ++
>   .../devicetree/bindings/phy/phy-rockchip-typec.txt |  55 ++
>   .../bindings/sound/rockchip-cdn-dp-audio.txt       |  12 +
>   drivers/gpu/drm/rockchip/Kconfig                   |   9 +
>   drivers/gpu/drm/rockchip/Makefile                  |   1 +
>   drivers/gpu/drm/rockchip/cdn-dp-core.c             | 620 ++++++++++++++++
>   drivers/gpu/drm/rockchip/cdn-dp-core.h             |  95 +++
>   drivers/gpu/drm/rockchip/cdn-dp-reg.c              | 730 ++++++++++++++++++
>   drivers/gpu/drm/rockchip/cdn-dp-reg.h              | 404 ++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |   9 +-
>   drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |   2 +
>   drivers/gpu/drm/rockchip/rockchip_vop_reg.c        |   2 +
>   drivers/phy/Kconfig                                |   7 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-rockchip-typec.c                   | 823 +++++++++++++++++++++
>   include/sound/cdn-dp-audio.h                       |  51 ++
>   sound/soc/codecs/Kconfig                           |   3 +
>   sound/soc/codecs/Makefile                          |   2 +
>   sound/soc/codecs/cdn-dp-audio.c                    | 246 ++++++
>   sound/soc/rockchip/Kconfig                         |   9 +
>   sound/soc/rockchip/Makefile                        |   2 +
>   sound/soc/rockchip/rockchip-cdn-dp-audio.c         | 167 +++++
>   22 files changed, 3306 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/cdn-dp-rockchip.txt
>   create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>   create mode 100644 Documentation/devicetree/bindings/sound/rockchip-cdn-dp-audio.txt
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.c
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-core.h
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.c
>   create mode 100644 drivers/gpu/drm/rockchip/cdn-dp-reg.h
>   create mode 100644 drivers/phy/phy-rockchip-typec.c
>   create mode 100644 include/sound/cdn-dp-audio.h
>   create mode 100644 sound/soc/codecs/cdn-dp-audio.c
>   create mode 100644 sound/soc/rockchip/rockchip-cdn-dp-audio.c
>
