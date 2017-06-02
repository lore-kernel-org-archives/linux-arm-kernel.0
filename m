From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:05 +0800
Subject: [PATCH 00/19] drm/sun4i: hdmi: Support HDMI controller on A31
Message-ID: <20170602101024.18940-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for the HDMI controller found on Allwinner
A31/A31s SoCs. It builds upon Maxime's work that added support for
the HDMI controller on the Allwinner A10s SoC.

The HDMI controllers in the older generation Allwinner SoCs is very
similar. The A10/A10s/A20 all have the same hardware block, with the
A10 having slightly different initial configuration values. The A31's
variant splits out the DDC parent clock, has different formulas for
the DDC and TMDS clocks, and a different register layout for the DDC
block. Also, it does not expose the CEC pins outside of the SoC, which
is unfortunate.

The first 2 patches allow the sun4i-drm driver to work correctly with
2 display pipelines.

Patch 3 adds support for the TCON demuxing feature on the A31. This is
needed if the user wants to output through HDMI from the second display
pipeline.

Patch 4 adds proper error path cleanup to the HDMI driver.

Patch 5 allows the HDMI TMDS clock to use the second PLL as its parent,
in case the first PLL is driving an incompatible dot clock.

Patch 6 adds the A31 HDMI controller variant to the device tree binding.

Patch 7 adds support for different variants of the TMDS clock, with the
different being an offset value for the divider.

Patch 8 adds support for the A31's TMDS clock variant.

Patch 9 adds support for different variants of the DDC clock, with the
differences being a different register offset, different divider offset,
different pre-divider, and different clock parent.

Patch 10 renames the HDMI block's DDC clock, so that it doesn't conflict
with the A31's SoC level HDMI DDC clock.

Patch 11 adds defines for the A31 specific DDC register offsets.

Patch 12 adds support for the A31's DDC clock variant.

Patch 13 adds support for different variants of the HDMI controller
hardware, with the differences mentioned in the beginning of this
letter.

Patch 14 adds support for the A31's HDMI controller variant.

Patch 15 exports the 2x outputs of the two video PLLs. These feed the
TMDS clock directly.

Patch 16 adds a device node for the HDMI controller on the A31.

Patches 17~19 enable HDMI video output on three boards that I have.


Patches 13 & 14 are somewhat complicated. If the DDC block were factored
out into a proper I2C controller, it might be cleaner. Other than that
this series should be quite straightforward.

I also had simultaneous output on both display pipelines on the SinA31s,
one with an LCD panel and the other using HDMI. After boot, both screens
showed a proper console. The HDMI screen had higher resolution, so the
console was limited to the upper left corner.


Regards
ChenYu

Chen-Yu Tsai (19):
  drm/sun4i: call drm_vblank_init with correct number of crtcs
  drm/sun4i: add components in two passes with encoders added in second
    pass
  drm/sun4i: tcon: Add support for demuxing TCON output on A31
  drm/sun4i: hdmi: Disable clks in bind function error path and unbind
    function
  drm/sun4i: hdmi: Allow using second PLL as TMDS clk parent
  dt-bindings: display: sun4i: Add binding for A31 HDMI controller
  drm/sun4i: hdmi: Support different variants of the TMDS clock
  drm/sun4i: hdmi: Support the TMDS clock in the A31's HDMI controller
  drm/sun4i: hdmi: Support different variants of the DDC clock
  drm/sun4i: hdmi: Rename internal DDC clock to avoid name collision
  drm/sun4i: hdmi: Add A31 specific DDC register definitions
  drm/sun4i: hdmi: Support the DDC clock in the A31's HDMI controller
  drm/sun4i: hdmi: Add support for controller hardware variants
  drm/sun4i: hdmi: Add support for A31's HDMI controller
  clk: sunxi-ng: sun6i: Export video PLLs
  ARM: sun6i: a31: Add device node for HDMI controller
  ARM: sun6i: a31: Enable HDMI support on the A31 Hummingbird
  ARM: sun6i: a31s: Enable HDMI display output on the Sinlinx SinA31s
  ARM: sun6i: a31s: Enable HDMI display output on the MSI Primo81 tablet

 .../bindings/display/sunxi/sun4i-drm.txt           |   3 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  21 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  55 ++++
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  25 ++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  25 ++
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   8 +-
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  34 ++-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                 |  39 +++
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c         |  55 +++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 280 ++++++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c        |  82 +++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  61 +++++
 include/dt-bindings/clock/sun6i-a31-ccu.h          |   4 +
 14 files changed, 613 insertions(+), 81 deletions(-)

-- 
2.11.0
