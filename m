From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed,  5 Mar 2014 10:20:51 +0100
Subject: [PATCH v5 00/11] imx-drm dt bindings
Message-ID: <1394011262-16849-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this latest version of the imx-drm DT binding patches applies
on top of staging-next and also depends on the OF graph binding
patchset that moves the v4l2_of helpers to drivers/of.
Currently, the two patchsets are also available at:
    git://git.pengutronix.de/git/pza/linux.git topic/of-graph
    git://git.pengutronix.de/git/pza/linux.git topic/imx-drm-dt

I have added device tree bindings between IPU and the encoders as
documented in Documentation/devicetree/bindings/graph.txt and used
those to determine the possible_crtcs and mux_id, and to find all
necessary components that hang off of the display interface ports.
This allows to move the imx-drm node into the SoC level dtsi. The
existing i.MX51 and i.MX53 device trees are updated and device tree
binding documentation is included.

Changes since v4:
 - Changed DT compatible string to 'fsl,imx-display-subsystem'
   instead of Linux specific 'fsl,imx-drm'
 - Changed DT node name from 'imx-drm' to 'display-subsystem'
 - Fixed copy&paste documentation error and added optional
   'ddc-i2c-bus' property in HDMI binding documentation
 - Fixed imx-tve and imx-hdmi to use the common 'ddc-i2c-bus'
   property as already used by the simple-panel binding instead of
   the custom but very generic 'ddc'.

regards
Philipp


Philipp Zabel (11):
  staging: imx-drm-core: Use OF graph to find components and connections
    between encoder and crtcs
  staging: imx-drm-core: use of_graph_parse_endpoint
  staging: imx-drm: Document updated imx-drm device tree bindings
  staging: imx-drm: Document imx-hdmi device tree bindings
  imx-drm: imx-hdmi: Fix DDC I2C bus property
  imx-drm: imx-tve: Fix DDC I2C bus property
  ARM: dts: imx53-mba53: Fix TVE DDC I2C bus property
  ARM: dts: imx51: Add IPU ports and endpoints, move imx-drm node to
    dtsi
  ARM: dts: imx53: Add IPU DI ports and endpoints, move imx-drm node to
    dtsi
  ARM: dts: imx6qdl: Add IPU DI ports and endpoints, move imx-drm node
    to dtsi
  staging: imx-drm: Update TODO

 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |  48 ++++-
 .../devicetree/bindings/staging/imx-drm/hdmi.txt   |  58 ++++++
 .../devicetree/bindings/staging/imx-drm/ldb.txt    |  20 +-
 arch/arm/boot/dts/imx51-apf51dev.dts               |  11 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  28 ++-
 arch/arm/boot/dts/imx51.dtsi                       |  22 ++-
 arch/arm/boot/dts/imx53-m53evk.dts                 |  17 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |  17 +-
 arch/arm/boot/dts/imx53-qsb.dts                    |  17 +-
 arch/arm/boot/dts/imx53.dtsi                       |  64 +++++-
 arch/arm/boot/dts/imx6dl.dtsi                      |  22 +--
 arch/arm/boot/dts/imx6q-sabresd.dts                |   4 -
 arch/arm/boot/dts/imx6q.dtsi                       | 124 +++++++++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   6 -
 arch/arm/boot/dts/imx6qdl.dtsi                     | 128 +++++++++++-
 drivers/staging/imx-drm/TODO                       |   5 -
 drivers/staging/imx-drm/imx-drm-core.c             | 217 +++++++++++++++------
 drivers/staging/imx-drm/imx-drm.h                  |   5 +-
 drivers/staging/imx-drm/imx-hdmi.c                 |   4 +-
 drivers/staging/imx-drm/imx-ldb.c                  |   4 +-
 drivers/staging/imx-drm/imx-tve.c                  |   2 +-
 drivers/staging/imx-drm/ipuv3-crtc.c               |  47 ++++-
 22 files changed, 712 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt

-- 
1.9.0.rc3
