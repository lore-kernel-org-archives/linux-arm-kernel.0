From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Fri, 7 Oct 2016 10:19:57 +0530
Subject: [PATCH v2 2/6] pwm: core: make the PWM_POLARITY flag in DTB
 optional
In-Reply-To: <20161006083642.6a28a629@jawa>
References: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
 <20161001101235.24598-3-bhuvanchandra.dv@toradex.com>
 <20161006083642.6a28a629@jawa>
Message-ID: <815c2a76-a22d-8938-6d27-ff3da5694791@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lukasz,

On 10/06/16 12:06, Lukasz Majewski wrote:

> Hi Bhuvanchandra,
>
>> From: Lothar Wassmann <LW@KARO-electronics.de>
>>
>> Change the pwm chip driver registration, so that a chip driver that
>> supports polarity inversion can still be used with DTBs that don't
>> provide the 'PWM_POLARITY' flag.
>>
>> This is done to provide polarity inversion support for the pwm-imx
>> driver without having to modify all existing DTS files.
>>
>> Signed-off-by: Lothar Wassmann <LW@KARO-electronics.de>
>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
>> ---
>>   drivers/pwm/core.c | 27 ++++++++++++++++-----------
>>   1 file changed, 16 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 195373e..aae8db3 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -137,9 +137,14 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc,
>> const struct of_phandle_args *args) {
>>   	struct pwm_device *pwm;
>>   
>> +	/* check, whether the driver supports a third cell for flags
>> */ if (pc->of_pwm_n_cells < 3)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	/* flags in the third cell are optional */
>> +	if (args->args_count < 2)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	if (args->args[0] >= pc->npwm)
>>   		return ERR_PTR(-EINVAL);
>>   
>> @@ -149,10 +154,12 @@ of_pwm_xlate_with_flags(struct pwm_chip *pc,
>> const struct of_phandle_args *args)
>>   	pwm->args.period = args->args[1];
>>   
>> -	if (args->args[2] & PWM_POLARITY_INVERTED)
>> -		pwm->args.polarity = PWM_POLARITY_INVERSED;
>> -	else
>> -		pwm->args.polarity = PWM_POLARITY_NORMAL;
>> +	if (args->args_count > 2) {
>> +		if (args->args[2] & PWM_POLARITY_INVERTED)
>> +			pwm_set_polarity(pwm, PWM_POLARITY_INVERSED);
> 			^^^^^^^^^^^^^^^^
> 			here we should set pwm->args.polarity, since
> 			the pwm_set_polarity() calls pwm_apply_state()
> 			which requires duty_cycle and period to be set.
>
> 			In this particular moment it is not yet set and
> 			polarity is not properly configured.

Agreed. Will do a clean v3 patchset along with the patch you sent
(pwm: core: Use pwm->args.polarity to setup PWM_POLARITY_INVERSED).

--
Bhuvan

>
> Patch fixing this will be sent as a reply to this e-mail. Please just
> squash it and test on your platform.
>
> Best regards,
> ?ukasz Majewski
>
>> +		else
>> +			pwm_set_polarity(pwm, PWM_POLARITY_NORMAL);
>> +	}
>>   
>>   	return pwm;
>>   }
>> @@ -163,9 +170,14 @@ of_pwm_simple_xlate(struct pwm_chip *pc, const
>> struct of_phandle_args *args) {
>>   	struct pwm_device *pwm;
>>   
>> +	/* sanity check driver support */
>>   	if (pc->of_pwm_n_cells < 2)
>>   		return ERR_PTR(-EINVAL);
>>   
>> +	/* all cells are required */
>> +	if (args->args_count != pc->of_pwm_n_cells)
>> +		return ERR_PTR(-EINVAL);
>> +
>>   	if (args->args[0] >= pc->npwm)
>>   		return ERR_PTR(-EINVAL);
>>   
>> @@ -672,13 +684,6 @@ struct pwm_device *of_pwm_get(struct device_node
>> *np, const char *con_id) goto put;
>>   	}
>>   
>> -	if (args.args_count != pc->of_pwm_n_cells) {
>> -		pr_debug("%s: wrong #pwm-cells for %s\n",
>> np->full_name,
>> -			 args.np->full_name);
>> -		pwm = ERR_PTR(-EINVAL);
>> -		goto put;
>> -	}
>> -
>>   	pwm = pc->of_xlate(pc, &args);
>>   	if (IS_ERR(pwm))
>>   		goto put;
