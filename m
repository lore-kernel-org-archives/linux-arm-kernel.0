From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Dec 2010 10:54:43 +0000
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <1291855051.31916.85.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855051.31916.85.camel@r60e>
Message-ID: <20101209105443.GA4469@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 03:37:31AM +0300, Alexander wrote:
> > > - Formats list shortened to just S32_LE, this makes all the DMA transactions right,
> > >   while ALSA will do all sample format translation for us.

> > Again, what was the actual problem?  32 bit samples seem very large if
> > the hardware is capable of other formats, especially given that things
> > like MP3 tend to produce 16 bit data.

> It seems that EP93xx DMA could only operate 32 bit words. So the I2S
> module is always feed by 32 bit samples. Incorrect setting of LRCLK (2
> times slower) in original ep93xx-i2s.c masks the problem. DMA takes two
> 16 bit samples instead of one, overall sound speed seems to be normal,
> but you get actually 4000 sampling rate instead of requested 8000 and
> therefore some noise... This is also the reason why the capture function
> not worked at all in this driver...

The approach taken by the original code (while it sounds like it still
has issues is a pretty standard way to deal with limitations in DMA
controllers like this.  You often end up programming the DMA controller
to transfer 32 bit chunks and the I2S controller to transfer two 16 bit
samples then let the FIFOs on the edge of the I2S controller sort out
the difference.  This means that the DMA controller transfers a stereo
pair of samples at a go, which works well enough.  Some of the hardware
configuration may be technically incorrect according to the spec but so
long as the externally observable behaviour is OK that's not an issue.

It may be that there's limitations in the hardware that prevent such a
configuration but I'd like to see more analysis of what's going on here.
