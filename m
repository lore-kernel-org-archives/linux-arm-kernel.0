From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 19 Sep 2017 11:52:47 +0200
Subject: [PATCH v2] drm: exynos: Add driver for HDMI audio interface
In-Reply-To: <cf0c7e1e-030a-d4a6-a282-387c6c4b3d02@samsung.com>
References: <CGME20170918161922epcas2p3110a775caf0b8c6de599995986630b62@epcas2p3.samsung.com>
 <1505751550-24303-1-git-send-email-s.nawrocki@samsung.com>
 <cf0c7e1e-030a-d4a6-a282-387c6c4b3d02@samsung.com>
Message-ID: <d12efe49-a013-a5df-3683-c57a619de0d7@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2017 10:30 AM, Andrzej Hajda wrote:
> On 18.09.2017 18:19, Sylwester Nawrocki wrote:

>> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> index 214fa5e..dc254b7 100644
>> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
>> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
>> @@ -40,7 +40,7 @@

>> +struct hdmi_audio {
>> +	struct platform_device *pdev;
>> +	struct hdmi_audio_infoframe infoframe;
>> +	unsigned int sample_rate;
>> +	unsigned int sample_width;
>> +	u8 enable;
> 
> Why not bool ?

Yes, I also asked myself that question after submitting the patch.
>> -static void hdmi_audio_init(struct hdmi_context *hdata)
>> +static void hdmi_audio_config(struct hdmi_context *hdata)
>>   {
>> -	u32 sample_rate, bits_per_sample;
>> -	u32 data_num, bit_ch, sample_frq;
>> -	u32 val;
>> +	u32 data_num, sample_freq, val;
>> +	u32 bit_ch = 1;
>>
>> -	sample_rate = 44100;
>> -	bits_per_sample = 16;
>>
>> -	switch (bits_per_sample) {
>> +	switch (hdata->audio.sample_width) {
>>   	case 20:
>>   		data_num = 2;
>> -		bit_ch = 1;
>>   		break;
>>   	case 24:
>>   		data_num = 3;
>> -		bit_ch = 1;
>>   		break;
>>   	default:
>>   		data_num = 1;
>> @@ -1019,7 +1034,7 @@ static void hdmi_audio_init(struct hdmi_context *hdata)
>>   		break;
>>   	}
>>
>> -	hdmi_reg_acr(hdata, sample_rate);
>> +	hdmi_reg_acr(hdata, hdata->audio.sample_rate);
>>
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_MUX_CON, HDMI_I2S_IN_DISABLE
>>   				| HDMI_I2S_AUD_I2S | HDMI_I2S_CUV_I2S_ENABLE
>> @@ -1030,10 +1045,21 @@ static void hdmi_audio_init(struct hdmi_context *hdata)
>>
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_MUX_CUV, HDMI_I2S_CUV_RL_EN);
>>
>> -	sample_frq = (sample_rate == 44100) ? 0 :
>> -			(sample_rate == 48000) ? 2 :
>> -			(sample_rate == 32000) ? 3 :
>> -			(sample_rate == 96000) ? 0xa : 0x0;
>> +	switch (hdata->audio.sample_rate) {
>> +	case 32000:
>> +		sample_freq = 0x3;
>> +		break;
>> +	case 48000:
>> +		sample_freq = 0x2;
>> +		break;
>> +	case 96000:
>> +		sample_freq = 0xa;
>> +		break;
>> +	case 44100:
>> +	default:
>> +		sample_freq = 0;
>> +		break;
>> +	}
>>
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CLK_CON, HDMI_I2S_CLK_DIS);
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CLK_CON, HDMI_I2S_CLK_EN);
>> @@ -1067,7 +1093,7 @@ static void hdmi_audio_init(struct hdmi_context *hdata)
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CH_ST_1, HDMI_I2S_CD_PLAYER);
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CH_ST_2, HDMI_I2S_SET_SOURCE_NUM(0));
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CH_ST_3, HDMI_I2S_CLK_ACCUR_LEVEL_2
>> -			| HDMI_I2S_SET_SMP_FREQ(sample_frq));
>> +			| HDMI_I2S_SET_SMP_FREQ(sample_freq));
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CH_ST_4,
>>   			HDMI_I2S_ORG_SMP_FREQ_44_1
>>   			| HDMI_I2S_WORD_LEN_MAX24_24BITS
> 
> I am not audio expert, so maybe I miss something but I wonder if it
> wouldn't be good to fill HDMI_I2S_CH_ST_* with content of
> hdmi_codec_params.iec.status?
> This way you can remove some magic code above, but maybe it could be
> done in separate patch.

Yes, makes sense, I will try and see if it works properly with
the HDMI_I2S_CH_ST_? registers written directly with values from
the IEC status arrray.

>> @@ -1076,13 +1102,15 @@ static void hdmi_audio_init(struct hdmi_context *hdata)
>>   	hdmi_reg_writeb(hdata, HDMI_I2S_CH_ST_CON, HDMI_I2S_CH_STATUS_RELOAD);
>>   }
>>
>> -static void hdmi_audio_control(struct hdmi_context *hdata, bool onoff)
>> +static void hdmi_audio_control(struct hdmi_context *hdata)
>>   {
>> +	bool enable = hdata->audio.enable;
>> +
>>   	if (hdata->dvi_mode)
>>   		return;
>>
>> -	hdmi_reg_writeb(hdata, HDMI_AUI_CON, onoff ? 2 : 0);
>> -	hdmi_reg_writemask(hdata, HDMI_CON_0, onoff ?
>> +	hdmi_reg_writeb(hdata, HDMI_AUI_CON, enable ? 2 : 0);
> 
> While at it you can replace magic '2' to HDMI_AUI_CON_EVERY_VSYNC.

Changed.

>> +	hdmi_reg_writemask(hdata, HDMI_CON_0, enable ?
>>   			HDMI_ASP_EN : HDMI_ASP_DIS, HDMI_ASP_MASK);
>>   }
>>

>>   static void hdmi_disable(struct drm_encoder *encoder)
>>   {
>>   	struct hdmi_context *hdata = encoder_to_hdmi(encoder);
>>
>> -	if (!hdata->powered)
>> +	mutex_lock(&hdata->mutex);
>> +
>> +	if (hdata->powered) {
>> +		/*
>> +		 * The SFRs of VP and Mixer are updated by Vertical Sync of
>> +		 * Timing generator which is a part of HDMI so the sequence
>> +		 * to disable TV Subsystem should be as following,
>> +		 *	VP -> Mixer -> HDMI
>> +		 *
>> +		 * To achieve such sequence HDMI is disabled together with
>> +		 * HDMI PHY, via pipe clock callback.
>> +		 */
>> +		mutex_unlock(&hdata->mutex);
>> +		cancel_delayed_work(&hdata->hotplug_work);
>> +		cec_notifier_set_phys_addr(hdata->notifier,
>> +					   CEC_PHYS_ADDR_INVALID);
>>   		return;
>> +	}
>>
>> -	/*
>> -	 * The SFRs of VP and Mixer are updated by Vertical Sync of
>> -	 * Timing generator which is a part of HDMI so the sequence
>> -	 * to disable TV Subsystem should be as following,
>> -	 *	VP -> Mixer -> HDMI
>> -	 *
>> -	 * To achieve such sequence HDMI is disabled together with HDMI PHY, via
>> -	 * pipe clock callback.
>> -	 */
>> -	cancel_delayed_work(&hdata->hotplug_work);
>> -	cec_notifier_set_phys_addr(hdata->notifier, CEC_PHYS_ADDR_INVALID);
>> +	mutex_unlock(&hdata->mutex);
> 
> Wouldn't be enough to change it to:
> mutex_lock
> powered = hdata->powered;
> mutex_unlock
> if (!powered)
>      return

It would, I tried it but current version looks better to me so I would
prefer to keep it that way.

>>   }
>>
>>   static const struct drm_encoder_helper_funcs exynos_hdmi_encoder_helper_funcs = {
>> @@ -1513,6 +1554,109 @@ static void hdmi_disable(struct drm_encoder *encoder)
>>   	.destroy = drm_encoder_cleanup,
>>   };

>> +static int hdmi_register_audio_device(struct hdmi_context *hdata)
>> +{
>> +	struct hdmi_codec_pdata codec_data = {
>> +		.ops = &audio_codec_ops,
>> +		.max_i2s_channels = 6,
>> +		.i2s = 1,
>> +	};
>> +
>> +	hdata->audio.pdev = platform_device_register_data(
>> +		hdata->dev, HDMI_CODEC_DRV_NAME, PLATFORM_DEVID_AUTO,
>> +		&codec_data, sizeof(codec_data));
>> +
>> +	if (IS_ERR(hdata->audio.pdev))
>> +		return PTR_ERR(hdata->audio.pdev);
>> +
>> +	return 0;
> 
> return PTR_ERR_OR_ZERO(...) ?

Changed.

> Beside these nitpicks:
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks for your review.

-- 
Regards,
Sylwester
