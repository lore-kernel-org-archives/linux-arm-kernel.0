From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:23 +0100
Subject: [PATCH v3 00/19] drm: Add Allwinner A10 display engine support
Message-ID: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

The Allwinner SoCs (except for the very latest ones) all share the
same set of controllers, loosely coupled together to form the display
pipeline.

Depending on the SoC, the number of instances of the controller will
change (2 instances of each in the A10, only one in the A13, for
example), and the output availables will change too (HDMI, composite,
VGA on the A20, none of them on the A13).

On most featured SoCs, it looks like that:

+--------------------------------------------+
|                    RAM                     |
+--------------------------------------------+
      |            |      |            |
      v            |      |            v
+----------------+ |      | +----------------+
|    Frontend    | |      | |    Frontend    |
+----------------+ |      | +----------------+
        |          |      |         |
        v          |      |         v
+----------------+ |      | +----------------+
|    Backend     |<+      +>|    Backend     |
+----------------+          +----------------+
        |                           |
        v                           v
+----------------+          +----------------+---> LVDS
|      TCON      |          |      TCON      |---> RGB
+----------------+          +----------------+
       |       +---+       +---+          |
       |           |       |              |
       v           v       v              v
+------------+  +------------+  +------------+---> VGA
| TV Encoder |  |    HDMI    |  | TV Encoder |---> Composite
+------------+  +------------+  +------------+

The current code only assumes that there is a single instance of all
the controllers. It also supports only the RGB and Composite
interfaces.

Let me know what you think,
Maxime

Changes from v2:
  - Rebased on top of next-20160318

  - Dropped the generic clock regmap conversion and implemented a
    custom clock for our pixel clock, backed by a regmap
  - Added the reset bits for the tcon channel 0 and display clocks
  - Used the new generic gates compatible for the DRAM gates
  - Few clock fixes (missing iounmap, return error checks, etc)
  - Found out that the TCON channel 1 clock was not operating properly
    because of some weird rounding down and up between the various
    generic clocks involved. Rewrote it using custom operations

  - Removed some TODO that were still there
  - Converted our panel DT description to the OF graph instead of a
    custom property
  - Tested the driver on a setup where U-Boot was not initialising the
    display, or initialising it on a different output, and fixed a
    number of associated bugs (mostly related to missing
    initialisation bits, missing reset handles, and so on)
  - Fixed the layer code that was assuming that the X and Y
    coordinates were in pixels, leading to a miscalculation of the
    buffer address when those coordinates where set.
  - Added the missing EXPORT_SYMBOL calls

  - Fixed our VBLANK interrupt code that was completely broken (and
    not usable, which is why it was unnoticed)

Changes from v1:
  - Rebased on top of 4.4

  - Merged the clock drivers for the display and TCON channel 0 clocks
  - Replaced the container_of calls in the display reset clocks to an
    inline function
  - Checked the return code of of_clk_parent_fill in the clocks
    drivers
  - Checked the return code of of_clk_add_provider in the tcon-ch1 and
    PLL3 clocks
  - Added missing clocks headers
  - Created a composite clock unregister function

  - Moved the binding documentation to
    Documentation/devicetree/bindings/display
  - Added the clocks binding documentation
  - Added the Olimex vendor to the list of DT vendors
  - Moved to the OF graph representation and the component framework

  - Moved the reset cells count check into the reset framework to
    avoid duplicating the code in every xlate implementation.
  - Made the reset_ops const

  - Reworked the DRM cmdline mode parsing code to allow named mode
  - Fixed the TV mode lookup when the mode name is not present (for
    example because it was given by the userspace)

  - Made the driver outputs optional (to avoid crashing when a board
    doesn't have either a panel or a composite output enabled)
  - Added multiple plane support with transparency
  - Moved the backend registers writes commit in the CRTC atomic_flush
    callback
  - Removed the load / unload functions
  - Removed the enabled booleans in my private structure and removed
    the implicit call to disable_unused_functions in the DRM core to
    push it in the drivers.
  - Fixed a few bitmasks on some bitfields definition
  - Fixed the RGB connector mode validation that was not testing the
    right values

Maxime Ripard (19):
  clk: composite: Add unregister function
  clk: sunxi: Add display and TCON0 clocks driver
  clk: sunxi: Add PLL3 clock
  clk: sunxi: Add TCON channel1 clock
  dt-bindings: clk: sun5i: add DRAM gates compatible
  ARM: sun5i: dt: Add pll3 and pll7 clocks
  ARM: sun5i: a13: Add display and TCON clocks
  ARM: sun5i: Add DRAM gates
  ARM: sun5i: Add TV encoder gate to the DTSI
  drm: fb: Add seq_file definition
  drm/panel: simple: Add timings for the Olimex LCD-OLinuXino-4.3TS
  drm: Add Allwinner A10 Display Engine support
  drm: sun4i: Add DT bindings documentation
  drm: sun4i: Add RGB output
  drm: sun4i: Add composite output
  drm: sun4i: tv: Add PAL output standard
  drm: sun4i: tv: Add NTSC output standard
  ARM: sun5i: r8: Add display blocks to the DTSI
  ARM: sun5i: chip: Enable the TV Encoder

 Documentation/devicetree/bindings/clock/sunxi.txt  |   5 +
 .../display/panel/olimex,lcd-olinuxino-43-ts.txt   |   7 +
 .../bindings/display/sunxi/sun4i-drm.txt           | 254 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  66 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts                |  12 +
 arch/arm/boot/dts/sun5i-r8.dtsi                    | 142 ++++-
 arch/arm/boot/dts/sun5i.dtsi                       |  43 ++
 drivers/clk/clk-composite.c                        |  15 +
 drivers/clk/sunxi/Makefile                         |   3 +
 drivers/clk/sunxi/clk-sun4i-display.c              | 262 ++++++++
 drivers/clk/sunxi/clk-sun4i-pll3.c                 |  98 +++
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c             | 300 +++++++++
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   3 +-
 drivers/gpu/drm/panel/panel-simple.c               |  26 +
 drivers/gpu/drm/sun4i/Kconfig                      |  14 +
 drivers/gpu/drm/sun4i/Makefile                     |  13 +
 drivers/gpu/drm/sun4i/sun4i_backend.c              | 364 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_backend.h              | 165 +++++
 drivers/gpu/drm/sun4i/sun4i_crtc.c                 | 120 ++++
 drivers/gpu/drm/sun4i/sun4i_crtc.h                 |  30 +
 drivers/gpu/drm/sun4i/sun4i_dotclock.c             | 160 +++++
 drivers/gpu/drm/sun4i/sun4i_dotclock.h             |  21 +
 drivers/gpu/drm/sun4i/sun4i_drv.c                  | 326 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.h                  |  30 +
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c          |  54 ++
 drivers/gpu/drm/sun4i/sun4i_framebuffer.h          |  19 +
 drivers/gpu/drm/sun4i/sun4i_layer.c                | 161 +++++
 drivers/gpu/drm/sun4i/sun4i_layer.h                |  30 +
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 234 +++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.h                  |  18 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 538 ++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 | 186 ++++++
 drivers/gpu/drm/sun4i/sun4i_tv.c                   | 708 +++++++++++++++++++++
 include/drm/drm_fb_cma_helper.h                    |   2 +
 include/linux/clk-provider.h                       |   1 +
 36 files changed, 4424 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt
 create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
 create mode 100644 drivers/clk/sunxi/clk-sun4i-display.c
 create mode 100644 drivers/clk/sunxi/clk-sun4i-pll3.c
 create mode 100644 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
 create mode 100644 drivers/gpu/drm/sun4i/Kconfig
 create mode 100644 drivers/gpu/drm/sun4i/Makefile
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_backend.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_crtc.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_dotclock.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_drv.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_framebuffer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_layer.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_rgb.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.c
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tcon.h
 create mode 100644 drivers/gpu/drm/sun4i/sun4i_tv.c

-- 
2.7.3
