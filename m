From: liquid.acid@gmx.net (Tobias Jakobi)
Date: Sat, 24 Jan 2015 02:53:41 +0100
Subject: [PATCH v2 00/16] ASoC: samsung: Add clk provider for I2S
 internal clocks
In-Reply-To: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <54C2FB25.4030501@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've tested the series on my X2 and so far I haven't encountered any
obvious issues with it.

I have a small question though. With the move to simple-audio-card the
old driver (selected by SND_SOC_ODROIDX2) is probably going away after
some time.
Currently SND_SOC_ODROIDX2 also selects SND_SOC_MAX98090 and
SND_SAMSUNG_I2S, which I believe (correct me if I'm wrong) are necessary
to use the sound subsystem even with simple-audio-card (since the
max98090 codec has to be built at least). I've found no way of selecting
these two manually, so at the moment I need both CONFIG_SND_SIMPLE_CARD
and SND_SOC_ODROIDX2 enabled to use sound. Is this intended behaviour?


And while I'm at it. I'm booting the board with an upstream u-boot
version which sets the MPLL to 800MHz, which AFAIK is the clocking rate
that makes less 'trouble' (but at the expense of performance).
I was wondering if anyone can comment on whether the recent rework has
any influence on the behaviour when booting with the vendor u-boot
(which sets the MPLL to 880MHz). IIRC then clock rounding issues arose
there.

It would be interesting to know if this series gets us closer to drive
the MPLL with the recommended (?) higher clocking rate.


With best wishes,
Tobias



Sylwester Nawrocki wrote:
> This series is an attempt to resolve the CDCLK clock gating issue on Odroid
> X2/U3 as reported by Daniel Drake [1], by exposing the CDCLK gate clock 
> (and the two other clocks) through clk API. 
> 
> Changes since previous version:
>  - removed check for the i2s_opclk1 mux input clock while creating the mux
>    and div clocks,
>  - the DT binding documentation changes reworked (addressing review comments),
>  - added include/dt-bindings/sound/samsung-i2s.h header file defining
>    the clk indices, it's been put into a separate patch together with the I2S 
>    DT binding documentation updates to make merging of the ASoC and the dts
>    patches separately easier,
>  - a patch fixing compatible strings of I2S1, I2S2 in exynos4.dtsi is included
>    in this series.
> 
> This whole series may need more testing on other SoCs, so far I only tested 
> it on Odroid Exynos4412 X2, with the I2S working in slave mode.
> 
> [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/081753.html
> 
> Sylwester Nawrocki (16):
>   ASoC: samsung: i2s: Remove unused gpios field from struct i2s
>   ASoC: samsung: i2s: samsung_i2s_get_driver_data() cleanup
>   ASoC: samsung: i2s: Add return value checks in probe()
>   ASoC: samsung: i2s: Request memory region in driver probe()
>   ASoC: samsung: i2s: Move clk_get() to platform driver probe()
>   ASoC: samsung: i2s: Move clk enable to the platform driver probe()
>   ASoC: samsung: i2s: Add get_other_dai helper function
>   ASoC: samsung: i2s: Remove an unneeded goto usage
>   ASoC: samsung: i2s: Add spinlock in place of local_irq_* calls
>   ASoC: samsung: i2s: Protect more registers with a spinlock
>   ASoC: samsung: odroidx2: Handle I2S CDCLK clock conditionally
>   ASoC: samsung: i2s: Add clk provider DT binding documentation
>   ASoC: samsung: i2s: Add clock provider for the I2S internal clocks
>   ARM: dts: Exynos4 and Odroid X2/U3 sound device nodes update
>   ARM: dts: Switch Odroid X2/U2 to simple-audio-card
>   ARM: dts: Fix I2S1, I2S2 compatible for exynos4 SoCs
> 
>  .../devicetree/bindings/sound/samsung-i2s.txt      |   22 ++
>  arch/arm/boot/dts/exynos4.dtsi                     |   13 +-
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   27 +-
>  arch/arm/boot/dts/exynos4412-odroidu3.dts          |    8 +-
>  arch/arm/boot/dts/exynos4412-odroidx2.dts          |    8 +-
>  include/dt-bindings/sound/samsung-i2s.h            |    8 +
>  sound/soc/samsung/i2s.c                            |  362 ++++++++++++--------
>  sound/soc/samsung/odroidx2_max98090.c              |    6 +-
>  8 files changed, 295 insertions(+), 159 deletions(-)
>  create mode 100644 include/dt-bindings/sound/samsung-i2s.h
> 
