From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:27 +0100
Subject: [PATCH V3 00/15] ASoC: samsung: Add clk provider for I2S internal
 clocks
Message-ID: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is an attempt to resolve the CDCLK clock gating issue on Odroid
X2/U3 as reported by Daniel Drake [1], by exposing the CDCLK gate clock
(and the two other clocks) through clk API. The upside is we can switch
Odroid X2/U3 to the simple-card, once the CDCLK clock is taken care of by
the clk core and DT.

Changes since v2:
 - skipped the first, already merged patch,
 - modified description of the patch moving clk_prepare_enable() from DAI
   to the platform device probe(),
 - the last patch marked for stable.

The patch series has been created on top of branch:
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/samsung

Changes since the first version:
 - removed check for the i2s_opclk1 mux input clock while creating the mux
   and div clocks,
 - the DT binding documentation changes reworked (addressing review comments),
 - added include/dt-bindings/sound/samsung-i2s.h header file defining
   the clk indices, it's been put into a separate patch together with the I2S
   DT binding documentation updates to make merging of the ASoC and the dts
   patches separately easier,
 - a patch fixing compatible strings of I2S1, I2S2 in exynos4.dtsi is included
   in this series.

This whole series may need more testing on other SoCs, so far I only tested
it on Odroid Exynos4412 X2, with the I2S working in slave mode.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081753.html

Sylwester Nawrocki (15):
  ASoC: samsung: i2s: samsung_i2s_get_driver_data() cleanup
  ASoC: samsung: i2s: Add return value checks in probe()
  ASoC: samsung: i2s: Request memory region in driver probe()
  ASoC: samsung: i2s: Move clk_get() to platform driver probe()
  ASoC: samsung: i2s: Move clk enable to the platform driver probe()
  ASoC: samsung: i2s: Add get_other_dai helper function
  ASoC: samsung: i2s: Remove an unneeded goto usage
  ASoC: samsung: i2s: Add spinlock in place of local_irq_* calls
  ASoC: samsung: i2s: Protect more registers with a spinlock
  ASoC: samsung: odroidx2: Handle I2S CDCLK clock conditionally
  ASoC: samsung: i2s: Add clk provider DT binding documentation
  ASoC: samsung: i2s: Add clock provider for the I2S internal clocks
  ARM: dts: Exynos4 and Odroid X2/U3 sound device nodes update
  ARM: dts: Switch Odroid X2/U2 to simple-audio-card
  ARM: dts: Fix I2S1, I2S2 compatible for exynos4 SoCs

 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 ++
 arch/arm/boot/dts/exynos4.dtsi                     |   13 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   27 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |    8 +-
 arch/arm/boot/dts/exynos4412-odroidx2.dts          |    8 +-
 include/dt-bindings/sound/samsung-i2s.h            |    8 +
 sound/soc/samsung/i2s.c                            |  361 ++++++++++++--------
 sound/soc/samsung/odroidx2_max98090.c              |    6 +-
 8 files changed, 295 insertions(+), 158 deletions(-)
 create mode 100644 include/dt-bindings/sound/samsung-i2s.h

--
1.7.9.5
