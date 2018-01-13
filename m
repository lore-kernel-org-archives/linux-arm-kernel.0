From: rohitkr@codeaurora.org (Rohit Kumar)
Date: Sat, 13 Jan 2018 14:15:54 +0530
Subject: [alsa-devel] [RESEND PATCH v2 12/15] ASoC: qcom: qdsp6: Add
 support to q6asm dai driver
In-Reply-To: <20171214173402.19074-13-srinivas.kandagatla@linaro.org>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-13-srinivas.kandagatla@linaro.org>
Message-ID: <15c0e6ac-2772-112e-c79b-4263234b13b2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/14/2017 11:03 PM, srinivas.kandagatla at linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to q6asm dai driver which configures Q6ASM streams
> to pass pcm data.
> Currently the driver only exposes 2 playback streams for hdmi playback
> support, it can be easily extended to add all 8 streams.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   sound/soc/qcom/Kconfig           |   6 +
>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>   sound/soc/qcom/qdsp6/q6asm-dai.c | 534 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 541 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm-dai.c
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 003ce182691c..ecd1e4ba834d 100644
> --- a/sound/soc/qcom/Kconfig
[..]
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
Add support for V2 version of opcode to support latest adsp
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
> +	if (ret < 0)
> +		pr_info("%s: CMD Format block failed\n", __func__);
> +
> +	prtd->state = RUNNING;
> +
> +	return 0;
> +}
> +
> +static int q6asm_dai_trigger(struct snd_pcm_substream *substream, int cmd)
> +{
> +	int ret = 0;
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
> +		break;
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
> +		break;
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		prtd->state = STOPPED;
> +		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
> +		break;
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int q6asm_dai_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
> +	struct q6asm_dai_rtd *prtd;
> +	struct q6asm_dai_data *pdata;
> +	struct device *dev = soc_prtd->platform->dev;
> +	int ret = 0;
> +
> +	pdata = dev_get_drvdata(dev);
> +	if (!pdata) {
> +		pr_err("Platform data not found ..\n");
> +		return -EINVAL;
> +	}
> +
> +	prtd = kzalloc(sizeof(struct q6asm_dai_rtd), GFP_KERNEL);
> +	if (prtd == NULL)
> +		return -ENOMEM;
> +
> +	prtd->substream = substream;
> +	prtd->audio_client = q6asm_audio_client_alloc(dev,
> +				(app_cb)event_handler, prtd);
> +	if (!prtd->audio_client) {
> +		pr_info("%s: Could not allocate memory\n", __func__);
> +		kfree(prtd);
> +		return -ENOMEM;
> +	}
> +
> +//	prtd->audio_client->dev = dev;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		runtime->hw = q6asm_dai_hardware_playback;
> +
> +	ret = snd_pcm_hw_constraint_list(runtime, 0,
> +				SNDRV_PCM_HW_PARAM_RATE,
> +				&constraints_sample_rates);
> +	if (ret < 0)
> +		pr_info("snd_pcm_hw_constraint_list failed\n");
> +	/* Ensure that buffer size is a multiple of period size */
> +	ret = snd_pcm_hw_constraint_integer(runtime,
> +					    SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		pr_info("snd_pcm_hw_constraint_integer failed\n");
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		ret = snd_pcm_hw_constraint_minmax(runtime,
> +			SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
> +			PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE,
> +			PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE);
> +		if (ret < 0) {
> +			pr_err("constraint for buffer bytes min max ret = %d\n",
> +									ret);
> +		}
> +	}
> +
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
> +	if (ret < 0) {
> +		pr_err("constraint for period bytes step ret = %d\n",
> +								ret);
> +	}
> +	ret = snd_pcm_hw_constraint_step(runtime, 0,
> +		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
> +	if (ret < 0) {
> +		pr_err("constraint for buffer bytes step ret = %d\n",
> +								ret);
> +	}
> +
> +	prtd->set_channel_map = false;
> +	runtime->private_data = prtd;
> +
> +	snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_playback);
> +
> +	runtime->dma_bytes = q6asm_dai_hardware_playback.buffer_bytes_max;
> +
> +
> +	if (pdata->sid < 0)
> +		prtd->phys = substream->dma_buffer.addr;
> +	else
> +		prtd->phys = substream->dma_buffer.addr | (pdata->sid << 32);
> +
> +	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
> +
> +	return 0;
> +}
> +
> +static int q6asm_dai_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +
> +	if (prtd->audio_client) {
> +		q6asm_cmd(prtd->audio_client, CMD_CLOSE);
> +		q6asm_unmap_memory_regions(substream->stream,
> +					   prtd->audio_client);
> +		q6asm_audio_client_free(prtd->audio_client);
> +	}
> +	q6routing_dereg_phy_stream(soc_prtd->dai_link->id,
> +						SNDRV_PCM_STREAM_PLAYBACK);
> +	kfree(prtd);
> +	return 0;
> +}
> +
> +static snd_pcm_uframes_t q6asm_dai_pointer(struct snd_pcm_substream *substream)
> +{
> +
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +
> +	if (prtd->pcm_irq_pos >= prtd->pcm_size)
> +		prtd->pcm_irq_pos = 0;
> +
> +	return bytes_to_frames(runtime, (prtd->pcm_irq_pos));
> +}
> +
> +static int q6asm_dai_mmap(struct snd_pcm_substream *substream,
> +				struct vm_area_struct *vma)
> +{
> +
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
> +	struct snd_card *card = soc_prtd->card->snd_card;
> +
> +	return dma_mmap_coherent(card->dev, vma,
> +			runtime->dma_area, runtime->dma_addr,
> +			runtime->dma_bytes);
> +}
> +
> +static int q6asm_dai_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct q6asm_dai_rtd *prtd = runtime->private_data;
> +
> +	prtd->pcm_size = params_buffer_bytes(params);
> +	prtd->periods = params_periods(params);
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		prtd->bits_per_sample = 16;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		prtd->bits_per_sample = 24;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_pcm_ops q6asm_dai_ops = {
> +	.open           = q6asm_dai_open,
> +	.hw_params	= q6asm_dai_hw_params,
> +	.close          = q6asm_dai_close,
> +	.ioctl          = snd_pcm_lib_ioctl,
> +	.prepare        = q6asm_dai_prepare,
> +	.trigger        = q6asm_dai_trigger,
> +	.pointer        = q6asm_dai_pointer,
> +	.mmap		= q6asm_dai_mmap,
> +};
> +
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
> +
> +
> +	substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
> +	size = q6asm_dai_hardware_playback.buffer_bytes_max;
> +	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
> +				  &substream->dma_buffer);
> +	if (ret) {
> +		dev_err(dev, "Cannot allocate buffer(s)\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
> +{
> +	struct snd_pcm_substream *substream;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
> +		substream = pcm->streams[i].substream;
> +		if (substream) {
> +			snd_dma_free_pages(&substream->dma_buffer);
> +			substream->dma_buffer.area = NULL;
> +			substream->dma_buffer.addr = 0;
> +		}
> +	}
> +}
> +
> +static struct snd_soc_platform_driver q6asm_soc_platform = {
> +	.ops		= &q6asm_dai_ops,
> +	.pcm_new	= q6asm_dai_pcm_new,
> +	.pcm_free	= q6asm_dai_pcm_free,
> +
> +};
> +
> +static const struct snd_soc_dapm_route afe_pcm_routes[] = {
> +	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
> +	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
> +
> +};
> +
> +static int fe_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_dapm_context *dapm;
> +
> +	dapm = snd_soc_component_get_dapm(dai->component);
> +	snd_soc_dapm_add_routes(dapm, afe_pcm_routes,
> +				ARRAY_SIZE(afe_pcm_routes));
> +
> +	return 0;
> +}
> +
> +static const struct snd_soc_component_driver q6asm_fe_dai_component = {
> +	.name		= "q6asm-fe-dai",
> +};
> +
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
> +		},
> +		.name = "MM_DL2",
> +		.probe = fe_dai_probe,
> +		.id = MSM_FRONTEND_DAI_MULTIMEDIA2,
> +	},
> +};
> +
> +static int q6asm_dai_probe(struct platform_device *pdev)
> +{
> +	struct q6asm_dai_data *pdata;
> +	struct device *dev = &pdev->dev;
> +	int rc;
> +
> +	pdata = devm_kzalloc(dev, sizeof(struct q6asm_dai_data), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +
> +	dev_set_drvdata(dev, pdata);
> +
> +	rc = snd_soc_register_platform(dev,  &q6asm_soc_platform);
> +	if (rc) {
> +		dev_err(&pdev->dev, "err_dai_platform\n");
> +		return rc;
> +	}
> +
> +	rc = snd_soc_register_component(dev, &q6asm_fe_dai_component,
> +					q6asm_fe_dais,
> +					ARRAY_SIZE(q6asm_fe_dais));
> +	if (rc)
> +		dev_err(dev, "err_dai_component\n");
> +
> +	return rc;
> +
> +}
> +
> +static int q6asm_dai_remove(struct platform_device *pdev)
> +{
> +	snd_soc_unregister_platform(&pdev->dev);
> +	return 0;
> +}
> +
> +static struct platform_driver q6asm_dai_driver = {
> +	.driver = {
> +		.name = "q6asm_dai",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = q6asm_dai_probe,
> +	.remove = q6asm_dai_remove,
> +};
> +
> +module_platform_driver(q6asm_dai_driver);
> +
> +MODULE_DESCRIPTION("PCM module platform driver");
> +MODULE_LICENSE("GPL v2");
