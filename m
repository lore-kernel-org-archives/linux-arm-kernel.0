From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Nov 2014 14:56:20 +0100
Subject: [PATCH v8 0/2] drm: add support for Atmel HLCDC Display Controller
Message-ID: <1416405382-24692-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series adds support for the Atmel HLCDC Display Controller
embedded in the HLCDC block.

The drivers supports basic CRTC functionalities, several overlays and
provides an hardware cursor.

At the moment, it only supports connection to LCD panels through an RGB
connector (defined as an LVDS connector in my implementation), though
connection to other kind of devices (like DRM bridges) could be added later.

It also supports several RGB formats on all planes and some YUV formats on
the HEO overlay plane.

Best Regards,

Boris

Changes since v7:
 - split MFD, PWM and Display Controller drivers in several patch series
 - fix inline documentation (suggested by Nicolas)
 - fix DMA BURST LEN config (suggested by Nicolas)
 - call load and unload in probe and remove functions instead of setting
   them in drm_driver struct

Changes since v6:
- move interrupts property from hlcdc display controller node to its
  parent node (the MFD device)
- add mode_set_base implementation
- rework page flip handling to rely on vblank events instead of DMA
  transfer events (the end of a DMA transfer does not mean the frame
  is actually flipped: data are first copied to an output FIFO before
  being sent on the RGB/DPI connector)
- few minor coding style fixes

Changes since v5:
- fix Kconfig dependency bug
- use adjusted mode in crtc config
- move signal config (clk, hsync, vsync) from connector to crtc mode_set
  function
- use standard rotation property
- check display_mode validity in connecto mode_valid function
- remove dma_set_coherent mask call (now done in MFD core)
- do not use drm_platform_init

Changes since v4:
- fix a few more bugs in rotation handling (rotation was buggy on some
  formats)
- return connector_status_unknown until a panel is exposed by the
  drm_panel infrastructure (prevent fbdev creation until everyting is
  in place)
- rework Kconfig MFD_ATMEL_HLCDC selection to simplify the configuration
  (automatically select this option when selecting the HLCDC PMW or DRM
  driver, instead of depending on this option)

Changes since v3:
- rework the layer code to simplify several parts (locking and layer
  disabling)
- make use of the drm_flip_work infrastructure
- rely on default HW cursor implementation using on the cursor plane
- rework the display controller DT bindings (based on OF graph
  representation)
- add rotation support
- retrive RGB bus format from drm_display_info
- drop the dynamic pinctrl state selection
- rework HLCDC output handling (previously specialized to interface
  with LCD panels)
- drop ".module = THIS_MODULE" lines
- change display controller compatible string

Changes since v2:
- fix coding style issues (macro indentation)
- make use of GENMASK in several places
- declare regmap config as a static structure
- rework hlcdc plane update API
- rework cursor handling to make use of the new plane update API
- fix backporch config
- do not use devm_regmap_init_mmio_clk to avoid extra clk_enable
  clk disable calls when accessing registers
- explicitely include regmap and clk headers instead of relying on
  atmel-hlcdc.h inclusions
- make the atmel-hlcdc driver depends on CONFIG_OF
- separate DT bindings documentation from driver implementation
- support several pin muxing for HLCDC pins on sama5d3 SoCs

Changes since v1:
- replace the backlight driver by a PWM driver
- make use of drm_panel infrastructure
- split driver code in several subsystem: MFD, PWM and DRM
- add support for overlays
- add support for hardware cursor

Boris Brezillon (2):
  drm: add Atmel HLCDC Display Controller support
  drm: add DT bindings documentation for atmel-hlcdc-dc driver

 .../devicetree/bindings/drm/atmel/hlcdc-dc.txt     |  53 ++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/atmel-hlcdc/Kconfig                |  11 +
 drivers/gpu/drm/atmel-hlcdc/Makefile               |   7 +
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 406 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       | 579 ++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       | 213 +++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c    | 667 ++++++++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h    | 398 ++++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 323 ++++++++
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    | 856 +++++++++++++++++++++
 12 files changed, 3516 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/drm/atmel/hlcdc-dc.txt
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Kconfig
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/Makefile
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_layer.h
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c
 create mode 100644 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c

-- 
1.9.1
