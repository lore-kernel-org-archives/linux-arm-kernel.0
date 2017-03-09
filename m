From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  9 Mar 2017 18:05:23 +0800
Subject: [PATCH 00/11] drm/sun4i: Support two display pipelines
Message-ID: <20170309100534.14023-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is part 3 of my sun4i drm clean up series. In this part support
for 2 display pipelines is added, after some more code cleanups and
restructuring.

While this series enables the second display pipeline, there's no
usable output at the moment. For the A31, the second TCON's panel
interface uses the same pins as the Ethernet controller. However
Ethernet is used on most boards. We will have to wait for HDMI
support to actually use it.

Patch 1 fixes the TCON's clock and regmap initialization sequence,
splitting out the dot clock init part till after the regmap.

Patch 2 fixes a comment spotted while reviewing Maxime's HDMI patches.

Patch 3 makes the crtc init code use the tcon pointer embedded in the
crtc structure, instead of the sun4i_drv structure, to get the tcon's
output port node. This should have been a part of the last batch of
patches.

Patch 4 makes the tv encoder code get the tcon and backend pointers
from its attached crtc.

Patch 5 makes the crtc init function take tcon and backend pointers.

Patch 6 makes the layer init functions take a backend pointer.

Patch 7 adds a function to fetch a backend's ID from the device tree.

Patch 8 adds a function to fetch a TCON's ID from the device tree.

Patch 9 extends the sun4i drm driver to support 2 display pipelines.

Patch 10 adds device nodes for sun6i's second display pipeline.

Patch 11 enables sun6i's tcon0 by default.


Regards
ChenYu

Chen-Yu Tsai (11):
  drm/sun4i: Fix TCON clock and regmap initialization sequence
  drm/sun4i: Fix tcon channel 0 comment about backporch = backporch +
    hsync
  drm/sun4i: Use embedded tcon pointer to get the tcon's output port
    node
  drm/sun4i: tv: Get tcon and backend pointers from associated crtc
  drm/sun4i: Pass pointers for associated backend and tcon into crtc
    init
  drm/sun4i: Pass pointer for underlying backend into layer init
  drm/sun4i: Fetch backend ID from device tree
  drm/sun4i: Fetch TCON ID from device tree
  drm/sun4i: Support two display pipelines
  ARM: dts: sun6i: Add second display pipeline device nodes
  ARM: dts: sun6i: Enable tcon0 by default

 arch/arm/boot/dts/sun6i-a31-hummingbird.dts |   1 -
 arch/arm/boot/dts/sun6i-a31.dtsi            | 169 +++++++++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.c       |  53 ++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h       |   2 +
 drivers/gpu/drm/sun4i/sun4i_crtc.c          |  13 ++-
 drivers/gpu/drm/sun4i/sun4i_crtc.h          |   4 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c           |   2 +-
 drivers/gpu/drm/sun4i/sun4i_drv.h           |   6 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c         |  13 +--
 drivers/gpu/drm/sun4i/sun4i_layer.h         |   3 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c          |  99 ++++++++++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h          |   2 +
 drivers/gpu/drm/sun4i/sun4i_tv.c            |  19 ++--
 13 files changed, 344 insertions(+), 42 deletions(-)

-- 
2.11.0
