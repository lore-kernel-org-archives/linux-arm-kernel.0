From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 30 Nov 2016 16:43:41 +0100
Subject: [PATCH v2 0/4] drm: Add support for the Amlogic Video Processing Unit
Message-ID: <1480520625-13269-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This a repost of the previous version at [2] with fixes, the following patches will
be sent via a PULL Request once the DT maintainers acks the DT bindings.
The Amlogic maintainer will take the arm64 DT patches to avoid merges conflicts.

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

Changes since v1 at [2] :
 - Simplify bindings to have a "composite-video-connector" to represent the on-board composite connector
 - Remove the component_match binding since it's unused for now
 - Moved all DRM connector code back in the venc_cvbs file
 - Check for port endpoints validity to detech connector existence
 - Added Daniel Vetter's ack on non-dt patches commit messages

Changes since RFC at [1] :
 - Add maintainers entry
 - Move all Plane and CRTC code from backend to corresponding DRM code
 - Keep only init and common code in backend source files
 - Move the CVBS encoder out of the CVBS DT node, only keep the connector
 - Various cleanups using DRM helpers
 - Cleanup of copyright headers
 - Fixup of bindings documentation

[1] http://lkml.kernel.org/r/1480089791-12517-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1480416469-9655-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (4):
  drm: Add support for Amlogic Meson Graphic Controller
  ARM64: dts: meson-gx: Add Graphic Controller nodes
  dt-bindings: display: add Amlogic Meson DRM Bindings
  MAINTAINERS: add entry for Amlogic DRM drivers

 .../bindings/display/meson/meson-drm.txt           |  101 ++
 MAINTAINERS                                        |    9 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   19 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |    4 +
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    4 +
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   15 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |    4 +
 drivers/gpu/drm/Kconfig                            |    2 +
 drivers/gpu/drm/Makefile                           |    1 +
 drivers/gpu/drm/meson/Kconfig                      |    9 +
 drivers/gpu/drm/meson/Makefile                     |    4 +
 drivers/gpu/drm/meson/meson_canvas.c               |   68 +
 drivers/gpu/drm/meson/meson_canvas.h               |   42 +
 drivers/gpu/drm/meson/meson_crtc.c                 |  208 +++
 drivers/gpu/drm/meson/meson_crtc.h                 |   32 +
 drivers/gpu/drm/meson/meson_drv.c                  |  343 +++++
 drivers/gpu/drm/meson/meson_drv.h                  |   60 +
 drivers/gpu/drm/meson/meson_plane.c                |  230 ++++
 drivers/gpu/drm/meson/meson_plane.h                |   30 +
 drivers/gpu/drm/meson/meson_registers.h            | 1395 ++++++++++++++++++++
 drivers/gpu/drm/meson/meson_vclk.c                 |  167 +++
 drivers/gpu/drm/meson/meson_vclk.h                 |   34 +
 drivers/gpu/drm/meson/meson_venc.c                 |  254 ++++
 drivers/gpu/drm/meson/meson_venc.h                 |   72 +
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |  293 ++++
 drivers/gpu/drm/meson/meson_venc_cvbs.h            |   41 +
 drivers/gpu/drm/meson/meson_viu.c                  |  331 +++++
 drivers/gpu/drm/meson/meson_viu.h                  |   64 +
 drivers/gpu/drm/meson/meson_vpp.c                  |  162 +++
 drivers/gpu/drm/meson/meson_vpp.h                  |   35 +
 33 files changed, 4078 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/meson/meson-drm.txt
 create mode 100644 drivers/gpu/drm/meson/Kconfig
 create mode 100644 drivers/gpu/drm/meson/Makefile
 create mode 100644 drivers/gpu/drm/meson/meson_canvas.c
 create mode 100644 drivers/gpu/drm/meson/meson_canvas.h
 create mode 100644 drivers/gpu/drm/meson/meson_crtc.c
 create mode 100644 drivers/gpu/drm/meson/meson_crtc.h
 create mode 100644 drivers/gpu/drm/meson/meson_drv.c
 create mode 100644 drivers/gpu/drm/meson/meson_drv.h
 create mode 100644 drivers/gpu/drm/meson/meson_plane.c
 create mode 100644 drivers/gpu/drm/meson/meson_plane.h
 create mode 100644 drivers/gpu/drm/meson/meson_registers.h
 create mode 100644 drivers/gpu/drm/meson/meson_vclk.c
 create mode 100644 drivers/gpu/drm/meson/meson_vclk.h
 create mode 100644 drivers/gpu/drm/meson/meson_venc.c
 create mode 100644 drivers/gpu/drm/meson/meson_venc.h
 create mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.c
 create mode 100644 drivers/gpu/drm/meson/meson_venc_cvbs.h
 create mode 100644 drivers/gpu/drm/meson/meson_viu.c
 create mode 100644 drivers/gpu/drm/meson/meson_viu.h
 create mode 100644 drivers/gpu/drm/meson/meson_vpp.c
 create mode 100644 drivers/gpu/drm/meson/meson_vpp.h

-- 
1.9.1
