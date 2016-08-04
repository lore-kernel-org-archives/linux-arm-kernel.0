From: mark.yao@rock-chips.com (Mark yao)
Date: Thu, 4 Aug 2016 10:01:27 +0800
Subject: [PATCH 1/3] drm/rockchip: inno_hdmi: add audio support
In-Reply-To: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
References: <1465997312-17777-1-git-send-email-ykk@rock-chips.com>
Message-ID: <57A2A1F7.2080405@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir

After apply your patch, I got following warning messge:

drivers/gpu/drm/rockchip/inno_hdmi.c:818:2: warning: initialization from 
incompatible pointer type [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:818:2: warning: (near 
initialization for 'audio_codec_ops.hw_params') [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:819:2: warning: initialization from 
incompatible pointer type [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:819:2: warning: (near 
initialization for 'audio_codec_ops.audio_shutdown') [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:820:2: warning: initialization from 
incompatible pointer type [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:820:2: warning: (near 
initialization for 'audio_codec_ops.digital_mute') [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:821:2: warning: initialization from 
incompatible pointer type [enabled by default]
drivers/gpu/drm/rockchip/inno_hdmi.c:821:2: warning: (near 
initialization for 'audio_codec_ops.get_eld') [enabled by default]

since the commit "efc9194 ASoC: hdmi-codec: callback function will be 
called with private data",
the hdmi_codec_ops had some changes.
Can you rebase your patch to the newest kernel?

Thanks.
On 2016?06?15? 21:28, Yakir Yang wrote:
> Using the common hdmi-codec driver to support hdmi audio function.
>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---
>   drivers/gpu/drm/rockchip/inno_hdmi.c | 237 ++++++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/rockchip/inno_hdmi.h |   2 +
>   2 files changed, 237 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> index f8b4feb..c31dc07 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -29,6 +29,8 @@
>   #include <drm/drm_crtc_helper.h>
>   #include <drm/drm_edid.h>
>   
> +#include <sound/hdmi-codec.h>
> +
>   #include "rockchip_drm_drv.h"
>   #include "rockchip_drm_vop.h"
>   
> @@ -36,6 +38,12 @@
>   
>   #define to_inno_hdmi(x)	container_of(x, struct inno_hdmi, x)
>   
> +struct audio_info {
> +	int sample_rate;
> +	int channels;
> +	int sample_width;
> +};
> +
>   struct hdmi_data_info {
>   	int vic;
>   	bool sink_is_hdmi;
> @@ -71,6 +79,9 @@ struct inno_hdmi {
>   
>   	unsigned int tmds_rate;
>   
> +	struct platform_device *audio_pdev;
> +	bool audio_enable;
> +
>   	struct hdmi_data_info	hdmi_data;
>   	struct drm_display_mode previous_mode;
>   };
> @@ -306,6 +317,57 @@ static int inno_hdmi_config_video_avi(struct inno_hdmi *hdmi,
>   	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AVI, 0, 0, 0);
>   }
>   
> +static int inno_hdmi_config_audio_aai(struct inno_hdmi *hdmi,
> +				      struct audio_info *audio)
> +{
> +	struct hdmi_audio_infoframe *faudio;
> +	union hdmi_infoframe frame;
> +	int rc;
> +
> +	rc = hdmi_audio_infoframe_init(&frame.audio);
> +	faudio = (struct hdmi_audio_infoframe *)&frame;
> +
> +	faudio->channels = audio->channels;
> +
> +	switch (audio->sample_width) {
> +	case 16:
> +		faudio->sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
> +		break;
> +	case 20:
> +		faudio->sample_size = HDMI_AUDIO_SAMPLE_SIZE_20;
> +		break;
> +	case 24:
> +		faudio->sample_size = HDMI_AUDIO_SAMPLE_SIZE_24;
> +		break;
> +	}
> +
> +	switch (audio->sample_rate) {
> +	case 32000:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_32000;
> +		break;
> +	case 44100:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_44100;
> +		break;
> +	case 48000:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_48000;
> +		break;
> +	case 88200:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_88200;
> +		break;
> +	case 96000:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_96000;
> +		break;
> +	case 176400:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_176400;
> +		break;
> +	case 192000:
> +		faudio->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_192000;
> +		break;
> +	}
> +
> +	return inno_hdmi_upload_frame(hdmi, rc, &frame, INFOFRAME_AAI, 0, 0, 0);
> +}
> +
>   static int inno_hdmi_config_video_csc(struct inno_hdmi *hdmi)
>   {
>   	struct hdmi_data_info *data = &hdmi->hdmi_data;
> @@ -478,8 +540,9 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
>   	inno_hdmi_i2c_init(hdmi);
>   
>   	/* Unmute video and audio output */
> -	hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_VIDEO_BLACK,
> -		  v_AUDIO_MUTE(0) | v_VIDEO_MUTE(0));
> +	hdmi_modb(hdmi, HDMI_AV_MUTE, m_VIDEO_BLACK, v_VIDEO_MUTE(0));
> +	if (hdmi->audio_enable)
> +		hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE, v_AUDIO_MUTE(0));
>   
>   	return 0;
>   }
> @@ -616,6 +679,174 @@ static struct drm_connector_helper_funcs inno_hdmi_connector_helper_funcs = {
>   	.best_encoder = inno_hdmi_connector_best_encoder,
>   };
>   
> +int inno_hdmi_audio_config_set(struct inno_hdmi *hdmi, struct audio_info *audio)
> +{
> +	int rate, N, channel;
> +
> +	if (audio->channels < 3)
> +		channel = I2S_CHANNEL_1_2;
> +	else if (audio->channels < 5)
> +		channel = I2S_CHANNEL_3_4;
> +	else if (audio->channels < 7)
> +		channel = I2S_CHANNEL_5_6;
> +	else
> +		channel = I2S_CHANNEL_7_8;
> +
> +	switch (audio->sample_rate) {
> +	case 32000:
> +		rate = AUDIO_32K;
> +		N = N_32K;
> +		break;
> +	case 44100:
> +		rate = AUDIO_441K;
> +		N = N_441K;
> +		break;
> +	case 48000:
> +		rate = AUDIO_48K;
> +		N = N_48K;
> +		break;
> +	case 88200:
> +		rate = AUDIO_882K;
> +		N = N_882K;
> +		break;
> +	case 96000:
> +		rate = AUDIO_96K;
> +		N = N_96K;
> +		break;
> +	case 176400:
> +		rate = AUDIO_1764K;
> +		N = N_1764K;
> +		break;
> +	case 192000:
> +		rate = AUDIO_192K;
> +		N = N_192K;
> +		break;
> +	default:
> +		dev_err(hdmi->dev, "[%s] not support such sample rate %d\n",
> +			__func__, audio->sample_rate);
> +		return -ENOENT;
> +	}
> +
> +	/* set_audio source I2S */
> +	hdmi_writeb(hdmi, HDMI_AUDIO_CTRL1, 0x01);
> +	hdmi_writeb(hdmi, AUDIO_SAMPLE_RATE, rate);
> +	hdmi_writeb(hdmi, AUDIO_I2S_MODE, v_I2S_MODE(I2S_STANDARD) |
> +		    v_I2S_CHANNEL(channel));
> +
> +	hdmi_writeb(hdmi, AUDIO_I2S_MAP, 0x00);
> +	hdmi_writeb(hdmi, AUDIO_I2S_SWAPS_SPDIF, 0);
> +
> +	/* Set N value */
> +	hdmi_writeb(hdmi, AUDIO_N_H, (N >> 16) & 0x0F);
> +	hdmi_writeb(hdmi, AUDIO_N_M, (N >> 8) & 0xFF);
> +	hdmi_writeb(hdmi, AUDIO_N_L, N & 0xFF);
> +
> +	/*Set hdmi nlpcm mode to support hdmi bitstream*/
> +	hdmi_writeb(hdmi, HDMI_AUDIO_CHANNEL_STATUS, v_AUDIO_STATUS_NLPCM(0));
> +
> +	return inno_hdmi_config_audio_aai(hdmi, audio);
> +}
> +
> +static int inno_hdmi_audio_hw_params(struct device *dev,
> +				     struct hdmi_codec_daifmt *daifmt,
> +				     struct hdmi_codec_params *params)
> +{
> +	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
> +	struct audio_info audio = {
> +		.sample_width = params->sample_width,
> +		.sample_rate = params->sample_rate,
> +		.channels = params->channels,
> +	};
> +
> +	if (!hdmi->hdmi_data.sink_has_audio) {
> +		dev_err(hdmi->dev, "Sink do not support audio!\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!hdmi->encoder.crtc)
> +		return -ENODEV;
> +
> +	switch (daifmt->fmt) {
> +	case HDMI_I2S:
> +		break;
> +	default:
> +		dev_err(dev, "%s: Invalid format %d\n", __func__, daifmt->fmt);
> +		return -EINVAL;
> +	}
> +
> +	return inno_hdmi_audio_config_set(hdmi, &audio);
> +}
> +
> +static void inno_hdmi_audio_shutdown(struct device *dev)
> +{
> +	/* do nothing */
> +}
> +
> +static int inno_hdmi_audio_digital_mute(struct device *dev, bool mute)
> +{
> +	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
> +
> +	if (!hdmi->hdmi_data.sink_has_audio) {
> +		dev_err(hdmi->dev, "Sink do not support audio!\n");
> +		return -ENODEV;
> +	}
> +
> +	hdmi->audio_enable = !mute;
> +
> +	if (mute)
> +		hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_AUDIO_PD,
> +			  v_AUDIO_MUTE(1) | v_AUDIO_PD(1));
> +	else
> +		hdmi_modb(hdmi, HDMI_AV_MUTE, m_AUDIO_MUTE | m_AUDIO_PD,
> +			  v_AUDIO_MUTE(0) | v_AUDIO_PD(0));
> +
> +	return 0;
> +}
> +
> +static int inno_hdmi_audio_get_eld(struct device *dev, uint8_t *buf, size_t len)
> +{
> +	struct inno_hdmi *hdmi = dev_get_drvdata(dev);
> +	struct drm_mode_config *config = &hdmi->encoder.dev->mode_config;
> +	struct drm_connector *connector;
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&config->mutex);
> +	list_for_each_entry(connector, &config->connector_list, head) {
> +		if (&hdmi->encoder == connector->encoder) {
> +			memcpy(buf, connector->eld,
> +			       min(sizeof(connector->eld), len));
> +			ret = 0;
> +		}
> +	}
> +	mutex_unlock(&config->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct hdmi_codec_ops audio_codec_ops = {
> +	.hw_params = inno_hdmi_audio_hw_params,
> +	.audio_shutdown = inno_hdmi_audio_shutdown,
> +	.digital_mute = inno_hdmi_audio_digital_mute,
> +	.get_eld = inno_hdmi_audio_get_eld,
> +};
> +
> +static int inno_hdmi_audio_codec_init(struct inno_hdmi *hdmi,
> +				      struct device *dev)
> +{
> +	struct hdmi_codec_pdata codec_data = {
> +		.i2s = 1,
> +		.ops = &audio_codec_ops,
> +		.max_i2s_channels = 8,
> +	};
> +
> +	hdmi->audio_enable = false;
> +	hdmi->audio_pdev = platform_device_register_data(
> +				dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_NONE,
> +				&codec_data, sizeof(codec_data));
> +
> +	return PTR_ERR_OR_ZERO(hdmi->audio_pdev);
> +}
> +
>   static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
>   {
>   	struct drm_encoder *encoder = &hdmi->encoder;
> @@ -645,6 +876,8 @@ static int inno_hdmi_register(struct drm_device *drm, struct inno_hdmi *hdmi)
>   
>   	drm_mode_connector_attach_encoder(&hdmi->connector, encoder);
>   
> +	inno_hdmi_audio_codec_init(hdmi, dev);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.h b/drivers/gpu/drm/rockchip/inno_hdmi.h
> index aa7c415..8b23037 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.h
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.h
> @@ -104,11 +104,13 @@ enum {
>   #define HDMI_AV_MUTE			0x05
>   #define m_AVMUTE_CLEAR			(1 << 7)
>   #define m_AVMUTE_ENABLE			(1 << 6)
> +#define m_AUDIO_PD			(1 << 2)
>   #define m_AUDIO_MUTE			(1 << 1)
>   #define m_VIDEO_BLACK			(1 << 0)
>   #define v_AVMUTE_CLEAR(n)		(n << 7)
>   #define v_AVMUTE_ENABLE(n)		(n << 6)
>   #define v_AUDIO_MUTE(n)			(n << 1)
> +#define v_AUDIO_PD(n)			(n << 2)
>   #define v_VIDEO_MUTE(n)			(n << 0)
>   
>   #define HDMI_VIDEO_TIMING_CTL		0x08


-- 
?ark Yao
