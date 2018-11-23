From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 22 Nov 2018 20:26:14 -0800
Subject: [PATCH v9 0/8] Add support for audiocodec in Allwinner A64
In-Reply-To: <20181122102325.29495-1-wens@csie.org>
References: <20181122102325.29495-1-wens@csie.org>
Message-ID: <2007258.VzpTJLJblp@anarsoul-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 22, 2018 2:23:17 AM PST Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v9 of the A64 audio codec series, originally started by Vasily.
> These are the last changes to make the A64 audio codec work correctly,
> and be accurately represented in the device tree and in software.
> 
> Notably, the new driver changes cover regulator supplies for the simple
> audio amplifier, which is used in the Pinebook for the internal
> speakers, and the audio codec's internal headphone amp. There's also an
> extra patch that enables SDM fractional clock support for the audio PLL
> on the A64, which gives us accurate audio playback.
> 
> Patch 1 & 2 add the cpvdd regulator supply to the sun50i-codec-analog
> dt bindings & driver.
> 
> Patch 3 & 4 add a regulator supply to the simple-audio-amplifier dt
> bindings & driver.
> 
> Patch 5 adds SDM fractional clock support for the audio PLL on the A64.
> 
> Patch 6 ~ 8 add the device tree bits and enables audio on several
> boards.
> 
> I have one extra patch for the Bananapi M64 that's not included here,
> as I'm waiting for an accessory to test the microphone bias. I'll send
> that one out once it's tested.
> 
> As always, we'll take the clock and dts patches after Mark has merged
> the ASoC ones.
> 
> And a big thanks to Vasily for having worked on this for so long.

Thank you for picking it up!

Just a minor note: hpvcc-supply should be a property of codec_analog in 
sun50i-a64-pinebook.dts

Otherwise looks fine, tested on Pinebook and Pine64-LTS.

Tested-by: Vasily Khoruzhick <anarsoul@gmail.com> 

> Regards
> ChenYu
> 
> v9: - Dropped simple amplifier headphone amp device tree changes
>     - Dropped "make enable-gpio optional for simple amplifier"
>     - Lowered oversampling rate from 512 to 128
>     - Add regulator supply for audio codec CPVDD (headphone amp charge pump)
> - Hook up CPVDD regulator in board device trees
>     - Add patch to enable SDM fractional clock support for audio PLL on A64
> v8: - drop merged patches
>     - add regulator property for simple amplifier, make enable-gpio
>       optional
>     - add regulator to speaker amp, introduce headphone amp
> v7: - drop 'Mic' and 'Headset Mic' from dtsi
>     - move AIF1 Slot 0 ADC to ADC route to sun8i-codec
>     - drop BIAS routes for Pine64 and SoPine
> v6: - driver patches has been merged through ASoC tree
>     - rebase onto 4.20-rc1
>     - Drop 'Speaker' from routes on sopine and pine64, they don't have
>       speaker.
> v5: - collect all the tags
> v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-codec,
>       define our board-level widgets instead.
> v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
>     - use ilog2() to calculate reg value for LRCK div instead of using a
>       table
> v2: - Use simple-amplifier for speaker amp on Pinebook
>     - Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preserve compatible
>       string for other 3 I2S modules in A64 in case if there's any
>       incompatibility with H3
> 
> Chen-Yu Tsai (3):
>   ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator
>     supply
>   ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator
>     supply
>   clk: sunxi-ng: sun50i: a64: Use sigma-delta modulation for audio PLL
> 
> Vasily Khoruzhick (5):
>   ASoC: dt-bindings: add regulator property to simple amplifier
>   ASoC: simple-amplifier: add VCC regulator widget
>   arm64: dts: allwinner: a64: add nodes necessary for analog sound
>     support
>   arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
>   arm64: dts: allwinner: a64: enable sound on Pinebook
> 
>  .../bindings/sound/simple-amplifier.txt       |  5 ++
>  .../bindings/sound/sun50i-codec-analog.txt    |  2 +
>  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 27 ++++++++++
>  .../dts/allwinner/sun50i-a64-pinebook.dts     | 49 +++++++++++++++++
>  .../allwinner/sun50i-a64-sopine-baseboard.dts | 26 +++++++++
>  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |  4 ++
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 54 +++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c         | 37 ++++++++-----
>  sound/soc/codecs/simple-amplifier.c           |  4 ++
>  sound/soc/sunxi/sun50i-codec-analog.c         |  2 +
>  10 files changed, 197 insertions(+), 13 deletions(-)
