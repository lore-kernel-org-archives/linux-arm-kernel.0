From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Mon, 17 Jan 2011 14:05:48 +0000
Subject: [alsa-devel] [PATCH] ASoC: EP93xx: fixed LRCLK rate and DMA
	oper. in I2S code
In-Reply-To: <1295182085.15631.231.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1295182085.15631.231.camel@r60e>
Message-ID: <1295273148.3283.21.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-01-16 at 15:48 +0300, Alexander wrote:
> From: Alexander Sverdlin <subaparts@yandex.ru>
> 
> Changelog:
> 1. I2S module of EP93xx should be feed by 32bit DMA transfers. This is 
> hardware limitation and that's the way original Cirrus's driver worked.
> This will fix distorted sound playback and make capture actually work in
> present ep93xx drivers.
> 
> I've found, that author of code, on which modern ep93xx-i2s.c and
> ep93xx-pcm.c are based, had faced this problem also in 2007:
> http://blog.gmane.org/gmane.linux.ports.arm.cirrus/month=20070101/page=3
> 
> Now SoC code uses his developments, but not overcomes the hardware
> issues. Some details from EP93xx users guide:
> 
> Both I2S transmitter and receiver have similar 16x32bit FIFO, where they
> store 8 samples for both left and right channels. The FIFO is always
> 32bit wide and should be properly aligned if you use samples of other
> width. Transmitter and receiver have configuration registers for
> selection of I2S word length (16, 24, 32). They are I2STXWrdLen and
> I2SRXWrdLen.
> 
> Yes, EP93xx DMA can do byte, word and quad-word transfers. The width for
> transfers to and from peripherals is selected by particular module
> configuration. Lucky AC97 module has such configuration: AC97RXCRx
> registers, bit CM (Compact mode enable) switches between 16 and 32 bit
> samples. AC97TXCRx registers have the same bits for transmitters.
> ep93xx-ac97.c enables this compact mode and so has all the rights to use
> S16_LE format.
> No one has found such a configuration in I2S module until now in any
> Cirrus manuals. I2S module always feeds it's 32bit wide FIFO with 32bit
> samples consecutively for left and right channels. You cannot use 32-bit
> DMA transfers to transfer two 16-bit samples. 
> 
> So we can use two formats for AC97, but should remove all but S32_LE for
> I2S. Always using 32 bit chunks is not a problem for I2S, the codec I
> use uses less bits too (24), it's permitted by I2S standard.
> 
> In proposed patch formats list shortened to just S32_LE, this makes all
> the DMA transactions right, while ALSA will do all sample format
> translation for us.
> 
> 2. Incorrect setting of LRCLK (2 times slower) in original ep93xx-i2s.c 
> masks the first problem. 
> 
> DMA takes two 16 bit samples instead of one, overall sound speed seems
> to be normal, but you get actually 4000 sampling rate instead of
> requested 8000 and therefore some noise... This is also the reason why
> the capture function not worked at all in this driver...
> 
> If we take a look into I2S specification, we will figure that LRCLK MUST
> be equal to sample rate, if we are talking about stereo (in mono too,
> but it's not our case at all).
> 
> In proposed patch SCLK and LRCLK rates are corrected, assuming we always
> send 32 bits * 2 channels to codec.
> 
> Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
