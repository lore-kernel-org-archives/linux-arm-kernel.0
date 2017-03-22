From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Mar 2017 11:32:22 +0100
Subject: [PATCH v2 0/5] clk: meson: Fix GXBB and GXL/GXM GP0 PLL
Message-ID: <1490178747-14837-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes support for the Amlogic GXBB then GXL/GXM embedded GP0 PLL.

The current support is done via a very generic interface where only the
N/M/OD parameters are changed in the control registers.

But unlike the Fixed PLL, this PLL is not initialized by the bootloader or
firmware, and needs some parameters to initialize and lock correctly.

This patchset also adds the GXL variant compatible string which is already
supported by the GXL and GXM DT nodes.

Changes since v1 at [1]:
 - Rebase on the Mali clocks patchset at [2]
 - also depends on v2 Audio Clocks patchset from Jerome Brunet at [3]
 - Add match table and separate tables for gxl
 - Switch to probe function to use match table data only
 - Rename unreset_for_lock to clear_reset_for_lock

[1] http://lkml.kernel.org/r/1489411604-18700-1-git-send-email-narmstrong at baylibre.com
[2] http://lkml.kernel.org/r/1490177935-9646-1-git-send-email-narmstrong at baylibre.com
[3] http://lkml.kernel.org/r/20170309104154.28295-1-jbrunet at baylibre.com

Neil Armstrong (5):
  clk: meson: Add support for parameters for specific PLLs
  clk: meson-gxbb: Add GP0 PLL init parameters
  clk: meson-gxbb: Add GXL/GXM GP0 Variant
  clk: meson-gxbb: Expose GP0 dt-bindings clock id
  dt-bindings: clock: gxbb-clkc: Add GXL compatible variant

 .../bindings/clock/amlogic,gxbb-clkc.txt           |   3 +-
 drivers/clk/meson/clk-pll.c                        |  53 +++-
 drivers/clk/meson/clkc.h                           |  23 ++
 drivers/clk/meson/gxbb.c                           | 314 +++++++++++++++++++--
 drivers/clk/meson/gxbb.h                           |   4 +-
 include/dt-bindings/clock/gxbb-clkc.h              |   1 +
 6 files changed, 366 insertions(+), 32 deletions(-)

-- 
1.9.1
