From: romain.perier@collabora.com (Romain Perier)
Date: Mon, 24 Apr 2017 08:44:34 +0200
Subject: [PATCH v2 2/2] drm: dw-hdmi: gate audio clock from the I2S
 enablement callbacks
In-Reply-To: <c9258563-afcd-4088-a4f4-6a4e056f5d36@codeaurora.org>
References: <20170414083113.4255-1-romain.perier@collabora.com>
 <20170414083113.4255-3-romain.perier@collabora.com>
 <c9258563-afcd-4088-a4f4-6a4e056f5d36@codeaurora.org>
Message-ID: <eeb069cf-1dba-91c4-c30b-bb37403e3b3b@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


Le 19/04/2017 ? 06:51, Archit Taneja a ?crit :
>
>
> On 04/14/2017 02:01 PM, Romain Perier wrote:
>> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
>> step E. and is kept enabled for later use. This clock should be enabled
>> and disabled along with the actual audio stream and not always on (that
>> is bad for PM). Futhermore, as described by the datasheet, the I2S
>
> s/Futhermore/Furthermore
>
>> variant need to gate/ungate the clock when the stream is
>
> s/need/needs
>
>> enabled/disabled.
>>
>> This commit adds a parameter to hdmi_audio_enable_clk() that controls
>> when the audio sample clock must be enabled or disabled. Then, it adds
>> the call to this function from dw_hdmi_i2s_audio_enable() and
>> dw_hdmi_i2s_audio_disable().
>>
>> Signed-off-by: Romain Perier <romain.perier@collabora.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 20 ++++++++++++++------
>>  1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 5b328c0..a6da634 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -544,6 +544,12 @@ void dw_hdmi_set_sample_rate(struct dw_hdmi
>> *hdmi, unsigned int rate)
>>  }
>>  EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
>>
>> +static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, bool enable)
>> +{
>> +    hdmi_modb(hdmi, enable ? 0 : HDMI_MC_CLKDIS_AUDCLK_DISABLE,
>> +          HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
>> +}
>> +
>>  void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
>>  {
>>      hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
>> @@ -557,6 +563,12 @@ void dw_hdmi_ahb_audio_disable(struct dw_hdmi
>> *hdmi)
>>  void dw_hdmi_i2s_audio_enable(struct dw_hdmi *hdmi)
>>  {
>>      hdmi_set_cts_n(hdmi, hdmi->audio_cts, hdmi->audio_n);
>> +    hdmi_enable_audio_clk(hdmi, true);
>> +}
>> +
>> +void dw_hdmi_i2s_audio_disable(struct dw_hdmi *hdmi)
>> +{
>> +    hdmi_enable_audio_clk(hdmi, false);
>>  }
>
> This should be static too.
>
> If you're okay with the suggestions, I can fix these myself and push. Let
> me know if that's okay.
>
> Thanks,
> Archit
>

Yes, I completely agree.
Thanks,
Romain
