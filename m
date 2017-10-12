From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:36:56 +0800
Subject: [PATCH 0/9] clk: sunxi-ng: Use sigma-delta modulation for audio PLL
Message-ID: <20171012083705.24409-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This series adds support for fractional-N synthesis using sigma-delta
modulation in the audio PLL to get the exact required clock rate.
This fixes the speed and pitch change when audio is played back on
sunxi platforms, due to the slightly inaccurate audio clock.

I've done this for all platforms I can test at the moment. A83T is left
out for now as the the clock unit's design is slightly different. I
was unable to work on the A33, as my board is very unstable, plus A33
audio playback seems to be broken at the moment. There might be some
issue with the DAPM routes.

Patch 1 fixes an error with the audio PLL's post-divider bit field
offset.

Patch 2 adds a check for fractional mode clock rates in the N-M clock's
round_rate callback. This is mostly for aesthetics to have both
round_rate and set_rate code paths look the same. In practice the N-M
factors can also generate the fractional mode clock rates directly.

Patch 3 adds a table based sigma-delta modulation clock type. This is
implemented much like the fractional mode clocks, as a helper library
to be integrated into the various factor clocks where needed. As there
is no explanation on how to calculate the parameters for SDM, the table
based approach allows us to copy existing parameters from the vendor
kernel.

Patch 4 hooks the SDM clock type helpers into the N-M factors clock
type. The audio PLLs on most of our are of this type.

Patches 5 ~ 9 convert the audio PLL to using SDM on various SoCs. The
changes are the same, accounting for minor variances between SoCs:

    - audio PLL post-divider now forced to 1.

    - pll-audio-1x fixed-factor-clock divider now set to 1, matching
      the hardware setting from above.

    - SDM parameter table added.

    - SDM parameters added to pll-audio-base clock.

Please have a look.

ChenYu

Chen-Yu Tsai (9):
  clk: sunxi-ng: sun5i: Fix bit offset of audio PLL post-divider
  clk: sunxi-ng: nm: Check if requested rate is supported by fractional
    clock
  clk: sunxi-ng: Add sigma-delta modulation support
  clk: sunxi-ng: nm: Add support for sigma-delta modulation
  clk: sunxi-ng: sun8i: h3: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: sun4i: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: sun5i: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: sun6i: Use sigma-delta modulation for audio PLL
  clk: sunxi-ng: sun8i: a23: Use sigma-delta modulation for audio PLL

 drivers/clk/sunxi-ng/Makefile        |   1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c |  26 ++++--
 drivers/clk/sunxi-ng/ccu-sun5i.c     |  27 ++++--
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c |  38 ++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c |  38 ++++++---
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c  |  38 ++++++---
 drivers/clk/sunxi-ng/ccu_common.h    |   1 +
 drivers/clk/sunxi-ng/ccu_nm.c        |  25 +++++-
 drivers/clk/sunxi-ng/ccu_nm.h        |  25 ++++++
 drivers/clk/sunxi-ng/ccu_sdm.c       | 158 +++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.h       |  80 ++++++++++++++++++
 11 files changed, 404 insertions(+), 53 deletions(-)
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.h

-- 
2.14.2
