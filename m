From: hias@horus.com (Matthias Reichl)
Date: Tue, 26 Apr 2016 20:05:43 +0200
Subject: [alsa-devel] [PATCH 3/3] ASoC: bcm2835: Register also as PCM
 device
In-Reply-To: <571F89A4.6070008@metafoo.de>
References: <1461591580-7565-1-git-send-email-kernel@martin.sperl.org>
 <1461591580-7565-3-git-send-email-kernel@martin.sperl.org>
 <571E218A.7050508@metafoo.de> <20160425171515.GA10952@camel2.lan>
 <571F2B09.1000107@metafoo.de> <20160426130914.GA2015@delle.lan>
 <571F6B95.1000709@metafoo.de> <20160426151841.GA5433@camel2.lan>
 <571F89A4.6070008@metafoo.de>
Message-ID: <20160426180542.GA767@camel2.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 05:30:44PM +0200, Lars-Peter Clausen wrote:
> On 04/26/2016 05:18 PM, Matthias Reichl wrote:
> > On Tue, Apr 26, 2016 at 03:22:29PM +0200, Lars-Peter Clausen wrote:
> >> On 04/26/2016 03:09 PM, Matthias Reichl wrote:
> >>> Hi Lars,
> >>>
> >>> first of all thanks a lot for your detailled feedback!
> >>>
> >>> On Tue, Apr 26, 2016 at 10:47:05AM +0200, Lars-Peter Clausen wrote:
> >>>>>>> +	.periods_min		= 2,
> >>>>>>> +	.periods_max		= 255,
> >>>>>>> +	.buffer_bytes_max	= 128 * PAGE_SIZE,
> >>>>>>> +};
> >>>>>>> +
> >>>>>>> +static const struct snd_dmaengine_pcm_config bcm2835_dmaengine_pcm_config = {
> >>>>>>> +	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
> >>>>>>> +	.pcm_hardware = &bcm2835_pcm_hardware,
> >>>>>>> +	.prealloc_buffer_size = 256 * PAGE_SIZE,
> >>>>>>> +};
> >>>>>>
> >>>>>> The generic dmaengine PCM driver auto-discovers these things, no need to
> >>>>>> provide them. The code is OK as it is.
> >>>>>
> >>>>> With the auto-discover code we loose the S16_LE format.
> >>>>>
> >>>>> If I understood the code in dmaengine_pcm_set_runtime_hwparams
> >>>>> correctly, this is because the DMA controller doesn't support
> >>>>> 16bit transfers (only multiples of 32bit are allowed).
> >>>>>
> >>>>> But since the I2S driver needs exactly 2 channels S16_LE actually
> >>>>> works fine (one 32bit transfer per frame).
> >>>>>
> >>>>> Do you know of a better way to get S16_LE support? It could well
> >>>>> be that I missed something important...
> >>>>
> >>>> With your patch we should just get an error when trying to configure a
> >>>> stream with 16-bit samples since when setting up the DMA controller the
> >>>> generic code will still choose a 16-bit device port size and this will be
> >>>> rejected by the DMA controller.
> >>>
> >>> We had that code in downstream RPi kernel for ages (IIRC since
> >>> 3.10) and so far it worked fine.
> >>>
> >>> I traced the code for the S16_LE case to find out why:
> >>>
> >>> snd_hwparams_to_dma_slave_config() sets src/dst_addr_width to 16bit.
> >>>
> >>> But immediately afterwards snd_dmaengine_pcm_set_config_from_dai_data()
> >>> overrides addr_width to 32bit.
> >>>
> >>
> >> Ok, makes sense.
> >>
> >>> bcm2835-i2s only supports 32bit access to the FIFO/data register
> >>> and dma_data.addr_width is set to 32bit in the I2S driver - that
> >>> code is also in mainline since the initial bcm2835-i2s commit.
> >>>
> >>> Of course all this only works because the number of channels
> >>> is always 2.
> >>>
> >>>> When you look at peripherals that have DMA support there are basically two
> >>>> types.
> >>>>
> >>>> Type A expect that each write (same applies for read) to the memory mapped
> >>>> FIFO corresponds to exactly one sample. So if the sample width is 16-bit a
> >>>> 16-bit write is done, if the sample width is 32-bit a 32-bit write is done.
> >>>> In this case it is up to the DMA controller to fragment the byte stream into
> >>>> individual samples.
> >>>>
> >>>> Type B on the other hand has a fixed port width (usually the bus size) and
> >>>> expects that each write to the memory mapped FIFO uses the port width. It
> >>>> then internally unpacks the data into the sample data. E.g. if the FIFO is
> >>>> 32-bit wide and the sample width is 16-bit it will unpack the 32-bit entry
> >>>> into two samples.
> >>>>
> >>>> Currently the generic code only supports type A. It would be great if you
> >>>> could add support for type B to support the BCM2835 I2S controller properly.
> >>>
> >>> Do you have a particular solution in mind?
> >>>
> >>> Introducing a flag to just auto-add some packed formats would be
> >>> easy, but a generic, robust solution might be tricky. We'd have
> >>> to make sure that unsupported configurations (like an odd number
> >>> of 16bit channels on 32bit-only setups) get rejected or we might
> >>> be in trouble.
> >>
> >> I think in this case the DMA shouldn't limit the supported sample types.
> >> Since the unpacking is done by the peripheral the peripheral is the one
> >> component that limits what is supported and what is not and the DMA itself
> >> has no influence on this. In the peripheral driver you have all the
> >> information available there to specify the proper constraints and can handle
> >> all the corner cases.
> > 
> > Do you mean let the DAI driver check for and reject invalid
> > configurations in hw_params? Yes, I think that should do it.
> 
> The DAI driver already specifies which formats it can handle, just keep that
> as it is. The ALSA core takes care of rejecting invalid configurations, so
> need to do anything special in hw_params.

I was thinking about the odd corner cases which might not be caught
by the ALSA core. Like packed single channel transfers with an
odd period length. Not sure if there are any devices out there
that support such things, but you never know :)

For bcm2835-i2s it's no problem at all, it'll work fine without
any changes to hw_params.

> >> The overall constraints are the intersection of the
> >> DMA and peripheral constraints, so by having no DMA constraints the
> >> peripheral is the one providing all the constraints.
> >>
> >> We could either say that we assume that when the addr_width is fixed the DMA
> >> shouldn't supply any constraints, or we could introduce a new flag in
> >> snd_dmaengine_dai_dma_data that the peripheral has unpack support and the
> >> DMA constraints don't matter.
> > 
> > The additional flag sounds like a good idea. How about something
> > like the patch below?
> > 
> > If the ...PACK_16_32 flag is set, 16-bit data will always be
> > packed into 32bit and 32bit DMA is done instead of 16bit.
> > No further checks are done.
> 
> You don't need to be specific about what kind of unpack the the peripheral
> supports. If it supports unpacking it is in charge of what formats can be
> supported.
> 
> [...]
> >  void snd_dmaengine_pcm_set_config_from_dai_data(
> > diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
> > index fba365a..a429f94 100644
> > --- a/sound/core/pcm_dmaengine.c
> > +++ b/sound/core/pcm_dmaengine.c
> > @@ -117,11 +117,21 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
> >  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >  		slave_config->dst_addr = dma_data->addr;
> >  		slave_config->dst_maxburst = dma_data->maxburst;
> > +		if ((slave_config->dst_addr_width ==
> > +		     DMA_SLAVE_BUSWIDTH_2_BYTES) &&
> > +		    (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK_16_32))
> > +			slave_config->dst_addr_width =
> > +				DMA_SLAVE_BUSWIDTH_4_BYTES;
> 
> If the PACK flag is set we should set the width to UNKOWN, that means the
> DMA controller is free to choose whatever width it things is most efficient.
> If the port has a fixed width it will be overwritten later as you described
> in the earlier mail.
> 
> [...]
> > diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
> > index 6fd1906..25552c2 100644
> > --- a/sound/soc/soc-generic-dmaengine-pcm.c
> > +++ b/sound/soc/soc-generic-dmaengine-pcm.c
> > @@ -173,6 +173,11 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
> 
> In this function when the flag is set just skip this step altogether and set
> hw->formats. That means the DMA does not restrict the sample formats that
> are supported.
> 
> >  	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
> >  		int bits = snd_pcm_format_physical_width(i);
> >  
> > +		if ((bits == 16) &&
> > +		    (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK_16_32))
> > +			/* 16-bit data needs to be packed into 32bit */
> > +			bits = 32;
> > +
> >  		/* Enable only samples with DMA supported physical widths */
> >  		switch (bits) {
> >  		case 8:
> > 
> 

Ok, I think I got you now and I have to say that solution is really elegant.
I wouldn't have thought that it could be that simple. V2 of the patch
is below.

so long,

Hias

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index f86ef5e..67be244 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -51,6 +51,16 @@ struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
 	void *filter_data);
 struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream);
 
+/*
+ * The DAI supports packed transfers, eg 2 16-bit samples in a 32-bit word.
+ * If this flag is set the dmaengine driver won't put any restriction on
+ * the supported sample formats and set the DMA transfer size to undefined.
+ * The DAI driver is responsible to disable any unsupported formats in it's
+ * configuration and catch corner cases that are not already handled in
+ * the ALSA core.
+ */
+#define SND_DMAENGINE_PCM_DAI_FLAG_PACK BIT(0)
+
 /**
  * struct snd_dmaengine_dai_dma_data - DAI DMA configuration data
  * @addr: Address of the DAI data source or destination register.
@@ -63,6 +73,7 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * requesting the DMA channel.
  * @chan_name: Custom channel name to use when requesting DMA channel.
  * @fifo_size: FIFO size of the DAI controller in bytes
+ * @flags: PCM_DAI flags, only SND_DMAENGINE_PCM_DAI_FLAG_PACK for now
  */
 struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
@@ -72,6 +83,7 @@ struct snd_dmaengine_dai_dma_data {
 	void *filter_data;
 	const char *chan_name;
 	unsigned int fifo_size;
+	unsigned int flags;
 };
 
 void snd_dmaengine_pcm_set_config_from_dai_data(
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index fba365a..c6519ca 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -106,8 +106,9 @@ EXPORT_SYMBOL_GPL(snd_hwparams_to_dma_slave_config);
  * direction of the substream. If the substream is a playback stream the dst
  * fields will be initialized, if it is a capture stream the src fields will be
  * initialized. The {dst,src}_addr_width field will only be initialized if the
- * addr_width field of the DAI DMA data struct is not equal to
- * DMA_SLAVE_BUSWIDTH_UNDEFINED.
+ * SND_DMAENGINE_PCM_DAI_FLAG_PACK flag is set or if the addr_width field of
+ * the DAI DMA data struct is not equal to DMA_SLAVE_BUSWIDTH_UNDEFINED. If
+ * both conditions are met the latter takes priority.
  */
 void snd_dmaengine_pcm_set_config_from_dai_data(
 	const struct snd_pcm_substream *substream,
@@ -117,11 +118,17 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		slave_config->dst_addr = dma_data->addr;
 		slave_config->dst_maxburst = dma_data->maxburst;
+		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
+			slave_config->dst_addr_width =
+				DMA_SLAVE_BUSWIDTH_UNDEFINED;
 		if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			slave_config->dst_addr_width = dma_data->addr_width;
 	} else {
 		slave_config->src_addr = dma_data->addr;
 		slave_config->src_maxburst = dma_data->maxburst;
+		if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
+			slave_config->src_addr_width =
+				DMA_SLAVE_BUSWIDTH_UNDEFINED;
 		if (dma_data->addr_width != DMA_SLAVE_BUSWIDTH_UNDEFINED)
 			slave_config->src_addr_width = dma_data->addr_width;
 	}
diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index c413973..68c8e524 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -887,6 +887,15 @@ static int bcm2835_i2s_probe(struct platform_device *pdev)
 	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].maxburst = 2;
 	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].maxburst = 2;
 
+	/*
+	 * Set the PACK flag to enable S16_LE support (2 S16_LE values
+	 * packed into 32-bit transfers).
+	 */
+	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].flags =
+		SND_DMAENGINE_PCM_DAI_FLAG_PACK;
+
 	/* BCLK ratio - use default */
 	dev->bclk_ratio = 0;
 
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6fd1906..30d3b2a 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -162,32 +162,44 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 			addr_widths = dma_caps.src_addr_widths;
 	}
 
-	/*
-	 * Prepare formats mask for valid/allowed sample types. If the dma does
-	 * not have support for the given physical word size, it needs to be
-	 * masked out so user space can not use the format which produces
-	 * corrupted audio.
-	 * In case the dma driver does not implement the slave_caps the default
-	 * assumption is that it supports 1, 2 and 4 bytes widths.
-	 */
-	for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
-		int bits = snd_pcm_format_physical_width(i);
-
-		/* Enable only samples with DMA supported physical widths */
-		switch (bits) {
-		case 8:
-		case 16:
-		case 24:
-		case 32:
-		case 64:
-			if (addr_widths & (1 << (bits / 8)))
-				hw.formats |= (1LL << i);
-			break;
-		default:
-			/* Unsupported types */
-			break;
+	if (dma_data->flags & SND_DMAENGINE_PCM_DAI_FLAG_PACK)
+		/*
+		 * Don't put a restriction on supported formats.
+		 * It's the responsibility of the DAI driver to provide the
+		 * supported format information.
+		 */
+		hw.formats = GENMASK_ULL((int)SNDRV_PCM_FORMAT_LAST-1, 0);
+	else
+		/*
+		 * Prepare formats mask for valid/allowed sample types. If the
+		 * dma does not have support for the given physical word size,
+		 * it needs to be masked out so user space can not use the
+		 * format which produces corrupted audio.
+		 * In case the dma driver does not implement the slave_caps the
+		 * default assumption is that it supports 1, 2 and 4 bytes
+		 * widths.
+		 */
+		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+			int bits = snd_pcm_format_physical_width(i);
+
+			/*
+			 * Enable only samples with DMA supported physical
+			 * widths
+			 */
+			switch (bits) {
+			case 8:
+			case 16:
+			case 24:
+			case 32:
+			case 64:
+				if (addr_widths & (1 << (bits / 8)))
+					hw.formats |= (1LL << i);
+				break;
+			default:
+				/* Unsupported types */
+				break;
+			}
 		}
-	}
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
