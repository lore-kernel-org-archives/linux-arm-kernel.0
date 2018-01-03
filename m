From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 2 Jan 2018 16:03:06 -0800
Subject: [RESEND PATCH v2 12/15] ASoC: qcom: qdsp6: Add support to q6asm
 dai driver
In-Reply-To: <20171214173402.19074-13-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-13-srinivas.kandagatla@linaro.org>
Message-ID: <20180103000306.GT478@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:

[..]
> +
> +enum stream_state {
> +	IDLE = 0,
> +	STOPPED,
> +	RUNNING,

These are too generic.

> +};
> +
> +struct q6asm_dai_rtd {
> +	struct snd_pcm_substream *substream;
> +	dma_addr_t phys;
> +	unsigned int pcm_size;
> +	unsigned int pcm_count;
> +	unsigned int pcm_irq_pos;       /* IRQ position */
> +	unsigned int periods;
> +	uint16_t bits_per_sample;
> +	uint16_t source; /* Encoding source bit mask */
> +
> +	struct audio_client *audio_client;
> +	uint16_t session_id;
> +
> +	enum stream_state state;
> +	bool set_channel_map;
> +	char channel_map[8];

There's a define for this 8

> +};
> +
> +struct q6asm_dai_data {
> +	u64 sid;
> +};
> +
> +static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
> +	.info =                 (SNDRV_PCM_INFO_MMAP |
> +				SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +				SNDRV_PCM_INFO_MMAP_VALID |
> +				SNDRV_PCM_INFO_INTERLEAVED |
> +				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
> +	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
> +				SNDRV_PCM_FMTBIT_S24_LE),
> +	.rates =                SNDRV_PCM_RATE_8000_192000,
> +	.rate_min =             8000,
> +	.rate_max =             192000,
> +	.channels_min =         1,
> +	.channels_max =         8,
> +	.buffer_bytes_max =     (PLAYBACK_MAX_NUM_PERIODS *
> +				PLAYBACK_MAX_PERIOD_SIZE),
> +	.period_bytes_min =	PLAYBACK_MIN_PERIOD_SIZE,
> +	.period_bytes_max =     PLAYBACK_MAX_PERIOD_SIZE,
> +	.periods_min =          PLAYBACK_MIN_NUM_PERIODS,
> +	.periods_max =          PLAYBACK_MAX_NUM_PERIODS,

If you just put the numbers here, instead of using the PLAYBACK_
defines, it's possible to grok the values of this struct without having
to jump to the defines for each one.

> +	.fifo_size =            0,
> +};
> +
> +/* Conventional and unconventional sample rate supported */
> +static unsigned int supported_sample_rates[] = {
> +	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
> +	88200, 96000, 176400, 192000
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_sample_rates = {

This is unreferenced.

> +	.count = ARRAY_SIZE(supported_sample_rates),
> +	.list = supported_sample_rates,
> +	.mask = 0,
> +};
> +
> +static void event_handler(uint32_t opcode, uint32_t token,
> +			  uint32_t *payload, void *priv)
> +{
> +	struct q6asm_dai_rtd *prtd = priv;
> +	struct snd_pcm_substream *substream = prtd->substream;
> +
> +	switch (opcode) {
> +	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
> +		q6asm_write_nolock(prtd->audio_client,
> +				   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +		break;
> +	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
> +		prtd->state = STOPPED;
> +		break;
> +	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
> +		prtd->pcm_irq_pos += prtd->pcm_count;
> +		snd_pcm_period_elapsed(substream);
> +		if (prtd->state == RUNNING)
> +			q6asm_write_nolock(prtd->audio_client,
> +					   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
> +
> +		break;
> +		}
> +	default:
> +		break;
> +	}
> +}
> +
> +static int q6asm_dai_prepare(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +	struct q6asm_dai_data *pdata;
> +	int ret;
> +
> +	pdata = dev_get_drvdata(soc_prtd->platform->dev);
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	if (!prtd || !prtd->audio_client) {
> +		pr_err("%s: private data null or audio client freed\n",
> +			__func__);
> +		return -EINVAL;
> +	}
> +
> +	prtd->pcm_count = snd_pcm_lib_period_bytes(substream);
> +	prtd->pcm_irq_pos = 0;
> +	/* rate and channels are sent to audio driver */
> +	if (prtd->state) {
> +		/* clear the previous setup if any  */
> +		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
> +		q6asm_unmap_memory_regions(substream->stream,
> +					   prtd->audio_client);
> +		q6routing_dereg_phy_stream(soc_prtd->dai_link->id,
> +					 SNDRV_PCM_STREAM_PLAYBACK);
> +	}
> +
> +	ret = q6asm_map_memory_regions(substream->stream, prtd->audio_client,
> +				       prtd->phys,
> +				       (prtd->pcm_size / prtd->periods),
> +				       prtd->periods);
> +
> +	if (ret < 0) {
> +		pr_err("Audio Start: Buffer Allocation failed rc = %d\n",
> +							ret);
> +		return -ENOMEM;
> +	}
> +
> +	ret = q6asm_open_write(prtd->audio_client, FORMAT_LINEAR_PCM,
> +			       prtd->bits_per_sample);
> +	if (ret < 0) {
> +		pr_err("%s: q6asm_open_write failed\n", __func__);
> +		q6asm_audio_client_free(prtd->audio_client);
> +		prtd->audio_client = NULL;

Do you need to roll back the q6asm_map_memory_regions?

> +		return -ENOMEM;
> +	}
> +
> +	prtd->session_id = q6asm_get_session_id(prtd->audio_client);
> +	ret = q6routing_reg_phy_stream(soc_prtd->dai_link->id, LEGACY_PCM_MODE,
> +				      prtd->session_id, substream->stream);
> +	if (ret) {
> +		pr_err("%s: stream reg failed ret:%d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = q6asm_media_format_block_multi_ch_pcm(
> +			prtd->audio_client, runtime->rate,
> +			runtime->channels, !prtd->set_channel_map,
> +			prtd->channel_map, prtd->bits_per_sample);

set_channel_map and channel_map aren't referenced elsewhere. If this
isn't used consider removing it for now.

> +	if (ret < 0)
> +		pr_info("%s: CMD Format block failed\n", __func__);
> +
> +	prtd->state = RUNNING;
> +
> +	return 0;
> +}
> +
[..]
> +static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_pcm *pcm = rtd->pcm;
> +	struct snd_pcm_substream *substream;
> +	struct snd_card *card = rtd->card->snd_card;
> +	struct device *dev = card->dev;
> +	struct device_node *node = dev->of_node;
> +	struct q6asm_dai_data *pdata = dev_get_drvdata(rtd->platform->dev);
> +	struct of_phandle_args args;
> +
> +	int size, ret = 0;
> +
> +	ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
> +	if (ret < 0)
> +		pdata->sid = -1;
> +	else
> +		pdata->sid = args.args[0];
> +

Is this really how you're supposed to deal with the iommu?

> +
> +
> +	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> +	size = q6asm_dai_hardware_playback.buffer_bytes_max;
> +	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> +				  &substream->dma_buffer);
> +	if (ret) {
> +		dev_err(dev, "Cannot allocate buffer(s)\n");
> +		return ret;

Just fall through.

> +	}
> +
> +	return ret;
> +}
> +
[..]
> +static struct snd_soc_dai_driver q6asm_fe_dais[] = {
> +	{
> +		.playback = {
> +			.stream_name = "MultiMedia1 Playback",
> +			.rates = (SNDRV_PCM_RATE_8000_192000|
> +					SNDRV_PCM_RATE_KNOT),
> +			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
> +						SNDRV_PCM_FMTBIT_S24_LE),
> +			.channels_min = 1,
> +			.channels_max = 8,
> +			.rate_min =     8000,
> +			.rate_max =	192000,
> +		},
> +		.name = "MM_DL1",
> +		.probe = fe_dai_probe,
> +		.id = MSM_FRONTEND_DAI_MULTIMEDIA1,
> +	},
> +	{
> +		.playback = {
> +			.stream_name = "MultiMedia2 Playback",
> +			.rates = (SNDRV_PCM_RATE_8000_192000|
> +					SNDRV_PCM_RATE_KNOT),
> +			.formats = (SNDRV_PCM_FMTBIT_S16_LE |
> +						SNDRV_PCM_FMTBIT_S24_LE),
> +			.channels_min = 1,
> +			.channels_max = 8,
> +			.rate_min =     8000,
> +			.rate_max =	192000,

I presume the listed frontend DAIs needs to match the firmware of the
DSP (and features of hardware)? Can we get away with a single list for
all versions of the adsp?

In msm-4.4 the max rate for these where changed to 384000, see:

9c46f74b2724 ("ASoC: msm: add 384KHz playback support")

> +		},
> +		.name = "MM_DL2",
> +		.probe = fe_dai_probe,
> +		.id = MSM_FRONTEND_DAI_MULTIMEDIA2,
> +	},
> +};
> +

Regards,
Bjorn
