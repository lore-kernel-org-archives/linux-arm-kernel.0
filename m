From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 27 May 2017 18:09:25 +0200
Subject: [PATCH v4 00/11] drm: sun4i: Add support for the HDMI controller
Message-ID: <cover.c61cbe60123a4aeb24f255bca7927218dda6283e.1495900658.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is an attempt at getting the HDMI controller running.

This HDMI controller is found on a number of old Allwinner SoCs (A10, A10s,
A20, A31).

This driver only supports for now the A10s because it was an easy target,
being very close to the A13 that is already supported by our DRM driver.

There's nothing out of the extraordinary there, except maybe the clock
setup. All the internal clocks (TMDS, DDC) have been modeled using the
common clock framework, the TMDS clock being the parent of the DDC one.

While this might sound overkill, other SoC have a different, external
source for the DDC clock, which will be easier to support through the clock
framework.

The IP also supports audio (through an already supported i2s controller,
and some missing configuration in the HDMI controller) and CEC. Both will
come eventually.

Let me know what you think!
Maxime

Changes from v3:
  - Added Chen-Yu and Rob's tags
  - Rebased on top of -next
  - Fixed the vtotal calculation in interlace for the TCON channel 1

Changes from v2:
  - Fixed the PLL control macros definitions
  - Called clk_enable / disable on the DDC clock
  - Added the flags to enable the connection polling
  - Fixed the vtotal computation in TCON's code, and added a comment
  - Added and documented the A10s display engine compatible
  - Reworked the component parsing code to bail out when a standard
    connector is found
  - Fixed a inconsistent comment in the predivider unapplication
  - Fixed a commit log
  - Added Chen-Yu's and Rob's Acked-By
  - Changed divider_round_rate to a static, inline function in the header
  - Added and document the A10s display pipeline compatible
  - Rebased on top of 4.12

Changes from v1:
  - Fixed typos in the CCU header and the HDMI code
  - Reintroduced the comment for the backporch timings
  - Renamed the hdmi node to hdmi, instead of hdmi0
  - Added support for hdmi-connector
  - Added a separate Kconfig option for the HDMI support
  - Changed the TCON muxing configuration for an explicit call in the
    TCON's "clients"
  - Fixed the initialisation sequence that was clearing the clocks bits
  - Constified the HDMI's structures and removed whitespaces errors
  - Fixed an issue in the sunxi-ng code that was not reporting the proper
    parent clock rate if it was modified
  - Removed unused headers
  - Removed CLK_SET_RATE_PARENT for the DDC clock
  - Used the DDC address defines
  - Removed the interlace flag that wasn't supported at the moment
  - Moved most of the HDMI encoder init to the bind function like we do for
    the other encoders
  - Switched to drm_of_find_possible_crtcs
  - Removed the extra printk that were still in my code
  - Rebased on top of linux-next
  - Removed the patch changing the divider_round_rate prototype to
    introduce a new function instead that takes the parent clock to
    evaluate
  - Added a clk_set_rate for the hdmi module clock
  - Fixed the V_TOTAL TCON ch0 calculation to be consistent with ch1's
  - Defined all registers, and remove the TODOs
  - Fixed the EDID issues by increasing the timeout.
  - Added an atomic_check to prevent the DBLCLK modes to be used, as it is
    not supported yet
  - Updated the binding to add the interrupts and DMA channels

Maxime Ripard (11):
  drm/sun4i: tcon: Add channel debug
  drm/sun4i: tcon: Move the muxing out of the mode set function
  drm/sun4i: tcon: Switch mux on only for composite
  drm/sun4i: tcon: Fix tcon channel 1 backporch calculation
  drm/sun4i: tcon: Change vertical total size computation inconsistency
  drm/sun4i: tcon: multiply the vtotal when not in interlace
  drm/sun4i: Ignore the generic connectors for components
  dt-bindings: display: sun4i: Add HDMI display bindings
  dt-bindings: display: sun4i: Add allwinner,tcon-channel property
  drm/sun4i: Add HDMI support
  drm/sun4i: Add compatible for the A10s pipeline

 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt |  91 +-
 drivers/gpu/drm/sun4i/Kconfig                                 |   8 +-
 drivers/gpu/drm/sun4i/Makefile                                |   5 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                             |  13 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                            | 157 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c                    | 127 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c                        | 501 +++++++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c                   | 225 +++-
 drivers/gpu/drm/sun4i/sun4i_rgb.c                             |   1 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                            |  65 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                            |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c                              |   1 +-
 12 files changed, 1180 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c

base-commit: eb60b8cf83febf37fcd65bba0bb4dbcb2412b601
-- 
git-series 0.9.1
