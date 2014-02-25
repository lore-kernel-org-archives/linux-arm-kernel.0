From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 25 Feb 2014 15:23:15 +0100
Subject: [RFC PATCH v4 0/8] imx-drm dt bindings
Message-ID: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here is an updated version of the imx-drm DT binding series.
These patches apply on top of Russell's imx-drm-staging branch
that just got merged int staging-next. I have added device tree
bindings between IPU and the encoders as documented in
Documentation/devicetree/bindings/media/video-interfaces.txt
and used those to determine the possible_crtcs and mux_id,
and to find all necessary components that hang off of the display
interface ports.
This allows to move the imx-drm node into the SoC level dtsi.
The existing i.MX51 and i.MX53 device trees are updated and device
tree binding documentation is included.

Changes since v3:
 - Kept the -EPROBE_DEFER in of_parse_endpoint and removed LVDS
   output ports for now. This can be revisited once drm_panel support
   is added.
 - Dropped the temporary of_graph helper copies, so this depends on
   the patch that moves the v4l2_of helpers to drivers/of.

regards
Philipp

Philipp Zabel (8):
  staging: imx-drm-core: Use OF graph to find components and connections
    between encoder and crtcs
  staging: imx-drm-core: use of_graph_parse_endpoint
  staging: imx-drm: Document updated imx-drm device tree bindings
  staging: imx-drm: Document imx-hdmi device tree bindings
  ARM: dts: imx51: Add IPU ports and endpoints, move imx-drm node to
    dtsi
  ARM: dts: imx53: Add IPU DI ports and endpoints, move imx-drm node to
    dtsi
  ARM: dts: imx6qdl: Add IPU DI ports and endpoints, move imx-drm node
    to dtsi
  staging: imx-drm: Update TODO

 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |  48 ++++-
 .../devicetree/bindings/staging/imx-drm/hdmi.txt   |  53 +++++
 .../devicetree/bindings/staging/imx-drm/ldb.txt    |  20 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |  11 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  28 ++-
 arch/arm/boot/dts/imx51.dtsi                       |  22 ++-
 arch/arm/boot/dts/imx53-m53evk.dts                 |  17 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |  15 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |  17 +-
 arch/arm/boot/dts/imx53.dtsi                       |  64 +++++-
 arch/arm/boot/dts/imx6dl.dtsi                      |  22 +--
 arch/arm/boot/dts/imx6q-sabresd.dts                |   4 -
 arch/arm/boot/dts/imx6q.dtsi                       | 124 +++++++++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   6 -
 arch/arm/boot/dts/imx6qdl.dtsi                     | 128 +++++++++++-
 drivers/staging/imx-drm/TODO                       |   5 -
 drivers/staging/imx-drm/imx-drm-core.c             | 215 +++++++++++++++------
 drivers/staging/imx-drm/imx-drm.h                  |   5 +-
 drivers/staging/imx-drm/imx-hdmi.c                 |   2 +-
 drivers/staging/imx-drm/imx-ldb.c                  |   4 +-
 drivers/staging/imx-drm/ipuv3-crtc.c               |  47 ++++-
 21 files changed, 703 insertions(+), 154 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt

-- 
1.8.5.3
