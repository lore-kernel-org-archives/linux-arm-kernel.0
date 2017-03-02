From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  2 Mar 2017 16:39:56 +0100
Subject: [PATCH 00/11] drm/meson: Initial support for HDMI Output
Message-ID: <1488469207-523-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Amlogic GX SoCs implements a Synopsys DesignWare HDMI TX Controller
in combination with a very custom PHY.

This patchset depends on Laurent Pinchart v4 patchset at [1] and my v2
patchset at [2] to permit PHY control from outside the dw-hdmi driver.

The Synopsys DesignWare HDMI TX Controller is integrated like :
         ___________________________________
        |            HDMI TOP               |<= HPD
        |___________________________________|
        |                  |                |
HDMI-TX-|  Synopsys HDMI   |   HDMI PHY     |=> TMDS
        |    Controller    |________________|
        |___________________________________|<=> DDC

And uses the following paths for Pixels Encoding :
       _____   _____   ____________________
vd1---|     |-|     | | VENC     /---------|----VDAC
vd2---| VIU |-| VPP |-|-----ENCI/-ENCI_DVI-|\
osd1--|     |-|     | | \                  | X--HDMI-TX
osd2--|_____|-|_____| |  |\-ENCP--ENCP_DVI-|/
                      |  |                 |
                      |  \--ENCL-----------|----LVDS
                      |____________________|

The ENCI and ENCP encoders pre-formats the data for the ENCI-DVI and
ENCP-DVI encoders. Those DVI encoders will format the pixels for the
Synopsys DesignWare HDMI TX Controller.

In order to support display modes, the ENCI and ENCP encoders needs very
specific parameters for *each* display modes, so usage of the CEA VIC
identifier is necessary. But the DVI timings are generated from the
drm_mode structure in a generic way.

To simplify the first push, only the main CEA modes are supported up to
1920x1080p60. Supporting the 480i and 576i needs tweaking in the dw-hdmi
in order to support the Clock Doubling necessary for these modes.

Support for more traditional modes like the EDID fallback modes is planned
but will need tome additionnal handling along the CEA modes.
Support for 4k2k modes needs to be able to get the EDID HDMI modes, but
for now only the HDMI 1.4 modes are currently available in the drm_edid
implementation.

This patchset does :
 - Fixes the CRTC handling
 - Fixes the registers definitions
 - Adds support for device components registration along of-graph
 - Adds support for HDMI clocks
 - Adds support for HDMI VENC video modes
 - Adds support for the Custom HDMI PHY using callbacks added in [1] and [2]
 - Adds CMA node to reserve enougth memory for 1080p display
 - Adds the HDMI controller et connector modes on selected boards
 - Adds a proper dt-bindings for the HDMI controller et connector
 - Updates the MAINTAINERS file to track the new files

[1] http://lkml.kernel.org/r/20170301223915.29888-1-laurent.pinchart+renesas at ideasonboard.com
[2] http://lkml.kernel.org/r/1488468572-31971-1-git-send-email-narmstrong at baylibre.com

Neil Armstrong (11):
  drm/meson: Use crtc_state for hdisplay and fix atomic flush/enable
    sync for vsync commit
  drm/meson: Add missing HDMI register
  drm/meson: Add support for components
  drm/meson: venc_cvbs: no more return -ENODEV if CVBS is not available
  drm/meson: add support for HDMI clock support
  drm/meson: Add support for HDMI venc modes and settings
  drm/meson: Add support for HDMI encoder and DW-HDMI bridge + PHY
  ARM64: dts: meson-gx: Add shared CMA dma memory pool
  ARM64: dts: meson-gx: Add support for HDMI output
  dt-bindings: Add bindings for the Amlogic Meson dw-hdmi extension
  MAINTAINERS: update files for Amlogic DRM Driver

 .../bindings/display/amlogic,meson-dw-hdmi.txt     |  111 ++
 MAINTAINERS                                        |    1 +
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   39 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   40 +
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |   23 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |   23 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |   12 +
 .../boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |   23 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |   13 +
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   23 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |    4 +
 drivers/gpu/drm/meson/Kconfig                      |    6 +
 drivers/gpu/drm/meson/Makefile                     |    1 +
 drivers/gpu/drm/meson/meson_crtc.c                 |   15 +-
 drivers/gpu/drm/meson/meson_drv.c                  |  113 +-
 drivers/gpu/drm/meson/meson_drv.h                  |    3 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c              |  918 +++++++++++++++
 drivers/gpu/drm/meson/meson_dw_hdmi.h              |  146 +++
 drivers/gpu/drm/meson/meson_registers.h            |    1 +
 drivers/gpu/drm/meson/meson_vclk.c                 |  624 +++++++++-
 drivers/gpu/drm/meson/meson_vclk.h                 |    6 +-
 drivers/gpu/drm/meson/meson_venc.c                 | 1245 +++++++++++++++++++-
 drivers/gpu/drm/meson/meson_venc.h                 |    7 +
 drivers/gpu/drm/meson/meson_venc_cvbs.c            |   11 +-
 drivers/gpu/drm/meson/meson_vpp.h                  |    2 +
 25 files changed, 3370 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt
 create mode 100644 drivers/gpu/drm/meson/meson_dw_hdmi.c
 create mode 100644 drivers/gpu/drm/meson/meson_dw_hdmi.h

-- 
1.9.1
