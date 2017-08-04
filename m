From: architt@codeaurora.org (Archit Taneja)
Date: Fri, 4 Aug 2017 19:09:02 +0530
Subject: [PATCH v2 2/4] drm/bridge: dw-hdmi: add better clock disable
 control
In-Reply-To: <8bc9989d-d385-a8f9-d433-b8abe6e53fe9@xs4all.nl>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <E1dcBha-00088l-DE@rmk-PC.armlinux.org.uk>
 <8bc9989d-d385-a8f9-d433-b8abe6e53fe9@xs4all.nl>
Message-ID: <1a014928-8e94-b9db-e21f-746d8fd452c1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/31/2017 08:56 PM, Hans Verkuil wrote:
> On 07/31/2017 04:29 PM, Russell King wrote:
>> The video setup path aways sets the clock disable register to a specific
>> value, which has the effect of disabling the CEC engine.  When we add the
>> CEC driver, this becomes a problem.
>>
>> Fix this by only setting/clearing the bits that the video path needs to.
>>
>> Reviewed-by: Jose Abreu <joabreu@synopsys.com>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> 
> Acked-by: Hans Verkuil <hans.verkuil@cisco.com>


Queued to drm-misc-next.

Thanks,
Archit

> 
> Regards,
> 
> 	Hans
> 
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 29 ++++++++++++++++++-----------
>>   1 file changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index 82e55ee8e4fa..b08cc0c95590 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -166,6 +166,7 @@ struct dw_hdmi {
>>   	bool bridge_is_on;		/* indicates the bridge is on */
>>   	bool rxsense;			/* rxsense state */
>>   	u8 phy_mask;			/* desired phy int mask settings */
>> +	u8 mc_clkdis;			/* clock disable register */
>>   
>>   	spinlock_t audio_lock;
>>   	struct mutex audio_mutex;
>> @@ -551,8 +552,11 @@ EXPORT_SYMBOL_GPL(dw_hdmi_set_sample_rate);
>>   
>>   static void hdmi_enable_audio_clk(struct dw_hdmi *hdmi, bool enable)
>>   {
>> -	hdmi_modb(hdmi, enable ? 0 : HDMI_MC_CLKDIS_AUDCLK_DISABLE,
>> -		  HDMI_MC_CLKDIS_AUDCLK_DISABLE, HDMI_MC_CLKDIS);
>> +	if (enable)
>> +		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_AUDCLK_DISABLE;
>> +	else
>> +		hdmi->mc_clkdis |= HDMI_MC_CLKDIS_AUDCLK_DISABLE;
>> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>>   }
>>   
>>   static void dw_hdmi_ahb_audio_enable(struct dw_hdmi *hdmi)
>> @@ -1574,8 +1578,6 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
>>   /* HDMI Initialization Step B.4 */
>>   static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>>   {
>> -	u8 clkdis;
>> -
>>   	/* control period minimum duration */
>>   	hdmi_writeb(hdmi, 12, HDMI_FC_CTRLDUR);
>>   	hdmi_writeb(hdmi, 32, HDMI_FC_EXCTRLDUR);
>> @@ -1587,17 +1589,21 @@ static void dw_hdmi_enable_video_path(struct dw_hdmi *hdmi)
>>   	hdmi_writeb(hdmi, 0x21, HDMI_FC_CH2PREAM);
>>   
>>   	/* Enable pixel clock and tmds data path */
>> -	clkdis = 0x7F;
>> -	clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
>> -	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
>> +	hdmi->mc_clkdis |= HDMI_MC_CLKDIS_HDCPCLK_DISABLE |
>> +			   HDMI_MC_CLKDIS_CSCCLK_DISABLE |
>> +			   HDMI_MC_CLKDIS_AUDCLK_DISABLE |
>> +			   HDMI_MC_CLKDIS_PREPCLK_DISABLE |
>> +			   HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
>> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_PIXELCLK_DISABLE;
>> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>>   
>> -	clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
>> -	hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
>> +	hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_TMDSCLK_DISABLE;
>> +	hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>>   
>>   	/* Enable csc path */
>>   	if (is_color_space_conversion(hdmi)) {
>> -		clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
>> -		hdmi_writeb(hdmi, clkdis, HDMI_MC_CLKDIS);
>> +		hdmi->mc_clkdis &= ~HDMI_MC_CLKDIS_CSCCLK_DISABLE;
>> +		hdmi_writeb(hdmi, hdmi->mc_clkdis, HDMI_MC_CLKDIS);
>>   	}
>>   
>>   	/* Enable color space conversion if needed */
>> @@ -2272,6 +2278,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>   	hdmi->disabled = true;
>>   	hdmi->rxsense = true;
>>   	hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
>> +	hdmi->mc_clkdis = 0x7f;
>>   
>>   	mutex_init(&hdmi->mutex);
>>   	mutex_init(&hdmi->audio_mutex);
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
