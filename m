From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Jul 2013 17:52:46 +0100
Subject: [PATCH 2/6] ASoC: sirf: add I2S CPU DAI driver
In-Reply-To: <1374232042-26088-3-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-3-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130719165246.GL9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 07:07:18PM +0800, Barry Song wrote:

Pretty good overall - there's a few things below but should all be
fairly small.

> +static int sirf_i2s_startup(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +
> +	if (si2s->master_mode)
> +		pwm_enable(si2s->mclk_pwm);
> +	clk_prepare_enable(si2s->clk);
> +
> +	device_reset(dai->dev);
> +	snd_soc_dai_set_dma_data(dai, substream,
> +		&sirf_i2s_dai_dma_data[substream->stream]);
> +	return 0;
> +}

device_reset() sounds like it's not going to work for simultaneous
playback and capture.

> +static int sirf_i2s_trigger(struct snd_pcm_substream *substream,
> +		int cmd, struct snd_soc_dai *dai)
> +{
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		spin_lock(&si2s->lock);
> +
> +		if (playback) {
> +			/* First start the FIFO, then enable the tx/rx */
> +			writel(AUDIO_FIFO_RESET,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +			mdelay(1);
> +			writel(AUDIO_FIFO_START,
> +				si2s->base + AUDIO_CTRL_EXT_TXFIFO1_OP);
> +			mdelay(1);

Do we really need these 1ms delays?  They're very long for the
context...

> +static int sirf_i2s_prepare(struct snd_pcm_substream *substream,
> +			struct snd_soc_dai *dai)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct sirf_i2s *si2s = snd_soc_dai_get_drvdata(dai);
> +	u32 ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +
> +	if (runtime->channels == 2)
> +		ctrl &= ~I2S_SIX_CHANNELS;
> +	else
> +		ctrl |= I2S_SIX_CHANNELS;

A switch statement for the number of channels would make me happier
here.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		ctrl = readl(si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		ctrl |= I2S_SLAVE_MODE;
> +		writel(ctrl, si2s->base + AUDIO_CTRL_I2S_CTRL);
> +		si2s->master_mode = 0;
> +		break;

Do we need locking on all these register updates?

> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		si2s->master_mode = 1;
> +		return -EINVAL;

Should this be undoing the work done for _CBM_CFM?

> +#ifdef CONFIG_PM
> +static int sirf_i2s_suspend(struct platform_device *pdev,
> +		pm_message_t state)
> +{
> +	struct sirf_i2s *si2s = platform_get_drvdata(pdev);
> +
> +	si2s->i2s_ctrl = readl(si2s->base+AUDIO_CTRL_I2S_CTRL);
> +
> +	clk_disable_unprepare(si2s->clk);
> +
> +	if (si2s->master_mode)
> +		pwm_disable(si2s->mclk_pwm);
> +	return 0;
> +}

Should these be runtime PM calls as well?  Seems like the bus could be
unclocked whenever audio is not playing.  If you need the clock to write
conifguraiton perhaps regmap-mmio could help?

> +	spin_lock_init(&si2s->lock);

What is this lock actually protecting?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/727ea2f8/attachment.sig>
