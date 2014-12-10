From: Ying.Liu@freescale.com (Liu Ying)
Date: Wed, 10 Dec 2014 16:37:13 +0800
Subject: [PATCH RFC 00/15] Add support for i.MX MIPI DSI DRM driver
Message-ID: <1418200648-32656-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for i.MX MIPI DSI DRM driver.
Currently, the MIPI DSI driver only supports the burst with sync pulse mode.

This series also includes a DRM panel driver for the Truly TFT480800-16-E panel
which is driven by the Himax HX8369A driver IC.  The driver IC data sheet could
be found at [1].  As mentioned by the data sheet, the driver IC supports several
interface modes.  Currently, the DRM panel driver only supports the MIPI DSI video
mode.  New interface modes could be added later(perhaps, just like the way the DRM
simple panel driver supports both MIPI DSI interface panels and simple(parallel)
interface panels).

The MIPI DSI feature is tested on i.MX6Q SabreSD board and i.MX6DL SabreSD board.
The MIPI DSI display could be enabled directly on i.MX6Q SabreSD board after
applying this series, because the 26.4MHz pixel clock the panel requires could be
derived from the IPU HSP clock(264MHz) with an integer divider.
On i.MX6DL SabreSD board, we need to manually disable the LVDS and HDMI displays in
the device tree blob, since the i.MX6DL IPU HSP clock is 198MHz at present, which
makes the pixel clock share the PLL5 video clock source with the LVDS and HDMI,
thus, the panel cannot get the pixel clock rate it wants.

Patch 01/15 is needed to get a precise pixel clock rate(26.4MHz) from the PLL5 video
clock.  If we don't have this patch, the pixel clock rate is about 20MHz, which
causes a horitonal shift on the display image.

This series can be applied on the drm-next branch.

[1] http://www.allshore.com/pdf/Himax_HX8369-A.pdf

Liu Ying (15):
  clk: divider: Correct parent clk round rate if no bestdiv is normally
    found
  of: Add vendor prefix for Himax Technologies Inc.
  of: Add vendor prefix for Truly Semiconductors Limited
  drm/dsi: Do not add DSI devices for the child nodes with input-port
    property
  ARM: dts: imx6qdl: Add input-port property to MIPI DSI node's CTRC
    child nodes
  ARM: dts: imx6q: Add MIPI DSI remote end points for IPU2 DI0/1 end
    points
  ARM: imx6q: Add GPR3 MIPI muxing control register field shift bits
    definition
  ARM: imx6q: clk: Add the video_27m clock
  drm: imx: Add MIPI DSI host controller driver
  drm: panel: Add support for Himax HX8369A MIPI DSI panel
  ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller
  ARM: dts: imx6qdl-sabresd: Add support for TRULY TFT480800-16-E MIPI
    DSI panel
  ARM: imx_v6_v7_defconfig: Cleanup for imx drm being moved out of
    staging
  ARM: imx_v6_v7_defconfig: Add support for MIPI DSI host controller
  ARM: imx_v6_v7_defconfig: Add support for Himax HX8369A panel

 .../devicetree/bindings/drm/imx/mipi_dsi.txt       |   81 ++
 .../devicetree/bindings/mipi/dsi/mipi-dsi-bus.txt  |    4 +
 .../devicetree/bindings/panel/himax,hx8369a.txt    |   86 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 arch/arm/boot/dts/imx6q.dtsi                       |    4 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   41 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |    9 +
 arch/arm/configs/imx_v6_v7_defconfig               |   17 +-
 arch/arm/mach-imx/clk-imx6q.c                      |    1 +
 drivers/clk/clk-divider.c                          |    3 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |    5 +-
 drivers/gpu/drm/imx/Kconfig                        |    6 +
 drivers/gpu/drm/imx/Makefile                       |    1 +
 drivers/gpu/drm/imx/imx-mipi-dsi.c                 | 1017 ++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |    6 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-hx8369a.c              |  627 ++++++++++++
 include/dt-bindings/clock/imx6qdl-clock.h          |    3 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    1 +
 19 files changed, 1903 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/panel/himax,hx8369a.txt
 create mode 100644 drivers/gpu/drm/imx/imx-mipi-dsi.c
 create mode 100644 drivers/gpu/drm/panel/panel-hx8369a.c

-- 
2.1.0
