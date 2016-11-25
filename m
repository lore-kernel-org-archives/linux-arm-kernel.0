From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 25 Nov 2016 17:03:08 +0100
Subject: [RFC PATCH 0/3] drm: Add support for the Amlogic Video Processing Unit
Message-ID: <1480089791-12517-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic Meson SoCs embeds a Video Processing Unit able to output at least
a Composite/CVBS Video with embedded VDAC and an HDMI Link with Embedded HDMI
Transceiver.

Thus, the current driver does not support HDMI yet.

The Video Processig Unit is composed of multiple modules like the Video
Input Unit and the Video Post Processing that can be associated to a
CRTC with Planes management.
The last Unit is the Venc that embeds at least 3 Encoders, ENCI for Interlace
Video used by CVBS or HDMI, ENCP for Progressive Video used by the HDMI
Transceiver and ENCL for LCD Display.

The LCD Display is not planned to be supported on the Meson GX Family.

This driver is a DRM/KMS driver using the following DRM components :
 - GEM-CMA
 - PRIME-CMA
 - Atomic Modesetting
 - FBDev-CMA

For the following SoCs :
 - GXBB Family (S905)
 - GXL Family (S905X, S905D)
 - GXM Family (S912)

The current driver only supports the CVBS PAL/NTSC output modes, but the
CRTC/Planes management should support bigger modes.
But Advanced Colorspace Conversion, Scaling and HDMI Modes will be added in
a second time.

The Device Tree bindings makes use of the endpoints video interface definitions
to connect to the optional CVBS and in the future the HDMI Connector nodes.

The driver has been tested with Xorg modesetting driver and Weston DRM backend.

Neil Armstrong (3):
  drm: Add support for Amlogic Meson Graphic Controller
  ARM64: dts: meson-gx: Add Graphic Controller nodes
  dt-bindings: display: add Amlogic Meson DRM Bindings

 .../bindings/display/meson/meson-drm.txt           |  134 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   46 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   12 +
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    8 +
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |    4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |    9 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/meson/Kconfig                      |    8 +
 drivers/gpu/drm/meson/Makefile                     |    5 +
 drivers/gpu/drm/meson/meson_canvas.c               |   96 ++
 drivers/gpu/drm/meson/meson_canvas.h               |   31 +
 drivers/gpu/drm/meson/meson_crtc.c                 |  176 +++
 drivers/gpu/drm/meson/meson_crtc.h                 |   34 +
 drivers/gpu/drm/meson/meson_cvbs.c                 |  293 ++++
 drivers/gpu/drm/meson/meson_cvbs.h                 |   32 +
 drivers/gpu/drm/meson/meson_drv.c                  |  383 ++++++
 drivers/gpu/drm/meson/meson_drv.h                  |   68 +
 drivers/gpu/drm/meson/meson_plane.c                |  150 +++
 drivers/gpu/drm/meson/meson_plane.h                |   32 +
 drivers/gpu/drm/meson/meson_registers.h            | 1395 ++++++++++++++++++++
 drivers/gpu/drm/meson/meson_vclk.c                 |  169 +++
 drivers/gpu/drm/meson/meson_vclk.h                 |   36 +
 drivers/gpu/drm/meson/meson_venc.c                 |  286 ++++
 drivers/gpu/drm/meson/meson_venc.h                 |   77 ++
 drivers/gpu/drm/meson/meson_viu.c                  |  497 +++++++
 drivers/gpu/drm/meson/meson_viu.h                  |   37 +
 drivers/gpu/drm/meson/meson_vpp.c                  |  189 +++
 drivers/gpu/drm/meson/meson_vpp.h                  |   43 +
 32 files changed, 4265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/meson/meson-drm.txt
 create mode 100644 drivers/gpu/drm/meson/Kconfig
 create mode 100644 drivers/gpu/drm/meson/Makefile
 create mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 create mode 100644 drivers/gpu/drm/meson/meson_canvas.h
 create mode 100644 drivers/gpu/drm/meson/meson_crtc.c
 create mode 100644 drivers/gpu/drm/meson/meson_crtc.h
 create mode 100644 drivers/gpu/drm/meson/meson_cvbs.c
 create mode 100644 drivers/gpu/drm/meson/meson_cvbs.h
 create mode 100644 drivers/gpu/drm/meson/meson_drv.c
 create mode 100644 drivers/gpu/drm/meson/meson_drv.h
 create mode 100644 drivers/gpu/drm/meson/meson_plane.c
 create mode 100644 drivers/gpu/drm/meson/meson_plane.h
 create mode 100644 drivers/gpu/drm/meson/meson_registers.h
 create mode 100644 drivers/gpu/drm/meson/meson_vclk.c
 create mode 100644 drivers/gpu/drm/meson/meson_vclk.h
 create mode 100644 drivers/gpu/drm/meson/meson_venc.c
 create mode 100644 drivers/gpu/drm/meson/meson_venc.h
 create mode 100644 drivers/gpu/drm/meson/meson_viu.c
 create mode 100644 drivers/gpu/drm/meson/meson_viu.h
 create mode 100644 drivers/gpu/drm/meson/meson_vpp.c
 create mode 100644 drivers/gpu/drm/meson/meson_vpp.h

-- 
1.9.1
