From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 21 Apr 2017 16:38:48 +0800
Subject: [PATCH v2 0/9] drm/sun4i: Support multiple display pipelines
Message-ID: <20170421083857.29636-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v2 of the series previously named "drm/sun4i: Support two
display pipelines". As the name change suggests, the driver now
supports any number of pipelines, though the hardware only has
2 or 3.

Changes since v1:

  - Add component endpoint ID numbering scheme to device tree binding.

  - Use lists to keep references to registered backends and tcons.

  - Save pointer to device node for backends.

  - Traverse the device tree of_graph starting from the tcons, going
    up towards the inputs, and matching the device nodes with the
    device nodes of registered backends, to find the one linked with
    the tcon the search started from.

  - Copy the ID for the tcon from its upstream backend, instead of
    trying, and possibly failing, to figure it out from the device
    tree.

  - Split out hunk dropping trailing 0 from a backend error message.

Patch 1 adds the component endpoint ID numbering scheme to the
device tree binding. New in v2.

Patch 2 adds lists to track registered display backends and TCONs,
instead of just one pointer per component type. Previously added
arrays of pointers in v1.

Patch 3 drops the trailing 0 from one of the backend's bind error
messages. This was previously part of the patch "drm/sun4i: Support
two display pipelines".

Patch 4 adds a function to fetch a backend's ID from the device tree.
Unchanged.

Patch 5 adds a device node field to the backend data structure and
saves a reference to the underlying device node of the backend.
New in v2.

Patch 6 makes the tcon driver find its upstream backend by traversing
the of_graph and matching device nodes against the device nodes of
registered backends.
New in v2.

Patch 7 makes the tcon driver use the ID from its associated backend.
New in v2. This is not immediately used in this series, but will be
used in similar fashion for downstream encoders to figure out IDs and
muxing

Patch 8 adds device nodes for sun6i's second display pipeline.
Unchanged.

Patch 9 enables sun6i's tcon0 by default.
Unchanged.

With this series, the sun4i drm driver now supports registering multiple
display pipelines. However the driver does not guard against setups the
hardware does not support, such as driving 2 encoders with incompatible
dot clocks from the same source clock. Muxing of downstream encoders is
not supported either, as we have no drivers for hardware that uses them.
The WiP HDMI driver will be the first.

While this series enables the second display pipeline, there's no
usable output at the moment. For the A31, the second TCON's panel
interface uses the same pins as the Ethernet controller. However
Ethernet is used on most boards.


Regards
ChenYu


Chen-Yu Tsai (9):
  dt-bindings: display: sun4i: Add component endpoint ID numbering
    scheme
  drm/sun4i: Use lists to track registered display backends and TCONs
  drm/sun4i: backend: Drop trailing 0 from backend in error message
  drm/sun4i: backend: Fetch backend ID from device tree
  drm/sun4i: backend: Save pointer to device tree node
  drm/sun4i: tcon: Find matching display backend by device node matching
  drm/sun4i: tcon: Copy ID from associated backend
  ARM: dts: sun6i: Add second display pipeline device nodes
  ARM: dts: sun6i: Enable tcon0 by default

 .../bindings/display/sunxi/sun4i-drm.txt           |  10 ++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |   1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 169 ++++++++++++++++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  53 ++++++-
 drivers/gpu/drm/sun4i/sun4i_backend.h              |   8 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |   2 +
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |   4 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  62 +++++++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   6 +
 9 files changed, 307 insertions(+), 8 deletions(-)

-- 
2.11.0
