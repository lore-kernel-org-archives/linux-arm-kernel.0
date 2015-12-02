From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 2 Dec 2015 18:46:57 +0800
Subject: [PATCH v8 14/17] drm: bridge: analogix/dp: add max link rate and
 lane count limit for RK3288
In-Reply-To: <2807882.UeSPH80il3@diego>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446022561-16870-1-git-send-email-ykk@rock-chips.com>
 <2807882.UeSPH80il3@diego>
Message-ID: <565ECC21.3060306@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 11/27/2015 09:32 PM, Heiko St?bner wrote:
> Am Mittwoch, 28. Oktober 2015, 16:56:01 schrieb Yakir Yang:
>> There are some IP limit on rk3288 that only support 4 physical lanes
>> of 2.7/1.6 Gbps/lane, so seprate them out by device_type flag.
>>
>> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
> [...]
>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c index
>> 6307060..563ffb1d 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -890,8 +890,8 @@ static void analogix_dp_commit(struct analogix_dp_device
>> *dp) return;
>>   	}
>>
>> -	ret = analogix_dp_set_link_train(dp, dp->video_info.lane_count,
>> -					 dp->video_info.link_rate);
>> +	ret = analogix_dp_set_link_train(dp, dp->video_info.max_lane_count,
>> +					 dp->video_info.max_link_rate);
>>   	if (ret) {
>>   		dev_err(dp->dev, "unable to do link train\n");
>>   		return;
>> @@ -1156,16 +1156,25 @@ static int analogix_dp_dt_parse_pdata(struct
>> analogix_dp_device *dp) struct device_node *dp_node = dp->dev->of_node;
>>   	struct video_info *video_info = &dp->video_info;
>>
>> -	if (of_property_read_u32(dp_node, "samsung,link-rate",
>> -				 &video_info->link_rate)) {
>> -		dev_err(dp->dev, "failed to get link-rate\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	if (of_property_read_u32(dp_node, "samsung,lane-count",
>> -				 &video_info->lane_count)) {
>> -		dev_err(dp->dev, "failed to get lane-count\n");
>> -		return -EINVAL;
>> +	switch (dp->plat_data && dp->plat_data->dev_type) {
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c: In function ?analogix_dp_dt_parse_pdata?:
> drivers/gpu/drm/bridge/analogix/analogix_dp_core.c:1191:10: warning: switch condition has boolean value [-Wswitch-bool]
>    switch (dp->plat_data && dp->plat_data->dev_type) {
>            ^
>
> As I think we always will need to distinguish between implementations,
> I guess it should be safe to exit with an error, it that implementation-data
> is not available, like just doing before the switch a:
>
> if (!dp->plat_data)
> 	return -EINVAL;

Done, thanks

- Yakir

>
> Heiko
>
>
>
