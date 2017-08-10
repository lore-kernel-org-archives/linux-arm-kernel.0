From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Thu, 10 Aug 2017 08:34:00 +0200
Subject: [PATCH v5 0/7] add support for Sama5d2 audio PLLs and enable ClassD
Message-ID: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the audio PLLs and enables ClassD that
can be found in ATMEL Sama5d2 SoC.

There are two audio PLLs (PMC and PAD) that shares the same parent (FRAC).
FRAC can output between 620 and 700MHz and only multiply the rate of its
parent. The two audio PLLs then divide the FRAC rate to best match the
asked rate.

I basically took an old patch series posted by Nicolas on December, 6th
2016[1][2][3] and the comments Boris did on the first version[4] Nicolas
sent on July, 15th 2015.

I also fixed the function used to compute the divisors, removed useless
spinlocks and added a range to the audio frac PLL to stay within vendor's
supported range. Clocks that are children of gclk (generated-clk) are now
able to propagate rate to the audio PLL clocks when needed.

However, there are multiple children clocks that could technically
change the rate of audio_pll (via gck). With the rate locking introduced
in Jerome Brunet's patch series[5], the first consumer to enable the clock
will be the one definitely setting the rate of the clock. Without the rate
locking, the last consumer to set the rate will be able to mess with the
rate.
Since audio IPs are most likely to request the same rate, we enforce
that the only clks able to modify gck rate are those of audio IPs.

To remain consistent, we deny other clocks to be children of audio_pll.

I suggest this whole series going through the clk subsystem.

v5:
 - replaced clk_audio_pll_frac_round_rate by
 clk_audio_pll_frac_determine_rate to also return min and max rate for
 the clk, suggested by Stephen Boyd during v3,

v4:
 - initialized the clk_init_data structure,
 - switched to of_clk_parent_fill instead of manually setting
 parent_names,
 - removed include of clkdev.h in favor of slab.h,
 - removed unnecessary second cast in operation,
 - used clamp instead of two conditions,
 - removed dependency on clock-output-names, the name is gotten from DT
 node,
 - merged all three drivers for audio PLLs (FRAC, PMC, PAD) into one,

v3:
 - added a flag per generated clock to know which one is allowed to
 modify audio_pll rate,
 - set the flag in setup function depending on the compatible and the
 clock ID,

v2:
 - split big patch containing dt-binding, pll drivers and classd
 modifications,
 - removed unused AUDIO_PLL_*FOUT* defines from clk-audio-pll-pmc,
 - added conditions for audio pll rate setting restriction for SSC and
 I2S,
 - renamed all mentions of ACLK to GCLK in classD driver,

Thanks,
Quentin

[1] https://patchwork.kernel.org/patch/9462351/
[2] https://patchwork.kernel.org/patch/9462347/
[3] https://patchwork.kernel.org/patch/9462349/
[4] https://www.spinics.net/lists/arm-kernel/msg436120.html
[5] http://www.spinics.net/lists/linux-clk/msg17927.html

Quentin Schulz (7):
  clk: at91: clk-generated: remove useless divisor loop
  dt-bindings: clk: at91: add audio plls to the compatible list
  clk: at91: add audio pll clock drivers
  clk: at91: clk-generated: create function to find best_diff
  clk: at91: clk-generated: make gclk determine audio_pll rate
  ASoC: atmel-classd: remove aclk clock from DT binding
  ASoC: atmel-classd: remove aclk clock

 Documentation/devicetree/bindings/clock/at91-clock.txt   |  10 +-
 Documentation/devicetree/bindings/sound/atmel-classd.txt |   9 +-
 arch/arm/mach-at91/Kconfig                               |   4 +-
 drivers/clk/at91/Makefile                                |   1 +-
 drivers/clk/at91/clk-audio-pll.c                         | 536 ++++++++-
 drivers/clk/at91/clk-generated.c                         | 101 +-
 include/linux/clk/at91_pmc.h                             |  25 +-
 sound/soc/atmel/atmel-classd.c                           |  47 +-
 8 files changed, 675 insertions(+), 58 deletions(-)
 create mode 100644 drivers/clk/at91/clk-audio-pll.c

base-commit: 22bbe310b60b37b029659460843265f190364e48
-- 
git-series 0.9.1
