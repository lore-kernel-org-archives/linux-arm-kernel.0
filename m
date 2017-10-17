From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 17 Oct 2017 19:38:15 +0300
Subject: [RFC v2 0/8] Acer Chromebook R13 support
In-Reply-To: <1508167900-27415-1-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1508167900-27415-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <3437221.yAhrl0lKkh@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulrich,

(CC'ing Matthias Brugger and Daniel Kurtz)

On Monday, 16 October 2017 18:31:32 EEST Ulrich Hecht wrote:
> Hi!
> 
> This is a new revision of the Acer Chromebook R13 support series. It does
> not offer anything new in terms of functionality, but eliminates three out
> of four ugly hacks and adds a few minor cleanups; see below for details.
> Thanks to Robin Murphy and CK Hu for their comments and suggestions!
> 
> I'm still looking for advice on how to implement the dual-role mmsys device
> correctly; see "hack: mediatek: get mmsys to register as both DRM and clock
> device" for details on this.

What I'd really like to find out is what the mmsys device is. Its DT binding 
documents it as "The Mediatek mmsys controller provides various clocks to the 
system". Even if it provides clocks to the display engine, it shouldn't be 
used as the root device in the display complex. There could of course be 
information I'm lacking as the datasheet isn't public. Hopefully someone from 
Mediatek and/or Google will be able to comment on this.

> Like the previous revision, you can find this series at
> https://github.com/uli/kernel/tree/elm-working, which also contains a config
> file and several ancillary bits that are required to build a kernel
> partition for the Chromebook. Instructions on how to do so (and various
> other things that have to be done to get it running on your device) are
> available at
> https://www.elinux.org/User:Uli/Acer_Chromebook_R13_GPU_test_system (These
> instructions have been written for the vendor kernel, but apply to mainline
> as well, except that you won't need any extra patches.)
> 
> CU
> Uli
> 
> Changes since RFC v1:
> - cmdq: remove obsolete driver; not currently used anyway
> - dt: remove CD GPIO from mmc1, does not seem to be correct
> - mmc: remove mtk-sd.c revert hack (works fine without the CD pin)
> - dsi: fix port number for drm_of_find_panel_or_bridge(), remove hack
> - fbdev: add missing Signed-off-bys
> - iommu: remove io-pgtable sanity check hack, has been properly fixed
> - minor style fixes
> 
> 
> Ulrich Hecht (8):
>   drm/bridge: GPIO-controlled display multiplexer driver
>   platform/chrome: ChromeOS firmware interface driver
>   drm/bridge: Parade PS8640 MIPI DSI -> eDP converter driver
>   drm/bridge: Analogix ANX7688 HDMI -> DP bridge driver
>   arm64: dts: mediatek: Add Elm Rev. 3 device tree
>   hack: mediatek: get mmsys to register as both DRM and clock device
>   drm/mediatek: Add DRM-based framebuffer device
>   drm: mediatek: Fix drm_of_find_panel_or_bridge conversion
> 
>  arch/arm64/boot/dts/mediatek/Makefile            |    1 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts |   21 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi     |  210 ++++
>  arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi     | 1013 +++++++++++++++++++
>  drivers/clk/mediatek/clk-mt8173.c                |    4 +-
>  drivers/gpu/drm/bridge/Kconfig                   |   32 +
>  drivers/gpu/drm/bridge/Makefile                  |    5 +
>  drivers/gpu/drm/bridge/analogix-anx7688.c        |  233 +++++
>  drivers/gpu/drm/bridge/generic-gpio-mux.c        |  316 +++++++
>  drivers/gpu/drm/bridge/parade-ps8640.c           | 1104 +++++++++++++++++++
>  drivers/gpu/drm/mediatek/Makefile                |    2 +
>  drivers/gpu/drm/mediatek/mtk_dpi.c               |    5 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c           |    5 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c           |   15 +
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h           |    4 +-
>  drivers/gpu/drm/mediatek/mtk_drm_fb.c            |   13 +
>  drivers/gpu/drm/mediatek/mtk_drm_fb.h            |    3 +
>  drivers/gpu/drm/mediatek/mtk_drm_fbdev.c         |  181 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_fbdev.h         |   32 +
>  drivers/gpu/drm/mediatek/mtk_dsi.c               |    2 +-
>  drivers/gpu/drm/mediatek/mtk_hdmi.c              |    5 +-
>  drivers/platform/chrome/Kconfig                  |   18 +
>  drivers/platform/chrome/Makefile                 |    2 +
>  drivers/platform/chrome/chromeos.c               |  120 +++
>  drivers/platform/chrome/chromeos.h               |   61 ++
>  drivers/platform/chrome/chromeos_arm.c           |  264 ++++++
>  drivers/platform/chrome/elog.h                   |  186 ++++
>  include/linux/chromeos_platform.h                |   27 +
>  28 files changed, 3874 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-rev3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-oak.dtsi
>  create mode 100644 drivers/gpu/drm/bridge/analogix-anx7688.c
>  create mode 100644 drivers/gpu/drm/bridge/generic-gpio-mux.c
>  create mode 100644 drivers/gpu/drm/bridge/parade-ps8640.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.c
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_drm_fbdev.h
>  create mode 100644 drivers/platform/chrome/chromeos.c
>  create mode 100644 drivers/platform/chrome/chromeos.h
>  create mode 100644 drivers/platform/chrome/chromeos_arm.c
>  create mode 100644 drivers/platform/chrome/elog.h
>  create mode 100644 include/linux/chromeos_platform.h


-- 
Regards,

Laurent Pinchart
