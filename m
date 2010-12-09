From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 9 Dec 2010 12:34:57 +0000
Subject: [PATCH 1/3] ASoC: EP93xx I2S and PCM fixes
In-Reply-To: <1291897061.31916.149.camel@r60e>
References: <1291809693.31916.2.camel@r60e>
	<20101208124637.GD16418@rakim.wolfsonmicro.main>
	<1291855051.31916.85.camel@r60e>
	<20101209105443.GA4469@rakim.wolfsonmicro.main>
	<1291897061.31916.149.camel@r60e>
Message-ID: <20101209123457.GD4469@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 03:17:41PM +0300, Alexander wrote:
> On Thu, 2010-12-09 at 10:54 +0000, Mark Brown wrote:

> > pair of samples at a go, which works well enough.  Some of the hardware
> > configuration may be technically incorrect according to the spec but so
> > long as the externally observable behaviour is OK that's not an issue.

> I2S controller always takes 2 samples (2 ch) from DMA, DMA is always 32
> bit, so if you will feed it with 16 samples, you will get 2 times faster
> sound.

How exactly does it "take" the samples?  You're really not being clear
about what the hardware is doing here.  Please be specific about the
interaction between the I2S controller and the DMA controller - for
example, is there a FIFO on the edge of the I2S controller, is there any
mediation of the data words anywhere in the process?

I *think* what you're trying to say above is that the I2S controller
reads each sample as an individual word directly from the DMA controller
so the DMA word size must match exactly the I2S word size but you're
really not being clear.

> > It may be that there's limitations in the hardware that prevent such a
> > configuration but I'd like to see more analysis of what's going on here.

> If we take a look into I2S specification, we will figure that LRCLK MUST
> be equal to sample rate, if we are talking about stereo (in mono too,
> but it's not our case at all). So it doesnt seems strange to you,
> ep93xx-i2s.c produces LRCLK two times slower than it MUST be? It's a
> bug, making DMA bug less visible...

Right, but the DMA controller can (ignoring any restrictions in your
hardware) happily transfer data in any size and this needn't have
anything to do with what the I2S controller is emitting.  You need to
look at the configuration of the interaction between the I2S and DMA
controllers rather than the external interface when looking at this
stuff.

This is all broadly orthogonal to the external BCLK and LRCLK rates,
it's all about how the data gets between the I2S and DMA controllers.

> Always using 32 bit chunks is not a problem for I2S, the codec I use
> uses less bits too (24), it's permitted by I2S standard.

It's a problem because it means that the data needs to be laid out in
memory in 32 bit words which means that a lot of data is going to need
to be repacked from 16 bit to 32 bit samples which is wasteful.  If the
hardware can be persuaded to avoid this then that's much better.
