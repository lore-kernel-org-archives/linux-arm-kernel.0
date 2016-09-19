From: john@metanate.com (John Keeping)
Date: Mon, 19 Sep 2016 18:24:30 +0100
Subject: [PATCH 00/27] drm/rockchip: MIPI fixes & improvements
In-Reply-To: <20160919171747.28512-1-john@metanate.com>
References: <20160919171747.28512-1-john@metanate.com>
Message-ID: <20160919182430.13fb3151.john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

D'oh, I got send-email horribly wrong here.  Please ignore the n/27
patches following this message - the n/26 versions are correct.

I won't spam the list with a cleaned-up v2 immediately, but I'll make
extra sure to clean out my working directory when I do send the re-roll!

On Mon, 19 Sep 2016 18:17:10 +0100, John Keeping wrote:

> This is a bit of a mixed selection of patches to all areas of the
> Rockchip dw-mipi-dsi driver, which I've been using for a while.
> 
> The first few patches fix the driver's use of the atomic API by removing
> hardware manipulation from the mode_set hook:
> 
>   drm/rockchip: dw-mipi-dsi: use mode from display state
>   drm/rockchip: dw-mipi-dsi: pass new mode into MIPI mode set
>   drm/rockchip: dw-mipi-dsi: don't configure hardware in mode_set for
>     MIPI
>   drm/rockchip: dw-mipi-dsi: rename commit hook to enable
> 
> The following several patches fix various aspects of DSI host transfers
> in order to improve support for displays that need to be set up via DSI
> commands:
> 
>   drm/rockchip: dw-mipi-dsi: fix command header writes
>   drm/rockchip: dw-mipi-dsi: fix generic packet status check
>   drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read on tx_buf
>   drm/rockchip: dw-mipi-dsi: include bad value in error message
>   drm/rockchip: dw-mipi-dsi: respect message flags
>   drm/rockchip: dw-mipi-dsi: only request HS clock when required
>   drm/rockchip: dw-mipi-dsi: don't assume buffer is aligned
>   drm/rockchip: dw-mipi-dsi: prepare panel after phy init
>   drm/rockchip: dw-mipi-dsi: allow commands in panel_disable
> 
> Then a bunch of patches to improve the PHY PLL and other clock setup:
> 
>   drm/rockchip: dw-mipi-dsi: fix escape clock rate
>   drm/rockchip: dw-mipi-dsi: ensure PHY is reset
>   drm/rockchip: dw-mipi-dsi: configure bias and bandgap before enable
>   drm/rockchip: dw-mipi-dsi: don't enable PHY PLL until it's configured
>   drm/rockchip: dw-mipi-dsi: properly configure PHY timing
>   drm/rockchip: dw-mipi-dsi: improve PLL configuration
> 
> A couple of patches make the VOP and MIPI host consistent when panels do
> not set explicit hsync/vsync polarities:
> 
>   drm/rockchip: dw-mipi-dsi: use positive check for N{H,V}SYNC
>   drm/rockchip: vop: test for P{H,V}SYNC
> 
> The following patch fixes fbcon by making sure that the output
> resolution is known before it loads:
> 
>   drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
> 
> Then a patch that should be self-explanatory:
> 
>   drm/rockchip: dw-mipi-dsi: support non-burst modes
> 
> And the final two patches were useful in development but aren't really
> needed once everything's working:
> 
>   drm/rockchip: dw-mipi-dsi: add reset control
>   drm/rockchip: dw-mipi-dsi: support read commands
> 
> 
> John Keeping (26):
>   drm/rockchip: dw-mipi-dsi: use mode from display state
>   drm/rockchip: dw-mipi-dsi: pass new mode into MIPI mode set
>   drm/rockchip: dw-mipi-dsi: don't configure hardware in mode_set for
>     MIPI
>   drm/rockchip: dw-mipi-dsi: rename commit hook to enable
>   drm/rockchip: dw-mipi-dsi: fix command header writes
>   drm/rockchip: dw-mipi-dsi: fix generic packet status check
>   drm/rockchip: dw-mipi-dsi: avoid out-of-bounds read on tx_buf
>   drm/rockchip: dw-mipi-dsi: include bad value in error message
>   drm/rockchip: dw-mipi-dsi: respect message flags
>   drm/rockchip: dw-mipi-dsi: only request HS clock when required
>   drm/rockchip: dw-mipi-dsi: don't assume buffer is aligned
>   drm/rockchip: dw-mipi-dsi: prepare panel after phy init
>   drm/rockchip: dw-mipi-dsi: allow commands in panel_disable
>   drm/rockchip: dw-mipi-dsi: fix escape clock rate
>   drm/rockchip: dw-mipi-dsi: ensure PHY is reset
>   drm/rockchip: dw-mipi-dsi: configure bias and bandgap before enable
>   drm/rockchip: dw-mipi-dsi: don't enable PHY PLL until it's configured
>   drm/rockchip: dw-mipi-dsi: properly configure PHY timing
>   drm/rockchip: dw-mipi-dsi: improve PLL configuration
>   drm/rockchip: dw-mipi-dsi: use specific poll helper
>   drm/rockchip: dw-mipi-dsi: use positive check for N{H,V}SYNC
>   drm/rockchip: vop: test for P{H,V}SYNC
>   drm/rockchip: dw-mipi-dsi: defer probe if panel is not loaded
>   drm/rockchip: dw-mipi-dsi: support non-burst modes
>   drm/rockchip: dw-mipi-dsi: add reset control
>   drm/rockchip: dw-mipi-dsi: support read commands
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c      | 325 ++++++++++++++++++++--------
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c |   4 +-
>  2 files changed, 234 insertions(+), 95 deletions(-)
> 
