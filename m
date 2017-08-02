From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 2 Aug 2017 16:17:15 +0200
Subject: [PATCH v2 1/4] drm/bridge: dw-hdmi: add cec notifier support
In-Reply-To: <2091520.p8lH1xBY9c@avalon>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <E1dcBhV-00088e-8x@rmk-PC.armlinux.org.uk> <2091520.p8lH1xBY9c@avalon>
Message-ID: <734aa419-2f1c-131e-bad3-298ba295bdd3@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/17 16:11, Laurent Pinchart wrote:
> Hi Russell,
> 
> Thank you for the patch.
> 
> On Monday 31 Jul 2017 15:29:41 Russell King wrote:
>> Add CEC notifier support to the HDMI bridge driver, so that the CEC
>> part of the IP can receive its physical address.
>>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/Kconfig   |  1 +
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 22 +++++++++++++++++++++-
>>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> [snip]
> 
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
>> ead11242c4b9..82e55ee8e4fa 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> 
> [snip]
> 
>> @@ -2376,6 +2387,12 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  	if (ret)
>>  		goto err_iahb;
>>
>> +	hdmi->cec_notifier = cec_notifier_get(dev);
>> +	if (!hdmi->cec_notifier) {
>> +		ret = -ENOMEM;
>> +		goto err_iahb;
>> +	}
>> +
>>  	/*
>>  	 * To prevent overflows in HDMI_IH_FC_STAT2, set the clk regenerator
>>  	 * N and cts values before enabling phy
>> @@ -2452,6 +2469,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
>>  		hdmi->ddc = NULL;
>>  	}
>>
>> +	if (hdmi->cec_notifier)
>> +		cec_notifier_put(hdmi->cec_notifier);
>> +
>>  	clk_disable_unprepare(hdmi->iahb_clk);
>>  err_isfr:
>>  	clk_disable_unprepare(hdmi->isfr_clk);
> 
> I'm not very familiar yet with the CEC API so I made have missed something, 
> but shouldn't you call cec_notifier_put() in the remove() handler ?
> 

Yes, you should. Well spotted, I missed that one.

Regards,

	Hans
