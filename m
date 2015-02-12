From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 14:01:23 +0800
Subject: [PATCH RFC v9 00/20] Add support for i.MX MIPI DSI DRM driver
Message-ID: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This version mainly addresses the comments from Philipp Zabel on v8.
The comments include
a. A common compatible string "snps,dw-mipi-dsi" should be appended to all SoCs'
   MIPI DSI device tree documentations and nodes.
b. Clean up the common clocks needed by the Synopsys DesignWare MIPI DSI host
   controller.

This version also drops two documentation patches in v8 for adding Himax and
Truly vendor prefixes since Rob Herring has taken them.

The i.MX MIPI DSI is a Synopsys DesignWare MIPI DSI host controller IP.
This series adds support for a Synopsys DesignWare MIPI DSI host controller
DRM bridge driver and a i.MX MIPI DSI specific DRM driver.
Currently, the MIPI DSI drivers only support the burst with sync pulse mode.

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

Patch 01/20 is needed to get a precise pixel clock rate(26.4MHz) from the PLL5 video
clock.  If we don't have this patch, the pixel clock rate is about 20MHz, which
causes a horitonal shift on the display image.

This series can be applied on the imx-drm/next branch of Philipp Zabel's open
git repository.

[1] http://www.allshore.com/pdf/Himax_HX8369-A.pdf

Liu Ying (20):
  clk: divider: Correct parent clk round rate if no bestdiv is normally
    found
  ARM: imx6q: Add GPR3 MIPI muxing control register field shift bits
    definition
  ARM: imx6q: clk: Add the video_27m clock
  ARM: imx6q: clk: Change hdmi_isfr clock's parent to be video_27m clock
  ARM: imx6q: clk: Change hsi_tx clock to be a shared clock gate
  ARM: imx6q: clk: Add support for mipi_core_cfg clock as a shared clock
    gate
  ARM: imx6q: clk: Add support for mipi_ipg clock as a shared clock gate
  ARM: dts: imx6qdl: Move existing MIPI DSI ports into a new 'ports'
    node
  drm/dsi: Add a helper to get bits per pixel of MIPI DSI pixel format
  Documentation: dt-bindings: Add bindings for Synopsys DW MIPI DSI DRM
    bridge driver
  drm/bridge: Add Synopsys DesignWare MIPI DSI host controller driver
  Documentation: dt-bindings: Add bindings for i.MX specific Synopsys DW
    MIPI DSI driver
  drm: imx: Support Synopsys DesignWare MIPI DSI host controller
  Documentation: dt-bindings: Add bindings for Himax HX8369A DRM panel
    driver
  drm: panel: Add support for Himax HX8369A MIPI DSI panel
  ARM: dtsi: imx6qdl: Add support for MIPI DSI host controller
  ARM: dts: imx6qdl-sabresd: Add support for TRULY TFT480800-16-E MIPI
    DSI panel
  ARM: imx_v6_v7_defconfig: Cleanup for imx drm being moved out of
    staging
  ARM: imx_v6_v7_defconfig: Add support for MIPI DSI host controller
  ARM: imx_v6_v7_defconfig: Add support for Himax HX8369A panel

 .../devicetree/bindings/drm/bridge/dw_mipi_dsi.txt |   76 ++
 .../devicetree/bindings/drm/imx/mipi_dsi.txt       |   81 ++
 .../devicetree/bindings/panel/himax,hx8369a.txt    |   39 +
 arch/arm/boot/dts/imx6q.dtsi                       |   20 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   20 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   30 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   23 +-
 arch/arm/mach-imx/clk-imx6q.c                      |    8 +-
 drivers/clk/clk-divider.c                          |    3 +-
 drivers/gpu/drm/bridge/Kconfig                     |   10 +
 drivers/gpu/drm/bridge/Makefile                    |    1 +
 drivers/gpu/drm/bridge/dw_mipi_dsi.c               | 1006 ++++++++++++++++++++
 drivers/gpu/drm/imx/Kconfig                        |    7 +
 drivers/gpu/drm/imx/Makefile                       |    1 +
 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c              |  230 +++++
 drivers/gpu/drm/panel/Kconfig                      |    5 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-himax-hx8369a.c        |  610 ++++++++++++
 include/drm/bridge/dw_mipi_dsi.h                   |   27 +
 include/drm/drm_mipi_dsi.h                         |   14 +
 include/dt-bindings/clock/imx6qdl-clock.h          |    5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    1 +
 22 files changed, 2184 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/bridge/dw_mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/drm/imx/mipi_dsi.txt
 create mode 100644 Documentation/devicetree/bindings/panel/himax,hx8369a.txt
 create mode 100644 drivers/gpu/drm/bridge/dw_mipi_dsi.c
 create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx.c
 create mode 100644 drivers/gpu/drm/panel/panel-himax-hx8369a.c
 create mode 100644 include/drm/bridge/dw_mipi_dsi.h

-- 
2.1.0
