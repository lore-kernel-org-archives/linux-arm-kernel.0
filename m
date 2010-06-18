From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Fri, 18 Jun 2010 12:01:02 +0100
Subject: [PATCH] ASoC: Add new TI TLV320AIC3204 CODEC driver
In-Reply-To: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
References: <1276833465-31702-1-git-send-email-redhatter@gentoo.org>
Message-ID: <1276858862.3054.28.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-06-18 at 13:57 +1000, Stuart Longland wrote:
> The TLV320AIC3204 is a low-power stereo audio CODEC capable of sample
> rates of up to 192kHz.  This driver implements basic functionality,
> using I?C for the control channel.
> 
> The audio interface supports many data bus formats, including I?S
> master/slave, DSP, left/right justified and TDM.
> 
> What works:
> 	- Playback at various bitrates up to 96kHz
> 	- Recording at various bitrates up to 96kHz
> 	- Mixer interface
> 	- PLL generation of CODEC clocks from MCLK
> 
> What could work better:
> 	- DAPM
> 
> What isn't tested:
> 	- Audio interfaces other than I?S
> 	- PLL with clocks other than ~12MHz
> 	- Mono recording/playback
> 	- 192kHz recording/playback
> 
> What isn't implemented:
> 	- SPI interface support
> 	- PLL without fractional divider (would allow <10MHz clocks)
> 	- Clock sources other than MCLK
> 	- Adaptive filtering
> 	- AGC
> 	- Headset detection, JACK framework
> 
> Signed-off-by: Stuart Longland <redhatter@gentoo.org>

Just had a quick check and the register caching needs addressed.

I agree with your comments, I don't think we really want to cache all
16K of codec registers here as we will probably only ever use a handful
of them. I think a smaller lookup table containing only the registers
that we care about will do.

Fwiw, a generic ASoC lookup table would be best as this could be used by
other codecs with large register maps too. The table should be ordered
(for quick lookup) and also contain a readable/writeable/volatile flag
for each register.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
