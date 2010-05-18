From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 18 May 2010 19:37:55 +0100
Subject: [RFC PATCH 1/3] ep93xx i2s driver
In-Reply-To: <AANLkTin0bJ_b9_BEcZzdkwtl8zBQV6bDRpdx8QSLcR1R@mail.gmail.com>
References: <4BF21B67.8090404@bluewatersys.com>
	<4BF21D48.3020005@bluewatersys.com>
	<AANLkTin0bJ_b9_BEcZzdkwtl8zBQV6bDRpdx8QSLcR1R@mail.gmail.com>
Message-ID: <20100518183754.GD22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 08:45:41AM -0400, Chase Douglas wrote:

Please cut text which is not relevant from your replies, it makes it
*much* easier to read them - it's hard to spot new text while deleting
lots of old text, and it scales much more nicely onto mobile devices
too.

> On Tue, May 18, 2010 at 12:53 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
> > Add ep93xx i2s audio driver

> > +# EP93xx Platform Support
> > +snd-soc-ep93xx-objs ? ? ? ? ? ? ? ? ? ? ? ? ? ?:= ep93xx-pcm.o
> > +snd-soc-ep93xx-i2s-objs ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?:= ep93xx-i2s.o
> > +
> > +obj-$(CONFIG_SND_EP93XX_SOC) ? ? ? ? ? ? ? ? ? += snd-soc-ep93xx.o
> > +obj-$(CONFIG_SND_EP93XX_SOC_I2S) ? ? ? ? ? ? ? += snd-soc-ep93xx-i2s.o

> Any reason not to just do:

> obj-$(CONFIG_SND_EP93XX_SOC) ? ? ? ? ? ? ? ? ? += ep93xx-pcm.o

> instead of indirection through a separate .o file? I'm no Makefile
> master, so there may be a real reason I'm unaware of.

This renaming of the object is idiomatic for ASoC.

> > + ? ? ? struct clk ? ? ? ? ? ? ? ? ? ? ?*i2s_clk;
> > + ? ? ? struct ep93xx_pcm_dma_params ? ?*dma_params[2];
> > + ? ? ? struct resource ? ? ? ? ? ? ? ? *mem;
> > + ? ? ? void __iomem ? ? ? ? ? ? ? ? ? ?*regs;
> > +};

> These defines and struct definitions should be in a header file,
> probably ep93xx-i2s.h.

Having them in the source file is fine from an ASoC point of view if
they're only referenced here but either way is fine.

> > + ? ? ? if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> > + ? ? ? ? ? ? ? ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
> > + ? ? ? else
> > + ? ? ? ? ? ? ? ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);

> The conditional is unnecessary here.

...or possibly (from the register name) indicates that the second one
should be _RXWRDLEN?  If the configuration is the same for both TX and
RX then the DAI should have the symmetric_rates flag set.
