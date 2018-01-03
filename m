From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 3 Jan 2018 16:27:08 +0000
Subject: [RESEND PATCH v2 10/15] ASoC: qcom: qdsp6: Add support to
 q6routing driver
In-Reply-To: <20180102230007.GR478@tuxbook>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-11-srinivas.kandagatla@linaro.org>
 <20180102230007.GR478@tuxbook>
Message-ID: <c11b49c8-3022-5591-41b1-d7be7ae6d17a@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/01/18 23:00, Bjorn Andersson wrote:
> On Thu 14 Dec 09:33 PST 2017, srinivas.kandagatla at linaro.org wrote:
> 
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds support to q6 routing driver which configures route
>> between ASM and AFE module using ADM apis.
>>
>> This driver uses dapm widgets to setup the matrix between AFE ports and
>> ASM streams.
>>
> 
> Why is this a separate driver from the q6adm?

This is actually exposing the mixer controls for routing streams on to 
different audio sink/sources using a matrix.

> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/Kconfig           |   5 +
>>   sound/soc/qcom/qdsp6/Makefile    |   1 +
>>   sound/soc/qcom/qdsp6/q6routing.c | 386 +++++++++++++++++++++++++++++++++++++++
>>   sound/soc/qcom/qdsp6/q6routing.h |   9 +
>>   4 files changed, 401 insertions(+)
>>   create mode 100644 sound/soc/qcom/qdsp6/q6routing.c
>>   create mode 100644 sound/soc/qcom/qdsp6/q6routing.h

>> diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c


>> +/**
>> + * q6routing_reg_phy_stream() - Register a new stream for route setup
>> + *
>> + * @fedai_id: Frontend dai id.
>> + * @perf_mode: Performace mode.
> 
> "Performance"
yep.

> 
>> + * @stream_id: ASM stream id to map.
>> + * @stream_type: Direction of stream
>> + *
>> + * Return: Will be an negative on error or a zero on success.
>> + */
>> +int q6routing_reg_phy_stream(int fedai_id, int perf_mode,
> 
> q6routing_stream_open() ?

sure if it helps reading.

> 
>> +			   int stream_id, int stream_type)
>> +{
>> +	int j, topology, num_copps = 0;
>> +	struct route_payload payload;
>> +	int copp_idx;
>> +	struct session_data *session;
>> +
>> +	if (!routing_data) {
>> +		pr_err("Routing driver not yet ready\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	session = &routing_data->sessions[stream_id - 1];
>> +	mutex_lock(&routing_data->lock);
>> +	session->fedai_id = fedai_id;
>> +	payload.num_copps = 0; /* only RX needs to use payload */
>> +	topology = NULL_COPP_TOPOLOGY;
>> +	copp_idx = q6adm_open(routing_data->dev, session->port_id,
>> +			      session->path_type, session->sample_rate,
>> +			      session->channels, topology, perf_mode,
>> +			      session->bits_per_sample, 0, 0);
>> +	if ((copp_idx < 0) || (copp_idx >= MAX_COPPS_PER_PORT)) {
> 
> Make q6adm_open() not return >= MAX_COPPS_PER_PORT.
> 
> And drop the extra parenthesis.
> 
>> +		mutex_unlock(&routing_data->lock);
>> +		return -EINVAL;
>> +	}
>> +
>> +	set_bit(copp_idx, &session->copp_map);
>> +	for (j = 0; j < MAX_COPPS_PER_PORT; j++) {
> 
> Use for_each_set_bit()
> 
>> +		unsigned long copp = session->copp_map;
>> +
>> +		if (test_bit(j, &copp)) {
>> +			payload.port_id[num_copps] = session->port_id;
>> +			payload.copp_idx[num_copps] = j;
>> +			num_copps++;
>> +		}
>> +	}
>> +
>> +	if (num_copps) {
>> +		payload.num_copps = num_copps;
>> +		payload.session_id = stream_id;
>> +		q6adm_matrix_map(routing_data->dev, session->path_type,
>> +				 payload, perf_mode);
>> +	}
>> +	mutex_unlock(&routing_data->lock);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(q6routing_reg_phy_stream);
>> +
>> +static struct session_data *routing_get_session(struct msm_routing_data *data,
>> +						int port_id, int port_type)
> 
> port_type is ignored

It will be used once we add capture support.

> 
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < MAX_SESSIONS; i++)
>> +		if (port_id == data->sessions[i].port_id)
>> +			return &data->sessions[i];
>> +
>> +	return NULL;
>> +}
>> +

>> +/**
>> + * q6routing_dereg_phy_stream() - Deregister a stream
>> + *
>> + * @fedai_id: Frontend dai id.
>> + * @stream_type: Direction of stream
>> + *
>> + * Return: Will be an negative on error or a zero on success.
>> + */
>> +void q6routing_dereg_phy_stream(int fedai_id, int stream_type)
> 
> q6routing_stream_close()?
> 
will rename it.
>> +{
>> +	struct session_data *session;
>> +	int idx;
>> +
>> +	session = get_session_from_id(routing_data, fedai_id);
>> +	if (!session)
>> +		return;
>> +
>> +	for_each_set_bit(idx, &session->copp_map, MAX_COPPS_PER_PORT)
>> +		q6adm_close(routing_data->dev, session->port_id,
>> +			    session->perf_mode, idx);
>> +
>> +	session->fedai_id = -1;
>> +	session->copp_map = 0;
>> +}
>> +EXPORT_SYMBOL_GPL(q6routing_dereg_phy_stream);
>> +

>> +


>> +
>> +static const struct snd_soc_dapm_widget msm_qdsp6_widgets[] = {
>> +	/* Frontend AIF */
>> +	/* Widget name equals to Front-End DAI name<Need confirmation>,
> 
> Perhaps this should be confirmed and the comment updated?
> 

Some leftover from old code...

>> +	 * Stream name must contains substring of front-end dai name
>> +	 */
>> +	SND_SOC_DAPM_AIF_IN("MM_DL1", "MultiMedia1 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL2", "MultiMedia2 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL3", "MultiMedia3 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL4", "MultiMedia4 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL5", "MultiMedia5 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL6", "MultiMedia6 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL7", "MultiMedia7 Playback", 0, 0, 0, 0),
>> +	SND_SOC_DAPM_AIF_IN("MM_DL8", "MultiMedia8 Playback", 0, 0, 0, 0),
>> +
>> +	/* Mixer definitions */
>> +	SND_SOC_DAPM_MIXER("HDMI Mixer", SND_SOC_NOPM, 0, 0,
>> +			   hdmi_mixer_controls,
>> +			   ARRAY_SIZE(hdmi_mixer_controls)),
>> +};
>
>> +static int routing_hw_params(struct snd_pcm_substream *substream,
>> +				     struct snd_pcm_hw_params *params)
>> +{
>> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> +	unsigned int be_id = rtd->cpu_dai->id;
>> +	struct snd_soc_platform *platform = rtd->platform;
>> +	struct msm_routing_data *data = snd_soc_platform_get_drvdata(platform);
>> +	struct session_data *session;
>> +	int port_id, port_type, path_type, bits_per_sample;
> 
> bits_per_sample is likely unused.
> 
yep.

>> +
>> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>> +		path_type = ADM_PATH_PLAYBACK;
>> +		port_type = MSM_AFE_PORT_TYPE_RX;
>> +	}
>> +
>> +	port_id = be_id;
> 
> Why alias this variable?
will fix this in next version.

> 
>> +
>> +	session = routing_get_session(data, port_id, port_type);
>> +
>> +	if (!session) {
>> +		pr_err("No session matrix setup yet..\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	mutex_lock(&data->lock);
>> +
>> +	session->path_type = path_type;
>> +	session->sample_rate = params_rate(params);
>> +	session->channels = params_channels(params);
>> +	session->format = params_format(params);
>> +
>> +	if (session->format == SNDRV_PCM_FORMAT_S16_LE)
>> +		session->bits_per_sample = 16;
>> +	else if (session->format == SNDRV_PCM_FORMAT_S24_LE)
>> +		bits_per_sample = 24;
> 
> session-> ?

I agree, will fix it.

> 
> Perhaps switch on params_format(params) instead? And fail in the default
> case.
will give that a go.

> 
>> +
>> +	mutex_unlock(&data->lock);
>> +	return 0;
>> +}
>> +


>> +static struct snd_pcm_ops q6pcm_routing_ops = {
>> +	.hw_params = routing_hw_params,
>> +	.close = routing_close,
>> +	.prepare = routing_prepare,
>> +};
>> +
>> +/* Not used but frame seems to require it */
> 
> Remove comment?
> 
looks like leftover.. will remove it.

[...]
>> +
>> +static int q6pcm_routing_remove(struct platform_device *pdev)
>> +{
> 
> As you return here routing_data will be freed.  The early check in
> q6routing_reg_phy_stream() seems to indicate that this driver can be
> called even though the routing device isn't available.
> 
> So you probably want to clear that variable, at least.
sure, will fix this in next version.

> 
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver q6pcm_routing_driver = {
>> +	.driver = {
>> +		   .name = "q6routing",
>> +		   .owner = THIS_MODULE,
> 
> Drop .owner
> 
yep.
>> +		   },
>> +	.probe = q6pcm_routing_probe,
>> +	.remove = q6pcm_routing_remove,
>> +};

>>
