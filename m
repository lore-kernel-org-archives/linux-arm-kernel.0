From: ykk@rock-chips.com (Yakir Yang)
Date: Wed, 23 Dec 2015 08:49:34 +0800
Subject: [PATCH v11 03/19] drm: bridge: analogix/dp: remove duplicate
 configuration of link rate and link count
In-Reply-To: <000701d13cb1$a3d5f0c0$eb81d240$@com>
References: <1450236018-1118-1-git-send-email-ykk@rock-chips.com>
 <1450236502-1713-1-git-send-email-ykk@rock-chips.com>
 <000701d13cb1$a3d5f0c0$eb81d240$@com>
Message-ID: <5679EF9E.30703@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

Thanks for your respond.

On 12/22/2015 08:09 PM, Jingoo Han wrote:
> On Wednesday, December 16, 2015 12:28 PM, Yakir Yang wrote:
>> link_rate and lane_count already configured in analogix_dp_set_link_train(),
>> so we don't need to config those repeatly after training finished, just
>> remove them out.
>>
>> Beside Display Port 1.2 already support 5.4Gbps link rate, the maximum sets
>> would change from {1.62Gbps, 2.7Gbps} to {1.62Gbps, 2.7Gbps, 5.4Gbps}.
>>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>> Changes in v11: None
>> Changes in v10: None
>> Changes in v9: None
>> Changes in v8: None
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4:
>> - Update commit message more readable. (Jingoo)
>> - Adjust the order from 05 to 04
>>
>> Changes in v3:
>> - The link_rate and lane_count shouldn't config to the DT property value
>>    directly, but we can take those as hardware limite. For example, RK3288
>>    only support 4 physical lanes of 2.7/1.62 Gbps/lane, so DT property would
>>    like "link-rate = 0x0a" "lane-count = 4". (Thierry)
>>
>> Changes in v2: None
>>
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 8 ++++----
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 5 +++--
>>   2 files changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 4a05c2b..6f899cd 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -624,6 +624,8 @@ static void analogix_dp_get_max_rx_bandwidth(struct analogix_dp_device *dp,
>>   	/*
>>   	 * For DP rev.1.1, Maximum link rate of Main Link lanes
>>   	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps
>> +	 * For DP rev.1.2, Maximum link rate of Main Link lanes
>> +	 * 0x06 = 1.62 Gbps, 0x0a = 2.7 Gbps, 0x14 = 5.4Gbps
>>   	 */
>>   	analogix_dp_read_byte_from_dpcd(dp, DP_MAX_LINK_RATE, &data);
>>   	*bandwidth = data;
>> @@ -657,7 +659,8 @@ static void analogix_dp_init_training(struct analogix_dp_device *dp,
>>   	analogix_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
>>
>>   	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
>> -	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
>> +	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS) &&
>> +	    (dp->link_train.link_rate != LINK_RATE_5_40GBPS)) {
>>   		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
>>   			dp->link_train.link_rate);
>>   		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
>> @@ -898,9 +901,6 @@ static void analogix_dp_commit(struct analogix_dp_device *dp)
>>   	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
>>   	analogix_dp_enable_enhanced_mode(dp, 1);
>>
>> -	analogix_dp_set_lane_count(dp, dp->video_info->lane_count);
>> -	analogix_dp_set_link_bandwidth(dp, dp->video_info->link_rate);
>> -
>>   	analogix_dp_init_video(dp);
>>   	ret = analogix_dp_config_video(dp);
>>   	if (ret)
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> index 8e84208..57aa4b0d 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
>> @@ -21,8 +21,9 @@
>>   #define MAX_EQ_LOOP			5
>>
>>   enum link_rate_type {
>> -	LINK_RATE_1_62GBPS = 0x06,
>> -	LINK_RATE_2_70GBPS = 0x0a
>> +	LINK_RATE_1_62GBPS = DP_LINK_BW_1_62,
>> +	LINK_RATE_2_70GBPS = DP_LINK_BW_2_7,
>> +	LINK_RATE_5_40GBPS = DP_LINK_BW_5_4,
> Then, how about removing 'enum link_rate_type'?
> If DP_LINK_BW_* are used, LINK_RATE_* are not necessary.

Sure, good catch.

Thanks,
- Yakir

> Best regards,
> Jingoo Han
>
>
>>   };
>>
>>   enum link_lane_count_type {
>> --
>> 1.9.1
>
>
>
>
