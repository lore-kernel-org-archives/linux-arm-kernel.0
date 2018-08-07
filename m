From: maxi.jourdan@wanadoo.fr (Maxime Jourdan)
Date: Wed,  8 Aug 2018 00:00:07 +0200
Subject: [PATCH v2 0/4] soc: amlogic: add meson-canvas
Message-ID: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic SoCs feature a set of 256 canvas that act as pixel buffer
descriptors. Some IPs like the display and video decoders access those
pixels by using canvas IDs rather than direct phy addresses.

As such, allocating/manipulating canvases can be done concurrently and
there is a need for a standalone, lock-aware canvas provider module.

Currently, canvas code lies in the drm/meson module as it is the sole
user.

This patchset adds such canvas provider module and converts drm/meson to
using it, stripping/moving the current canvas code.

Changes since v1: [0]
 - Convert ops struct to a public API
 - Added comments
 - Hid the of-node probe code behind meson_canvas_get
 - Changed device lock to a spinlock with irqsave

[0]: https://lkml.org/lkml/2018/8/1/1512

Maxime Jourdan (4):
  soc: amlogic: add meson-canvas driver
  dt-bindings: soc: amlogic: add meson-canvas documentation
  ARM64: dts: meson-gx: add dmcbus and canvas nodes.
  drm/meson: convert to the new canvas module

 .../bindings/display/amlogic,meson-vpu.txt    |   9 +-
 .../soc/amlogic/amlogic,meson-canvas.txt      |  36 ++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  24 ++-
 drivers/gpu/drm/meson/Kconfig                 |   1 +
 drivers/gpu/drm/meson/Makefile                |   2 +-
 drivers/gpu/drm/meson/meson_canvas.c          |  70 -------
 drivers/gpu/drm/meson/meson_canvas.h          |  42 ----
 drivers/gpu/drm/meson/meson_crtc.c            |   9 +-
 drivers/gpu/drm/meson/meson_drv.c             |  22 +--
 drivers/gpu/drm/meson/meson_drv.h             |   5 +-
 drivers/gpu/drm/meson/meson_plane.c           |   3 +-
 drivers/gpu/drm/meson/meson_viu.c             |   1 -
 drivers/soc/amlogic/Kconfig                   |   7 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-canvas.c            | 185 ++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h      |  65 ++++++
 16 files changed, 337 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-canvas.txt
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

-- 
2.18.0
