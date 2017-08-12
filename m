From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 12 Aug 2017 13:00:48 +0200
Subject: [PATCH v3 00/11] ASoC: Add I2S support for Allwinner H3 SoCs
Message-ID: <20170812110059.5115-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

Hi All,
please find attached a series of patches to bring i2s support to the
Allwinner H3 SoC. This has been tested with the following setups:

A20 Olimex EVB connected to a pcm5102
Orange Pi 2 connected to a uda1380
Orange Pi 2 hdmi audio playback
Pine 64 connected to the audio DAC board

To get i2s working some additional patches are required which will be
delivered later. For now they have been pushed here

https://github.com/codekipper/linux-sunxi/commits/sunxi-audio-h3

I don't own a A33 device which uses the i2s block for the audio codec
so if someone could test against that it would be much appreciated.

I'm also wondering if there is a preferred way of setting the lrclk
size in the dts?..currently it is set to the sample width but for example
the pcm5102a wants it to be 32 bits whatever the sample rate.

Thanks in advance,
CK

---

v4 changes compared to v3 are:
- moved clkdiv variant adjustment out of function
- used PTR_ERR_OR_ZERO for checks
- tidy up of extra lines and lines over 80 chars.
- reduced names of polarity, wss and sr reg fields.
- added reviewed-by to commit messages
- added comments for functionality that hasn't been implemented yet.

v3 changes compared to v2 are:
- initial changes to prepare driver for newer SoCs has been broken down
  into smaller patches
- reduce use of regmap fields to where just needed.
- clkdiv expansion will be delivered later.
- defines for H3 variant segregated.
- fixed regmap config issue with SUN8I_I2S_FIFO_TX_REG.


v2 changes compared to v1 are:
 - massive refactoring to remove duplicate code making use of regmap_fields.
 - extending the clock divisors.
 - removed code that should be delivered when we support 20/24bits

---

Marcus Cooper (11):
  ASoC: sun4i-i2s: Add clkdiv offsets to quirks
  ASoC: sun4i-i2s: Add regmap config to quirks
  ASoC: sun4i-i2s: Add TX FIFO offset to quirks
  ASoC: sun4i-i2s: Add regmap fields for channels
  ASoC: sun4i-i2s: Add regfields for word size select and sample
    resolution
  ASoC: sun4i-i2s: bclk and lrclk polarity tidyup
  ASoC: sun4i-i2s: Add mclk enable regmap field
  ASoC: sun4i-i2s: Add regmap field to set DAI format
  ASoC: sun4i-i2s: Check for slave select bit
  ASoC: sun4i-i2s: Update global enable with bitmask
  ASoC: sun4i-i2s: Add support for H3

 .../devicetree/bindings/sound/sun4i-i2s.txt        |   2 +
 sound/soc/sunxi/sun4i-i2s.c                        | 444 ++++++++++++++++++---
 2 files changed, 391 insertions(+), 55 deletions(-)

-- 
2.14.1
