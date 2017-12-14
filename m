From: plaes@plaes.org (Priit Laes)
Date: Thu, 14 Dec 2017 07:01:57 +0000
Subject: [PATCH v4 00/15] drm/sun4i: Add A83t LVDS support
In-Reply-To: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20171214070157.rqx4tfpluzaqmtxu@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 07, 2017 at 04:58:45PM +0100, Maxime Ripard wrote:
> Hi,
> 
> Here is an attempt at supporting the LVDS output in our DRM driver. This
> has been tested on the A83T (with DE2), but since everything is basically
> in the TCON, it should also be usable on the older SoCs with minor
> modifications.

I managed to get the single-channel LVDS working on an A10 tablet after
doing those minor modifications (although, the colours are off a bit).
So in general this series looks good :)

> 
> This was the occasion to refactor a bunch of things. The most notable ones
> would be the documentation, and split of the UI layers in the mixer code,
> and the switch to kfifo for our endpoint parsing code in the driver that
> fixes an issue introduced by the switch to BFS.
> 
> Let me know what you think,
> Maxime
> 
> Changes from v3:
>   - Collect the tags
>   - Use SPDX headers when possible
>   - Added the new mixer configuration options
>   - Changed the LVDS clock for lvds-alt instead of lvds-pll
>   - Removed the MIPI PLL from the A31s
>   - Changed the LVDS_ANA0 macros name to reflect the generation they were
>     introduced in, and added a comment to mention the changes needed to
>     support the older SoCs
> 
> Changes from v2:
>   - Move the module clock rate to the mixer structure
>   - Adjusted the simple-panel documentation for power-supply
>   - Changed the compatible for the first A83t mixer to mixer 0
>   - Rebased on top of current drm-misc
>   - Split out the A83t bindings in its separate patch
> 
> Changes from v1:
>   - Added a fix for the error path handling in the TCON
>   - Enable the TCON by default
>   - Removed the patch that changes the channels offset but kept most of the
>     modifications as a cleanup
>   - Deal with the LVDS clock being able to have another PLL parent on some
>     SoCs
>   - Renamed the TCON compatible to TCON-TV, following the convention used
>     on newer SoCs
>   - Removed the hardcoded timings
>   - Moved LVDS enable quirks to a separate function
>   - Used clock indices define in the DT
>   - Removed the hardcoded clock rate in the DT and moved it to the driver
>   - Changed sun8i_mixer_planes to sun8i_mixer_ui_planes to be consistent
>   - Added the various tags collected
>   - Rebased on top of 4.15
> 
> Maxime Ripard (15):
>   dt-bindings: panel: lvds: Document power-supply property
>   drm/panel: lvds: Add support for the power-supply property
>   dt-bindings: display: sun4i-drm: Add LVDS properties
>   dt-bindings: display: sun4i-drm: Add A83T pipeline
>   drm/sun4i: Fix error path handling
>   drm/sun4i: Force the mixer rate at 150MHz
>   drm/sun4i: Create minimal multipliers and dividers
>   drm/sun4i: Add LVDS support
>   drm/sun4i: Add A83T support
>   ARM: dts: sun8i: a83t: Add display pipeline
>   ARM: dts: sun8i: a83t: Enable the PWM
>   ARM: dts: sun8i: a83t: Add LVDS pins group
>   ARM: dts: sun8i: a83t: Add the PWM pin group
>   ARM: dts: sun8i: a711: Reinstate the PMIC compatible
>   ARM: dts: sun8i: a711: Enable the LCD
> 
>  Documentation/devicetree/bindings/display/panel/panel-common.txt |   6 ++-
>  Documentation/devicetree/bindings/display/panel/panel-lvds.txt   |   1 +-
>  Documentation/devicetree/bindings/display/panel/simple-panel.txt |   2 +-
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt    |  12 +++-
>  arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                        |  62 ++++++++++++++++++-
>  arch/arm/boot/dts/sun8i-a83t.dtsi                                |  99 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/panel/panel-lvds.c                               |  23 +++++++-
>  drivers/gpu/drm/sun4i/Makefile                                   |   1 +-
>  drivers/gpu/drm/sun4i/sun4i_dotclock.c                           |  10 ++-
>  drivers/gpu/drm/sun4i/sun4i_drv.c                                |   1 +-
>  drivers/gpu/drm/sun4i/sun4i_lvds.c                               | 177 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_lvds.h                               |  18 +++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.c                               | 251 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/sun4i/sun4i_tcon.h                               |  31 +++++++++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.c                              |  20 ++++++-
>  drivers/gpu/drm/sun4i/sun8i_mixer.h                              |   3 +-
>  16 files changed, 710 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun4i_lvds.h
> 
> base-commit: 3b71239181e5429702387666f1ac70a9e6856cce
> -- 
> git-series 0.9.1
