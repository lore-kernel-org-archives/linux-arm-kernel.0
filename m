From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:22:52 +0800
Subject: [PATCH v3 00/14] drm/sun4i: hdmi: Support HDMI controller on A31
Message-ID: <20170929082306.16193-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is v3 of my A31 HDMI support series.

Changes since v2:

    - TCON muxing moved into functions for each platform, with pointers
      to them in the TCON quirks structure.

    - CCU "hdmi-ddc" clock renamed to "ddc".

    - Added Maxime's acks.

Changes since v1:

    - Core changes to sun4i-drm to support two display pipelines
      have been merged into drm-misc and thus dropped from this
      version

    - Reworked DDC variant support onto new exposed I2C interface bits.

    - Reworked DDC variant support to use regmap_fields.

    - Patches to add variant support to various (TMDS, DDC, HDMI
      controller) sub-blocks have been merged into one patch.

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

Patch 1 exports the 2x outputs of the two video PLLs. These feed the
TMDS clock directly.

Patch 2 renames the A31 CCU's DDC clock, so that it doesn't conflict
with the DDC clock in the HDMI block.

Patch 3 moves the existing TCON muxing code for the A13 into a separate
function, pointed to by by function pointer in the quirks structure.
The existing sun4i_tcon_set_mux() function calls the function pointer
if it is set.

Patch 4 adds support for the TCON demuxing feature on the A31. This is
needed if the user wants to output through HDMI from the second display
pipeline.

Patch 5 adds proper error path cleanup to the HDMI driver.

Patch 6 adds a regmap for the HDMI driver, to be used in a subsequent
patch.

Patch 7 allows the HDMI TMDS clock to use the second PLL as its parent,
in case the first PLL is driving an incompatible dot clock.

Patch 8 adds the A31 HDMI controller variant to the device tree binding.

Patch 9 adds an iopoll-like polling macro for regmap_field. This is used
in the next patch within the DDC part to poll for reset and I/O
completion.

Patch 10 adds support for different variants of the HDMI controller
hardware, with the differences mentioned in the beginning of this
letter.

Patch 11 adds defines for the A31 specific DDC register offsets.

Patch 12 adds support for the A31's HDMI controller variant.

Patch 13 adds a device node for the HDMI controller on the A31.

Patch 14 enable HDMI video output on three boards that I have.


I also had simultaneous output on both display pipelines on the SinA31s,
one with an LCD panel and the other using HDMI. After boot, both screens
showed a proper console. The HDMI screen had higher resolution, so the
console was limited to the upper left corner.

Note that this series does not deal with conflicting pixel clocks.

Assuming everyone is happy with the patches, I propose the following:

    1. We sunxi maintainers will take the clk and dts patches through
       our tree with minimal but proper cross references.

    2. Mark can either take the regmap patch on an immutable branch,
       which we then merge into drm-misc before applying the drm/sun4i
       patches, or give his Ack for us to merge that patch through
       drm-misc.

As I still don't have a freedesktop.org account [1] to access drm-misc,
Maxime will have to apply the patches for me.


Regards
ChenYu


[1] https://bugs.freedesktop.org/show_bug.cgi?id=102920

Chen-Yu Tsai (14):
  clk: sunxi-ng: sun6i: Export video PLLs
  clk: sunxi-ng: sun6i: Rename HDMI DDC clock to avoid name collision
  drm/sun4i: tcon: Add variant callback for TCON output muxing
  drm/sun4i: tcon: Add support for demuxing TCON output on A31
  drm/sun4i: hdmi: Disable clks in bind function error path and unbind
    function
  drm/sun4i: hdmi: create a regmap for later use
  drm/sun4i: hdmi: Allow using second PLL as TMDS clk parent
  dt-bindings: display: sun4i: Add binding for A31 HDMI controller
  regmap: add iopoll-like polling macro for regmap_field
  drm/sun4i: hdmi: Add support for controller hardware variants
  drm/sun4i: hdmi: Add A31 specific DDC register definitions
  drm/sun4i: hdmi: Add support for A31's HDMI controller
  ARM: dts: sun6i: Add device node for HDMI controller
  ARM: dts: sun6i: Enable HDMI support on some A31/A31s devices

 .../bindings/display/sunxi/sun4i-drm.txt           |   3 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  21 ++
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  55 +++++
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  25 +++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts           |  25 +++
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c               |   2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.h               |   8 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi.h                 | 107 ++++++++++
 drivers/gpu/drm/sun4i/sun4i_hdmi_ddc_clk.c         |  38 +++-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             | 204 +++++++++++++++---
 drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c             | 227 +++++++++++++++------
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c        |  68 +++---
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  83 ++++++--
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |   5 +
 include/dt-bindings/clock/sun6i-a31-ccu.h          |   4 +
 include/linux/regmap.h                             |  39 ++++
 16 files changed, 769 insertions(+), 145 deletions(-)

-- 
2.14.2
