From: mjourdan@baylibre.com (Maxime Jourdan)
Date: Thu, 23 Aug 2018 13:49:51 +0200
Subject: [PATCH v3 0/3] soc: amlogic: add meson-canvas
Message-ID: <20180823114954.30704-1-mjourdan@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amlogic SoCs feature a set of 256 canvas that act as pixel buffer
descriptors. Some IPs like the display and video decoders access those
pixels by using canvas IDs rather than direct phy addresses.

As such, allocating/manipulating canvases can be done concurrently and
there is a need for a standalone, lock-aware canvas provider module.

Currently, canvas code lies in the drm/meson module as it is the sole
user.

This patchset adds such canvas provider module.

Changes since v2: [1]
 - Don't include the drm changes in the serie.
 - Remove the syscon node in the dts and doc
 - Rename meson_canvas_setup to meson_canvas_config

Changes since v1: [0]
 - Convert ops struct to a public API
 - Added comments
 - Hid the of-node probe code behind meson_canvas_get
 - Changed device lock to a spinlock with irqsave

[0]: https://lkml.org/lkml/2018/8/1/1512
[1]: https://lkml.org/lkml/2018/8/7/894

Maxime Jourdan (3):
  dt-bindings: soc: amlogic: add meson-canvas documentation
  soc: amlogic: add meson-canvas driver
  ARM64: dts: meson-gx: add dmcbus and canvas nodes.

 .../bindings/soc/amlogic/amlogic,canvas.txt   |  29 +++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  13 ++
 drivers/soc/amlogic/Kconfig                   |   7 +
 drivers/soc/amlogic/Makefile                  |   1 +
 drivers/soc/amlogic/meson-canvas.c            | 185 ++++++++++++++++++
 include/linux/soc/amlogic/meson-canvas.h      |  65 ++++++
 6 files changed, 300 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.txt
 create mode 100644 drivers/soc/amlogic/meson-canvas.c
 create mode 100644 include/linux/soc/amlogic/meson-canvas.h

-- 
2.18.0
