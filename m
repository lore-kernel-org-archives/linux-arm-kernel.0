From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 17 Dec 2015 10:29:53 +0100
Subject: [PATCH v6 0/6] Add mipi dsi support for rk3288
In-Reply-To: <1450260616-21160-1-git-send-email-zyw@rock-chips.com>
References: <1450260616-21160-1-git-send-email-zyw@rock-chips.com>
Message-ID: <3523259.ZRgH1Shd9Y@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Mittwoch, 16. Dezember 2015, 18:10:10 schrieb Chris Zhong:
> The rk3288 MIPI DSI is a Synopsys DesignWare MIPI DSI host controller
> IP. This series adds support for a Synopsys DesignWare MIPI DSI host
> controller DRM driver.
> 
> The MIPI DSI feature is tested on rk3288 evb board, backport them to
> chrome os kernel chrome_v3.14, and it can display normally.
> 
> This patchset is base on the patchset from Ying.liu at freescale.com.
> <http://www.spinics.net/lists/dri-devel/msg77181.html>
> 
> According to the suggestion from Thierry, I have get rid of the bridge,
> and register the encoder & connecter in drm/rockchip/dw-mipi-dsi.c.

from my point it looks good (although I cannot really speak on the drm-related 
internals).

But I do think we'll be doing atomic modesetting conversion first (last 
version posted from Mark today), so you should probably make sure your dsi 
driver still works after that conversion and make changes if needed.


Heiko

> 
> 
> Changes in v6:
> - update the document, since the bridge device has been deleted.
> - Do not use bridge driver (Thierry Reding)
> - Optimization the phy init sequence
> 
> Changes in v5:
> - modify the clk name to SCLK_MIPIDSI_24M
> - add a blank line befor lcd_en
> 
> Changes in v4:
> - use clk_round_rate to check the clock rate in vop_crtc_mode_fixup
> 
> Changes in v3:
> - move dw_mipi_dsi_rockchip.txt to bindings/display/rockchip/
> 
> Chris Zhong (5):
>   drm/rockchip: return a true clock rate to adjusted_mode
>   Documentation: dt-bindings: Add bindings for rk3288 DW MIPI DSI driver
>   drm: rockchip: Support Synopsys DW MIPI DSI
>   ARM: dts: rockchip: add rk3288 mipi_dsi nodes
>   ARM: dts: rockchip: add support mipi panel tv080wum-nl0
> 
> Liu Ying (1):
>   drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
> 
>  .../display/rockchip/dw_mipi_dsi_rockchip.txt      |   60 +
>  arch/arm/boot/dts/rk3288-evb.dtsi                  |   20 +-
>  arch/arm/boot/dts/rk3288.dtsi                      |   39 +
>  drivers/gpu/drm/rockchip/Kconfig                   |   10 +
>  drivers/gpu/drm/rockchip/Makefile                  |    1 +
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c             | 1200
> ++++++++++++++++++++ drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  
>  8 +
>  include/drm/drm_mipi_dsi.h                         |   14 +
>  8 files changed, 1351 insertions(+), 1 deletion(-)
>  create mode 100644
> Documentation/devicetree/bindings/display/rockchip/dw_mipi_dsi_rockchip.txt
> create mode 100644 drivers/gpu/drm/rockchip/dw-mipi-dsi.c
