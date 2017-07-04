From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:18 +0200
Subject: [PATCH v2 0/9] add support for Sama5d2 audio PLLs and enable ClassD
Message-ID: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
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

Thanks,
Quentin

[1] https://patchwork.kernel.org/patch/9462351/
[2] https://patchwork.kernel.org/patch/9462347/
[3] https://patchwork.kernel.org/patch/9462349/
[4] https://www.spinics.net/lists/arm-kernel/msg436120.html
[5] http://www.spinics.net/lists/linux-clk/msg17927.html

Cyrille Pitchen (2):
  ARM: dts: at91: sama5d2: add classd nodes
  ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd

Quentin Schulz (7):
  clk: at91: clk-generated: remove useless divisor loop
  clk: at91: add audio plls to the compatible list in DT binding
  clk: at91: add audio pll clock drivers
  clk: at91: clk-generated: create function to find best_diff
  clk: at91: clk-generated: make gclk determine audio_pll rate
  ASoC: atmel-classd: remove aclk clock from DT binding
  ASoC: atmel-classd: remove aclk clock

 .../devicetree/bindings/clock/at91-clock.txt       |  10 +
 .../devicetree/bindings/sound/atmel-classd.txt     |   9 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  16 ++
 arch/arm/boot/dts/sama5d2.dtsi                     |  39 +++-
 arch/arm/mach-at91/Kconfig                         |   4 +
 drivers/clk/at91/Makefile                          |   2 +
 drivers/clk/at91/clk-audio-pll-pad.c               | 206 ++++++++++++++++++
 drivers/clk/at91/clk-audio-pll-pmc.c               | 174 +++++++++++++++
 drivers/clk/at91/clk-audio-pll.c                   | 239 +++++++++++++++++++++
 drivers/clk/at91/clk-generated.c                   |  86 ++++++--
 include/linux/clk/at91_pmc.h                       |  25 +++
 sound/soc/atmel/atmel-classd.c                     |  47 ++--
 12 files changed, 798 insertions(+), 59 deletions(-)
 create mode 100644 drivers/clk/at91/clk-audio-pll-pad.c
 create mode 100644 drivers/clk/at91/clk-audio-pll-pmc.c
 create mode 100644 drivers/clk/at91/clk-audio-pll.c

-- 
2.11.0
