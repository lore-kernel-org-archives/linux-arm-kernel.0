From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jun 2016 16:54:27 +0100
Subject: [alsa-devel] [PATCH v2 2/9] ASoC: mediatek: implement mediatek
 common structure
In-Reply-To: <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
References: <1464929784-5489-1-git-send-email-garlic.tseng@mediatek.com>
 <1464929784-5489-3-git-send-email-garlic.tseng@mediatek.com>
Message-ID: <20160607155427.GB7510@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 12:56:17PM +0800, Garlic Tseng wrote:

> +	/*enable agent*/

Lots of comments with missing spaces in them, there's quite a few
examples of that in here.

> +EXPORT_SYMBOL(mtk_afe_fe_startup);

All the ASoC and regmap APIs are _GPL(), you really shouldn't export new
interfaces based on them without it - the point with the _GPL() is that
non-GPL code shouldn't be able to use the APIs.

> +EXPORT_SYMBOL(mtk_afe_fe_hw_params);

Do you need to export the individual ops rather than just the ops
structure?

> +int mtk_afe_fe_trigger(struct snd_pcm_substream *substream, int cmd,
> +		       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_pcm_runtime * const runtime = substream->runtime;
> +	struct mtk_base_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
> +	struct mtk_base_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
> +	struct mtk_base_afe_irq *irqs = &afe->irqs[memif->irq_usage];
> +	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
> +	unsigned int counter = runtime->period_size;
> +	int fs;
> +
> +	dev_info(afe->dev, "%s %s cmd=%d\n", __func__, memif->data->name, cmd);

That's way too noisy, dev_dbg() at most.

> +static DEFINE_MUTEX(irqs_lock);
> +int mtk_dynamic_irq_acquire(struct mtk_base_afe *afe)
> +{
> +	int i;
> +
> +	mutex_lock(&irqs_lock);
> +	for (i = 0; i < afe->irqs_size; ++i) {

Why is the lock global and not part of the AFE struct?

> +void mtk_simple_isr(struct mtk_base_afe *afe, struct mtk_base_afe_memif *memif)
> +{
> +	snd_pcm_period_elapsed(memif->substream);
> +}
> +EXPORT_SYMBOL(mtk_simple_isr);

Is this really worth it over just calling _period_elapsed() directly?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160607/82eeab5e/attachment.sig>
