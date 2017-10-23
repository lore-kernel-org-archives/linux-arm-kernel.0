From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 23 Oct 2017 14:20:41 +0200
Subject: [PATCH v3] drm: exynos: Add driver for HDMI audio interface
In-Reply-To: <59ED4584.5030608@samsung.com>
References: <CGME20170926141814epcas1p1923ab779847932395bf2c2899291dfcd@epcas1p1.samsung.com>
 <1506435469-10591-1-git-send-email-s.nawrocki@samsung.com>
 <59ED4584.5030608@samsung.com>
Message-ID: <0b112664-d462-ebeb-b8e1-58e270833d2f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2017 03:27 AM, Inki Dae wrote:

>> +static int hdmi_audio_digital_mute(struct device *dev, void *data, bool mute)
>> +{
>> +	struct hdmi_context *hdata = dev_get_drvdata(dev);
>> +
>> +	mutex_lock(&hdata->mutex);
>> +
>> +	hdata->audio.enable = !mute;
> 
> Wouldn't it be better to keep 'mute' instead of 'enable'? 'hdata->audio.enable' 
is used by only hdmi_adio_control function and whether hdmi is power on or nis already checked by 'hdata->powered'
Yes, makes sense, I'll change it.
 
>> +
>> +	if (hdata->powered)
>> +		hdmi_audio_control(hdata);
>> +
>> +	mutex_unlock(&hdata->mutex);
>> +
>> +	return 0;
>> +}


>> +static void hdmi_unregister_audio_device(struct hdmi_context *hdata)
>> +{
>> +	platform_device_unregister(hdata->audio.pdev);
>> +}
> 
> This function is unnecessary wrapper. You can use platform_device_unregister(hdata->audio.pdev) at probe callback.
> And you would need to unregister audio device at remove callback.

Fixed in v4.

>>  static int hdmi_bridge_init(struct hdmi_context *hdata)
>> @@ -1697,6 +1812,7 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
>>  	struct drm_device *drm_dev = data;
>>  	struct hdmi_context *hdata = dev_get_drvdata(dev);
>>  	struct drm_encoder *encoder = &hdata->encoder;
>> +	struct hdmi_audio_infoframe *audio_infoframe = &hdata->audio.infoframe;
>>  	struct exynos_drm_crtc *crtc;
>>  	int ret;
>>
>> @@ -1704,6 +1820,12 @@ static int hdmi_bind(struct device *dev, struct device *master, void *data)
>>
>>  	hdata->phy_clk.enable = hdmiphy_clk_enable;
>>
>> +	hdmi_audio_infoframe_init(audio_infoframe);
>> +	audio_infoframe->coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
>> +	audio_infoframe->sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
>> +	audio_infoframe->sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
>> +	audio_infoframe->channels = 2;
> 
> Audio device is registered at probe callback so it would be better to move above code into probe callback.
> I coudln't see initializing audio infoframe should be done here.

Yes, it makes more sense indeed to have this initialization in probe().

Thanks for your review.

Regards,
Sylwester
