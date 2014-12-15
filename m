From: ykk@rock-chips.com (Yakir Yang)
Date: Mon, 15 Dec 2014 10:11:28 +0800
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
Message-ID: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


rk3288 use Designware HDMI IP, Designware HDMI supports four interfaces to
config hdmi audio(I2S, S/PDIF, Generic Parallel Audio, AHB Audio DMA), but
rk3288 only support two ways to config hdmi audio(I2S, S/PDIF), So we take
I2S as hdmi audio operation interfaces, and then treat hdmi audio as an
standard ALSA devices(only got platback function).

Four things we have done:
1. modify the audio part of dw_hdmi drivers for rk3288 platform specific.
2. add codec driver for hdmi audio, and creat codec device dynamically in
   hdmi driver probe function, using platform_register_device_full way, so
   that hdmi codec driver can connected with hdmi driver.
3. add sound driver for hdmi audio, creat hdmi audio sound card.
4. add dt-bings file and add hdmi_audio node to corresponding dt file.

[Explanation]:
those patch is depend on patch by Andy Yan
drm: bridge/dw_hdmi: add rockchip rk3288 support
see https://patchwork.kernel.org/patch/5442361/


Yakir Yang (6):
  drm: bridge/dw_hdmi: add hdmi audio config interfaces
  drm: bridge/bridge: add support for rk3288 hdmi-audio
  ASoC: dw-hdmi-audio: add codec driver for dw hdmi audio
  ASoC: rockchip-hdmi-audio: add sound driver for hdmi audio
  dt-bindings: Add documentation for Rockchip hdmi-audio
  ARM: dts: rockchip: add hdmi audio nodes

 .../sound/rockchip,rockchip-hdmi-audio.txt         |  16 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  11 +
 arch/arm/boot/dts/rk3288.dtsi                      |   8 +
 drivers/gpu/drm/bridge/dw_hdmi.c                   |  32 +-
 include/drm/bridge/dw_hdmi.h                       |  12 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/dw-hdmi-audio.c                   | 371 +++++++++++++++++++++
 sound/soc/codecs/dw-hdmi-audio.h                   |  82 +++++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c           | 208 ++++++++++++
 12 files changed, 756 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.c
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.h
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

-- 
2.1.2
