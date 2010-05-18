From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 19 May 2010 09:21:51 +1200
Subject: [RFC PATCH 1/3] ep93xx i2s driver
In-Reply-To: <AANLkTin0bJ_b9_BEcZzdkwtl8zBQV6bDRpdx8QSLcR1R@mail.gmail.com>
References: <4BF21B67.8090404@bluewatersys.com>	
	<4BF21D48.3020005@bluewatersys.com>
	<AANLkTin0bJ_b9_BEcZzdkwtl8zBQV6bDRpdx8QSLcR1R@mail.gmail.com>
Message-ID: <4BF304EF.2020801@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chase Douglas wrote:
> On Tue, May 18, 2010 at 12:53 AM, Ryan Mallon <ryan@bluewatersys.com> wrote:
>> Add ep93xx i2s audio driver
>>
>> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
>> ---

>> diff --git a/sound/soc/ep93xx/Kconfig b/sound/soc/ep93xx/Kconfig
>> new file mode 100644
>> index 0000000..6af5dd8
>> --- /dev/null
>> +++ b/sound/soc/ep93xx/Kconfig
>> @@ -0,0 +1,15 @@
>> +config SND_EP93XX_SOC
>> +       tristate "SoC Audio support for the Cirrus Logic EP93xx series"
>> +       depends on ARCH_EP93XX && SND_SOC
>> +       help
>> +         Say Y or M if you want to add support for codecs attached to
>> +         the EP93xx I2S interface.
>> +
>> +config SND_EP93XX_SOC_I2S
>> +       tristate
>> +
>> +config SND_EP93XX_SOC_SNAPPERCL15
>> +        tristate "SoC Audio support for Bluewater Systems Snapper CL15 module"
>> +        depends on SND_EP93XX_SOC && MACH_SNAPPER_CL15
>> +        select SND_EP93XX_SOC_I2S
>> +        select SND_SOC_TLV320AIC23
> 
> This last config should be in patch 3/3 instead of this patch.

Yeah, I generated the patches in a bit of a hurry :-)

>> diff --git a/sound/soc/ep93xx/Makefile b/sound/soc/ep93xx/Makefile
>> new file mode 100644
>> index 0000000..272e60f
>> --- /dev/null
>> +++ b/sound/soc/ep93xx/Makefile
>> @@ -0,0 +1,11 @@
>> +# EP93xx Platform Support
>> +snd-soc-ep93xx-objs                            := ep93xx-pcm.o
>> +snd-soc-ep93xx-i2s-objs                                := ep93xx-i2s.o
>> +
>> +obj-$(CONFIG_SND_EP93XX_SOC)                   += snd-soc-ep93xx.o
>> +obj-$(CONFIG_SND_EP93XX_SOC_I2S)               += snd-soc-ep93xx-i2s.o
> 
> Any reason not to just do:
> 
> obj-$(CONFIG_SND_EP93XX_SOC)                   += ep93xx-pcm.o
> 
> instead of indirection through a separate .o file? I'm no Makefile
> master, so there may be a real reason I'm unaware of.

The alsa soc object files are all done this way so that they get
prefixed with snd-soc-

>> + *
>> + * Based on the original driver by:
>> + *   Copyright (C) 2007 Chase Douglas <chasedouglas@gmail>
> 
> Please use my full email "chasedouglas at gmail.com".

Will do, thanks.

>> +#define EP93XX_I2S_CLKCFG_LRS          (1 << 0) /* lrclk polarity */
>> +#define EP93XX_I2S_CLKCFG_CKP          (1 << 1) /* Bit clock polarity */
>> +#define EP93XX_I2S_CLKCFG_REL          (1 << 2) /*  */
>> +#define EP93XX_I2S_CLKCFG_MASTER       (1 << 3) /* Master mode */
>> +#define EP93XX_I2S_CLKCFG_NBCG         (1 << 4) /* Not bit clock gating */
>> +
>> +struct ep93xx_i2s_info {
>> +       struct clk                      *i2s_clk;
>> +       struct ep93xx_pcm_dma_params    *dma_params[2];
>> +       struct resource                 *mem;
>> +       void __iomem                    *regs;
>> +};
> 
> These defines and struct definitions should be in a header file,
> probably ep93xx-i2s.h.

I would much rather leave them here since they are only required by this
file. The ep93xx-i2s.h header should only include the public interface
to the i2s driver.

> I think the struct name should be something like ep93xx_i2s_priv.
> *_info is very vague, but *_priv tells us it's passed around as an
> opaque structure filled with device specific data.

I think info is fine, it should be relatively clear what it is used for.

>> +
>> +static int ep93xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>> +                             struct snd_soc_dai *dai)
>> +{
>> +       return 0;
>> +}
> 
> Unless there's a platform or cpu trigger function, this function is
> unnecesssary. See soc_pcm_trigger in sound/soc/soc-core.c.

Fixed.

>> +
>> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
>> +       else
>> +               ep93xx_i2s_write_reg(info, EP93XX_I2S_TXWRDLEN, word_len);
> 
> The conditional is unnecessary here.

Oops, this is a cut and paste bug. The else case should write to the
EP93XX_I2S_RXWRDLEN register instead. However, the EP93xx users' guide
says that if the tx and rx channels are both in master mode then
txclkcfg is used for both and the word length for both must be the same.
 Possibly we should just write the word length for both here.

>> +static int ep93xx_i2s_set_clkdiv(struct snd_soc_dai *cpu_dai, int div_id,
>> +                                int div)
>> +{
>> +       unsigned val;
>> +
>> +       /*
>> +        * The LRDIV (frame clock) and SDIV (bit clock) controls are in the
>> +        * EP93XX_SYSCON_I2SCLKDIV register, which is also used by clock.c
>> +        * to set the I2S master clock.
>> +        *
>> +        * FIXME - This functions is potentially racy with the clock api for
>> +        * the I2S master clock. Its also ugly modifying the syscon registers
>> +        * here.
> 
> Yeah, this is ugly, but if there's a potential race condition can we
> put a mutex in there?

The problem is that it races with code inside
arch/arm/mach-ep93xx/clock.c so it would need to be an exported mutex,
which is just as ugly. I think I will end up going with Hartley's/Mark's
idea to use the clock api for this.

>> +
>> +#define EP93XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
>> +                           SNDRV_PCM_FMTBIT_S24_LE | \
>> +                           SNDRV_PCM_FMTBIT_S32_LE)
> 
> I'd either move this to be just above its usage, or in a header file.
> Right here it's an island of its own.

Okay, moved it down a few lines so it is just aboce ep93xx_i2s_dai.

>> diff --git a/sound/soc/ep93xx/ep93xx-i2s.h b/sound/soc/ep93xx/ep93xx-i2s.h
>> new file mode 100644
>> index 0000000..37e6370
>> --- /dev/null
>> +++ b/sound/soc/ep93xx/ep93xx-i2s.h
> 
> It's my opinion that every file, unless really really trivial, should
> have a license header. I suggest adding one here.

Okay, will fix.

>> +
>> +struct ep93xx_runtime_data
>> +{
>> +       struct ep93xx_dma_m2p_client    cl;
>> +       struct ep93xx_pcm_dma_params    *params;
>> +       int                             pointer_bytes;
>> +       struct tasklet_struct           period_tasklet;
>> +       int                             periods;
>> +       struct ep93xx_dma_buffer        buf[32];
>> +};
> 
> I'd rather this be named something like "ep93xx_pcm_priv".

Other drivers are using runtime_data, I think it is more descriptive
than priv.

>> +
>> +module_init(ep93xx_soc_platform_init);
>> +module_exit(ep93xx_soc_platform_exit);
>> +
>> +MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
> Lennert may be the original author, but if you're proposing this for
> upstream you probably want to put yourself here. That is, unless
> you've chatted with Lennert about this. It seems presumptuous to get
> code in the kernel and point people to someone else when it breaks :).

Changed it to me, and left Lennert's original copyright in the comment
at the top of the file.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
