From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 24 Dec 2015 09:23:05 +0800
Subject: [PATCH v12 16/18] drm: bridge: analogix/dp: expand the wait time
 for looking AUX CH reply flag
In-Reply-To: <000001d13d94$120e0d60$362a2820$@com>
References: <1450873538-18304-1-git-send-email-ykk@rock-chips.com>
 <1450875064-19627-1-git-send-email-ykk@rock-chips.com>
 <000001d13d94$120e0d60$362a2820$@com>
Message-ID: <567B48F9.6010902@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo,

Okay, fine, I would drop this patch, until I found the the root cause.

- Yakir

On 12/23/2015 11:10 PM, Jingoo Han wrote:
> On Wednesday, December 23, 2015 9:51 PM, Yakir Yang wrote:
>> On Rockchip platform, sometimes driver would failed at reading EDID
>> message, and it's caused by the AUX reply flag wouldn't received under
>> the 100*10us wait time.
> The problem is specific for Rockchip platform.
> Also, 1 ms is long time.
> The best way is that your hardware engineers find the root cause.
> I cannot understand why your engineers cannot find the root cause. :-(
>
>> But after expand the wait time a little, the AUX reply flag would be
>> set, so maybe the wait time is a little critical. Besides the analogix
>> dp book haven't reminded the standard wait for looking AUX reply flag,
>> so I thought it's okay to expand the wait time.
>>
>> And the external wait time won't hurt Exynos DP too much, cause they
>> wouldn't meet this problem, then driver would received the reply command
>> very soon, so no more additional wait time would bring to Exynos platform.
> Then, when loop time happens on Exynos platform, it will take long time
> to return error.
>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> ---
>> Changes in v12:
>> - Using another way to expand the AUX reply wait time (Jingoo)
>>
>> Changes in v11: None
>> Changes in v10: None
>> Changes in v9: None
>> Changes in v8: None
>> Changes in v7: None
>> Changes in v6: None
>> Changes in v5: None
>> Changes in v4: None
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> index cba3ffd..8687eea 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
>> @@ -471,7 +471,7 @@ int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
>>   {
>>   	int reg;
>>   	int retval = 0;
>> -	int timeout_loop = 0;
>> +	unsigned long timeout;
>>
>>   	/* Enable AUX CH operation */
>>   	reg = readl(dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
>> @@ -479,14 +479,12 @@ int analogix_dp_start_aux_transaction(struct analogix_dp_device *dp)
>>   	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_CH_CTL_2);
>>
>>   	/* Is AUX CH command reply received? */
>> -	reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
>> -	while (!(reg & RPLY_RECEIV)) {
>> -		timeout_loop++;
>> -		if (DP_TIMEOUT_LOOP_COUNT < timeout_loop) {
>> +	timeout = jiffies + msecs_to_jiffies(5);
>> +	while ((readl(dp->reg_base + ANALOGIX_DP_INT_STA) & RPLY_RECEIV) == 0) {
>> +		if (time_after(jiffies, timeout)) {
>>   			dev_err(dp->dev, "AUX CH command reply failed!\n");
>>   			return -ETIMEDOUT;
>>   		}
>> -		reg = readl(dp->reg_base + ANALOGIX_DP_INT_STA);
> Sorry, I don't like your patch.
>
> The problem happens because of Rockchip platform.
> So, you need to add workaround for only Rockchip platform.
>
> Just add new DT property and new variable for the value for wait time.
> When, the probe is called, new wait time value is read from Rockchip DT file.
> Then, the new wait time value can be written to the new variable.
>
>      new DT property: wait-time-aux
>      new variable: wait_time_aux
>
>
> If ( ) // New DT
>      wait_time_aux = New DT;
> else
>      wait_time_aux = 10;
>
>
>>   		usleep_range(10, 11);
> If there is NO  new wait time value from DT file, the default value '10' is
> used for sleep.
>
> But, if there is new wait time value from DT file, new wait time value
> can be used for sleep.
>
>                   usleep_range(dp->wait_time_aux, dp->wait_time_aux + 1);
>
> What I want to say is that there should be NO effect on Exynos platform,
> because of the hardware bug of Rockchip platform.
>
> Best regards,
> Jingoo Han
>
>>   	}
>>
>> --
>> 1.9.1
>
>
>
>
