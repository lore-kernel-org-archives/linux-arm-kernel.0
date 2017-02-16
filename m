From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 16 Feb 2017 11:01:46 +0800
Subject: [PATCH v3 22/24] drm/rockchip: dw-mipi-dsi: support non-burst
 modes
In-Reply-To: <20170131192255.GF20076@art_vandelay>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-23-john@metanate.com>
 <20170131192255.GF20076@art_vandelay>
Message-ID: <58A5161A.3070205@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

On 02/01/2017 03:22 AM, Sean Paul wrote:
> On Sun, Jan 29, 2017 at 01:24:42PM +0000, John Keeping wrote:
>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>
>> Signed-off-by: John Keeping <john@metanate.com>
>> Reviewed-by: Chris Zhong <zyw@rock-chips.com>
>> ---
>> v3:
>> - Add Chris' Reviewed-by
>> Unchanged in v2
>>
>>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> index 5bad92e2370e..58cb8ace2fe8 100644
>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>> @@ -82,6 +82,7 @@
>>   #define FRAME_BTA_ACK			BIT(14)
>>   #define ENABLE_LOW_POWER		(0x3f << 8)
>>   #define ENABLE_LOW_POWER_MASK		(0x3f << 8)
>> +#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS	0x1
>>   #define VID_MODE_TYPE_BURST_SYNC_PULSES		0x2
This field indicates the video mode transmission type as follows:
00: Non-burst with sync pulses
01: Non-burst with sync events
10 and 11: Burst mode

So, I think define the macro like this is better:

#define VID_MODE_TYPE_NON_BURST_SYNC_PULSES    0x0
#define VID_MODE_TYPE_NON_BURST_SYNC_EVENTS    0x1
#define VID_MODE_TYPE_BURST            0x2


>>   #define VID_MODE_TYPE_MASK			0x3
>>   
>> @@ -286,6 +287,7 @@ struct dw_mipi_dsi {
>>   	u32 format;
>>   	u16 input_div;
>>   	u16 feedback_div;
>> +	unsigned long mode_flags;
>>   
>>   	const struct dw_mipi_dsi_plat_data *pdata;
>>   };
>> @@ -551,15 +553,10 @@ static int dw_mipi_dsi_host_attach(struct mipi_dsi_host *host,
>>   		return -EINVAL;
>>   	}
>>   
>> -	if (!(device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) ||
>> -	    !(device->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)) {
>> -		dev_err(dsi->dev, "device mode is unsupported\n");
>> -		return -EINVAL;
>> -	}
>> -
>>   	dsi->lanes = device->lanes;
>>   	dsi->channel = device->channel;
>>   	dsi->format = device->format;
>> +	dsi->mode_flags = device->mode_flags;
>>   	dsi->panel = of_drm_find_panel(device->dev.of_node);
>>   	if (dsi->panel)
>>   		return drm_panel_attach(dsi->panel, &dsi->connector);
>> @@ -716,7 +713,12 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
>>   {
>>   	u32 val;
>>   
>> -	val = VID_MODE_TYPE_BURST_SYNC_PULSES | ENABLE_LOW_POWER;
>> +	val = ENABLE_LOW_POWER;
>> +
>> +	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
>> +		val |= VID_MODE_TYPE_BURST_SYNC_PULSES;
>> +	else if (!(dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE))
>> +		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;

if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
	val |= VID_MODE_TYPE_BURST;
else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
	val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
else
	val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;



>>   
>>   	dsi_write(dsi, DSI_VID_MODE_CFG, val);
>>   }
>> -- 
>> 2.11.0.197.gb556de5.dirty
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel at lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
