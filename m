From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 22 Feb 2018 11:16:26 +0000
Subject: [alsa-devel] [PATCH v3 15/25] ASoC: qcom: qdsp6: Add support to
 q6asm dai driver
In-Reply-To: <6ea65838-f01a-ecbf-70cd-0dc9299eae80@codeaurora.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-16-srinivas.kandagatla@linaro.org>
 <6ea65838-f01a-ecbf-70cd-0dc9299eae80@codeaurora.org>
Message-ID: <d0f42d37-ed4b-fb19-17ce-d825bb78fe40@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your review Rohit,

On 21/02/18 11:14, Rohit Kumar wrote:
> 
> 
> On 2/13/2018 10:28 PM, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to q6asm dai driver which configures Q6ASM 
>> streams
>> to pass pcm data.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> [..]
>> diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c 
>> b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> new file mode 100644
>> index 000000000000..7c5e94b2ced4
>> --- /dev/null
>> +++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
>> @@ -0,0 +1,621 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2011-2016, The Linux Foundation
>> + * Copyright (c) 2017, Linaro Limited
>> + */
>> +
>> +#include <linux/init.h>
>> +#include <linux/err.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <sound/soc.h>
>> +#include <sound/soc-dapm.h>
>> +#include <sound/pcm.h>
>> +#include <asm/dma.h>
> [..]
>> +static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
>> +    .count = ARRAY_SIZE(supported_sample_rates),
>> +    .list = supported_sample_rates,
>> +    .mask = 0,
>> +};
>> +
>> +static void event_handler(uint32_t opcode, uint32_t token,
>> +              uint32_t *payload, void *priv)
>> +{
>> +    struct q6asm_dai_rtd *prtd = priv;
>> +    struct snd_pcm_substream *substream = prtd->substream;
>> +
>> +    switch (opcode) {
>> +    case ASM_CLIENT_EVENT_CMD_RUN_DONE:
> Need to add support for V2 version of opcodes
Makes sense, I will add them.

>> +        q6asm_write_async(prtd->audio_client,
>> +                   prtd->pcm_count, 0, 0, NO_TIMESTAMP);
>> +        break;
>> +    case ASM_CLIENT_EVENT_CMD_EOS_DONE:
>> +        prtd->state = Q6ASM_STREAM_STOPPED;
>> +        break;
>> +    case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
>> +        prtd->pcm
> [..]
>> +
>> +static int q6asm_dai_trigger(struct snd_pcm_substream *substream, int 
>> cmd)
>> +{
>> +    int ret = 0;
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct q6asm_dai_rtd *prtd = runtime->private_data;
>> +
>> +    switch (cmd) {
>> +    case SNDRV_PCM_TRIGGER_START:
>> +        ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
>> +        break;
> below two cases can be combined with START if no change
Yep, I will do that in next version.

>> +    case SNDRV_PCM_TRIGGER_RESUME:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> +        ret = q6asm_run_nowait(prtd->audio_client, 0, 0, 0);
>> +        break;
>> +    case SNDRV_PCM_TRIGGER_STOP:
>> +        prtd->state = Q6ASM_STREAM_STOPPED;
>> +        ret = q6asm_cmd_nowait(prtd->audio_client, CMD_EOS);
>> +        break;
>> +    case SNDRV_PCM_TRIGGER_SUSPEND:
>> +    case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> +        ret = q6asm_cmd_nowait(prtd->audio_client, CMD_PAUSE);
>> +        break;
>> +    default:
>> +        ret = -EINVAL;
>> +        break;
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int q6asm_dai_open(struct snd_pcm_substream *substream)
>> +{
>> +    struct snd_pcm_runtime *runtime = substream->runtime;
>> +    struct snd_soc_pcm_runtime *soc_prtd = substream->private_data;
>> +    struct snd_soc_dai *cpu_dai = soc_prtd->cpu_dai;
>> +
>> +    struct q6asm_dai_rtd *prtd;
>> +    struct q6asm_dai_data *pdata;
>> +    struct device *dev = soc_prtd->platform->dev;
>> +    int ret = 0;
>> +    int stream_id;
>> +
>> +    stream_id = cpu_dai->driver->id;
>> +
>> +    pdata = q6asm_get_dai_data(dev);
>> +    if (!pdata) {
>> +        pr_err("Platform data not found ..\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    prtd = kzalloc(sizeof(struct q6asm_dai_rtd), GFP_KERNEL);
>> +    if (prtd == NULL)
>> +        return -ENOMEM;
>> +
>> +    prtd->substream = substream;
>> +    prtd->audio_client = q6asm_audio_client_alloc(dev,
>> +                (q6asm_cb)event_handler, prtd, stream_id);
>> +    if (!prtd->audio_client) {
>> +        pr_info("%s: Could not allocate memory\n", __func__);
>> +        kfree(prtd);
>> +        return -ENOMEM;
>> +    }
>> +
>> +//    prtd->audio_client->dev = dev;
> cleanup this
Sure!

>> +
>> +    if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>> +        runtime->hw = q6asm_dai_hardware_playback;
>> +
>> +    ret = snd_pcm_hw_constraint_list(runtime, 0,
>> +                SNDRV_PCM_HW_PARAM_RATE,
>> +                &constraints_sample_rates);
> [..]
>> +
>> +static int q6asm_dai_pcm_new(struct snd_soc_pcm_runtime *rtd)
>> +{
>> +    struct snd_pcm_substream *substream;
>> +    struct of_phandle_args args;
>> +    struct device_node *node;
>> +    struct q6asm_dai_data *pdata;
>> +    struct snd_pcm *pcm = rtd->pcm;
>> +    struct device *dev;
>> +    int size, ret;
>> +
>> +    dev = rtd->platform->dev->parent;
>> +    node = dev->of_node;
>> +    pdata = q6asm_get_dai_data(rtd->platform->dev);
>> +
>> +    ret = of_parse_phandle_with_fixed_args(node, "iommus", 1, 0, &args);
>> +    if (ret < 0)
>> +        pdata->sid = -1;
>> +    else
>> +        pdata->sid = args.args[0];
>> +
>> +
>> +
> iommus for sdm845 is 16bit value. we need to have sid_mask which is 0x1 
> in sdm845. We need to mask sid with 0x1 to get proper sid.
> pdata->sid &= 0x1;

Okay, I will take closer look at sdm845 and other socs, and make it more 
generic in next version.



>> +    substream = pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
>> +    size = q6asm_dai_hardware_playback.buffer_bytes_max;
>> +    ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size,
>> +                  &substream->dma_buffer);
>> +    if (ret)
>> +        dev_err(dev, "Cannot allocate buffer(s)\n");
>> +
>> +    return ret;
>> +}
>> +
> 
> 
