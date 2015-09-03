From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 03 Sep 2015 13:04:36 +0800
Subject: [PATCH v4 01/16] drm: exynos/dp: fix code style
In-Reply-To: <55E79297.3050203@samsung.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086399-24889-1-git-send-email-ykk@rock-chips.com>
 <55E79297.3050203@samsung.com>
Message-ID: <55E7D4E4.6070808@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

? 09/03/2015 08:21 AM, Krzysztof Kozlowski ??:
> On 01.09.2015 14:46, Yakir Yang wrote:
>> After run "checkpatch.pl -f --subjective" command, I see there
>> are lots of alignment problem in exynos_dp driver, so let just
>> fix them.
> Hi,
>
> Warnings from checkpatch are not a reason for a commit. Reason for a
> commit could be for example an unreadable code, violation of
> coding-style leading to decrease in code maintainability or just
> improving the code readability so it will be easier to review and
> maintain it.
>
> You do not make commits because some tool tells you that. We do not
> listen to machines :) ... If that would be the case, the commit could be
> made automatically, without human interaction. Such automated commit
> could be even easily tested by the machine by comparing object files.
>
> Especially that you enabled "subjective" rule. This is not a valid
> motivation for a commit.
>
> Please rephrase this to sensible reason and convince that change is
> worth the effort.

Oh, nice, thanks for your remind. I would rephrase the commit.

>> - Take Romain suggest, rebase on linux-next branch
> That comment seems unrelated to the commit. Please remove it.

Done,

>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2:
>> - Take Joe Preches advise, improved commit message more readable, and
>>    avoid using some uncommon style like bellow:
>>    -  retval = exynos_dp_read_bytes_from_i2c(...
>> 				...)
>>    +  retval =
>>    +  exynos_dp_read_bytes_from_i2c(......);
>>
>>   drivers/gpu/drm/exynos/exynos_dp_core.c | 226 ++++++++++++++++----------------
>>   drivers/gpu/drm/exynos/exynos_dp_core.h |  54 ++++----
>>   drivers/gpu/drm/exynos/exynos_dp_reg.c  | 106 +++++++--------
>>   3 files changed, 188 insertions(+), 198 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
>> index d66ade0..266f7f7 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
>> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
>> @@ -115,8 +115,8 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   
>>   	/* Read Extension Flag, Number of 128-byte EDID extension blocks */
>>   	retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>> -				EDID_EXTENSION_FLAG,
>> -				&extend_block);
>> +					      EDID_EXTENSION_FLAG,
>> +					      &extend_block);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -124,10 +124,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   		dev_dbg(dp->dev, "EDID data includes a single extension!\n");
>>   
>>   		/* Read EDID data */
>> -		retval = exynos_dp_read_bytes_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>> -						EDID_HEADER_PATTERN,
>> -						EDID_BLOCK_LENGTH,
>> -						&edid[EDID_HEADER_PATTERN]);
>> +		retval = exynos_dp_read_bytes_from_i2c(
>> +					dp, I2C_EDID_DEVICE_ADDR,
>> +					EDID_HEADER_PATTERN,
>> +					EDID_BLOCK_LENGTH,
>> +					&edid[EDID_HEADER_PATTERN]);
>>   		if (retval != 0) {
>>   			dev_err(dp->dev, "EDID Read failed!\n");
>>   			return -EIO;
>> @@ -139,11 +140,11 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   		}
>>   
>>   		/* Read additional EDID data */
>> -		retval = exynos_dp_read_bytes_from_i2c(dp,
>> -				I2C_EDID_DEVICE_ADDR,
>> -				EDID_BLOCK_LENGTH,
>> -				EDID_BLOCK_LENGTH,
>> -				&edid[EDID_BLOCK_LENGTH]);
>> +		retval = exynos_dp_read_bytes_from_i2c(
>> +					dp, I2C_EDID_DEVICE_ADDR,
>> +					EDID_BLOCK_LENGTH,
>> +					EDID_BLOCK_LENGTH,
>> +					&edid[EDID_BLOCK_LENGTH]);
>>   		if (retval != 0) {
>>   			dev_err(dp->dev, "EDID Read failed!\n");
>>   			return -EIO;
>> @@ -155,24 +156,22 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   		}
>>   
>>   		exynos_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
>> -					&test_vector);
>> +					      &test_vector);
>>   		if (test_vector & DP_TEST_LINK_EDID_READ) {
>> -			exynos_dp_write_byte_to_dpcd(dp,
>> -				DP_TEST_EDID_CHECKSUM,
>> +			exynos_dp_write_byte_to_dpcd(
>> +				dp, DP_TEST_EDID_CHECKSUM,
>>   				edid[EDID_BLOCK_LENGTH + EDID_CHECKSUM]);
>> -			exynos_dp_write_byte_to_dpcd(dp,
>> -				DP_TEST_RESPONSE,
>> +			exynos_dp_write_byte_to_dpcd(
>> +				dp, DP_TEST_RESPONSE,
>>   				DP_TEST_EDID_CHECKSUM_WRITE);
> To me, missing argument after opening parenthesis, looks worse. I would
> prefer:
>
> 			exynos_dp_write_byte_to_dpcd(dp,
>
> Why you moved the 'dp' argument to new line?

Hmm... Just like style tool indicate, no more warning after
that change.

For now, I would like to follow the original style, just improved
some obvious style problem.  :-)

>
>>   		}
>>   	} else {
>>   		dev_info(dp->dev, "EDID data does not include any extensions.\n");
>>   
>>   		/* Read EDID data */
>> -		retval = exynos_dp_read_bytes_from_i2c(dp,
>> -				I2C_EDID_DEVICE_ADDR,
>> -				EDID_HEADER_PATTERN,
>> -				EDID_BLOCK_LENGTH,
>> -				&edid[EDID_HEADER_PATTERN]);
>> +		retval = exynos_dp_read_bytes_from_i2c(
>> +				dp, I2C_EDID_DEVICE_ADDR, EDID_HEADER_PATTERN,
>> +				EDID_BLOCK_LENGTH, &edid[EDID_HEADER_PATTERN]);
> ditto

Done

>
>>   		if (retval != 0) {
>>   			dev_err(dp->dev, "EDID Read failed!\n");
>>   			return -EIO;
>> @@ -183,16 +182,15 @@ static int exynos_dp_read_edid(struct exynos_dp_device *dp)
>>   			return -EIO;
>>   		}
>>   
>> -		exynos_dp_read_byte_from_dpcd(dp,
>> -			DP_TEST_REQUEST,
>> -			&test_vector);
>> +		exynos_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
>> +					      &test_vector);
>>   		if (test_vector & DP_TEST_LINK_EDID_READ) {
>> -			exynos_dp_write_byte_to_dpcd(dp,
>> -				DP_TEST_EDID_CHECKSUM,
>> -				edid[EDID_CHECKSUM]);
>> -			exynos_dp_write_byte_to_dpcd(dp,
>> -				DP_TEST_RESPONSE,
>> -				DP_TEST_EDID_CHECKSUM_WRITE);
>> +			exynos_dp_write_byte_to_dpcd(
>> +					dp, DP_TEST_EDID_CHECKSUM,
>> +					edid[EDID_CHECKSUM]);
>> +			exynos_dp_write_byte_to_dpcd(
>> +					dp, DP_TEST_RESPONSE,
>> +					DP_TEST_EDID_CHECKSUM_WRITE);
> ditto

Done

>
>>   		}
>>   	}
>>   
>> @@ -207,8 +205,7 @@ static int exynos_dp_handle_edid(struct exynos_dp_device *dp)
>>   	int retval;
>>   
>>   	/* Read DPCD DP_DPCD_REV~RECEIVE_PORT1_CAP_1 */
>> -	retval = exynos_dp_read_bytes_from_dpcd(dp, DP_DPCD_REV,
>> -				12, buf);
>> +	retval = exynos_dp_read_bytes_from_dpcd(dp, DP_DPCD_REV, 12, buf);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -223,7 +220,7 @@ static int exynos_dp_handle_edid(struct exynos_dp_device *dp)
>>   }
>>   
>>   static void exynos_dp_enable_rx_to_enhanced_mode(struct exynos_dp_device *dp,
>> -						bool enable)
>> +						 bool enable)
>>   {
>>   	u8 data;
>>   
>> @@ -231,11 +228,11 @@ static void exynos_dp_enable_rx_to_enhanced_mode(struct exynos_dp_device *dp,
>>   
>>   	if (enable)
>>   		exynos_dp_write_byte_to_dpcd(dp, DP_LANE_COUNT_SET,
>> -			DP_LANE_COUNT_ENHANCED_FRAME_EN |
>> -			DPCD_LANE_COUNT_SET(data));
>> +					     DP_LANE_COUNT_ENHANCED_FRAME_EN |
>> +					     DPCD_LANE_COUNT_SET(data));
>>   	else
>>   		exynos_dp_write_byte_to_dpcd(dp, DP_LANE_COUNT_SET,
>> -			DPCD_LANE_COUNT_SET(data));
>> +					     DPCD_LANE_COUNT_SET(data));
>>   }
>>   
>>   static int exynos_dp_is_enhanced_mode_available(struct exynos_dp_device *dp)
>> @@ -262,13 +259,12 @@ static void exynos_dp_training_pattern_dis(struct exynos_dp_device *dp)
>>   {
>>   	exynos_dp_set_training_pattern(dp, DP_NONE);
>>   
>> -	exynos_dp_write_byte_to_dpcd(dp,
>> -		DP_TRAINING_PATTERN_SET,
>> -		DP_TRAINING_PATTERN_DISABLE);
>> +	exynos_dp_write_byte_to_dpcd(dp, DP_TRAINING_PATTERN_SET,
>> +				     DP_TRAINING_PATTERN_DISABLE);
>>   }
>>   
>>   static void exynos_dp_set_lane_lane_pre_emphasis(struct exynos_dp_device *dp,
>> -					int pre_emphasis, int lane)
>> +						 int pre_emphasis, int lane)
>>   {
>>   	switch (lane) {
>>   	case 0:
>> @@ -308,15 +304,14 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
>>   	/* Setup RX configuration */
>>   	buf[0] = dp->link_train.link_rate;
>>   	buf[1] = dp->link_train.lane_count;
>> -	retval = exynos_dp_write_bytes_to_dpcd(dp, DP_LINK_BW_SET,
>> -				2, buf);
>> +	retval = exynos_dp_write_bytes_to_dpcd(dp, DP_LINK_BW_SET, 2, buf);
>>   	if (retval)
>>   		return retval;
>>   
>>   	/* Set TX pre-emphasis to minimum */
>>   	for (lane = 0; lane < lane_count; lane++)
>> -		exynos_dp_set_lane_lane_pre_emphasis(dp,
>> -			PRE_EMPHASIS_LEVEL_0, lane);
>> +		exynos_dp_set_lane_lane_pre_emphasis(dp, PRE_EMPHASIS_LEVEL_0,
>> +						     lane);
>>   
>>   	/* Wait for PLL lock */
>>   	pll_tries = 0;
>> @@ -334,9 +329,9 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
>>   	exynos_dp_set_training_pattern(dp, TRAINING_PTN1);
>>   
>>   	/* Set RX training pattern */
>> -	retval = exynos_dp_write_byte_to_dpcd(dp,
>> -			DP_TRAINING_PATTERN_SET,
>> -			DP_LINK_SCRAMBLING_DISABLE | DP_TRAINING_PATTERN_1);
>> +	retval = exynos_dp_write_byte_to_dpcd(dp, DP_TRAINING_PATTERN_SET,
>> +					      DP_LINK_SCRAMBLING_DISABLE |
>> +					      DP_TRAINING_PATTERN_1);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -345,7 +340,7 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
>>   			    DP_TRAIN_VOLTAGE_SWING_LEVEL_0;
>>   
>>   	retval = exynos_dp_write_bytes_to_dpcd(dp, DP_TRAINING_LANE0_SET,
>> -			lane_count, buf);
>> +					       lane_count, buf);
>>   
>>   	return retval;
>>   }
>> @@ -353,7 +348,7 @@ static int exynos_dp_link_start(struct exynos_dp_device *dp)
>>   static unsigned char exynos_dp_get_lane_status(u8 link_status[2], int lane)
>>   {
>>   	int shift = (lane & 1) * 4;
>> -	u8 link_value = link_status[lane>>1];
>> +	u8 link_value = link_status[lane >> 1];
>>   
>>   	return (link_value >> shift) & 0xf;
>>   }
>> @@ -372,7 +367,7 @@ static int exynos_dp_clock_recovery_ok(u8 link_status[2], int lane_count)
>>   }
>>   
>>   static int exynos_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
>> -				int lane_count)
>> +				   int lane_count)
>>   {
>>   	int lane;
>>   	u8 lane_status;
>> @@ -391,10 +386,10 @@ static int exynos_dp_channel_eq_ok(u8 link_status[2], u8 link_align,
>>   }
>>   
>>   static unsigned char exynos_dp_get_adjust_request_voltage(u8 adjust_request[2],
>> -							int lane)
>> +							  int lane)
>>   {
>>   	int shift = (lane & 1) * 4;
>> -	u8 link_value = adjust_request[lane>>1];
>> +	u8 link_value = adjust_request[lane >> 1];
>>   
>>   	return (link_value >> shift) & 0x3;
>>   }
>> @@ -404,13 +399,13 @@ static unsigned char exynos_dp_get_adjust_request_pre_emphasis(
>>   					int lane)
>>   {
>>   	int shift = (lane & 1) * 4;
>> -	u8 link_value = adjust_request[lane>>1];
>> +	u8 link_value = adjust_request[lane >> 1];
>>   
>>   	return ((link_value >> shift) & 0xc) >> 2;
>>   }
>>   
>>   static void exynos_dp_set_lane_link_training(struct exynos_dp_device *dp,
>> -					u8 training_lane_set, int lane)
>> +					     u8 training_lane_set, int lane)
>>   {
>>   	switch (lane) {
>>   	case 0:
>> @@ -430,9 +425,8 @@ static void exynos_dp_set_lane_link_training(struct exynos_dp_device *dp,
>>   	}
>>   }
>>   
>> -static unsigned int exynos_dp_get_lane_link_training(
>> -				struct exynos_dp_device *dp,
>> -				int lane)
>> +static unsigned int
>> +exynos_dp_get_lane_link_training(struct exynos_dp_device *dp, int lane)
>>   {
>>   	u32 reg;
>>   
>> @@ -466,7 +460,7 @@ static void exynos_dp_reduce_link_rate(struct exynos_dp_device *dp)
>>   }
>>   
>>   static void exynos_dp_get_adjust_training_lane(struct exynos_dp_device *dp,
>> -					u8 adjust_request[2])
>> +					       u8 adjust_request[2])
>>   {
>>   	int lane, lane_count;
>>   	u8 voltage_swing, pre_emphasis, training_lane;
>> @@ -499,13 +493,13 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>>   
>>   	lane_count = dp->link_train.lane_count;
>>   
>> -	retval =  exynos_dp_read_bytes_from_dpcd(dp,
>> -			DP_LANE0_1_STATUS, 2, link_status);
>> +	retval =  exynos_dp_read_bytes_from_dpcd(dp, DP_LANE0_1_STATUS,
>> +						 2, link_status);
>>   	if (retval)
>>   		return retval;
>>   
>> -	retval =  exynos_dp_read_bytes_from_dpcd(dp,
>> -			DP_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
>> +	retval =  exynos_dp_read_bytes_from_dpcd(dp, DP_ADJUST_REQUEST_LANE0_1,
>> +						 2, adjust_request);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -513,8 +507,8 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>>   		/* set training pattern 2 for EQ */
>>   		exynos_dp_set_training_pattern(dp, TRAINING_PTN2);
>>   
>> -		retval = exynos_dp_write_byte_to_dpcd(dp,
>> -				DP_TRAINING_PATTERN_SET,
>> +		retval = exynos_dp_write_byte_to_dpcd(
>> +				dp, DP_TRAINING_PATTERN_SET,
>>   				DP_LINK_SCRAMBLING_DISABLE |
>>   				DP_TRAINING_PATTERN_2);
> ditto

Done

>
>>   		if (retval)
>> @@ -552,11 +546,11 @@ static int exynos_dp_process_clock_recovery(struct exynos_dp_device *dp)
>>   	exynos_dp_get_adjust_training_lane(dp, adjust_request);
>>   
>>   	for (lane = 0; lane < lane_count; lane++)
>> -		exynos_dp_set_lane_link_training(dp,
>> -			dp->link_train.training_lane[lane], lane);
>> +		exynos_dp_set_lane_link_training(
>> +				dp, dp->link_train.training_lane[lane], lane);
>>   
>> -	retval = exynos_dp_write_bytes_to_dpcd(dp,
>> -			DP_TRAINING_LANE0_SET, lane_count,
>> +	retval = exynos_dp_write_bytes_to_dpcd(
>> +			dp, DP_TRAINING_LANE0_SET, lane_count,
>>   			dp->link_train.training_lane);
> ditto

Done

>
>>   	if (retval)
>>   		return retval;
>> @@ -574,8 +568,8 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>>   
>>   	lane_count = dp->link_train.lane_count;
>>   
>> -	retval = exynos_dp_read_bytes_from_dpcd(dp,
>> -			DP_LANE0_1_STATUS, 2, link_status);
>> +	retval = exynos_dp_read_bytes_from_dpcd(dp, DP_LANE0_1_STATUS,
>> +						2, link_status);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -584,13 +578,13 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>>   		return -EIO;
>>   	}
>>   
>> -	retval = exynos_dp_read_bytes_from_dpcd(dp,
>> -			DP_ADJUST_REQUEST_LANE0_1, 2, adjust_request);
>> +	retval = exynos_dp_read_bytes_from_dpcd(dp, DP_ADJUST_REQUEST_LANE0_1,
>> +						2, adjust_request);
>>   	if (retval)
>>   		return retval;
>>   
>> -	retval = exynos_dp_read_byte_from_dpcd(dp,
>> -			DP_LANE_ALIGN_STATUS_UPDATED, &link_align);
>> +	retval = exynos_dp_read_byte_from_dpcd(dp, DP_LANE_ALIGN_STATUS_UPDATED,
>> +					       &link_align);
>>   	if (retval)
>>   		return retval;
>>   
>> @@ -629,17 +623,18 @@ static int exynos_dp_process_equalizer_training(struct exynos_dp_device *dp)
>>   	}
>>   
>>   	for (lane = 0; lane < lane_count; lane++)
>> -		exynos_dp_set_lane_link_training(dp,
>> -			dp->link_train.training_lane[lane], lane);
>> +		exynos_dp_set_lane_link_training(
>> +				dp, dp->link_train.training_lane[lane], lane);
> ditto

Done

>
>>   
>>   	retval = exynos_dp_write_bytes_to_dpcd(dp, DP_TRAINING_LANE0_SET,
>> -			lane_count, dp->link_train.training_lane);
>> +					       lane_count,
>> +					       dp->link_train.training_lane);
>>   
>>   	return retval;
>>   }
>>   
>>   static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
>> -					u8 *bandwidth)
>> +					   u8 *bandwidth)
>>   {
>>   	u8 data;
>>   
>> @@ -652,7 +647,7 @@ static void exynos_dp_get_max_rx_bandwidth(struct exynos_dp_device *dp,
>>   }
>>   
>>   static void exynos_dp_get_max_rx_lane_count(struct exynos_dp_device *dp,
>> -					u8 *lane_count)
>> +					    u8 *lane_count)
>>   {
>>   	u8 data;
>>   
>> @@ -665,8 +660,8 @@ static void exynos_dp_get_max_rx_lane_count(struct exynos_dp_device *dp,
>>   }
>>   
>>   static void exynos_dp_init_training(struct exynos_dp_device *dp,
>> -			enum link_lane_count_type max_lane,
>> -			enum link_rate_type max_rate)
>> +				    enum link_lane_count_type max_lane,
>> +				    enum link_rate_type max_rate)
>>   {
>>   	/*
>>   	 * MACRO_RST must be applied after the PLL_LOCK to avoid
>> @@ -679,7 +674,7 @@ static void exynos_dp_init_training(struct exynos_dp_device *dp,
>>   	exynos_dp_get_max_rx_lane_count(dp, &dp->link_train.lane_count);
>>   
>>   	if ((dp->link_train.link_rate != LINK_RATE_1_62GBPS) &&
>> -	   (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
>> +	    (dp->link_train.link_rate != LINK_RATE_2_70GBPS)) {
>>   		dev_err(dp->dev, "Rx Max Link Rate is abnormal :%x !\n",
>>   			dp->link_train.link_rate);
>>   		dp->link_train.link_rate = LINK_RATE_1_62GBPS;
>> @@ -739,8 +734,7 @@ static int exynos_dp_sw_link_training(struct exynos_dp_device *dp)
>>   }
>>   
>>   static int exynos_dp_set_link_train(struct exynos_dp_device *dp,
>> -				u32 count,
>> -				u32 bwtype)
>> +				    u32 count, u32 bwtype)
>>   {
>>   	int i;
>>   	int retval;
>> @@ -828,21 +822,19 @@ static void exynos_dp_enable_scramble(struct exynos_dp_device *dp, bool enable)
>>   	if (enable) {
>>   		exynos_dp_enable_scrambling(dp);
>>   
>> -		exynos_dp_read_byte_from_dpcd(dp,
>> -			DP_TRAINING_PATTERN_SET,
>> -			&data);
>> -		exynos_dp_write_byte_to_dpcd(dp,
>> -			DP_TRAINING_PATTERN_SET,
>> -			(u8)(data & ~DP_LINK_SCRAMBLING_DISABLE));
>> +		exynos_dp_read_byte_from_dpcd(dp, DP_TRAINING_PATTERN_SET,
>> +					      &data);
>> +		exynos_dp_write_byte_to_dpcd(
>> +				dp, DP_TRAINING_PATTERN_SET,
>> +				(u8)(data & ~DP_LINK_SCRAMBLING_DISABLE));
> ditto

Done

>
>>   	} else {
>>   		exynos_dp_disable_scrambling(dp);
>>   
>> -		exynos_dp_read_byte_from_dpcd(dp,
>> -			DP_TRAINING_PATTERN_SET,
>> -			&data);
>> -		exynos_dp_write_byte_to_dpcd(dp,
>> -			DP_TRAINING_PATTERN_SET,
>> -			(u8)(data | DP_LINK_SCRAMBLING_DISABLE));
>> +		exynos_dp_read_byte_from_dpcd(dp, DP_TRAINING_PATTERN_SET,
>> +					      &data);
>> +		exynos_dp_write_byte_to_dpcd(
>> +				dp, DP_TRAINING_PATTERN_SET,
>> +				(u8)(data | DP_LINK_SCRAMBLING_DISABLE));
> ditto

Done

>
>>   	}
>>   }
>>   
>> @@ -913,7 +905,7 @@ static void exynos_dp_commit(struct drm_encoder *encoder)
>>   	}
>>   
>>   	ret = exynos_dp_set_link_train(dp, dp->video_info->lane_count,
>> -					dp->video_info->link_rate);
>> +				       dp->video_info->link_rate);
>>   	if (ret) {
>>   		dev_err(dp->dev, "unable to do link train\n");
>>   		return;
>> @@ -941,8 +933,8 @@ static void exynos_dp_commit(struct drm_encoder *encoder)
>>   	exynos_dp_start_video(dp);
>>   }
>>   
>> -static enum drm_connector_status exynos_dp_detect(
>> -				struct drm_connector *connector, bool force)
>> +static enum drm_connector_status
>> +exynos_dp_detect(struct drm_connector *connector, bool force)
>>   {
>>   	return connector_status_connected;
>>   }
>> @@ -990,8 +982,8 @@ static int exynos_dp_get_modes(struct drm_connector *connector)
>>   	return 1;
>>   }
>>   
>> -static struct drm_encoder *exynos_dp_best_encoder(
>> -			struct drm_connector *connector)
>> +static struct drm_encoder *
>> +exynos_dp_best_encoder(struct drm_connector *connector)
>>   {
>>   	struct exynos_dp_device *dp = ctx_from_connector(connector);
>>   
>> @@ -1005,7 +997,7 @@ static struct drm_connector_helper_funcs exynos_dp_connector_helper_funcs = {
>>   
>>   /* returns the number of bridges attached */
>>   static int exynos_drm_attach_lcd_bridge(struct exynos_dp_device *dp,
>> -		struct drm_encoder *encoder)
>> +					struct drm_encoder *encoder)
>>   {
>>   	int ret;
>>   
>> @@ -1036,7 +1028,8 @@ static int exynos_dp_create_connector(struct drm_encoder *encoder)
>>   	connector->polled = DRM_CONNECTOR_POLL_HPD;
>>   
>>   	ret = drm_connector_init(dp->drm_dev, connector,
>> -			&exynos_dp_connector_funcs, DRM_MODE_CONNECTOR_eDP);
>> +				 &exynos_dp_connector_funcs,
>> +				 DRM_MODE_CONNECTOR_eDP);
>>   	if (ret) {
>>   		DRM_ERROR("Failed to initialize connector with drm\n");
>>   		return ret;
>> @@ -1139,8 +1132,8 @@ static struct video_info *exynos_dp_dt_parse_pdata(struct device *dev)
>>   	struct device_node *dp_node = dev->of_node;
>>   	struct video_info *dp_video_config;
>>   
>> -	dp_video_config = devm_kzalloc(dev,
>> -				sizeof(*dp_video_config), GFP_KERNEL);
>> +	dp_video_config = devm_kzalloc(dev, sizeof(*dp_video_config),
>> +				       GFP_KERNEL);
>>   	if (!dp_video_config)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> @@ -1154,37 +1147,37 @@ static struct video_info *exynos_dp_dt_parse_pdata(struct device *dev)
>>   		of_property_read_bool(dp_node, "interlaced");
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,color-space",
>> -				&dp_video_config->color_space)) {
>> +				 &dp_video_config->color_space)) {
>>   		dev_err(dev, "failed to get color-space\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,dynamic-range",
>> -				&dp_video_config->dynamic_range)) {
>> +				 &dp_video_config->dynamic_range)) {
>>   		dev_err(dev, "failed to get dynamic-range\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,ycbcr-coeff",
>> -				&dp_video_config->ycbcr_coeff)) {
>> +				 &dp_video_config->ycbcr_coeff)) {
>>   		dev_err(dev, "failed to get ycbcr-coeff\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,color-depth",
>> -				&dp_video_config->color_depth)) {
>> +				 &dp_video_config->color_depth)) {
>>   		dev_err(dev, "failed to get color-depth\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,link-rate",
>> -				&dp_video_config->link_rate)) {
>> +				 &dp_video_config->link_rate)) {
>>   		dev_err(dev, "failed to get link-rate\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>>   	if (of_property_read_u32(dp_node, "samsung,lane-count",
>> -				&dp_video_config->lane_count)) {
>> +				 &dp_video_config->lane_count)) {
>>   		dev_err(dev, "failed to get lane-count\n");
>>   		return ERR_PTR(-EINVAL);
>>   	}
>> @@ -1197,7 +1190,7 @@ static int exynos_dp_dt_parse_panel(struct exynos_dp_device *dp)
>>   	int ret;
>>   
>>   	ret = of_get_videomode(dp->dev->of_node, &dp->priv.vm,
>> -			OF_USE_NATIVE_MODE);
>> +			       OF_USE_NATIVE_MODE);
>>   	if (ret) {
>>   		DRM_ERROR("failed: of_get_videomode() : %d\n", ret);
>>   		return ret;
>> @@ -1294,7 +1287,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>>   	exynos_dp_init_dp(dp);
>>   
>>   	ret = devm_request_irq(&pdev->dev, dp->irq, exynos_dp_irq_handler,
>> -			irq_flags, "exynos-dp", dp);
>> +			       irq_flags, "exynos-dp", dp);
>>   	if (ret) {
>>   		dev_err(&pdev->dev, "failed to request irq\n");
>>   		return ret;
>> @@ -1328,7 +1321,7 @@ static int exynos_dp_bind(struct device *dev, struct device *master, void *data)
>>   }
>>   
>>   static void exynos_dp_unbind(struct device *dev, struct device *master,
>> -				void *data)
>> +			     void *data)
>>   {
>>   	struct exynos_dp_device *dp = dev_get_drvdata(dev);
>>   
>> @@ -1347,7 +1340,7 @@ static int exynos_dp_probe(struct platform_device *pdev)
>>   	struct exynos_dp_device *dp;
>>   
>>   	dp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_dp_device),
>> -				GFP_KERNEL);
>> +			  GFP_KERNEL);
>>   	if (!dp)
>>   		return -ENOMEM;
>>   
>> @@ -1369,8 +1362,9 @@ static int exynos_dp_probe(struct platform_device *pdev)
>>   			of_node_put(bridge_node);
>>   			if (!dp->bridge)
>>   				return -EPROBE_DEFER;
>> -		} else
>> +		} else {
>>   			return -EPROBE_DEFER;
>> +		}
>>   	}
>>   
>>   	return component_add(&pdev->dev, &exynos_dp_ops);
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.h b/drivers/gpu/drm/exynos/exynos_dp_core.h
>> index e413b6f..71f2b86 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.h
>> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.h
>> @@ -179,8 +179,8 @@ void exynos_dp_config_interrupt(struct exynos_dp_device *dp);
>>   enum pll_status exynos_dp_get_pll_lock_status(struct exynos_dp_device *dp);
>>   void exynos_dp_set_pll_power_down(struct exynos_dp_device *dp, bool enable);
>>   void exynos_dp_set_analog_power_down(struct exynos_dp_device *dp,
>> -				enum analog_power_block block,
>> -				bool enable);
>> +				     enum analog_power_block block,
>> +				     bool enable);
>>   void exynos_dp_init_analog_func(struct exynos_dp_device *dp);
>>   void exynos_dp_init_hpd(struct exynos_dp_device *dp);
>>   enum dp_irq_type exynos_dp_get_irq_type(struct exynos_dp_device *dp);
>> @@ -191,50 +191,50 @@ int exynos_dp_get_plug_in_status(struct exynos_dp_device *dp);
>>   void exynos_dp_enable_sw_function(struct exynos_dp_device *dp);
>>   int exynos_dp_start_aux_transaction(struct exynos_dp_device *dp);
>>   int exynos_dp_write_byte_to_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned char data);
>> +				 unsigned int reg_addr,
>> +				 unsigned char data);
>>   int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned char *data);
>> +				  unsigned int reg_addr,
>> +				  unsigned char *data);
>>   int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char data[]);
>> +				  unsigned int reg_addr,
>> +				  unsigned int count,
>> +				  unsigned char data[]);
>>   int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char data[]);
>> +				   unsigned int reg_addr,
>> +				   unsigned int count,
>> +				   unsigned char data[]);
>>   int exynos_dp_select_i2c_device(struct exynos_dp_device *dp,
>>   				unsigned int device_addr,
>>   				unsigned int reg_addr);
>>   int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>> -				unsigned int device_addr,
>> -				unsigned int reg_addr,
>> -				unsigned int *data);
>> +				 unsigned int device_addr,
>> +				 unsigned int reg_addr,
>> +				 unsigned int *data);
>>   int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
>> -				unsigned int device_addr,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char edid[]);
>> +				  unsigned int device_addr,
>> +				  unsigned int reg_addr,
>> +				  unsigned int count,
>> +				  unsigned char edid[]);
>>   void exynos_dp_set_link_bandwidth(struct exynos_dp_device *dp, u32 bwtype);
>>   void exynos_dp_get_link_bandwidth(struct exynos_dp_device *dp, u32 *bwtype);
>>   void exynos_dp_set_lane_count(struct exynos_dp_device *dp, u32 count);
>>   void exynos_dp_get_lane_count(struct exynos_dp_device *dp, u32 *count);
>>   void exynos_dp_enable_enhanced_mode(struct exynos_dp_device *dp, bool enable);
>>   void exynos_dp_set_training_pattern(struct exynos_dp_device *dp,
>> -				 enum pattern_set pattern);
>> +				    enum pattern_set pattern);
>>   void exynos_dp_set_lane0_pre_emphasis(struct exynos_dp_device *dp, u32 level);
>>   void exynos_dp_set_lane1_pre_emphasis(struct exynos_dp_device *dp, u32 level);
>>   void exynos_dp_set_lane2_pre_emphasis(struct exynos_dp_device *dp, u32 level);
>>   void exynos_dp_set_lane3_pre_emphasis(struct exynos_dp_device *dp, u32 level);
>>   void exynos_dp_set_lane0_link_training(struct exynos_dp_device *dp,
>> -				u32 training_lane);
>> +				       u32 training_lane);
>>   void exynos_dp_set_lane1_link_training(struct exynos_dp_device *dp,
>> -				u32 training_lane);
>> +				       u32 training_lane);
>>   void exynos_dp_set_lane2_link_training(struct exynos_dp_device *dp,
>> -				u32 training_lane);
>> +				       u32 training_lane);
>>   void exynos_dp_set_lane3_link_training(struct exynos_dp_device *dp,
>> -				u32 training_lane);
>> +				       u32 training_lane);
>>   u32 exynos_dp_get_lane0_link_training(struct exynos_dp_device *dp);
>>   u32 exynos_dp_get_lane1_link_training(struct exynos_dp_device *dp);
>>   u32 exynos_dp_get_lane2_link_training(struct exynos_dp_device *dp);
>> @@ -245,9 +245,9 @@ void exynos_dp_init_video(struct exynos_dp_device *dp);
>>   void exynos_dp_set_video_color_format(struct exynos_dp_device *dp);
>>   int exynos_dp_is_slave_video_stream_clock_on(struct exynos_dp_device *dp);
>>   void exynos_dp_set_video_cr_mn(struct exynos_dp_device *dp,
>> -			enum clock_recovery_m_value_type type,
>> -			u32 m_value,
>> -			u32 n_value);
>> +			       enum clock_recovery_m_value_type type,
>> +			       u32 m_value,
>> +			       u32 n_value);
>>   void exynos_dp_set_video_timing_mode(struct exynos_dp_device *dp, u32 type);
>>   void exynos_dp_enable_video_master(struct exynos_dp_device *dp, bool enable);
>>   void exynos_dp_start_video(struct exynos_dp_device *dp);
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_reg.c b/drivers/gpu/drm/exynos/exynos_dp_reg.c
>> index c1f87a2..5aff19a 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_reg.c
>> +++ b/drivers/gpu/drm/exynos/exynos_dp_reg.c
>> @@ -202,8 +202,8 @@ void exynos_dp_set_pll_power_down(struct exynos_dp_device *dp, bool enable)
>>   }
>>   
>>   void exynos_dp_set_analog_power_down(struct exynos_dp_device *dp,
>> -				enum analog_power_block block,
>> -				bool enable)
>> +				     enum analog_power_block block,
>> +				     bool enable)
>>   {
>>   	u32 reg;
>>   
>> @@ -399,8 +399,8 @@ void exynos_dp_init_aux(struct exynos_dp_device *dp)
>>   	exynos_dp_reset_aux(dp);
>>   
>>   	/* Disable AUX transaction H/W retry */
>> -	reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) | AUX_HW_RETRY_COUNT_SEL(0)|
>> -		AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
>> +	reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) | AUX_HW_RETRY_COUNT_SEL(0) |
>> +	      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
>>   	writel(reg, dp->reg_base + EXYNOS_DP_AUX_HW_RETRY_CTL);
>>   
>>   	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
>> @@ -483,8 +483,8 @@ int exynos_dp_start_aux_transaction(struct exynos_dp_device *dp)
>>   }
>>   
>>   int exynos_dp_write_byte_to_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned char data)
>> +				 unsigned int reg_addr,
>> +				 unsigned char data)
>>   {
>>   	u32 reg;
>>   	int i;
>> @@ -519,17 +519,16 @@ int exynos_dp_write_byte_to_dpcd(struct exynos_dp_device *dp,
>>   		retval = exynos_dp_start_aux_transaction(dp);
>>   		if (retval == 0)
>>   			break;
>> -		else
>> -			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> -				__func__);
>> +
>> +		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
>>   	}
>>   
>>   	return retval;
>>   }
>>   
>>   int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned char *data)
>> +				  unsigned int reg_addr,
>> +				  unsigned char *data)
>>   {
>>   	u32 reg;
>>   	int i;
>> @@ -560,9 +559,8 @@ int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
>>   		retval = exynos_dp_start_aux_transaction(dp);
>>   		if (retval == 0)
>>   			break;
>> -		else
>> -			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> -				__func__);
>> +
>> +		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
>>   	}
>>   
>>   	/* Read data buffer */
>> @@ -573,9 +571,9 @@ int exynos_dp_read_byte_from_dpcd(struct exynos_dp_device *dp,
>>   }
>>   
>>   int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char data[])
>> +				  unsigned int reg_addr,
>> +				  unsigned int count,
>> +				  unsigned char data[])
>>   {
>>   	u32 reg;
>>   	unsigned int start_offset;
>> @@ -625,9 +623,9 @@ int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
>>   			retval = exynos_dp_start_aux_transaction(dp);
>>   			if (retval == 0)
>>   				break;
>> -			else
>> -				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> -					__func__);
>> +
>> +			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> +				__func__);
>>   		}
>>   
>>   		start_offset += cur_data_count;
>> @@ -637,9 +635,9 @@ int exynos_dp_write_bytes_to_dpcd(struct exynos_dp_device *dp,
>>   }
>>   
>>   int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char data[])
>> +				   unsigned int reg_addr,
>> +				   unsigned int count,
>> +				   unsigned char data[])
>>   {
>>   	u32 reg;
>>   	unsigned int start_offset;
>> @@ -683,9 +681,9 @@ int exynos_dp_read_bytes_from_dpcd(struct exynos_dp_device *dp,
>>   			retval = exynos_dp_start_aux_transaction(dp);
>>   			if (retval == 0)
>>   				break;
>> -			else
>> -				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> -					__func__);
>> +
>> +			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> +				__func__);
>>   		}
>>   
>>   		for (cur_data_idx = 0; cur_data_idx < cur_data_count;
>> @@ -736,9 +734,9 @@ int exynos_dp_select_i2c_device(struct exynos_dp_device *dp,
>>   }
>>   
>>   int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>> -				unsigned int device_addr,
>> -				unsigned int reg_addr,
>> -				unsigned int *data)
>> +				 unsigned int device_addr,
>> +				 unsigned int reg_addr,
>> +				 unsigned int *data)
>>   {
>>   	u32 reg;
>>   	int i;
>> @@ -767,9 +765,8 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>>   		retval = exynos_dp_start_aux_transaction(dp);
>>   		if (retval == 0)
>>   			break;
>> -		else
>> -			dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> -				__func__);
>> +
>> +		dev_dbg(dp->dev, "%s: Aux Transaction fail!\n", __func__);
>>   	}
>>   
>>   	/* Read data */
>> @@ -780,10 +777,10 @@ int exynos_dp_read_byte_from_i2c(struct exynos_dp_device *dp,
>>   }
>>   
>>   int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
>> -				unsigned int device_addr,
>> -				unsigned int reg_addr,
>> -				unsigned int count,
>> -				unsigned char edid[])
>> +				  unsigned int device_addr,
>> +				  unsigned int reg_addr,
>> +				  unsigned int count,
>> +				  unsigned char edid[])
>>   {
>>   	u32 reg;
>>   	unsigned int i, j;
>> @@ -807,8 +804,8 @@ int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
>>   			 * request without sending address
>>   			 */
>>   			if (!defer)
>> -				retval = exynos_dp_select_i2c_device(dp,
>> -						device_addr, reg_addr + i);
>> +				retval = exynos_dp_select_i2c_device(
>> +						dp, device_addr, reg_addr + i);
> ditto

Done

Thanks,
- Yakir

>
> Best regards,
> Krzysztof
>
>>   			else
>>   				defer = 0;
>>   
>> @@ -819,24 +816,23 @@ int exynos_dp_read_bytes_from_i2c(struct exynos_dp_device *dp,
>>   				 * If Bit 3 is 0, I2C transaction.
>>   				 */
>>   				reg = AUX_LENGTH(16) |
>> -					AUX_TX_COMM_I2C_TRANSACTION |
>> -					AUX_TX_COMM_READ;
>> +				      AUX_TX_COMM_I2C_TRANSACTION |
>> +				      AUX_TX_COMM_READ;
>>   				writel(reg, dp->reg_base +
>> -					EXYNOS_DP_AUX_CH_CTL_1);
>> +				       EXYNOS_DP_AUX_CH_CTL_1);
>>   
>>   				/* Start AUX transaction */
>>   				retval = exynos_dp_start_aux_transaction(dp);
>>   				if (retval == 0)
>>   					break;
>> -				else
>> -					dev_dbg(dp->dev,
>> -						"%s: Aux Transaction fail!\n",
>> -						__func__);
>> +
>> +				dev_dbg(dp->dev, "%s: Aux Transaction fail!\n",
>> +					__func__);
>>   			}
>>   			/* Check if Rx sends defer */
>>   			reg = readl(dp->reg_base + EXYNOS_DP_AUX_RX_COMM);
>>   			if (reg == AUX_RX_COMM_AUX_DEFER ||
>> -				reg == AUX_RX_COMM_I2C_DEFER) {
>> +			    reg == AUX_RX_COMM_I2C_DEFER) {
>>   				dev_err(dp->dev, "Defer: %d\n\n", reg);
>>   				defer = 1;
>>   			}
>> @@ -901,7 +897,7 @@ void exynos_dp_enable_enhanced_mode(struct exynos_dp_device *dp, bool enable)
>>   }
>>   
>>   void exynos_dp_set_training_pattern(struct exynos_dp_device *dp,
>> -				 enum pattern_set pattern)
>> +				    enum pattern_set pattern)
>>   {
>>   	u32 reg;
>>   
>> @@ -974,7 +970,7 @@ void exynos_dp_set_lane3_pre_emphasis(struct exynos_dp_device *dp, u32 level)
>>   }
>>   
>>   void exynos_dp_set_lane0_link_training(struct exynos_dp_device *dp,
>> -					u32 training_lane)
>> +				       u32 training_lane)
>>   {
>>   	u32 reg;
>>   
>> @@ -983,7 +979,7 @@ void exynos_dp_set_lane0_link_training(struct exynos_dp_device *dp,
>>   }
>>   
>>   void exynos_dp_set_lane1_link_training(struct exynos_dp_device *dp,
>> -					u32 training_lane)
>> +				       u32 training_lane)
>>   {
>>   	u32 reg;
>>   
>> @@ -992,7 +988,7 @@ void exynos_dp_set_lane1_link_training(struct exynos_dp_device *dp,
>>   }
>>   
>>   void exynos_dp_set_lane2_link_training(struct exynos_dp_device *dp,
>> -					u32 training_lane)
>> +				       u32 training_lane)
>>   {
>>   	u32 reg;
>>   
>> @@ -1001,7 +997,7 @@ void exynos_dp_set_lane2_link_training(struct exynos_dp_device *dp,
>>   }
>>   
>>   void exynos_dp_set_lane3_link_training(struct exynos_dp_device *dp,
>> -					u32 training_lane)
>> +				       u32 training_lane)
>>   {
>>   	u32 reg;
>>   
>> @@ -1125,9 +1121,9 @@ int exynos_dp_is_slave_video_stream_clock_on(struct exynos_dp_device *dp)
>>   }
>>   
>>   void exynos_dp_set_video_cr_mn(struct exynos_dp_device *dp,
>> -		enum clock_recovery_m_value_type type,
>> -		u32 m_value,
>> -		u32 n_value)
>> +			       enum clock_recovery_m_value_type type,
>> +			       u32 m_value,
>> +			       u32 n_value)
>>   {
>>   	u32 reg;
>>   
>> @@ -1221,7 +1217,7 @@ void exynos_dp_config_video_slave_mode(struct exynos_dp_device *dp)
>>   	u32 reg;
>>   
>>   	reg = readl(dp->reg_base + EXYNOS_DP_FUNC_EN_1);
>> -	reg &= ~(MASTER_VID_FUNC_EN_N|SLAVE_VID_FUNC_EN_N);
>> +	reg &= ~(MASTER_VID_FUNC_EN_N | SLAVE_VID_FUNC_EN_N);
>>   	reg |= MASTER_VID_FUNC_EN_N;
>>   	writel(reg, dp->reg_base + EXYNOS_DP_FUNC_EN_1);
>>   
>>
>
>
>
