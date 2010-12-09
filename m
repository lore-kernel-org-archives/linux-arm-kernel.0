From: subaparts@yandex.ru (Alexander)
Date: Thu, 09 Dec 2010 03:37:31 +0300
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <20101208124637.GD16418@rakim.wolfsonmicro.main>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
Message-ID: <1291855051.31916.85.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 2010-12-08 at 12:46 +0000, Mark Brown wrote:
> On Wed, Dec 08, 2010 at 03:01:33PM +0300, Alexander wrote:
> 
> > Changes to I2S code:
> 
> This should be split into a patch series, there's a bunch of changes
> here that are pretty much unrelated.  Having everything in one patch
> makes review harder as more changes have to be thought about
> simultaneously and means that the different changes get tied up with
> each other and a problem with one can hold up others.
> 

I'll split it.


> > - SCLK and LRCLK rates are corrected, assuming we always send 32 bits * 2 channels to codec.
> 
> What was the problem?
> 
> > - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
> >   while ALSA will do all sample format translation for us.
> 
> Again, what was the actual problem?  32 bit samples seem very large if
> the hardware is capable of other formats, especially given that things
> like MP3 tend to produce 16 bit data.

It seems that EP93xx DMA could only operate 32 bit words. So the I2S
module is always feed by 32 bit samples. Incorrect setting of LRCLK (2
times slower) in original ep93xx-i2s.c masks the problem. DMA takes two
16 bit samples instead of one, overall sound speed seems to be normal,
but you get actually 4000 sampling rate instead of requested 8000 and
therefore some noise... This is also the reason why the capture function
not worked at all in this driver...

Best regards,
	Alexander A. Sverdlin.
