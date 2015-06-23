From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Jun 2015 21:46:20 +0200
Subject: [PATCH] touchscreen: sun4i-ts: Really fix A10 temperature
 reporting
In-Reply-To: <41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com>
References: <1425893870-28715-1-git-send-email-hdegoede@redhat.com>
 <41a7a857-96fd-48ab-9778-127cfc091ef0@googlegroups.com>
Message-ID: <5589B78C.4080600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 06/23/2015 05:06 PM, m.silentcreek at gmail.com wrote:
> Hi Hans,
>
> is it possible that this patch (and the parent commit "Input: sun4i-ts - allow controlling filter and sensitivity via DT") has quite an adversial effect on other boards than the ones tested?
>
> On my Lemaker Bananapi the temperature is now being reported as somwhere between -15?C to -10?C with the latest Kernel 4.1.0. These negative values are obviously way off. On Kernel 4.0.5 the temperature reading was usually around 40?C. While that might not have been accurate either, it was at least plausible.

The temperature curve for the A20 SoC was not changed, if it did change then
you're using an old dtb file with a new kernel, you must always update your
dtb file together with the kernel.



>
> Given that there is no Documentation and things seem quite board-specific, I really don't know how this could be improved, so I can merely report my observation.
>
> Kind regards,
>
> Timo
>
>
> Am Montag, 9. M?rz 2015 10:38:02 UTC+1 schrieb Hans de Goede:
>> The commit titled:
>> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
>> contains a math error, the offset it uses is in degrees, but the actual code
>> applies the offset before multiplying by stepsize :|
>>
>> Given that this is rather backwards (every math course ever thought applies
>> the multiplication before the offset for linear functions), this commit
>> fixes things by changing the code applying the offset to do the logical
>> thing, adjusting the offset for the other models accordingly.
>>
>> This has been tested on an A10, A13, A20 and A31 to make sure everything really
>> is correct now.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note if possible this commit should be squashed into the original
>> "touchscreen: sun4i-ts: A10 (sun4i) has a different temperature curve"
>> commit as a fixup.
>> ---
>>   drivers/input/touchscreen/sun4i-ts.c | 14 +++++++-------
>>   1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/input/touchscreen/sun4i-ts.c b/drivers/input/touchscreen/sun4i-ts.c
>> index 66ccd5a..178d2ef 100644
>> --- a/drivers/input/touchscreen/sun4i-ts.c
>> +++ b/drivers/input/touchscreen/sun4i-ts.c
>> @@ -193,7 +193,7 @@ static int sun4i_get_temp(const struct sun4i_ts_data *ts, long *temp)
>>   	if (ts->temp_data == -1)
>>   		return -EAGAIN;
>>
>> -	*temp = (ts->temp_data - ts->temp_offset) * ts->temp_step;
>> +	*temp = ts->temp_data * ts->temp_step - ts->temp_offset;
>>
>>   	return 0;
>>   }
>> @@ -255,17 +255,17 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>>   	ts->ignore_fifo_data = true;
>>   	ts->temp_data = -1;
>>   	if (of_device_is_compatible(np, "allwinner,sun6i-a31-ts")) {
>> -		/* Allwinner SDK has temperature = -271 + (value / 6) (C) */
>> -		ts->temp_offset = 1626;
>> +		/* Allwinner SDK has temperature (C) = (value / 6) - 271 */
>> +		ts->temp_offset = 271000;
>>   		ts->temp_step = 167;
>>   	} else if (of_device_is_compatible(np, "allwinner,sun4i-a10-ts")) {
>>   		/*
>>   		 * The A10 temperature sensor has quite a wide spread, these
>>   		 * parameters are based on the averaging of the calibration
>>   		 * results of 4 completely different boards, with a spread of
>> -		 * temp_step from 96 - 170 and temp_offset from 1758 - 3310.
>> +		 * temp_step from 0.096 - 0.170 and temp_offset from 176 - 331.
>>   		 */
>> -		ts->temp_offset = 2570;
>> +		ts->temp_offset = 257000;
>>   		ts->temp_step = 133;
>>   	} else {
>>   		/*
>> @@ -273,13 +273,13 @@ static int sun4i_ts_probe(struct platform_device *pdev)
>>   		 * the temperature. The formula used here is from the AXP209,
>>   		 * which is designed by X-Powers, an affiliate of Allwinner:
>>   		 *
>> -		 *     temperature = -144.7 + (value * 0.1)
>> +		 *     temperature (C) = (value * 0.1) - 144.7
>>   		 *
>>   		 * Allwinner does not have any documentation whatsoever for
>>   		 * this hardware. Moreover, it is claimed that the sensor
>>   		 * is inaccurate and cannot work properly.
>>   		 */
>> -		ts->temp_offset = 1447;
>> +		ts->temp_offset = 144700;
>>   		ts->temp_step = 100;
>>   	}
>>
>> --
>> 2.3.1
>

Regards,

Hans
