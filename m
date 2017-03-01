From: david.wu@rock-chips.com (David.Wu)
Date: Wed, 1 Mar 2017 19:00:48 +0800
Subject: [PATCH v2] pwm: rockchip: State of pwm clock should synchronize
 with pwm enabled state
In-Reply-To: <20170301111915.445925ad@bbrezillon>
References: <1488363362-26624-1-git-send-email-david.wu@rock-chips.com>
 <20170301111915.445925ad@bbrezillon>
Message-ID: <cd8c01a0-3463-21ad-8958-28e8a86e01d7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris?

? 2017/3/1 18:19, Boris Brezillon ??:
> On Wed,  1 Mar 2017 18:16:02 +0800
> David Wu <david.wu@rock-chips.com> wrote:
>
>> From: "david.wu" <david.wu@rock-chips.com>
>>
>> If the pwm was not enabled at uboot loader, pwm could not work for clock
>> always disabled at pwm driver. The pwm clock is enabled at beginning of
>> pwm_apply(), but disabled at end of pwm_apply().
>>
>> If the pwm was enabled at uboot loader, pwm clock is always enabled unless
>> closed by ATF. The pwm-backlight might turn off the power at early suspend,
>> should disable pwm clock for saving power consume.
>>
>> It is important to provide opportunity to enable/disable clock at pwm driver,
>> the pwm consumer should ensure correct order to call pwm enable/disable, and
>> pwm driver ensure state of pwm clock synchronized with pwm enabled state.
>>
>> Fixes: 2bf1c98aa5a4 ("pwm: rockchip: Add support for atomic update")
>> Cc: stable at vger.kernel.org
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Reviewed-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>> ---
>>  drivers/pwm/pwm-rockchip.c | 40 +++++++++++++++++++++++++++++++++-------
>>  1 file changed, 33 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
>> index ef89df1..dbee3c3 100644
>> --- a/drivers/pwm/pwm-rockchip.c
>> +++ b/drivers/pwm/pwm-rockchip.c
>> @@ -191,6 +191,28 @@ static int rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>>  	return 0;
>>  }
>>
>> +static int rk_pwm_enable(struct pwm_chip *chip,
>> +			 struct pwm_device *pwm,
>> +			 bool enable,
>> +			 enum pwm_polarity polarity)
>
> You didn't change the function name:
>
> s/rk_pwm_enable/rockchip_pwm_enable/

Sorry, it is a pity not to fix in in v2.

>
>> +{
>> +	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
>> +	int ret;
>> +
>> +	if (enable) {
>> +		ret = clk_enable(pc->clk);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	pc->data->set_enable(chip, pwm, enable, polarity);
>> +
>> +	if (!enable)
>> +		clk_disable(pc->clk);
>> +
>> +	return 0;
>> +}
>> +
>>  static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>  			      struct pwm_state *state)
>>  {
>> @@ -207,22 +229,26 @@ static int rockchip_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>>  		return ret;
>>
>>  	if (state->polarity != curstate.polarity && enabled) {
>> -		pc->data->set_enable(chip, pwm, false, state->polarity);
>> +		ret = rk_pwm_enable(chip, pwm, false, state->polarity);
>> +		if (ret)
>> +			goto out;
>>  		enabled = false;
>>  	}
>>
>>  	ret = rockchip_pwm_config(chip, pwm, state->duty_cycle, state->period);
>>  	if (ret) {
>>  		if (enabled != curstate.enabled)
>> -			pc->data->set_enable(chip, pwm, !enabled,
>> -					     state->polarity);
>> -
>> +			rk_pwm_enable(chip, pwm, !enabled,
>> +				      state->polarity);
>>  		goto out;
>>  	}
>>
>> -	if (state->enabled != enabled)
>> -		pc->data->set_enable(chip, pwm, state->enabled,
>> -				     state->polarity);
>> +	if (state->enabled != enabled) {
>> +		ret = rk_pwm_enable(chip, pwm, state->enabled,
>> +				    state->polarity);
>> +		if (ret)
>> +			goto out;
>> +	}
>>
>>  	/*
>>  	 * Update the state with the real hardware, which can differ a bit
>
>
>
>
