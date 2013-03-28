From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 28 Mar 2013 16:23:24 +0100
Subject: [PATCH v3 0/11] LVDS Display Bridge support for i.MX
Message-ID: <1364484215-13935-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patches add support for LVDS displays on
i.MX53 and i.MX6q boards. I have reordered the patches,
as Shawn has already applied the now first five patches.

The clock patches are needed because the LVDS serial clock
needs to be in lockstep with the IPU display interface clock
providing the pixel data. A fixed factor of 7:1 (or 3.5:1 in
dual link mode) needs to be maintained. This is achieved on
i.MX by clocking the LDB DI clock directly from a PLL, and
manually setting the 3.5/7:1 divider depending on dual/single
link mode. The IPU display interface clock is then sourced
from the divided LDB clock.

Changes since v2:
 - Removed commented out code from LDB driver
 - Replaced magic constants in LDB driver
 - Let LDB driver select OF_VIDEOMODE
 - Renamed pll[45]_test_div to pll[45]_post_div
 - Renamed pll5_control3 to pll5_video_div
 - Reformatted clk_div_tables
 - Added missing imx_ccm_lock to audio/video post dividers
 - Added new clocks to device tree bindings documentation
 - Removed clocks properties from the ldb node in imx6qdl.dtsi,
   those are to be set in imx6q.dtsi and imx6dl.dtsi

regards
Philipp

---
 .../devicetree/bindings/clock/imx6q-clock.txt      |   3 +
 .../devicetree/bindings/staging/imx-drm/ldb.txt    |  99 ++++
 arch/arm/boot/dts/imx51.dtsi                       |   2 +
 arch/arm/boot/dts/imx53.dtsi                       |  34 ++
 arch/arm/boot/dts/imx6q.dtsi                       |  17 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |  20 +
 arch/arm/mach-imx/clk-imx51-imx53.c                |  19 +-
 arch/arm/mach-imx/clk-imx6q.c                      |  55 +-
 arch/arm/mach-imx/clk.h                            |  17 +
 arch/arm/mach-imx/common.h                         |   1 +
 arch/arm/mach-imx/mach-imx6q.c                     |   2 +-
 drivers/staging/imx-drm/Kconfig                    |   8 +
 drivers/staging/imx-drm/Makefile                   |   1 +
 drivers/staging/imx-drm/imx-ldb.c                  | 609 +++++++++++++++++++++
 14 files changed, 862 insertions(+), 25 deletions(-)
