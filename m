From: garlic.tseng@mediatek.com (Garlic Tseng)
Date: Wed, 8 Jun 2016 10:06:12 +0800
Subject: [alsa-devel] [PATCH v2 2/9] ASoC: mediatek: implement mediatek
 common structure
In-Reply-To: <20160607155427.GB7510@sirena.org.uk>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
 <20160607155427.GB7510@sirena.org.uk>
Message-ID: <1465351572.4197.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, thank for comment.

On Tue, 2016-06-07 at 16:54 +0100, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 12:56:17PM +0800, Garlic Tseng wrote:
> 
> > +	/*enable agent*/
> 
> Lots of comments with missing spaces in them, there's quite a few
> examples of that in here.

I'll check all the code and fix them. 

> 
> > +EXPORT_SYMBOL(mtk_afe_fe_startup);
> 
> All the ASoC and regmap APIs are _GPL(), you really shouldn't export new
> interfaces based on them without it - the point with the _GPL() is that
> non-GPL code shouldn't be able to use the APIs.

Thanks for comment, I'll fix them.


> 
> > +EXPORT_SYMBOL(mtk_afe_fe_hw_params);
> 
> Do you need to export the individual ops rather than just the ops
> structure?
> 

Yes, in 2701 driver we modify some ops.


+/* FE DAIs */
+static const struct snd_soc_dai_ops mt2701_single_memif_dai_ops = {
+	.startup	= mt2701_simple_fe_startup,
+	.shutdown	= mtk_afe_fe_shutdown,
+	.hw_params	= mt2701_simple_fe_hw_params,
+	.hw_free	= mtk_afe_fe_hw_free,
+	.prepare	= mtk_afe_fe_prepare,
+	.trigger	= mtk_afe_fe_trigger,
+
+};

And here is one of them. Here MT2701 need one more reg control.

+static int mt2701_simple_fe_hw_params(struct snd_pcm_substream
*substream,
+				      struct snd_pcm_hw_params *params,
+				      struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe =
snd_soc_platform_get_drvdata(rtd->platform);
+	int stream_dir = substream->stream;
+
+	/*single DL use PAIR_INTERLEAVE*/
+	if (stream_dir == SNDRV_PCM_STREAM_PLAYBACK) {
+		regmap_update_bits(afe->regmap,
+				   AFE_MEMIF_PBUF_SIZE,
+				   AFE_MEMIF_PBUF_SIZE_DLM_MASK,
+				   AFE_MEMIF_PBUF_SIZE_PAIR_INTERLEAVE);
+	}
+	return mtk_afe_fe_hw_params(substream, params, dai);
+}

MT2701 need some specific reg controls. If the control is
platform-specific I tend not to put them in the common ops structure.


> > +int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
> > +		       struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_pcm_runtime * const runtime = substream->runtime;
> > +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> > +	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
> > +	struct mtk_base_afe_irq *irqs = &afe->irqs[memif->irq_usage];
> > +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> > +	unsigned int counter = runtime->period_size;
> > +	int fs;
> > +
> > +	dev_info(afe->dev, "%s %s cmd=%d\n", __func__, memif->data->name, cmd);
> 
> That's way too noisy, dev_dbg() at most.

OK. I'll fix it.

> > +static DEFINE_MUTEX(irqs_lock);
> > +int mtk_dynamic_irq_acquire(struct mtk_base_afe *afe)
> > +{
> > +	int i;
> > +
> > +	mutex_lock(&irqs_lock);
> > +	for (i = 0; i < afe->irqs_size; ++i) {
> 
> Why is the lock global and not part of the AFE struct?

I'll put it in AFE struct. Thanks.

> 
> > +void mtk_simple_isr(struct mtk_base_afe *afe, struct mtk_base_afe_memif *memif)
> > +{
> > +	snd_pcm_period_elapsed(memif->substream);
> > +}
> > +EXPORT_SYMBOL(mtk_simple_isr);
> 
> Is this really worth it over just calling _period_elapsed() directly?

I'll remove the function and just calling period_elapsed() directly.
