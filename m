From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  8 Sep 2017 15:50:08 +0800
Subject: [PATCH 0/8] drm/sun4i: Make both display pipeline work together
Message-ID: <20170908075016.18657-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Previously I added support for two display pipelines for the sun4i-drm
driver. At the time we did not have support for downstream encoders to
actually test the second pipeline, nor having both pipelines active at
the same time.

With HDMI encoder support now merged and support for it on sun6i in
progress, we are now able to test both pipelines being active at the
same time, with LCD output from one and HDMI from the other. Testing
has revealed some more issues, such as component probing order. Also,
we found out that muxing between the display backend and TCON was
possible, and required for the second pipeline to work as intended.
Last, the number of CRTCs provided to drm_vblank_init needs to be
increased for vblanks to work properly.

This patch series does a few things:

  - Fix endpoint IDs so they conform to what the DT binding stipulates.

  - Change the order the individual components are queued up.

  - Fix how the TCON gets its ID when the backend-TCON mux is present.

  - Support the input mux in the TCON (which selects which backend to
    use on the A31/A31s).

  - Fix the drm_vblank_init call and pass the correct number of crtcs.

  - Add the cross pipeline connections between the DRCs and TCONs on
    the A31, conforming to the DT binding and what the hardware is
    capable of.

More details are available in each individual commit. Please have a look.

Regards
ChenYu


Chen-Yu Tsai (8):
  ARM: dts: sun6i: Fix endpoint IDs in second display pipeline
  drm/sun4i: add components in breadth first traversal order
  drm/sun4i: tcon: Check for multiple paths between TCONs and backends
  drm/sun4i: tcon: get TCON ID and matching engine with remote endpoint
    ID
  drm/sun4i: tcon: Simplify sun4i_tcon_find_engine_traverse for one
    input
  drm/sun4i: tcon: Support backend input mux
  drm/sun4i: call drm_vblank_init with correct number of crtcs
  ARM: dts: sun6i: Add cross pipeline connections between DRCs and TCONs

 arch/arm/boot/dts/sun6i-a31.dtsi   |  32 +++++--
 drivers/gpu/drm/sun4i/sun4i_drv.c  |  91 +++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 191 +++++++++++++++++++++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_tcon.h |   3 +
 4 files changed, 276 insertions(+), 41 deletions(-)

-- 
2.14.1
