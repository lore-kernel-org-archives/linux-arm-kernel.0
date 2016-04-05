From: stefan@agner.ch (Stefan Agner)
Date: Mon,  4 Apr 2016 22:28:32 -0700
Subject: [PATCH v3 0/9] add TCON and Vybrid support
Message-ID: <1459834121-25997-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds the missing pieces to make the Freescale
DCU DRM driver work on Freescale Vybrid.

Foremost, it adds support for the timing controller (TCON)
module. The module is between the Display Controller and the
actual output pins. It allows to alter the timings for RAW
TFT displays, but can also operate in a bypass mode. This
change has only support for the bypass mode.

Earlier variants of the DCU DRM driver configured the TCON
module in bypass mode, however this has been removed and
postponed. The last variant with the TCON code was v9:
https://lkml.org/lkml/2015/7/13/242

The patchset also fixes the DCU related clocks in the Vybrid
clock tree and makes use of the common clock framework for
the pixelclock divider.

Testing on LS1021a welcome!

Changes since v2:
- Add second clock ("pix") to ls1021a.dtsi too
- Updated documentation regarding clocks
- Do not warn if TCON is missing as some device do not
  provide it
- Allocate memory after checking for TCON node and return
  -ENOMEM if memory allocation fails
- Add fsl,tcon.txt to MAINTAINERS file

Changes since v1:
- Properly disable clocks on errors
- Create clear seperation of pixel clock and bus clock
- Simplified TCON driver by removing suspend/resume
  capabilities (encoder disable/enable makes sure that
  TCON bypass gets disabled/reenabled on suspend)
- Use common clock framework to create a divider clock
  which represents the DCU internal pixel clock divider

Stefan Agner (9):
  ARM: imx: clk-vf610: fix DCU clock tree
  ARM: imx: clk-vf610: add TCON ipg clock
  drm/fsl-dcu: disable clock on initialization failure and remove
  drm/fsl-dcu: add extra clock for pixel clock
  drm/fsl-dcu: use common clock framework for pixel clock divider
  drm/fsl-dcu: add TCON driver
  ARM: dts: vf610: add display nodes
  ARM: dts: vf610-colibri: enable display controller
  ARM: dts: ls1021a: add pix clock to DCU dts node

 .../devicetree/bindings/display/fsl,dcu.txt        |  15 ++-
 .../devicetree/bindings/display/fsl,tcon.txt       |  18 ++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   5 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |  16 +++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  33 ++++++
 arch/arm/boot/dts/vfxxx.dtsi                       |  19 ++++
 drivers/clk/imx/clk-vf610.c                        |   7 +-
 drivers/gpu/drm/fsl-dcu/Makefile                   |   3 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c         |   7 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c          |  73 ++++++++++----
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h          |   2 +
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          |  11 ++
 drivers/gpu/drm/fsl-dcu/fsl_tcon.c                 | 111 +++++++++++++++++++++
 drivers/gpu/drm/fsl-dcu/fsl_tcon.h                 |  33 ++++++
 include/dt-bindings/clock/vf610-clock.h            |   4 +-
 16 files changed, 323 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/fsl,tcon.txt
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.c
 create mode 100644 drivers/gpu/drm/fsl-dcu/fsl_tcon.h

-- 
2.7.4
